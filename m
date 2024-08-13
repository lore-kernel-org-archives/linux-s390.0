Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629043165;
	Tue, 13 Aug 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543391; cv=none; b=Ld2fkTuXb+G12hRYRkVGKgSlvjaiRf4/z2hHRKZ/tBJo4LuKU+0kwreGORvKeSAykAu7uPK3QObZmWfeOGm9gPPXWTjt+xCybGhBdbO+qNljUVkc6vXe9OWFA/eKXXZ6hvSqCJ8UXJSVixk1OxAu6MpcyudyuknVaiZwhMcrUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543391; c=relaxed/simple;
	bh=CU/3pjFcw+rqJMo9Zw0J9Qej5sIvuE9+onQ2jq6mmjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RyINku8QGBPpLYTCub4QCtQ4aiFZQln+EZ9JS7oQ70HEIpFEOoro/IwowhRr1/xE/Ac66nZbMEaQfRUDfUlZcti0N732Rf1XJ2DvlZfn+j1r4wu/KvLb5L49ly+eXYUpWD4TT5qjSU7/YZFFAfu6ENUkkzqs/GWo5z6mS2BWu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvm93Z8z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvm93Z8z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd65aaac27so42862335ad.1;
        Tue, 13 Aug 2024 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723543389; x=1724148189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlWr7h+QISzkZDuzfGOkZ330zkPe5mVXUP4ufUDh6KA=;
        b=Kvm93Z8znOyRu9jdFOhoXd0eLLzB9tlf2LFWzXjF1BRIrUu5MYpQdbQ6dC3P7hKcgx
         AkCXhuygIAP4hM6fXnfVmR9XHgb16nMfZ076LqP3Lh5tjxt0O/wU+jk31yA/ZD8oCKAP
         cFWuSoNgLA2HMGlntmSGbdqGHfufV9EZ45rONy/rpDqbUoPOfi0s3F9VyZpCOQtJ1y5a
         Bfz9erYh9T7ifFjO8I4RXWjtbldPhJq5vTQ06YMx2ciUjkC3VX03awP6e+c8NYgqauD7
         ulto07nbF0vskTZQX4jSmlfmQybnzWL/oXddcE+YlD25F3UJBoEjPZTA1yxJWiGZlO/F
         dVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543389; x=1724148189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlWr7h+QISzkZDuzfGOkZ330zkPe5mVXUP4ufUDh6KA=;
        b=B/fpGtxs7lfvE6Ehqx/RDyydR+uqxv5F38Nv6keFkJ7uA/adR5gVf4Wfb2tcmBrUy3
         DB3KYCxFgy6dgIPDKqE/f9ZwhYWarT28Ls8d3SUSvS3+SgrR7xBZ4syUzK8DFsNx5S/2
         UynYSmKcxppl4sGyRAXMyIBs/6P8dIEwEqXWJR9y8o/u/DxgBgbTP/Sp3ua8F1f2I8SL
         9ZJdhCZmDLKa/2ER4gt/U+iaYsq2Rv7tdG8YWazHzPzoRfkl8tKbJVfPi0ZyFLP6tXhL
         jPb2uHrol4MaWMs9Zfc7g/TOC69C6Q6LgyeyxVxgGfWli2wabzfRFYEI9iusSxw/RppQ
         B0tw==
X-Forwarded-Encrypted: i=1; AJvYcCVZhNFJlbjm8RQeBmOfJ7LoUjI5CmsEk2mi8gCdQyPReHX4NESsErqPEUPX6YOvLPSl+vvQ3D8sqSuUdJGXyWwBHxu7TgqKc81wxHMpPk17aOpqeQkzQGKs+QZEWDf8DhxEDywWWKH5ZmRKrfKYzQRRrg16u2GIRIe0u/iXBvZ4Qw==
X-Gm-Message-State: AOJu0YxrBMPZckUcoDGy1sTzG2XVSpOHR/+c/5CtC+IMNOjTWTyc6w6s
	e8RANIrt9bxTIxQjD8jDaYB+r+pBeewIz/G4dJfQhH+oHEdVx11U
X-Google-Smtp-Source: AGHT+IE+C+lINQxUVtSRnFABRk5+bu1+A6301+CJsJ6CNolFTJUpzWoO7I+eV4lNT8mqLYuYsSVUJA==
X-Received: by 2002:a17:903:230a:b0:1fc:4aa0:fad2 with SMTP id d9443c01a7336-201cbba9ee2mr39479965ad.6.1723543389163;
        Tue, 13 Aug 2024 03:03:09 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1b4509sm10090235ad.190.2024.08.13.03.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:03:08 -0700 (PDT)
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
Subject: [PATCH net,v2] net/smc: prevent NULL pointer dereference in txopt_get
Date: Tue, 13 Aug 2024 19:03:01 +0900
Message-Id: <20240813100301.180592-1-aha310510@gmail.com>
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
index bece346dd8e9..976644b28735 100644
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
+	.ipv6_pinfo_offset	= offsetof(struct smc6_sock, np),
 };
 
 static const struct proto_ops smc_inet6_stream_ops = {
--
