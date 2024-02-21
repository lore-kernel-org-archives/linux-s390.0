Received: from forward202c.mail.yandex.net (forward202c.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C06A35;
	Wed, 21 Feb 2024 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493080; cv=none; b=plhw/zSK5nFkHJ00h+TqAWp8SS1Tvf/I141bH9pfX7RpazdVUGKx572kTFhu1NKUxML7zOPG7t2B+8h+WNf+q1R3AhLCu8rVGUKnAij7G3rH8DH55NrvWmKhCi6CBfNhKs3va1IziR8kCEuDME1uc+DLckPQwMjAlyzculIateE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493080; c=relaxed/simple;
	bh=a4p5gbmw/k1eolUnHnUbHvrsOcZT9FhjC6mTgd1l0Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXRsVP7vrFr8jZg1mOvXz095MdHAWhrhAAB8x5sW0vpYmYIpNZdaRaRP/NN9f6V6Gzw/j1SjC/5R9hqNr+6lOvNb4EOF6yuLV2P8tXjDWSdzP1DFBPKBZUR/fKsqz5ggCb27n6qxcNd06JbhBYUh8Ggc2KTpfnK/tUhrgDX1tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=jB5XvF9I; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jB5XvF9I"
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
	by forward202c.mail.yandex.net (Yandex) with ESMTPS id BC2A26520D;
	Wed, 21 Feb 2024 08:17:36 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id 874C4608FE;
	Wed, 21 Feb 2024 08:17:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QHKu49U1X4Y0-uvxcV13Q;
	Wed, 21 Feb 2024 08:17:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1708492648; bh=HME8FwyWk7ssaEtN9qX9JBIZykLKV2MW7C8QAzR65l8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=jB5XvF9INfihB/jV1B6eSOL7NDLN2aq86T13yrEXgEfN14ZF+cA9enqGQQx8RDqA1
	 NH9ExqcuSrEMZOoywRXoiwq/XSTb/PRlB/v4Q74Gk19J1eUfEX3ygLQdR7Oinypf/o
	 EXvFqnSzMsUBYzatAWa48DssNpoj4LcH9AfWsIrU=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [RFC] net: smc: fix fasync leak in smc_release()
Date: Wed, 21 Feb 2024 08:16:08 +0300
Message-ID: <20240221051608.43241-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've tracked https://syzkaller.appspot.com/bug?extid=5f1acda7e06a2298fae6
down to the problem which may be illustrated by the following pseudocode:

int sock;

/* thread 1 */

while (1) {
       struct msghdr msg = { ... };
       sock = socket(AF_SMC, SOCK_STREAM, 0);
       sendmsg(sock, &msg, MSG_FASTOPEN);
       close(sock);
}

/* thread 2 */

while (1) {
       int on = 1;
       ioctl(sock, FIOASYNC, &on);
       on = 0;
       ioctl(sock, FIOASYNC, &on);
}

That is, something in thread 1 may cause 'smc_switch_to_fallback()' and
swap kernel sockets (of 'struct smc_sock') behind 'sock' between 'ioctl()'
calls in thread 2, so this becomes an attempt to add fasync entry to one
socket but remove from another one. When 'sock' is closing, '__fput()'
calls 'f_op->fasync()' _before_ 'f_op->release()', and it's too late to
revert the trick performed by 'smc_switch_to_fallback()' in 'smc_release()'
and below. Finally we end up with leaked 'struct fasync_struct' object
linked to the base socket, and this object is noticed by '__sock_release()'
("fasync list not empty"). Of course using 'fasync_remove_entry()' in such
a way is extremely ugly, but what else we can do without touching generic
socket code, '__fput()', etc.? Comments are highly appreciated.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/smc/af_smc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0f53a5c6fd9d..68cde9db5d2f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -337,9 +337,13 @@ static int smc_release(struct socket *sock)
 	else
 		lock_sock(sk);
 
-	if (old_state == SMC_INIT && sk->sk_state == SMC_ACTIVE &&
-	    !smc->use_fallback)
+	if (smc->use_fallback) {
+		/* FIXME: ugly and should be done in some other way */
+		if (sock->wq.fasync_list)
+			fasync_remove_entry(sock->file, &sock->wq.fasync_list);
+	} else if (old_state == SMC_INIT && sk->sk_state == SMC_ACTIVE) {
 		smc_close_active_abort(smc);
+	}
 
 	rc = __smc_release(smc);
 
-- 
2.43.2

