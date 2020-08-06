---
title: 机器学习基本概念
categories:
- MachineLearning
toc: true
---
## 机器学习简介
机器学习是一使用**正确**的数据，通过设计**正确**的模型，得到**正确**的结果的一类算法。机器学习算法可以不断地通过历史数据，执行相对应的任务，来提升算法的性能。

![机器学习基本框架](/wiki/data/images/ML/0-0.png)

- 学习的过程有可能是离线的，换句话说，在模型的执行之前进行模型的学习，例如：
    * 人脸识别
    * 垃圾邮件检测等
- 学习的过程也有可能是在线的，和模型的执行同步进行，例如：
    * 一种自适应的接口
- 学习的过程也有可能以上两者都有，例如：
    * 语音识别系统

## 机器学习的目标
通常情况下，我们希望能够设计出各种方法和工具来构建一种能够自我学习的机器，这种机器能够使用合适的训练数据集使自己解决很多问题。

最终，机器学习将形成一种**DIKW金字塔**的模式：
- 能够揭示本质，揭示方向，解答疑问，做出决策，决定行为方式等。
- 从过去的数据中学习，最终极大的增强未来的能力。

但是这需要大量的数据（Big Data）！如下图所示：

![机器学习与大数据](/wiki/data/images/ML/0-1.png)

## 机器学习的应用
- Search engines（搜索引擎）
- Machine perception（机器感知）
- Computer vision, including object recognition（机器视觉，包括目标识别）
- Natural language processing（自然语言处理）
- Bioinformatics（生物信息学）
- Syntactic pattern recognition（语义模式识别）
- Medical diagnosis（医学诊断）
- Brain-machine interfaces（脑机接口）
- Cheminformatics（化学信息学）
- Detecting credit card fraud（检测信用卡诈骗）
- Stock market analysis（股票市场分析）
- Classifying DNA sequences（DNA序列分类）
- Sequence mining（序列挖掘）
- Robot locomotion（机器人定位）
- Speech and handwriting recognition（语音和手写字体识别）
- Game playing（玩游戏）
- Software engineering（软件开发）
- Adaptive websites（自适应网站）
- Computational advertising（计算广告学）
- Computational finance（计算机金融）
- Structural health monitoring（结构性健康监控）
- Sentiment analysis (or opinion mining)（情感分析）
- Affective computing（情感计算）
- Information retrieval（信息检索）
- Recommender systems（推荐系统）

## 经典机器学习问题
给定样本集合（训练集），我们希望建立一个能够预测出新数据的模型。

例如：
- Spam filtering（垃圾邮件检测）
    * 邮件是垃圾邮件？或者不是？
- Medical diagnosis（医学诊断）
    * 这些预测结果是否暗示了恶性或良性？
- Natural language processing（自然语言处理）
    * 这些语句在问些什么？
- Face recognition（人脸识别）
    * 照片里的人是谁？
- Chess（象棋）
    * 现在该走哪一步？

### 一个机器学习问题的组成成分
- Task（任务）：需要不断被增强的行为或任务，例如：*分类*，*目标检测*等
- Data（数据）：用于提升Task（任务）性能的经验。
- Measure of performance（性能衡量指标）：如何来衡量性能的提升？例如：
    * 提供更准确的解决方案（例如：增加预测的准确性）
    * 覆盖更多的问题
    * 降低获取答案的成本（例如：速度的提升）
    * 简化可编码知识
    * 一开始没有表现出的新技能

## 机器学习的必要要素
- Prior assumptions（先验假设）
    * 我们知不知道一个问题的先验条件？
- Data（数据）
    * 我们有什么类型的数据？
- Representation（表达）
    * 我们如何表达数据？
- Model / hypothesis space（模型/假设 空间）
    * 我们希望形成怎样的模型假设类解释数据？
- Feedback / learning signal（反馈/学习信号）
    * 我们拥有什么类型的学习信号（标签之类的）?
- Learning algorithm（学习算法）
    * 我们如何从反馈中更新模型或一系列的假设？
- Evaluation（评估预测）
    * 我们做的有多好？我们是否需要优化模型？

## 机器学习的主要类型
- 监督学习
    * 提供标记好的训练数据
    * 给出正确的答案 - 一对【输入/输出】
- 半监督学习
    * 提供一部分标记好的训练数据，另一部分未标记的数据
    * 给出一部分正确答案，另一部分未知
- 强化学习
    * 提供随机的，经常性延迟的信息或奖励
    * 例如：赢了或输了游戏（但是没有针对单独的步数做出反馈）
- 非监督学习
    * 没有直接的学习信号或标记
    * 任务通常是寻找出数据中的结构（例如：聚类、降维）

### 部分机器学习问题
下图针对了部分机器学习类型进行了归类分析：

![机器学习问题归类](/wiki/data/images/ML/0-2.png)

## 训练、检验、测试数据集
通常情况下，我们将数据集划分为下面三个子数据集：
- **训练数据**是用来学习模型的参数的
- **检验数据**是用来决定哪个模型是最优的
- **测试数据**是用来得到一个最终的，对于模型性能评估的无偏估计

具体使用流程如下：
![机器学习问题归类](/wiki/data/images/ML/0-3.png)

## 经典AI与机器学习方法
> 经典AI方法 - 演绎推理（Deductive reasoning）
- 思考世界的本质
- 写下能够概括智能行为的规则
- 总希望能够充分的覆盖真实世界的各类情况

> 机器学习 - 归纳推理（Inductive reasoning）
- 搜集海量的数据
- 提供一个学习框架（事先指明一些目标）
- 期望能够通过数据抽象出一些有意义的通用概念

### 演绎推理和归纳推理
- 演绎推理（Deductive reasoning）：从一系列已知事实和规则中学习到额外的能够保证为真的规则
- 归纳推理（Inductive reasoning）：从一系列样本中学习到一些通用规则，这些规则应当能够适应新的样本，但是不能够保证结果一定是正确的

### 小结
事实上可以理解为：经典AI是人为制定规则来模拟世界规则，而机器学习则是通过从海量的数据中学习世界规则

## 机器学习系统
一个基础的机器学习系统如下所示：
![机器学习系统](/wiki/data/images/ML/0-4.png)

- 一个**任务**要求有一个合适的**映射**：用特征描述的数据 -> 一个模型 -> 输出
    * 从训练数据中获取这样的模型就是所谓的：**学习问题**
- **任务**是由模型进行处理的
- **学习问题**可以通过**学习算法**（学习算法可以产生模型）来解决

## 总结
以上就是一些机器学习基础概念的介绍，作此笔记，便于查找。

