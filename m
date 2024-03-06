Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D1131738;
	Wed,  6 Mar 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732790; cv=none; b=BVqyGR7UWV9VpDe+uGJ/I+mgf1FvnvnpR5SgVKE00alsgDlselMpPwDgYlylWHzboKFqHDhsFPF+/9qAZRA9DjUDzlgav6MLFRd9Ax9HJYTw3fMRoZH4ToDwcico+s/8vHHthhSrpKTOT+hUijGTbgBnzm+ZCSeAyWF2e/JS0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732790; c=relaxed/simple;
	bh=FqZikm1h341JKeQ19rJhJkZB1KxW9XraWNQ9MAjVbAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHjesZ1kUka7sQXLTbCNv1TDDfKpvcP011rGHRcJb/sbUE4ifQiceeeVEpIAt5e0rZTPgPnhcwee9/dZ7astVBUUJI3XYZfT43BfKX0WeXHYL5vFI4qpPQOl2qlDVPoWwQwZ6AwPAWhoJpfw1xMJRiuoCkCw7ur8NUeuYRxxVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=DB3G38YQ; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DB3G38YQ"
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:319b:0:640:ce08:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id ACAFD609DA;
	Wed,  6 Mar 2024 16:46:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Fkgod19BZGk0-v5wexYnx;
	Wed, 06 Mar 2024 16:46:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1709732776; bh=53XUHuuo2f90rqfuQwmCICt5APD+L6PmabtkDDU7t9k=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=DB3G38YQaqPBgVum9MmkisD5rf9leNKQeexayQiCBTsPv36Uxej4fNs8I0/Vx3DZg
	 rrwCU14j9AHlrs3ZJJLVAvFyxLl2FCGxvJEDgFMAet1Q8f17Fnwg6qU8aq7KFVvuaJ
	 LSGA4O1JhoemWjkwyNMlaiHr7l8a7pQAoEnOJ1SE=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jan Karcher <jaka@linux.ibm.com>
Cc: Wen Gu <guwen@linux.alibaba.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [RFC] net: smc: fix fasync leak in smc_release()
Date: Wed,  6 Mar 2024 16:44:24 +0300
Message-ID: <20240306134424.64314-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://syzkaller.appspot.com/bug?extid=5f1acda7e06a2298fae6 may be
tracked down to the problem illustrated by the following example:

int sock;

void *loop0(void *arg) {
        struct msghdr msg = {0};

        while (1) {
                sock = socket(AF_SMC, SOCK_STREAM, 0);
                sendmsg(sock, &msg, MSG_FASTOPEN);
                close(sock);
        }
        return NULL;
}

void *loop1(void *arg) {
        int on;

        while (1) {
                on = 1;
                ioctl(sock, FIOASYNC, &on);
                on = 0;
                ioctl(sock, FIOASYNC, &on);
        }

        return NULL;
}

int main(int argc, char *argv[]) {
        pthread_t a, b;
        struct sigaction sa = {0};

        sa.sa_handler = SIG_IGN;
        sigaction(SIGIO, &sa, NULL);

        pthread_create(&a, NULL, loop0, NULL);
        pthread_create(&b, NULL, loop1, NULL);

        pthread_join(a, NULL);
        pthread_join(b, NULL);

        return 0;
}

Running the program above, kernel memory leak (of 'struct fasync_struct'
object) may be triggered by the following scenario:

Thread 0 (user space):      Thread 1 (kernel space):

int on;
...
on = 1;
ioctl(sock, FIOASYNC, &on);
                            ...
                            smc_switch_to_fallback()
                            ...
                            smc->clcsock->file = smc->sk.sk_socket->file;
                            smc->clcsock->file->private_data = smc->clcsock;
                            ...
on = 0;
ioctl(sock, FIOASYNC, &on);

That is, thread 1 may cause 'smc_switch_to_fallback()' and swap kernel
sockets (of 'struct smc_sock') behind 'sock' between 'ioctl()' calls
in thread 0, so thread 0 makes an attempt to add fasync entry to one
socket (base) but remove from another one (CLC). When 'sock' is closing,
'__fput()' calls 'f_op->fasync()' _before_ 'f_op->release()', and it's
too late to revert the trick performed by 'smc_switch_to_fallback()' in
'smc_release()' and below. Finally there is a leaked 'struct fasync_struct'
object linked to the base socket, and this object is noticed by
'__sock_release()' with "fasync list not empty" message.

This patch makes an attempt to address this issue by introducing the wait
queue shared between base and CLC sockets, and using this wait queue in
'sock_async()'. This guarantees that all FIOASYNC changes always touches
the same list of 'struct fasync_struct' objects and thus may be issued
anytime regardless of an underlying base to CLC socket switch performed
by 'smc_switch_to_fallback()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/sock.h |  4 ++++
 net/smc/af_smc.c   | 10 ++++++----
 net/smc/smc.h      |  3 +++
 net/socket.c       |  4 +++-
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 54ca8dcbfb43..01b17654c289 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -422,6 +422,10 @@ struct sock {
 		struct socket_wq	*sk_wq_raw;
 		/* public: */
 	};
+
+	/* special AF_SMC quirk */
+	struct socket_wq	*sk_wq_shared;
+
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0f53a5c6fd9d..a00b6ae02b48 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -922,10 +922,8 @@ static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
 	if (smc->sk.sk_socket && smc->sk.sk_socket->file) {
 		smc->clcsock->file = smc->sk.sk_socket->file;
 		smc->clcsock->file->private_data = smc->clcsock;
-		smc->clcsock->wq.fasync_list =
-			smc->sk.sk_socket->wq.fasync_list;
-		smc->sk.sk_socket->wq.fasync_list = NULL;
-
+		/* shared wq should be used instead */
+		WARN_ON(smc->sk.sk_socket->wq.fasync_list);
 		/* There might be some wait entries remaining
 		 * in smc sk->sk_wq and they should be woken up
 		 * as clcsock's wait queue is woken up.
@@ -3360,6 +3358,10 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
 		smc->clcsock = clcsock;
 	}
 
+	/* use shared wq for sock_async() */
+	sock->sk->sk_wq_shared = &smc->smc_wq;
+	smc->clcsock->sk->sk_wq_shared = &smc->smc_wq;
+
 out:
 	return rc;
 }
diff --git a/net/smc/smc.h b/net/smc/smc.h
index df64efd2dee8..7403b7b467da 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -287,6 +287,9 @@ struct smc_sock {				/* smc sock container */
 						/* protects clcsock of a listen
 						 * socket
 						 * */
+	struct socket_wq	smc_wq;		/* used by both sockets
+						 * in sock_fasync()
+						 */
 };
 
 #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
diff --git a/net/socket.c b/net/socket.c
index ed3df2f749bf..b16d45b8c875 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1437,11 +1437,13 @@ static int sock_fasync(int fd, struct file *filp, int on)
 {
 	struct socket *sock = filp->private_data;
 	struct sock *sk = sock->sk;
-	struct socket_wq *wq = &sock->wq;
+	struct socket_wq *wq;
 
 	if (sk == NULL)
 		return -EINVAL;
 
+	wq = unlikely(sk->sk_wq_shared) ? sk->sk_wq_shared : &sock->wq;
+
 	lock_sock(sk);
 	fasync_helper(fd, filp, on, &wq->fasync_list);
 
-- 
2.44.0

