import 'package:event_bus/event_bus.dart';
import 'package:xmw_shop/bean/CommentListEntity.dart';

/// 创建EventBus
EventBus eventBus = EventBus();

/// Event 登录
class LoginEvent {
  LoginEvent();
}

/// Event 切换到第二个分类栏目
class MainChange2Event {
  int index;

  MainChange2Event(this.index);
}

/// Event 切换到BOM分类栏目
class MainChange4Event {
  int index;

  MainChange4Event(this.index);
}

/// Event 切换到帖子分类栏目
class MainChange3Event {
  int index;

  MainChange3Event(this.index);
}

/// Event 发帖成功
class InvitationAddEvent {
  InvitationAddEvent();
}

/// Event 评论成功成功
class EvaluateAddEvent {
  EvaluateAddEvent();
}
