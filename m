Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57430F817
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718381; cv=none; b=GCfFYh4AEpPvtP84cKglnQfoSzupAPn/ROB7TaVr72X+uSz+8PvHgsWFb6UKEws6iFAOMaAIydk4lZ0AUzEYtiF6tFdljUARmFO2RgunjkBaYSU/aVWlBzpdIqko+z1tLWuRtSuw/3/fV+ujE1QkJxYcqQUa0lZYuzL4YKGCxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718381; c=relaxed/simple;
	bh=XjuAxYKBI3IkXJfvQ3kH8dgkzun3QXNzWiHOIferAsU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ei5+PqfxL9592DR2484HZ8Qo/SF+PSBENUg3iIADw13d8aPX1uzieif+PgnSb7AUI0u/q3Nx0WJuHTDR/M0BOWv60ITkrdPNxPdMxZr8kYMNWODwksx8JXtKebo7B8a8AJU0odB7pQgRYxfAFSG3M5w1NN5TTa4HQ92r4CZIAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DXEQX+bY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DXEQX+bY"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so214550766b.2
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718377; x=1757323177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3Upj2m2g1j8fphq8NY5txcaBLQgQOVfeQ4k3TdopfU=;
        b=DXEQX+bYXq70Y1f5UkdcIks7JtRa0eSzATZtvDlSFczs0bR/6gCc+iha9hYpBv0ou/
         DXtUscRboTKPE3UCnkjZVHlVGx5L+U4UIzZf5jdPFRBcRgNYr96+JFDtcG1L1+1msW3f
         GfbRMvobUrjslmll54nCCGegclrrk7XCDPRf4fQ1Fpj7glinQMqK9ML8YPwwvBJ27XIN
         6FVMPrptovnDEZaNGEubw1typaLX9/REsDD3L8Ygwwb2YgVjfz/wz/K1fhIRGk9K0iRH
         eRnK1iz4C7sEhvPt68/W1yPZ0Q5SCQ14h3GbbTsbXPX8BkT+V0Lqe1FNMh/UgEgDtaCa
         HbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718377; x=1757323177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3Upj2m2g1j8fphq8NY5txcaBLQgQOVfeQ4k3TdopfU=;
        b=F6Cnxr8Y7j5sw87ZbXLAnDXuAwkWxZVxFpTUNskdeSNvD3kmyx2ozi2eQ0pkZFy36Q
         XcAKrPXHpDoH4KM3AufGt1BRYWyQhn9Sok28m7tnq9an9K4WaaRB95voYzty0EGfZ8fn
         WnqqMzD705kUyuKVVxMZ++IFyXDBocyg9PP6uV0pMg/0lP9nLQC0Ic+iPWts/1f1WxPG
         4VC76ErgwstCobRLZ/WIh4aOu6I8LprtymnpecKPS+oK4GlIr0dyEs0d6Oon1HVJllm7
         KbF7zMhG5b0+TWliSKm/vSm1Mwl/8YeEjTwj9ajZKwvPh6h5fnBnp2RmoTvVyuxZKs8q
         K+rg==
X-Forwarded-Encrypted: i=1; AJvYcCWtbxNXgRoNWjMhl7u909fXx2lWKu52tB9nYGB0CzYDF11nLZ24PvuwXIBf7FDjoDP7bQ4DbNHm3hH6@vger.kernel.org
X-Gm-Message-State: AOJu0YyaOEUpAWSkp/CyV1hEfmmQrz87yY4rnj4AGWltwNavpg3zT+2m
	pv85JmfR/Grtt+lrHAYgTNQby4/9weHjS8K2dMl9/tzMYntQQC8e5c0/pmObIRRTwRI=
X-Gm-Gg: ASbGncuNpHQpZj+h8LMbvkz/pTD3q1Ebuv/H4dyw/KzCUXJSxl4/iRx8LTmGrCy+hOk
	jyczTo83kLRxDYk2hThCml/NES0Btcs/LQ0oSwClcTec4WCHi4Nypbe9nFN1fqdNhoAlQgMwQyM
	VYT7VU+HFaAoZ/akaT7bL7YsHuxpR3Bq3mOfzgkUcH4ZtvA6sNoB9w3eBb3uYpnphp8Ta3bfMA+
	5NX4pPrDHHupHA5My76bXHz8v12FYwNX+d/J+tE+jYNIm3lrnnp5IkQ2oSCAWBFJUDrFU5ob1n1
	F62W71pmnLbj6uuGvgokd6TaKFkfw8QtUWj7VRACXpYGN7E/9DA1XC6uew7P6mfrINMsnpq76ir
	5ZaQZ2lw78xO9YU2RdydnIOy5m2jQIaKhoQiaz5+XvqcAs0ijeWY5+Qf+7AnZaPZkQ2JVbHnNpR
	ksLfTFT3QkTW0b3BE4pwTO6U2UZKNPzW+h
X-Google-Smtp-Source: AGHT+IHU03tJneIRXPXjJBcv8U2Bz02uUMfdpAyBKwgR6+o6K1xVYVpx/SIyHdw8wkNyrhH8/CTQOg==
X-Received: by 2002:a17:906:9f8e:b0:afe:c6a0:d116 with SMTP id a640c23a62f3a-b01d8a6b6ffmr681548166b.18.1756718376821;
        Mon, 01 Sep 2025 02:19:36 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:36 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 07/12] parisc: add `const` to mmap_upper_limit() parameter
Date: Mon,  1 Sep 2025 11:19:10 +0200
Message-ID: <20250901091916.3002082-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifier to the rlimit pointer parameter in
parisc's mmap_upper_limit() function that does not modify the referenced
memory, improving type safety and enabling compiler optimizations.

Functions improved:
- mmap_upper_limit()

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/parisc/include/asm/processor.h | 2 +-
 arch/parisc/kernel/sys_parisc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 4c14bde39aac..dd0b5e199559 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -48,7 +48,7 @@
 #ifndef __ASSEMBLER__
 
 struct rlimit;
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
+unsigned long mmap_upper_limit(const struct rlimit *rlim_stack);
 unsigned long calc_max_stack_size(unsigned long stack_max);
 
 /*
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index f852fe274abe..c2bbaef7e6b7 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack_max)
  * indicating that "current" should be used instead of a passed-in
  * value from the exec bprm as done with arch_pick_mmap_layout().
  */
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
+unsigned long mmap_upper_limit(const struct rlimit *const rlim_stack)
 {
 	unsigned long stack_base;
 
-- 
2.47.2

