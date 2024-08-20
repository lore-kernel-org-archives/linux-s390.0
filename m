Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4118FDBA;
	Tue, 20 Aug 2024 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156159; cv=none; b=lp2JCrNyd4gGnOq5V1FsYkzJrOhUmDjPgkDxAzcNmTFrdlvRTYNgpyBa2Eln+xdlgrcH9BUZFNpxy6DMQ0BtnQrrV+qiPZSVPZjr6UGvIQhqqaRrPlyeApawo+Io2mGqctjweMB0lfYp3gWtTg6WcWTrM7lsyka1zxqE9qkf2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156159; c=relaxed/simple;
	bh=xDBBSYV6Ptx6rKHiCplnxKfcjX5c3vcd1f7/FKM/Asc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+iVBeqvkcHFsQX5WQY3zuny7U7ksewTaTuFDJOPdgzJifL0QaHw/G2aZ3BP/X5isLvwIUUl5xuHwkVbJbAyvYnhNai9Sv6lbDC7jyCFoXAwyeRX5V8iQiYBNKRHGdfXWsGPy/o+x++Ss+g61wgHgd5bMPSb+EujEpkCI3uhqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuSy3UiI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuSy3UiI"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7104f93a20eso4450297b3a.1;
        Tue, 20 Aug 2024 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724156156; x=1724760956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD+EvjfAKeSYrZd9kcNbKChXbM1ZfpJxz800Ks1luhk=;
        b=CuSy3UiIo0DcIrLtHnuPF4dlbt9oBIAmKUzJQk871oyawilGNLQypgiphOFKILj1Sr
         +KxgTz7kOdWvBO+tALTEZeO0G6ODsGHAJTk9aQTHyJvODhhdhgBEAsPG4xrYDXQ4m3KL
         NFh7R/+Fiydy4whEt6WXIzAe18vfSPTcfDXBLdWN9qus9KTSRge7j2k4BWaJTlFPu33C
         6wBGccsOuM0UFfaylnG/bCkZ9DnqNpSbPmjUSLsx6eJgvN1QcK7DmCriT6ToWw2/g5BH
         eUqduQjiTF2HcCD2Eq850fNxyYLnvqfpVIKje82aysNJoM5ppjY8vEIpGwXAcn3Y7kBM
         tvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724156156; x=1724760956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eD+EvjfAKeSYrZd9kcNbKChXbM1ZfpJxz800Ks1luhk=;
        b=k4XWVbXV16KTKEXHMITPWo03rJVLgUnUU9tLHA1GSBhl8r5k6gAk4Ofm5hYKLVoTgS
         6ev/ERw+C7zY7ggjUluDRTwJm8RvmvGYhCbwJZM6tmzyO3Qh400RJ8iTyCYaMhJP8MGQ
         9WiihnPBenvt6rR6BcGTZvU1qbcO3VCvuw0rtq4er3iI9ARe0pG8F07X1D5QFz/Rt2ab
         g0lut4eNtHQ33zmlDtGmpFRtX+WRQxNcqWFuSs2PTMvQd5SS4U0NA4Y6WF6Td+FOpCHx
         Nn2BaEIvwBmf9TAYKbSY1dW2m/VZS5sOpHRE6odFaqclBemQ9b8rcNjpzelAAMpSmPhF
         iYig==
X-Forwarded-Encrypted: i=1; AJvYcCUp040ncEIcHMR8G2kQ0DhE1lY+gdhEZo1PwiuNTfs332sUW41/lI3ovqkTJMecMdRZAMwqP4RW@vger.kernel.org, AJvYcCWgwe8Z6C/l1rTbKflRJNmKuaSrA2YwU9vulROTWLzdPmXBajEXBNVVSSzV+nGm15OS9g197k5zOSHyLg==@vger.kernel.org, AJvYcCXnpGoXj7SgcU926G0/jXalzttPzfzz5MYLKgNvc0OXic4rxxnemLvSqCF5Szj4ITTyU4Z8ZifjQvrhca0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywAqXh/SRg/N4FOKuyfOFupziE4aPVhz9d7aJVhXFC9QljxUK6
	8JF9JKO/MtsdiiK80r/SyMDwifgpW2hN8P7zQpLlfdw7j7il4j1J
X-Google-Smtp-Source: AGHT+IGabRz64R3uyhBU7oGpUmjzA0HXnaEhvVJh/hSLEKv2/4s0S7VJvxiDK4GYi5T2vMe4Wm/2Iw==
X-Received: by 2002:a05:6a00:2d16:b0:70d:87e0:9e7 with SMTP id d2e1a72fcca58-7140a1e7cb3mr2910803b3a.25.1724156156485;
        Tue, 20 Aug 2024 05:15:56 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c3e5sm8097934b3a.204.2024.08.20.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 05:15:56 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	utz.bacher@de.ibm.com,
	dust.li@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net,v6,2/2] net/smc: initialize ipv6_pinfo_offset in smc_inet6_prot and add smc6_sock structure
Date: Tue, 20 Aug 2024 21:15:48 +0900
Message-Id: <20240820121548.380342-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820121312.380126-1-aha310510@gmail.com>
References: <20240820121312.380126-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create()
copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet6.

To solve this, you need to create a smc6_sock struct and add code to 
smc_inet6_prot to initialize ipv6_pinfo_offset.

Reported-by: syzkaller <syzkaller@googlegroups.com>
Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/smc/smc_inet.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index bece346dd8e9..26587a1b8c56 100644
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
+	.ipv6_pinfo_offset	= offsetof(struct smc6_sock, inet6);
 };
 
 static const struct proto_ops smc_inet6_stream_ops = {
--
