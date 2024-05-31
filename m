Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23406155A53;
	Fri, 31 May 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145682; cv=none; b=jXpHZXaN/U1O3vSaFI1/67CDQKE7H5hOsWKw790vI884KeH92tjoVqeLC8bvWaZTpmFU8BlKnR4FbxB4l56VaKSrlolTyBWZNIQ2e3zwXw3PT56XP4HgGi9EJ9ssZfbgmA9I468jQV11J/LpwxC6o6F3ezAyAMUMJ836mIjUXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145682; c=relaxed/simple;
	bh=JFEYnpKVhC3OKPMmlFbiYqQ6JmpSsmBSmRlLuUInyTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XgbkS4HAlyQ0OnmJmHoHmYamjzNqY8zDvGmjCMax69iXQgIjEUJkps17Mi/XubLUGtJWmE1aDaDRWyS4jfyh6bUcGBseQmf1SSHBHPU864cdKdtvQSgKJ8v0PTANvMRPAopzoRxAHJSXx7rL87rYPRoU26xkYtOzBu6jAXl3VZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E6Q56tQl; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E6Q56tQl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717145670; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=u45yl/ongPk3D/+8eUViTWu0t7iGmxovN58bXNXSZhI=;
	b=E6Q56tQlOz9ZCIS3rCuk651obBOfEO9XZciEF0mskSpsVfJUJmcdtKnarL748g57sjlYfVvfjzqKrsndHPT3177ZyxjhR61/Xkeb07324ZVsZLewgVYxpLs6jX7PyhM4DczHEP5Bnln2OHMYFW1R7CjPg5xQ0HEgmTwEQS6JQGg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7ZRJhf_1717145657;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W7ZRJhf_1717145657)
          by smtp.aliyun-inc.com;
          Fri, 31 May 2024 16:54:30 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: gbayer@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: avoid overwriting when adjusting sock bufsizes
Date: Fri, 31 May 2024 16:54:17 +0800
Message-Id: <20240531085417.43104-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When copying smc settings to clcsock, avoid setting clcsock's sk_sndbuf
to sysctl_tcp_wmem[1], since this may overwrite the value set by
tcp_sndbuf_expand() in TCP connection establishment.

And the other setting sk_{snd|rcv}buf to sysctl value in
smc_adjust_sock_bufsizes() can also be omitted since the initialization
of smc sock and clcsock has set sk_{snd|rcv}buf to smc.sysctl_{w|r}mem
or ipv4_sysctl_tcp_{w|r}mem[1].

Fixes: 30c3c4a4497c ("net/smc: Use correct buffer sizes when switching between TCP and SMC")
Link: https://lore.kernel.org/r/5eaf3858-e7fd-4db8-83e8-3d7a3e0e9ae2@linux.alibaba.com
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
FYI,
The detailed motivation and testing can be found in the link above.
---
 net/smc/af_smc.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9389f0cfa374..a35281153067 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -459,29 +459,11 @@ static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
 static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock *osk,
 				     unsigned long mask)
 {
-	struct net *nnet = sock_net(nsk);
-
 	nsk->sk_userlocks = osk->sk_userlocks;
-	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK) {
+	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK)
 		nsk->sk_sndbuf = osk->sk_sndbuf;
-	} else {
-		if (mask == SK_FLAGS_SMC_TO_CLC)
-			WRITE_ONCE(nsk->sk_sndbuf,
-				   READ_ONCE(nnet->ipv4.sysctl_tcp_wmem[1]));
-		else
-			WRITE_ONCE(nsk->sk_sndbuf,
-				   2 * READ_ONCE(nnet->smc.sysctl_wmem));
-	}
-	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK) {
+	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		nsk->sk_rcvbuf = osk->sk_rcvbuf;
-	} else {
-		if (mask == SK_FLAGS_SMC_TO_CLC)
-			WRITE_ONCE(nsk->sk_rcvbuf,
-				   READ_ONCE(nnet->ipv4.sysctl_tcp_rmem[1]));
-		else
-			WRITE_ONCE(nsk->sk_rcvbuf,
-				   2 * READ_ONCE(nnet->smc.sysctl_rmem));
-	}
 }
 
 static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
-- 
2.32.0.3.g01195cf9f

