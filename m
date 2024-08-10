Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A01370;
	Sat, 10 Aug 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723310589; cv=none; b=EM8KeOkhvUgzPm5AdxKSk9itqgizyvJylmsupcGlKOYoSUecUjsgjwTPRRuMbFF+jdxrIeBqFgUvLS5tadN/KaOdhp8CC5wGZqPYtndPjioY5hmZCz/6nTze3g0ngUrgR1SlmfCARMCSzGhb3cVBSWN1CzBhgsxyMPolX+UOI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723310589; c=relaxed/simple;
	bh=+g8Glx7sWnogUVdK4S5wG26sURgZcn4rilFx2H5dEzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uxU/a0AqHBbcT3mmiwkaXP5MXTGKoFllQ/+1lbDuyRHrLoor9iPHuQYfZ6ZhM5ifPgf3bZqdq+agmwjBhBz+ghLgmzfmoAw14GKXi8CRo+TuNYLTWvG/GWs8LgLCAOYFf/S26sHibXeIsL76J5PnVoseby+h9A+I83mqhRE3ldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/hdSn8T; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/hdSn8T"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso2796592b3a.0;
        Sat, 10 Aug 2024 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723310587; x=1723915387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=affVC0k0qR7e3AGVdqhTReSVRgzWoVwHV++rpK4cDus=;
        b=O/hdSn8TuUO/lQ7V1g+hBr9cbiKc3NFqyG9SlPrDdmNTy/RVRHQzb+Ag/TgBBU0cKE
         JHieQbRWGTMf00epZCuGoET/qCcMmgmEvHz//e26iJ0aiD0L7YTuCGdiQwejvz7bJZeF
         Mf1pq6feVApDUStKiJX05S+RwUAgs4LygEY6sTlKuwJltcZD2hqTqiGNhLX8b7fXTrgb
         HBCmo7lkc84lWZWdwKfrKepW3mXfcZXhjl3u0+etLQc9FFVZb+Zgy1TlnJej6kLlFPa3
         XJo7GHcWRcZD60MgrnCivBsmzR9LnVOSEjJlnTFViEDSd3VWdkifcBpqLyh352kGvlq2
         1q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723310587; x=1723915387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=affVC0k0qR7e3AGVdqhTReSVRgzWoVwHV++rpK4cDus=;
        b=PuKzCbwzNMzIWgJm7FKqs0uLpjyHfL52zJnPC17ZWAnqdig1GwIk5G3gEPPkfWaSjK
         lRpdKtsfCwekib8ek0YFX5YFNi0EWe1vJnPnSVcf7JMaR4By73p6DJcIMPacMPhlNs14
         a/Scytn/wIolUeSC0HmYcRn2rAYiEItsflcc9PBSswBy7Xru9LNch11/dVec085R+3KJ
         K6mzCyJ8vnv4ShG6hlDrz/WDd7uEboOg3PDvvU7kH6FtCvQ6uoYFB7lESErUmTEG6xIo
         /Gko89cl/8fc7smjhu4qfzzQnUBUqgzojtmMIkjp+Ojc7PM32ohEmCQkw9zP5wEyS4KO
         Bgrw==
X-Forwarded-Encrypted: i=1; AJvYcCUNCjci2tXoYDD3KOQ4XabO+Gyg1DwJ8oeJaOKhaEkG4tCkZel+idyNsfG2SAtX/Gj8QfE4cvuU8+Nmlw8=@vger.kernel.org, AJvYcCVgbRzTjNdUTL/9/8B8EHxamuyVeg70/ubUV9JcxSi2oBkKyisMrC6GHMmNLeHxijhaziGb4rAk@vger.kernel.org, AJvYcCWlRgy0VDj51hQog1nnHXA+oXmlNMf6EPWO0CEFTqXLqA/alAx4l/0fxG+4P/KFVgZ91+ITk2m+xeAecA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSXUfci9W7kDzfDcmWyx57Vy0YDI7LXHq4/IUUCOU4qqQ2EXR
	xspqBEiR06ldZIY8PGiDmJnT3a+U8Znq94lpSDeO1mRPcV2mF/jN
X-Google-Smtp-Source: AGHT+IGzxKli0I5QQg/8BvEj4e4bjep+wHRetZtYVau7DPusytDJRfO55WYb0vGyWz2NmAHpT01h/A==
X-Received: by 2002:a05:6a20:d498:b0:1c4:944c:41e2 with SMTP id adf61e73a8af0-1c89ff0f1f9mr8104927637.51.1723310586843;
        Sat, 10 Aug 2024 10:23:06 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbea2332sm1524959a12.86.2024.08.10.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 10:23:06 -0700 (PDT)
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
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] net/smc: prevent NULL pointer dereference in txopt_get
Date: Sun, 11 Aug 2024 02:22:59 +0900
Message-Id: <20240810172259.621270-1-aha310510@gmail.com>
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

