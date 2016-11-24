From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH V3 net-next 01/15] net: introduce keepalive function in struct proto
Date: Thu, 24 Nov 2016 16:06:31 +0100
Message-ID: <20161124150645.90881-2-ubraun@linux.vnet.ibm.com>
References: <20161124150645.90881-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20161124150645.90881-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com, ubraun@linux.vnet.ibm.com
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
index 442cbb1..cb4359b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -993,6 +993,7 @@ struct proto {
 	int			(*getsockopt)(struct sock *sk, int level,
 					int optname, char __user *optval,
 					int __user *option);
+	void			(*keepalive)(struct sock *sk, int valbool);
 #ifdef CONFIG_COMPAT
 	int			(*compat_setsockopt)(struct sock *sk,
 					int level,
diff --git a/net/core/sock.c b/net/core/sock.c
index 14e6145..ac8137d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -762,11 +762,8 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
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
index 5555eb8..70f5524 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2375,6 +2375,7 @@ struct proto tcp_prot = {
 	.shutdown		= tcp_shutdown,
 	.setsockopt		= tcp_setsockopt,
 	.getsockopt		= tcp_getsockopt,
+	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
 	.sendpage		= tcp_sendpage,
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3ea1cf8..9b1602a 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -617,6 +617,7 @@ void tcp_set_keepalive(struct sock *sk, int val)
 	else if (!val)
 		inet_csk_delete_keepalive_timer(sk);
 }
+EXPORT_SYMBOL(tcp_set_keepalive);
 
 
 static void tcp_keepalive_timer (unsigned long data)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 28ec0a2..5d4f58f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1886,6 +1886,7 @@ struct proto tcpv6_prot = {
 	.shutdown		= tcp_shutdown,
 	.setsockopt		= tcp_setsockopt,
 	.getsockopt		= tcp_getsockopt,
+	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
 	.sendpage		= tcp_sendpage,
-- 
2.8.4
