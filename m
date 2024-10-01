Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3D3A268;
	Tue,  1 Oct 2024 01:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747783; cv=none; b=gC58QqD/CNIrBEweGfd7F7tNFPCYFhvZNHNTJMLAuSztqjVenPYyh7EM9+oIP1EZWI6O5c3hCsues1e52+ccJMG027KlKzlVEptGhd5UvP3XeVXrc5LrGEg2RDqmKa0w47tHpQuENDfp3DiMPDmmMrzxtq5FMswWMzR+n4PBK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747783; c=relaxed/simple;
	bh=/XT/oy841jkXk2iUFGLYxvWw15d7q2cV7tmgzrF8xqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tc3cQaTOQ8jc68Av8B5xc056nhoVPLFxr3CH/bbM/kz1HQ5FnEYsZzxGYswndcQiKyKmDFmsx7QoKK5mljYrLvYUoBLmfLGEjTIp++dOplBkm3i/UGEFYhVy4Tr/Bxg1vhiftFgBkH4vUaquWDscyG9HqVwZDfsIiq7VR0Kamh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfKQZMNe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfKQZMNe"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20afdad26f5so64170065ad.1;
        Mon, 30 Sep 2024 18:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727747781; x=1728352581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=otGxTPtCO/PQwOU37QhKHhOTP56T1/H6NEa7wGOOsQg=;
        b=OfKQZMNe9P5tFYlAjvmDW02AI9WGWr8DiN8BKvfAYa0B5MdBRmu5MXV3dCzpQOGmOx
         gRPGFeuA0PrnJ2OW/cNeV6lp1qCsmSKuFpu2DAF1gKYW/kL5kZ2PnBhn5h6eJ6hXlrR0
         CPBzXcB/ZPx+36eleJiHamkE35pVF/ZiWfC87JxFrdf0RrM3W8KJw54pL4wWv9cwxX0z
         9s4bZc5K3gdWUsDcnC4i1ZsUXWDIqNMnZVe9RftyuNXi3eGxutOZKM+3w7AdPSUY3UT+
         ZKzm9wAuQnEC9zwsSlptp8A973v81UpUURUqwPAelDCQPWUJufhJRWLkcLPnxlUo2dmO
         xxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727747781; x=1728352581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otGxTPtCO/PQwOU37QhKHhOTP56T1/H6NEa7wGOOsQg=;
        b=nWLwWXBiIc35dfG8jFdnvQ87LVTi+z3yvQv6LG8j7dMagYcpFgiT08mBKCqS+vbqLA
         KdGinw+o/1YjKrUg2UPPR5hEae9UKbSYFPT4MzHffSCgo1V9oIzVPfs1g0UYtPVWQEPf
         3gwiZnDw40P20WVa0f3TAkuL8EbmMKtzVoabeGZmizpMN73j84Vuy8MbzWnUcQKlxKQG
         ofprPvINbkvhpK8jIcee7vHY/5HRxcFEbQEHclClcBJoUEQJwrqNeKZbMxzahrb2l6lT
         7QA238qbuqP8ovTntVq6M10sQJjYsBsdfAV4fCGXE752eip2YdJuMfyNQGf4z6iYzUsW
         2K+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOEdamCCMFO0JE82hcgJBpZxscqTpEtIwC+pgsLqlS1AaaGjdnWpUdTD16Tjqh2WwihiWGpANeK/1Avg==@vger.kernel.org, AJvYcCVlMQzsd2lTQqQ/epmtwLiFBru9+8+sE+kd4rgguXkDCJ+ULmDATrMIWhv2CkOepbhYUtFhKqfp@vger.kernel.org, AJvYcCX72J9idYRp5vx0rIizOoELfeywgys5gLtHR+Ij4DJ+baF4SbAzs1/v4N2VXljMQaBCjoBpkUw9rSaJmLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6J1m9FIMZwrtexgeuTZE2CL4nNRML51z0Inqrt5WLeEWQ0ilh
	Bd7964M+sfvQ7Bg51Z1HD86MLvqXR+f2+Hsz5LIm2hjEIjBc0qWY