[  278.629552][T28696] ==================================================================
[  278.631367][T28696] BUG: KASAN: null-ptr-deref in txopt_get+0x102/0x430
[  278.632724][T28696] Read of size 4 at addr 0000000000000200 by task syz.0.2965/28696
[  278.634802][T28696] 
[  278.635236][T28696] CPU: 0 UID: 0 PID: 28696 Comm: syz.0.2965 Not tainted 6.11.0-rc2 #3
[  278.637458][T28696] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  278.639426][T28696] Call Trace:
[  278.639833][T28696]  <TASK>
[  278.640190][T28696]  dump_stack_lvl+0x116/0x1b0
[  278.640844][T28696]  ? txopt_get+0x102/0x430
[  278.641620][T28696]  kasan_report+0xbd/0xf0
[  278.642440][T28696]  ? txopt_get+0x102/0x430
[  278.643291][T28696]  kasan_check_range+0xf4/0x1a0
[  278.644163][T28696]  txopt_get+0x102/0x430
[  278.644940][T28696]  ? __pfx_txopt_get+0x10/0x10
[  278.645877][T28696]  ? selinux_netlbl_socket_setsockopt+0x1d0/0x420
[  278.646972][T28696]  calipso_sock_getattr+0xc6/0x3e0
[  278.647630][T28696]  calipso_sock_getattr+0x4b/0x80
[  278.648349][T28696]  netlbl_sock_getattr+0x63/0xc0
[  278.649318][T28696]  selinux_netlbl_socket_setsockopt+0x1db/0x420
[  278.650471][T28696]  ? __pfx_selinux_netlbl_socket_setsockopt+0x10/0x10
[  278.652217][T28696]  ? find_held_lock+0x2d/0x120
[  278.652231][T28696]  selinux_socket_setsockopt+0x66/0x90
[  278.652247][T28696]  security_socket_setsockopt+0x57/0xb0
[  278.652278][T28696]  do_sock_setsockopt+0xf2/0x480
[  278.652289][T28696]  ? __pfx_do_sock_setsockopt+0x10/0x10
[  278.652298][T28696]  ? __fget_files+0x24b/0x4a0
[  278.652308][T28696]  ? __fget_light+0x177/0x210
[  278.652316][T28696]  __sys_setsockopt+0x1a6/0x270
[  278.652328][T28696]  ? __pfx___sys_setsockopt+0x10/0x10
[  278.661787][T28696]  ? xfd_validate_state+0x5d/0x180
[  278.662821][T28696]  __x64_sys_setsockopt+0xbd/0x160
[  278.663719][T28696]  ? lockdep_hardirqs_on+0x7c/0x110
[  278.664690][T28696]  do_syscall_64+0xcb/0x250
[  278.665507][T28696]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  278.666618][T28696] RIP: 0033:0x7fe87ed9712d
[  278.667236][T28696] Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
[  278.670801][T28696] RSP: 002b:00007fe87faa4fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
[  278.671832][T28696] RAX: ffffffffffffffda RBX: 00007fe87ef35f80 RCX: 00007fe87ed9712d
[  278.672806][T28696] RDX: 0000000000000036 RSI: 0000000000000029 RDI: 0000000000000003
[  278.674263][T28696] RBP: 00007fe87ee1bd8a R08: 0000000000000018 R09: 0000000000000000
[  278.675967][T28696] R10: 0000000020000000 R11: 0000000000000246 R12: 0000000000000000
[  278.677953][T28696] R13: 000000000000000b R14: 00007fe87ef35f80 R15: 00007fe87fa85000
[  278.679321][T28696]  </TASK>
[  278.679917][T28696] ==================================================================

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
index bece346dd8e9..3c54faef6042 100644
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
+	.name		       = "INET6_SMC",
+	.owner		       = THIS_MODULE,
+	.init		       = smc_inet_init_sock,
+	.hash		       = smc_hash_sk,
+	.unhash		       = smc_unhash_sk,
+	.release_cb	       = smc_release_cb,
+	.obj_size	       = sizeof(struct smc6_sock),
+	.h.smc_hash	       = &smc_v6_hashinfo,
+	.slab_flags	       = SLAB_TYPESAFE_BY_RCU,
+	.ipv6_pinfo_offset = offsetof(struct smc6_sock, np),
 };
 
 static const struct proto_ops smc_inet6_stream_ops = {
--
