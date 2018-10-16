From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH] net/ipv4: fix tcp_poll for SMC fallback
Date: Tue, 16 Oct 2018 16:45:54 +0200
Message-ID: <20181016144554.49660-1-kgraul@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: netdev@vger.kernel.org
Cc: ubraun@linux.ibm.com, hch@lst.de, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Commit dd979b4df817 ("net: simplify sock_poll_wait") breaks tcp_poll for 
SMC fallback: An AF_SMC socket establishes an internal TCP socket for the 
CLC handshake with the remote peer. Whenever the SMC connection can not be 
established this CLC socket is used as a fallback. All socket operations on the 
SMC socket are then forwarded to the CLC socket. In case of poll, the 
file->private_data pointer references the SMC socket because the CLC socket has 
no file assigned. This causes tcp_poll to wait on the wrong socket.

This patch fixes the issue by (re)introducing a sock_poll_wait variant with 
a socket parameter, and let tcp_poll use this variant.

Fixes: dd979b4df817 ("net: simplify sock_poll_wait")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/net/sock.h | 20 +++++++++++++++++---
 net/ipv4/tcp.c     |  2 +-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 433f45fc2d68..eb2980d48aeb 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2057,14 +2057,14 @@ static inline bool skwq_has_sleeper(struct socket_wq *wq)
 /**
  * sock_poll_wait - place memory barrier behind the poll_wait call.
  * @filp:           file
+ * @sock:           socket to wait
  * @p:              poll_table
  *
  * See the comments in the wq_has_sleeper function.
  */
-static inline void sock_poll_wait(struct file *filp, poll_table *p)
+static inline void _sock_poll_wait(struct file *filp, struct socket *sock,
+				   poll_table *p)
 {
-	struct socket *sock = filp->private_data;
-
 	if (!poll_does_not_wait(p)) {
 		poll_wait(filp, &sock->wq->wait, p);
 		/* We need to be sure we are in sync with the
@@ -2076,6 +2076,20 @@ static inline void sock_poll_wait(struct file *filp, poll_table *p)
 	}
 }
 
+/**
+ * sock_poll_wait - place memory barrier behind the poll_wait call.
+ * @filp:           file
+ * @p:              poll_table
+ *
+ * See the comments in the wq_has_sleeper function.
+ */
+static inline void sock_poll_wait(struct file *filp, poll_table *p)
+{
+	struct socket *sock = filp->private_data;
+
+	_sock_poll_wait(filp, sock, p);
+}
+
 static inline void skb_set_hash_from_sk(struct sk_buff *skb, struct sock *sk)
 {
 	if (sk->sk_txhash) {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 10c6246396cc..a8041729839d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -507,7 +507,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	const struct tcp_sock *tp = tcp_sk(sk);
 	int state;
 
-	sock_poll_wait(file, wait);
+	_sock_poll_wait(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	if (state == TCP_LISTEN)
-- 
2.18.0
