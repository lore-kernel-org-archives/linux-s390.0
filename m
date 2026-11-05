Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859155;
	b=nbjvs1eUYHIHxiRwXghRz/Xh+xlSp+7OT6QYo80vhpqEGqonr/tz3T933Dg6UzJnCwEs
	 AjgxpLe+0BX4/8actlwsn4UkpATAcu6LaGnVPaFvaWAN9+c8qpNa4Ugh8qLPnQjVbXubn
	 UCuR5rr6KXadYf29bcoRc4lcyXkM0CtiiM2Db/HJUmrAqtsuVzEaJH5UPHaRxZ0IHOkLp
	 uI01CdfnHR7Ep2hJX2Gl6YE72Y9oam0zrU4NFNMX0Ef0GubqDx2PAdFrFQUI5gaPNTPcm
	 OTsAFBgpaje9xGzkRtE5NbWIQUttS+ANH2BPxkKrxYvO0mn29bjzIfLRXwG0WZMldtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=86mQJyKlXA+m+CUFz+gI1B4tAIO9REzBudSQUtfJrm0=;
	b=0A+NcFXyt2ioLHhpmrA/G2BpU2q6hrAK6izghPyGxZLDXr4oyPpaLkuCHlAPAtNlqTCb
	 0ZcKM/Uj97aslhPn3qC1tROzdZaFkpXWy/nGCAXXeYa7aqgjJXwMpmc0uVV9Ir3quTtWV
	 d+DUZg+jlwtXOgdh8jmyner1Ro6YL4OtCVHV61r56Oum+nk7JiBAUV67DO6sFIz3S629J
	 DOW7w1Hdda0782cthjNSm2MUg2qHNT+GrGW61MSn3qM31NSKgw4BMRqrgwR+QHq+Qz92u
	 FmX5Zwe9dBaTi5znaOa6PheOyIYfb3ZyMUzcqfBEZGMn3iEgpC8ptAKzrwDbAEeqliA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Bp5MW+a7;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974D606A326
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 06:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8974D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Bp5MW+a7
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1089184a91.1
        for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 22:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793859154; x=1794463954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=86mQJyKlXA+m+CUFz+gI1B4tAIO9REzBudSQUtfJrm0=;
        b=Bp5MW+a7fGIv/7pTtYa3B2e1LhOCTCnK6GRwFYZT5vkcgLqZ8V8/SOaEEdzRIiXp01
         leju/Xa5AeZzZGikWexBA9GTDkYdVsV/DdrwZLuxDSMxS3Svl1VkYPWR795d/iZ1IvCC
         uGIK+Ml1tDM/D+fJLdWpkNBkTBzWBzuTU7/UkI1UIOR8USH+52nBRpcSJV9Nh5c7CmV3
         N95XAhWV+TXMh6gW1scO3WqQKDn03ibwh4ugu9mA+sy+Pi8ARwjac7k1sC348U8ucUAz
         Jsfm0DSjGVylU5zPIklTDCo5MHTj/gngSwoZcPM0kZ7MB/iE/H1qeV/fmCtTFGnCEFOZ
         jjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859154; x=1794463954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=86mQJyKlXA+m+CUFz+gI1B4tAIO9REzBudSQUtfJrm0=;
        b=wDPilSSoyUC9jBQfC+Xz3P0YeXyFh1zRNNCfShASk/zpvECa1k7PLuKEN/i3MqHMpV
         6Tjmm5wG4aA/RxhOX1sV6l4LRgWMdsVb7zjM9Z6Y8p/X3RsXstkfmzor+IYTtJlSkpoY
         6u3YC2w9LQ1TTlMHKnyqj6NTqn2XgXWzF13hlzjYDIxR7f1RLQhZtwtn/8EuUUWS86Pu
         aLlBrFklTlS/7d8zKDb0FjMSMs0DFhLRkQ4WzGG+sV9fXfh0LIkQ2DvxqYfQwJxXNyLH
         u6sUN54514pRdVaBHOsT3VkDeGY2vozZz7f/8TmSWH0vrI4mvO/YiUUIWyHtDEehWGhl
         HEzA==
X-Forwarded-Encrypted: i=1; AKwUvBwUQ5JbWZe8gS2ZSaP7DUGRJGq21u3btUuG17Lqf+EsIff0CciH9R/icHFP6I4jWW31Upkr8SJ1c2nr@vger.kernel.org
X-Gm-Message-State: APuU4Z+xhMDLamaVBJu3vse94nTglkVC4qdIrqB7yArFRrnSGuwE9Jz0
	Ny4KKoH8UjnanTHC24Sh0h2BixA30zQDCCqQgshgwRBd+dF4THNs4XRjd0z9dgLWigA=
