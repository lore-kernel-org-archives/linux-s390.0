Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917CF1607B9;
	Tue, 13 Aug 2024 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543653; cv=none; b=ehseLTND3p31jKRgmia0jbpkfJ00A2e0Yk20an5D4rH12M+FhBJ0p75AuVIyxTjCgqylbr+O9fetQ49BU9jsSGMX9pH+9hvlEHDgQQrNquvem2U2KVX1M9zxhSJXyPphS+nfHH5ZfAU950pgKoyieE6iLdZC1CONzokMyuqQZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543653; c=relaxed/simple;
	bh=1eu+OAMQ6xZiu0tesWEH67lOPbE8XFXCuJ4t02Bf6HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TeeS/+98adYaGCL6w3KlMaNRNMaGTtZnQuFdA7QQdi9SbBrSQfonB1+7nIhWpY32N7y6HXOoJY5g+2zlwuWAaPNEl4wVs7zO1BfbDuaEp1yyjvh/7qMDIoj4+UmeF4h7Pxt1gDAh0TCCyxUg49nJWDM20EiyjGMWMKjy64TaclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjecUxnj; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjecUxnj"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-81fd520fee5so213608439f.2;
        Tue, 13 Aug 2024 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723543650; x=1724148450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNaC4gcNrucQanmjIjqSI/sdAQVUCMeBxqt8+FHM7JQ=;
        b=cjecUxnjNZt+Pz1xrlUXGm6L73KVAI6Ar6pHzmnESCaPNBUybbrNUOPensCSVkjqVJ
         TIXeRR1qJBvmrU9zlaX3mFzk2UqyTUhbvqiZUHcl+pls583aS+ImYN/mSOpfvxZqPGk0
         s5B6eS+aVIyj3bYh0jNjijXVEIZsd3ikqoKlCEw8nNKP1trGB5h1temyEbGPavBG0PcJ
         VkxzRqzAtB4ZmqqabnGJ762sfUrAHFjwihc5hOP+hQWlxP2TAecjgxS6W+IeAwGAhX+u
         z7PjdROQGBAl/2OzEPj8yOGdtmnjDz4nwaOV+qHuIcdgKWTCavlCZ+LV0fPL5G7WrnLS
         M68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543650; x=1724148450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNaC4gcNrucQanmjIjqSI/sdAQVUCMeBxqt8+FHM7JQ=;
        b=mq0hvoufX3QlsMwlqzyHV8AvYd1fVmIYVNhvW2jOJXOe5kL7oqxoGXnOrHeJqt/Mum
         ZJcEsj9SSWlwJAJdihrznAmZ80nIFVMdVU677+nm9NkFJ8SqZdrNDkK+3E2LEb/HinA2
         +yqNFpOS0Vlcs7oEVxoU6EFZxemBXtcf9fG+V3E2pjx4tRrP2yVSi6spzv9oUDjNh5X1
         E61Tkttk5j5nki84GN6T8DOacN4IXPV3Ykk80c3KUvzhedGoxeu3fPNReSdLlpXoq4Mi
         0yItPCA9fq4qLeiYGf7XnfsUBKyNjVYsjJwRxIQfFKGoUqxNrm1eBR2Z6if3Q9i5MCd7
         HikQ==
X-Forwarded-Encrypted: i=1; AJvYcCWesVSeuOYVlXJ4fZnspDCLEvH26j8fyLJmbpn4aXcLlPQraash1Gx7i+JbqGZV+96Zdxn3VYpmzkJZVA==@vger.kernel.org, AJvYcCWj+l7K1jyZMphQuK62C5gH1mcJlOdyUFE9NDg/ohRH2JEk3P4dRK2qVnZ7zgmU877v6vgdDyMoqAoevEk=@vger.kernel.org, AJvYcCXnoUQGyA8C2qW4FlSq8ew1YyRbyr4AEU9C2/ixU3j0VYbTHG9+c1scOc5RF+CBYoJyi3CdXjwB@vger.kernel.org
X-Gm-Message-State: AOJu0YwQC/gjuMGjgRB46Vdra2qOGF+PEgP9qag5rhVQeKjlMvNboLWL
	t/LaT9H5N77FDBtNltxd7UBNCAds9SQZVDAXURK/1GXpSMfXHEFX
