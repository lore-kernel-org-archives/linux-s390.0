Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD28BE0;
	Thu, 29 Aug 2024 03:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903818; cv=none; b=Pj6+EyO3qhodZBLufuQUDyR0sL+kj6ciX+D3rPtcrQcWTNga02WmcmV5qHhbIeFayl8PWE3/STQK/dQ+urQk0pvRKWrsJYFcmAv1szCfuFS+WA2sgqhMQqoOYGP9Xq5U01NuJC+TziyZH2f6NVeJrTcezemxpUePIo1bPqeCOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903818; c=relaxed/simple;
	bh=ih7mSoXIP1+DeAmO3FwN1kCNuXc0wfOWkDXPC64sAOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PIfwt4tg3YE9Beyh/9xG8mYUPw4DgFTnG5Xz8k87aCPCveOMQ4nThLlNlSFe+HPh8WkZ3uRLGVYxyplhSbe7qvnjQ9ypTkVQYAi5av0rXIKeavwB5y5os3LFI589dTXGQyKoGyLbNBfVqYCf3t3u2iNcrV6ky7hkmxQHVzNFpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaxR3mA+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaxR3mA+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7143165f23fso178140b3a.1;
        Wed, 28 Aug 2024 20:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724903816; x=1725508616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq3h87UDYd68mWlRGjkd+Gz89++x4v5tn1y6q+lZp54=;
        b=AaxR3mA+ZI7nJPO/lbbJP+ACIciPL/7q7+QvSH6IMsbzdQCNnhZ3U+oo7bWN/GupNl
         /71hQFV+RIrvr1QBsZXCsgv93+5KiYRtgrI2yZdbClWCpcxbYckLXKnPZ4Wehyeldk1N
         v4P3ykIIbb2b0/bREvcAdgbW/lu42x/M/VLiWvJQI7CL/u/j1kt6yOYFhBRvZ6YBPbtM
         0nPEHww12nX31P3AddIxowZ6/JjO9zjNhUuTyVmRbY+jiHJWbEH9vO/+EDENzSDGSdrI
         Q7ZCBGaYczx9rY9QmAcHsclOnnxONPP12XzGLnPAcM8iX3c7BiOPh3ElduO8npK5TerO
         bxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724903816; x=1725508616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iq3h87UDYd68mWlRGjkd+Gz89++x4v5tn1y6q+lZp54=;
        b=bHCjrEozJolfUSG0H4SjuFoGjVSOv1tcXcx44Q5CWnNQArcok6pm8qWtA8ixt+ms0b
         bYI9tDwRAj8P793qEq+LI+4ONbvx/HhmfJ/OELtdtfBv8jmevUDOT6JitHWzpnOpV8Pb
         XbdFmDzsLvl2eowi4ltHMYcmM39VFStqBkEX0EnCTkWFEGkjTM9OB9qRzhNkQgFGjMXj
         81R/MiyKAm7Guu80E/k2uVLmfsl/iMIFNYHdmM2BJZwpWCtgj/uXytlMm+3vUpo2KIfQ
         tvvcUorpXP1UckrrEj2/svjtHAuJusY1lZ53Y0pjI85MFTX8nIbcXZr+wEYnUw4eJw09
         G4jg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ct+njmXqM9XXkGKUzr46F7NwaSwbqs8eIT4DntQ9r9gyIPq/pgXfCvoW0URiUY8Rr3MzVL/r@vger.kernel.org, AJvYcCWXAK+iSkeqGyT2TdaDaKJGrTVpOrCaVE8BcY1hGepFVycFua479AH2vMyj23VyqKP7Y9V7Ko0b8cPE1g==@vger.kernel.org, AJvYcCXaeIcnDyp23br/ZTzSkkX6p4VR2c4RiIgO9ExZz4t09ysNBVhegXT567YcXm9+kzlafPqLbL7nJTA6Gic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4/siMUOVMQk1HO0sjoTjmBZWodIY3dHL7q6BtGHLtNysKu2z
	r7ie7uMNBqQZ3X/c5WWd3xVotIoe53rybEWBr3ShKitOG8nFex9G
X-Google-Smtp-Source: AGHT+IHXiamxYiPf82bBRuAsBYfYPnMSCnlE7pJFYWqEQeCMbALf87ypH0ewGPiQ8V22ddPFxMdGog==
X-Received: by 2002:a05:6a20:e607:b0:1cc:be05:ffe2 with SMTP id adf61e73a8af0-1cce100ec67mr1358353637.18.1724903816035;
        Wed, 28 Aug 2024 20:56:56 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446f3c3bsm2786057a91.50.2024.08.28.20.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:56:55 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dust.li@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net,v7] net/smc: prevent NULL pointer dereference in txopt_get
Date: Thu, 29 Aug 2024 12:56:48 +0900
Message-Id: <20240829035648.262912-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create()
copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet6.

In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
point to the same address, when smc_create_clcsk() stores the newly
created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
into clcsock. This causes NULL pointer dereference and various other
memory corruptions.

To solve this problem, you need to initialize ipv6_pinfo_offset, add a 
smc6_sock structure, and then add ipv6_pinfo as the second member of 
the smc_sock structure.

Reported-by: syzkaller <syzkaller@googlegroups.com>
Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/smc/smc.h      | 3 +++
 net/smc/smc_inet.c | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 34b781e463c4..ad77d6b6b8d3 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -284,6 +284,9 @@ struct smc_connection {
 
 struct smc_sock {				/* smc sock container */
 	struct sock		sk;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct ipv6_pinfo	*pinet6;
+#endif
 	struct socket		*clcsock;	/* internal tcp socket */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index bece346dd8e9..a5b2041600f9 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -60,6 +60,11 @@ static struct inet_protosw smc_inet_protosw = {
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
+struct smc6_sock {
+	struct smc_sock		smc;
+	struct ipv6_pinfo	inet6;
+};
+
 static struct proto smc_inet6_prot = {
 	.name		= "INET6_SMC",
 	.owner		= THIS_MODULE,
@@ -67,9 +72,10 @@ static struct proto smc_inet6_prot = {
 	.hash		= smc_hash_sk,
 	.unhash		= smc_unhash_sk,
 	.release_cb	= smc_release_cb,
-	.obj_size	= sizeof(struct smc_sock),
+	.obj_size	= sizeof(struct smc6_sock),
 	.h.smc_hash	= &smc_v6_hashinfo,
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
+	.ipv6_pinfo_offset	= offsetof(struct smc6_sock, inet6),
 };
 
 static const struct proto_ops smc_inet6_stream_ops = {
--
