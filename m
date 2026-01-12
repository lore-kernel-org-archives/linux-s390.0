Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766D2DA75C
	for <linux-s390@vger.kernel.org>; Mon, 12 Jan 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222501; cv=none; b=fYxVOVyhlhwtId8ZgZ2GNvg1wB32QLZK8qCByjBkS2f3/tSzxCnxWnjJaTlJfZUCCXQhz9PmnNUqnGXiqelrr9TmZhHuSLcFDyyioTbr4s03KDen3fBNnz6ue5oep63eA4PYz6SwrMFnUy1fh1hGGuJ7z2YuLyruZLQsXCv3/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222501; c=relaxed/simple;
	bh=g9OI/f7GPo7UC+3XBPVRxdeF9Ovm1CbV3RBtTLw0PK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF6r7kgtjz2I19neFTgK40wAgE2rqZXe9o8oJvlTiY0lojlftR71GzzwCJKpKVR6EFkCoOp4PKK1jkcH4nQWzFt99JLUz4uGg8Ix1LsTN2fsIqSOGIkh3HisaZCTcjPopoqPYhd5E/SMrTrDmsik1sa9KqhBVp2OC4E/qEVAL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJqMrdWz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGrRpuHp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJqMrdWz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGrRpuHp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768222494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Cm1NSak9WVWnM5l9pqLl0T/8D4EW3BK+pbycyB1csg=;
	b=LJqMrdWzcDZO8mRZ0BAXxMDzUJR0rwzNCUwyMr6u7cvNtQfggQ6jBzZ7y3kHcuf1w9+4ns
	gXFQ2U2zYQk/7YOcjdZuVZEuMrmyxsNGzo4uoRVfiuoL8ZEkvdR73f34JVIn/Paa2go7wu
	NUQRAtDZ+BbrZ7v9tglouVl5Dh0cOro=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-9y8XjRKTOQq6mUnGHFa6XQ-1; Mon, 12 Jan 2026 07:54:53 -0500
X-MC-Unique: 9y8XjRKTOQq6mUnGHFa6XQ-1
X-Mimecast-MFC-AGG-ID: 9y8XjRKTOQq6mUnGHFa6XQ_1768222492
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b871403f69eso131479166b.2
        for <linux-s390@vger.kernel.org>; Mon, 12 Jan 2026 04:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768222491; x=1768827291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Cm1NSak9WVWnM5l9pqLl0T/8D4EW3BK+pbycyB1csg=;
        b=PGrRpuHp6XAv6NVVAkpcDp21tm7nihS9zq2XYs//GwixUYEJCwpb0eEmltgx0yJ/xo
         jxY4w0TPH2ypm5YwtIp9lwl0800/iv65+zg0+30xTQ0HmiOGQKDMORpaxmIpd0jbqmrO
         aOpQRgp3pA4UpDAFdhmQCCXKf6AW1WyS5/XNNfk+Ir2vwoBtKtb/MiDnCbFFDoRbAXfE
         MiI7kfETpwEORQDtijJvyLs2zeGCOhFxnHe15ATxC+o473lPMuIHl5o1H3GLtnuGKA8p
         cresY53qFFAm8n0OEFLzh1DPj7qJedHqrAtWAHtjMxlyXonDdxMgLPfAkTgQfu0ddnjC
         7loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222491; x=1768827291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Cm1NSak9WVWnM5l9pqLl0T/8D4EW3BK+pbycyB1csg=;
        b=iXJzW1Am8tINrLAMzUZ8RvO87bFnDQJuT99uOT9+khFqd3i9sSPkx5npEYwX3+Eds7
         1/pXgA1awUSkWhVBRH7G1G3dGZ1asFJTjT792fKz41lQCX3queWBN06K6YYYq5TMQG9s
         7p5O14ukvT6nRj9VaIB7GeJcM7rd4qO0LaGQOeOChPmWeH30KRTorHFhRwbMTGXTNYo5
         aVehVynEyboeEA3gMeIyoMth+2vyvt8l7nt5KypqIZAsScPEM4M688+Go4q4GX1T8RgO
         S7RH1mMtTkdAPCNBdKVTS8Jvaz4q0lezA9FeHviep6jLaPtCJVdnN/a5luZ49e6kRzjb
         gmug==
X-Forwarded-Encrypted: i=1; AJvYcCXNhINFtNUIBt+cd0aMXD1OlOeVi1dMpYduoMMP6Gw3JqyNYomdQ3Xl0uftaMrdUGt1Tr5ewMvDSoah@vger.kernel.org
X-Gm-Message-State: AOJu0YyWp0m+dPRxoQ0l28NVRehsG4rwX9cdL1K3OvPC1/OLIOIXz4VQ
	urpRSUX1I4rLMB1LcChlkaNnqDcZzNyib4kqDsZiOarEVIvklsNSSGE1/kx4kwJ+Eowbb4w5nly
	OIPRe+bCl56PODLadBn/tGo0SzhyvcTGLGQnWAR9JOzoGd81Zym7NAe/SCUFK8DE=