X-Google-Smtp-Source: AGHT+IGcoX9CRMGIJb99/xQCYHBJv1/W+zXd4GPEqwx+yZdp2G3vWZ2Hii0by/fJup1klqrL4e/xzQ==
X-Received: by 2002:a17:902:e5c4:b0:20b:b21e:db10 with SMTP id d9443c01a7336-20bb21eddddmr9982455ad.45.1727747781071;
        Mon, 30 Sep 2024 18:56:21 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37e4332csm60315135ad.215.2024.09.30.18.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 18:56:20 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: danielyangkang@gmail.com,
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Subject: [PATCH] fixed rtnl deadlock from gtp
Date: Mon, 30 Sep 2024 18:55:54 -0700
Message-Id: <20241001015555.144669-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes deadlock described in this bug:
https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd.
Specific crash report here:
https://syzkaller.appspot.com/text?tag=CrashReport&x=14670e07980000.

DESCRIPTION OF ISSUE
Deadlock: sk_lock-AF_INET --> &smc->clcsock_release_lock --> rtnl_mutex

rtnl_mutex->sk_lock-AF_INET
rtnetlink_rcv_msg() acquires rtnl_lock() and calls rtnl_newlink(), which
eventually calls gtp_newlink() which calls lock_sock() to attempt to
acquire sk_lock.

sk_lock-AF_INET->&smc->clcsock_release_lock
smc_sendmsg() calls lock_sock() to acquire sk_lock, then calls
smc_switch_to_fallback() which attempts to acquire mutex_lock(&smc->...).

&smc->clcsock_release_lock->rtnl_mutex
smc_setsockopt() calls mutex_lock(&smc->...). smc->...->setsockopt() is
called, which calls nf_setsockopt() which attempts to acquire
rtnl_lock() in some nested call in start_sync_thread() in ip_vs_sync.c.

FIX:
In smc_switch_to_fallback(), separate the logic into inline function
__smc_switch_to_fallback(). In smc_sendmsg(), lock ordering can be
modified and the functionality of smc_switch_to_fallback() is
encapsulated in the __smc_switch_to_fallback() function.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Tested-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd
---
 net/smc/af_smc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0316217b7..e04f132be 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -895,11 +895,15 @@ static void smc_fback_replace_callbacks(struct smc_sock *smc)
 	write_unlock_bh(&clcsk->sk_callback_lock);
 }
 
-static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
+/* assumes smc->clcsock_release_lock is held during execution
+ * reason for separating locking is to give flexibility in
+ * lock ordering in functions wanting to call smc_switch_to_fallback
+ * so that deadlocks can be avoided.
+ */
+static inline int __smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
 {
 	int rc = 0;
 
-	mutex_lock(&smc->clcsock_release_lock);
 	if (!smc->clcsock) {
 		rc = -EBADF;
 		goto out;
@@ -923,6 +927,13 @@ static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
 		smc_fback_replace_callbacks(smc);
 	}
 out:
+	return rc;
+}
+
+static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
+{
+	mutex_lock(&smc->clcsock_release_lock);
+	int rc = __smc_switch_to_fallback(smc, reason_code);
 	mutex_unlock(&smc->clcsock_release_lock);
 	return rc;
 }
@@ -2762,13 +2773,15 @@ int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	int rc;
 
 	smc = smc_sk(sk);
+	/* acquire smc lock before sk to avoid deadlock with rtnl */
+	mutex_lock(&smc->clcsock_release_lock);
 	lock_sock(sk);
 
 	/* SMC does not support connect with fastopen */
 	if (msg->msg_flags & MSG_FASTOPEN) {
 		/* not connected yet, fallback */
 		if (sk->sk_state == SMC_INIT && !smc->connect_nonblock) {
-			rc = smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
+			rc = __smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
 			if (rc)
 				goto out;
 		} else {
@@ -2790,6 +2803,7 @@ int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	}
 out:
 	release_sock(sk);
+	mutex_unlock(&smc->clcsock_release_lock);
 	return rc;
 }
 
-- 
2.39.2