X-Google-Smtp-Source: AGHT+IFuRf8XiyHGr8EVtAVRsl76P28vTT/K2BFEBcnSp+Mbwf1NCN054HtXjv3fNwJmP/8N/BbElw==
X-Received: by 2002:a05:6e02:1fc3:b0:39b:324a:d381 with SMTP id e9e14a558f8ab-39c477d0a88mr34253135ab.2.1723543650455;
        Tue, 13 Aug 2024 03:07:30 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a866csm5357505b3a.48.2024.08.13.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:07:30 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	gbayer@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net,v3] net/smc: prevent NULL pointer dereference in txopt_get
Date: Tue, 13 Aug 2024 19:07:22 +0900
Message-Id: <20240813100722.181250-1-aha310510@gmail.com>
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

To solve this, we need to add a smc6_sock structure for ipv6_pinfo_offset
initialization and modify the smc_sock structure.

Reported-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Tested-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/smc/smc.h      | 19 ++++++++++---------
 net/smc/smc_inet.c | 24 +++++++++++++++---------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 34b781e463c4..f4d9338b5ed5 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -284,15 +284,6 @@ struct smc_connection {
 
 struct smc_sock {				/* smc sock container */
 	struct sock		sk;
-	struct socket		*clcsock;	/* internal tcp socket */
-	void			(*clcsk_state_change)(struct sock *sk);
-						/* original stat_change fct. */
-	void			(*clcsk_data_ready)(struct sock *sk);
-						/* original data_ready fct. */
-	void			(*clcsk_write_space)(struct sock *sk);
-						/* original write_space fct. */
-	void			(*clcsk_error_report)(struct sock *sk);
-						/* original error_report fct. */
 	struct smc_connection	conn;		/* smc connection */
 	struct smc_sock		*listen_smc;	/* listen parent */
 	struct work_struct	connect_work;	/* handle non-blocking connect*/
@@ -325,6 +316,16 @@ struct smc_sock {				/* smc sock container */
 						/* protects clcsock of a listen
 						 * socket
 						 * */
+	struct socket		*clcsock;	/* internal tcp socket */
+	void			(*clcsk_state_change)(struct sock *sk);
+						/* original stat_change fct. */
+	void			(*clcsk_data_ready)(struct sock *sk);
+						/* original data_ready fct. */
+	void			(*clcsk_write_space)(struct sock *sk);
+						/* original write_space fct. */
+	void			(*clcsk_error_report)(struct sock *sk);
+						/* original error_report fct. */
+
 };
 
 #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index bece346dd8e9..25f34fd65e8d 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -60,16 +60,22 @@ static struct inet_protosw smc_inet_protosw = {
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
+struct smc6_sock {
+	struct smc_sock smc;
+	struct ipv6_pinfo np;
+};
+
 static struct proto smc_inet6_prot = {
-	.name		= "INET6_SMC",
-	.owner		= THIS_MODULE,
-	.init		= smc_inet_init_sock,
-	.hash		= smc_hash_sk,
-	.unhash		= smc_unhash_sk,
-	.release_cb	= smc_release_cb,
-	.obj_size	= sizeof(struct smc_sock),
-	.h.smc_hash	= &smc_v6_hashinfo,
-	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
+	.name				= "INET6_SMC",
+	.owner				= THIS_MODULE,
+	.init				= smc_inet_init_sock,
+	.hash				= smc_hash_sk,
+	.unhash				= smc_unhash_sk,
+	.release_cb			= smc_release_cb,
+	.obj_size			= sizeof(struct smc6_sock),
+	.h.smc_hash			= &smc_v6_hashinfo,
+	.slab_flags			= SLAB_TYPESAFE_BY_RCU,
+	.ipv6_pinfo_offset		= offsetof(struct smc6_sock, np),
 };
 
 static const struct proto_ops smc_inet6_stream_ops = {
--