X-Gm-Gg: AY/fxX42qQ4ioiu+T+nsgGgl5Ak1ycVGWQsSOthQat+6Eg8Zju18mlqnS6PQHuLRU7T
	echFhkf/zFPRuB8jcgCVm9p+ZI9QnjFrKOU00sysIh+d2KJljfF6xVxc0s9dPb4WL8ipvbvji2g
	TA3oPXUqF+FMzpy4VkK/y2JqmDWaumPK54DxkKVOUt0xiz+0SK+UGe6uH2+xsRh7YZeVp5St5No
	DSdJh405AN2WHaZ/GgZdcWH/docOpmAji73uhAtjAFgRR3SGZQRa3U/Cb6eL0HzBjLxmo3r2NqY
	EMkJBc7F2aujMD+qlvQdnh9CzkV/vDXfBHrYXUMOe32rHs1S4imvbdGEz5KFnF145hvs81erJ+J
	d0l26P5r2sfhS2SyidTszQdh8QOpnF3TUO+cgZMmF8aNZoaqyc57HRpgabnk=
X-Received: by 2002:a17:906:fe42:b0:b80:3fff:336a with SMTP id a640c23a62f3a-b84451dd5cbmr1891319066b.21.1768222491486;
        Mon, 12 Jan 2026 04:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3ocOYDaQBm47WQWHUtarwXWjqqK7PcY8X+pPMPt72lDykLUFXJDGh1s3S0jmZSzBP3eyQDg==
X-Received: by 2002:a17:906:fe42:b0:b80:3fff:336a with SMTP id a640c23a62f3a-b84451dd5cbmr1891315066b.21.1768222490986;
        Mon, 12 Jan 2026 04:54:50 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm497062466b.16.2026.01.12.04.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:54:50 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-riscv@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-s390@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [RFC PATCH 3/5] m68k: defconfig: replace deprecated NF_LOG configs by NF_LOG_SYSLOG
Date: Mon, 12 Jan 2026 13:54:29 +0100
Message-ID: <20260112125432.61218-4-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112125432.61218-1-lukas.bulwahn@redhat.com>
References: <20260112125432.61218-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

The config options NF_LOG_{ARP,IPV4,IPV6} are deprecated and they only
exist to ensure that older kernel configurations would enable the
replacement config option NF_LOG_SYSLOG. To step towards eventually
removing the definitions of these deprecated config options from the kernel
tree, update the m68k kernel configurations to set NF_LOG_SYSLOG and drop
the deprecated config options.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 arch/m68k/configs/amiga_defconfig    | 3 +--
 arch/m68k/configs/apollo_defconfig   | 3 +--
 arch/m68k/configs/atari_defconfig    | 3 +--
 arch/m68k/configs/bvme6000_defconfig | 3 +--
 arch/m68k/configs/hp300_defconfig    | 3 +--
 arch/m68k/configs/mac_defconfig      | 3 +--
 arch/m68k/configs/multi_defconfig    | 3 +--
 arch/m68k/configs/mvme147_defconfig  | 3 +--
 arch/m68k/configs/mvme16x_defconfig  | 3 +--
 arch/m68k/configs/q40_defconfig      | 3 +--
 arch/m68k/configs/sun3_defconfig     | 3 +--
 arch/m68k/configs/sun3x_defconfig    | 3 +--
 12 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 3c87c1d181a6..1955fe9812f4 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -200,8 +200,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 03eaace46fe7..879ce8fa40d9 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -196,8 +196,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 61228b9d2c2a..bb385edfdb95 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -203,8 +203,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 83fcc12916c5..5fc0f94cb64a 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -193,8 +193,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 84d477e95fe8..d7c5cb651cf2 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -195,8 +195,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index b1e911a138a0..83d811a48296 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -194,8 +194,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 0a2c3ac6dc7f..8d92432e96ef 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -214,8 +214,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 2087fe4af3d6..5d4017224a3a 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -192,8 +192,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 4af83b643da1..6064459bff9d 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -193,8 +193,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 56c303097050..75ae71ed6ff8 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -194,8 +194,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index de2a5b27d408..75fade03e947 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -189,8 +189,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 297b8edcff6d..cdd56ecf4941 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -190,8 +190,7 @@ CONFIG_IP_SET_LIST_SET=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
-- 
2.52.0

