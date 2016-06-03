From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Fri, 03 Jun 2016 15:27:00 +0000
Subject: [PATCH net-next 01/15] net: introduce keepalive function in struct proto
Message-Id: <201606031528.u53FQ0Ue037267@mx0a-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Direct call of tcp_set_keepalive() function from protocol-agnostic
sock_setsockopt() function in net/core/sock.c violates network
layering. And newly introduced protocol (SMC-R) will need its own
keepalive function. Therefore, add "keepalive" function pointer
to "struct proto", and call it from sock_setsockopt() via this pointer.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Utz Bacher <utz.bacher@de.ibm.com>
---
 include/net/sock.h   | 1 +
 net/core/sock.c      | 7 ++-----
 net/ipv4/tcp_ipv4.c  | 1 +
 net/ipv4/tcp_timer.c | 1 +
 net/ipv6/tcp_ipv6.c  | 1 +
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 649d2a8..454eefc 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -988,6 +988,7 @@ struct proto {
 	int			(*getsockopt)(struct sock *sk, int level,
 					int optname, char __user *optval,
 					int __user *option);
+	void			(*keepalive)(struct sock *sk, int valbool);
 #ifdef CONFIG_COMPAT
 	int			(*compat_setsockopt)(struct sock *sk,
 					int level,
diff --git a/net/core/sock.c b/net/core/sock.c
index 08bf97e..8493b27 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -760,11 +760,8 @@ set_rcvbuf:
 		goto set_rcvbuf;
 
 	case SO_KEEPALIVE:
-#ifdef CONFIG_INET
-		if (sk->sk_protocol == IPPROTO_TCP &&
-		    sk->sk_type == SOCK_STREAM)
-			tcp_set_keepalive(sk, valbool);
-#endif
+		if (sk->sk_prot->keepalive)
+			sk->sk_prot->keepalive(sk, valbool);
 		sock_valbool_flag(sk, SOCK_KEEPOPEN, valbool);
 		break;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 3708de2..9f2b00b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2332,6 +2332,7 @@ struct proto tcp_prot = {
 	.shutdown		= tcp_shutdown,
 	.setsockopt		= tcp_setsockopt,
 	.getsockopt		= tcp_getsockopt,
+	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
 	.sendpage		= tcp_sendpage,
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index debdd8b..66d0c05 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -565,6 +565,7 @@ void tcp_set_keepalive(struct sock *sk, int val)
 	else if (!val)
 		inet_csk_delete_keepalive_timer(sk);
 }
+EXPORT_SYMBOL(tcp_set_keepalive);
 
 
 static void tcp_keepalive_timer (unsigned long data)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 79e33e0..03ae520 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1875,6 +1875,7 @@ struct proto tcpv6_prot = {
 	.shutdown		= tcp_shutdown,
 	.setsockopt		= tcp_setsockopt,
 	.getsockopt		= tcp_getsockopt,
+	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
 	.sendpage		= tcp_sendpage,
-- 
2.6.6
