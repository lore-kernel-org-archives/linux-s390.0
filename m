From: frank.blaschka@de.ibm.com
Subject: [patch 4/6] [PATCH] af_iucv: allow retrieval of maximum message size
Date: Wed, 08 Feb 2012 11:19:48 +0100
Message-ID: <20120208102029.462750205@de.ibm.com>
References: <20120208101944.272235343@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=604-af_iucv-query-msg-size.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

For HS transport the maximum message size depends on the MTU-size
of the HS-device bound to the AF_IUCV socket. This patch adds a
getsockopt option MSGSIZE returning the maximum message size that
can be handled for this AF_IUCV socket.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---

 include/net/iucv/af_iucv.h |    1 +
 net/iucv/af_iucv.c         |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/include/net/iucv/af_iucv.h
+++ b/include/net/iucv/af_iucv.h
@@ -132,6 +132,7 @@ struct iucv_sock {
 /* iucv socket options (SOL_IUCV) */
 #define SO_IPRMDATA_MSG	0x0080		/* send/recv IPRM_DATA msgs */
 #define SO_MSGLIMIT	0x1000		/* get/set IUCV MSGLIMIT */
+#define SO_MSGSIZE	0x0800		/* get maximum msgsize */
 
 /* iucv related control messages (scm) */
 #define SCM_IUCV_TRGCLS	0x0001		/* target class control message */
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1633,7 +1633,8 @@ static int iucv_sock_getsockopt(struct s
 {
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv = iucv_sk(sk);
-	int val, len;
+	unsigned int val;
+	int len;
 
 	if (level != SOL_IUCV)
 		return -ENOPROTOOPT;
@@ -1656,6 +1657,13 @@ static int iucv_sock_getsockopt(struct s
 					   : iucv->msglimit;	/* default */
 		release_sock(sk);
 		break;
+	case SO_MSGSIZE:
+		if (sk->sk_state == IUCV_OPEN)
+			return -EBADFD;
+		val = (iucv->hs_dev) ? iucv->hs_dev->mtu -
+				sizeof(struct af_iucv_trans_hdr) - ETH_HLEN :
+				0x7fffffff;
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
