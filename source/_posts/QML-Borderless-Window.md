---
title: QML Borderless Window
date: 2020-08-10 00:36:36
tags: 
- Qt
- QML
- C++
- Windows
- GUI

categories:
- Qt
---

{% label GitHub info %}
[Source codes](https://github.com/jin-qin/qml-native-borderless-window)

The default frameless window style of Qt will lose the native animation and window shadow in Windows system. This is due to it does not use [Desktop Window Manager (DWM)](https://docs.microsoft.com/en-us/windows/win32/api/_dwm/) APIs to enable borderless effect.

## Demo
![demo](/data/images/native-borderlesswindow-demo.gif)

<!--more-->

## How to enable borderless window with native animation and shadow
> Here is a helper function [enableWindowBorderlessWin](https://github.com/jin-qin/qml-native-borderless-window/blob/03530089a81986f02d0b40559d587e48ca054a71/src/util/util_misc_win.cpp#L16) that can be used to enable native shadow for a window:
```cpp
void enableWindowBorderlessWin(qulonglong wId)
{
    HWND wnd = (HWND)wId;
    // enable borderless and keep aero effects.
    SetWindowLongPtr(wnd, GWL_STYLE, static_cast<LONG>(Style::aero_borderless));

    // enable shadow
    const MARGINS shadow_on = { 1, 1, 1, 1 };
    DwmExtendFrameIntoClientArea(wnd, &shadow_on);

    //redraw frame
    SetWindowPos(wnd, Q_NULLPTR, 0, 0, 0, 0, SWP_FRAMECHANGED | SWP_NOMOVE | SWP_NOSIZE);
    ShowWindow(wnd, SW_SHOW);
}
```

## How to setup window caption area and keep window border events
After we applying the helper function above, the window will lose its caption area and the window border events, we can set them by hooking the Windows native messages.

> Here is [nativeEventFilter](https://github.com/jin-qin/qml-native-borderless-window/blob/03530089a81986f02d0b40559d587e48ca054a71/src/util/native_event_filter.cpp#L13) to handle these issues:
```cpp
bool NativeEventFilter::nativeEventFilter(const QByteArray &eventType, void *message, long *result)
{
#ifdef Q_OS_WIN
    if (eventType == "windows_generic_MSG") {
        MSG* msg = static_cast<MSG *>(message);
        if (msg == Q_NULLPTR)
            return false;

        switch(msg->message) {
        case WM_COMMAND: {
          SendMessage(msg->hwnd, WM_SYSCOMMAND, msg->wParam, msg->lParam);
          *result = DefWindowProc(msg->hwnd, msg->message, msg->wParam, msg->lParam);
          return true;
        }
        case WM_NCCALCSIZE:{
            NCCALCSIZE_PARAMS& params = *reinterpret_cast<NCCALCSIZE_PARAMS*>(msg->lParam);
            if (params.rgrc[0].top != 0)
                params.rgrc[0].top -= 1;

            //this kills the window frame and title bar we added with WS_THICKFRAME and WS_CAPTION
            *result = WVR_REDRAW;
            return true;
        }
        case WM_NCHITTEST: {
            const LONG borderWidth = 8; //in pixels
            RECT winrect;
            GetWindowRect(msg->hwnd, &winrect);
            long x = GET_X_LPARAM(msg->lParam);
            long y = GET_Y_LPARAM(msg->lParam);

            // caption, a.k.a. title bar
            auto wndScaleFactor = qgetenv("QT_SCALE_FACTOR").toDouble();
            int titleBarHeight = m_wndsParams[(WId)msg->hwnd]["TitleHeight"].toInt();
            titleBarHeight = static_cast<int>(titleBarHeight * wndScaleFactor);
            int titleBarBtnsWidth = m_wndsParams[(WId)msg->hwnd]["TitleBarButtonsArea"].toSize().width();
            titleBarBtnsWidth = static_cast<int>(titleBarBtnsWidth * wndScaleFactor);
            if (x >= winrect.left && x < winrect.right - titleBarBtnsWidth &&
                    y > winrect.top + borderWidth && y < winrect.top + titleBarHeight) {
                *result = HTCAPTION;
                return true;
            }
            //bottom left corner
            if (x >= winrect.left && x < winrect.left + borderWidth &&
                y < winrect.bottom && y >= winrect.bottom - borderWidth) {
                *result = HTBOTTOMLEFT;
                return true;
            }
            //bottom right corner
            if (x < winrect.right && x >= winrect.right - borderWidth &&
                y < winrect.bottom && y >= winrect.bottom - borderWidth) {
                *result = HTBOTTOMRIGHT;
                return true;
            }
            //top left corner
            if (x >= winrect.left && x < winrect.left + borderWidth &&
                y >= winrect.top && y < winrect.top + borderWidth) {
                *result = HTTOPLEFT;
                return true;
            }
            //top right corner
            if (x < winrect.right && x >= winrect.right - borderWidth &&
                y >= winrect.top && y < winrect.top + borderWidth) {
                *result = HTTOPRIGHT;
                return true;
            }
            //left border
            if (x >= winrect.left && x < winrect.left + borderWidth) {
                *result = HTLEFT;
                return true;
            }
            //right border
            if (x < winrect.right && x >= winrect.right - borderWidth) {
                *result = HTRIGHT;
                return true;
            }
            //bottom border
            if (y < winrect.bottom && y >= winrect.bottom - borderWidth) {
                *result = HTBOTTOM;
                return true;
            }
            //top border
            if (y >= winrect.top && y < winrect.top + borderWidth) {
                *result = HTTOP;
                return true;
            }
            return false;
        }
        default:
            break;
        }
    }
#endif

    return false;
}
```