X-Gm-Gg: AYBFou1ZpWcXFyOrdlftKla+SHGzo8noK0AlZHKc4Yycc1yxnNSOqcWz6UvTz23aKiu
	MzEgR9LIb9cIc/Q2bNdP0/C3lV0Z36ZV0yV17DghxlqFjAJgGufXx2SLVCtKdcdkVIcPickXtOH
	sIeiGZeOk+5SdrL+tgQuypqhbqPO0bBtsiLSb8RrgUcDCPO0EUay5omYlNxqW/UGCERxKvxKYNp
	wZusqjwh/uGNBKSh8bjGAI31INe/OuLRlJUWIZDux30EmWwmUt3hrzjC98yMneQzTanm0GAGbVA
	nfBdJsttF53DNGswatJ3N7RFD0ztMqVseD5hy+LmSNhWJ+SorBLEDQ//fZMF7BCO/GfmgSqRjZB
	h7RRyRb5CjFzE1Ojd8jJjPcj3pWwAGIRFQXOjGF9AapPcqRKKohGSUR7QUrz4VsWVuBCRFqUg1Q
	0MbCwlvOq57nv7p6m0X6oRcEwxykgOCEurrZ8/iuHiNLFqQRZ8XpH67eiHRmAOLwqns9TWsM+XG
	UIlP1moGw5ff4etzNWVt9YL31nSdgxs0c10bRJQJvroVs+zylkTYXUS0g4ZdCfLHUsjlzNI0eWO
	RGG9RA5KpkNJtMORD9+1m6t9/ZnN3dkvowxo8ZO+bnNjHZ/NdV4jrlqsvSGSum35pQ==
X-Received: by 2002:a17:90b:3844:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3ae89814e4fmr15532805a91.30.1793859153687;
        Wed, 04 Nov 2026 22:12:33 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323a1fdsm2107528a91.5.2026.11.04.22.12.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 22:12:32 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/5] mm: Simplify device DAX vmemmap optimization plumbing
Date: Thu,  5 Nov 2026 14:12:12 +0800
Message-ID: <20261105061217.13302-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is split out from the earlier, larger series "mm: Generalize
HVO for HugeTLB and device DAX" [1]. While the parent series generalizes
vmemmap optimization across HugeTLB and device DAX, this subset addresses
a single, self-contained step: simplifying the device DAX vmemmap
optimization plumbing.

After device DAX was converted to section-based vmemmap optimization,
whether a mapping can be optimized is carried in mem_section, and the
architecture-specific population path can handle any remaining fallback.
The code still retains the DAX-specific vmemmap_can_optimize() helper, a
PowerPC override, and @pgmap arguments threaded through lower-level
vmemmap population and memory-removal interfaces. These duplicate the
section-order policy and keep otherwise generic paths coupled to
dev_pagemap.

This series removes that obsolete plumbing by consolidating the
optimization policy around memory-section metadata and simplifying the
generic and architecture-specific population paths. This also eliminates
dependencies that are no longer needed once the optimization state is
carried by the memory section.

This leaves the section compound order as the single source of truth for
vmemmap optimization and decouples the generic sparse-vmemmap and
memory-hotplug paths from device DAX.

This is another smaller step toward the broader HVO generalization.

[1] https://lore.kernel.org/20260513130542.35604-1-songmuchun@bytedance.com/

v2:
- Rebase onto mm-new at dba8aba0a9a0
- Add section_vmemmap_optimization_disable() and use it for PowerPC,
  LoongArch, and altmap fallbacks.
- Add a LoongArch patch that keeps device DAX vmemmap optimization
  disabled while leaving HugeTLB HVO unchanged.
- Ignore section compound orders that cannot be optimized.
- Add direct vmemmap-optimization.h includes for architecture users.

v1: https://lore.kernel.org/20261030140720.1256062-1-songmuchun@bytedance.com/

Muchun Song (5):
  powerpc/mm: make vmemmap_populate_compound_pages() static
  powerpc/mm: drop powerpc vmemmap_can_optimize()
  loongarch/mm: disable device DAX vmemmap optimization
  mm/sparse-vmemmap: drop vmemmap_can_optimize()
  mm/sparse-vmemmap: drop @pgmap from vmemmap population APIs

 arch/arm64/mm/mmu.c                        |  5 +-
 arch/loongarch/mm/init.c                   |  7 +--
 arch/powerpc/include/asm/book3s/64/radix.h | 12 -----
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 23 +++------
 arch/powerpc/mm/init_64.c                  |  2 +
 arch/powerpc/mm/mem.c                      |  5 +-
 arch/riscv/mm/init.c                       |  5 +-
 arch/s390/mm/init.c                        |  5 +-
 arch/x86/mm/init_64.c                      |  5 +-
 include/linux/memory_hotplug.h             |  8 ++--
 include/linux/mm.h                         | 40 +---------------
 include/linux/vmemmap-optimization.h       | 56 +++++++++++++++++-----
 mm/memory_hotplug.c                        | 16 +++----
 mm/memremap.c                              |  4 +-
 mm/sparse-vmemmap.c                        | 29 ++++++-----
 mm/sparse.c                                |  6 +--
 mm/sparse.h                                |  5 --
 17 files changed, 97 insertions(+), 136 deletions(-)


base-commit: dba8aba0a9a00ff781c03d82ae534fc6f8c2e263
-- 
2.54.0

