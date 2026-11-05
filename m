Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859173;
	b=qm801fgmvdW24cA0fJP+8J64TxeqI6feb7g5cbLpFyAIjv0T6LpFk4qbuOwRre/dz773
	 cFz+X+Pb+ksneoHfZz0FVtQcKThnx0Lpb9xAX/ZvUUkuVMVzDh8zYnhtsHj9/Oi5Pq5vW
	 iRHAyscsK/J+rVAET0lDTfogjJ4/7tGbmhYGf2mNp4LscZh3tUfEg/Vc2/P4Rg9NFkVDn
	 tfS7vZg0OhWssc0Hf3RQ+krPt9MJ9StR0a0pOrcJ0ChaLTnOcbDSWWmFJbUhvQz5pPHSV
	 VH2Egov9GquqtIvLXh36bi6d7onGDQa4RM0jLgK0eODOc14Hx8rWNhH1sPW2XzC6mEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
	b=UP5UKbLO1GM4Bmfmr4i5f0IzECbme5/yoKHgSzUKNYMg0xaiyZ4ggAJAYokbQxYUs2aX
	 YxFgmNEqUNo7ny9XdLU71yil5FrEtL0bsp995LWXKFxGWHQkj0RuVJ1RjKTOq3wDBoNAg
	 wWmuxKYtE1Lov5WXhBQO01VEatrbaFuR3hT1KIZ2f8ZqiESL1Efn5hmpOmcyiLidUMPB7
	 dyCsbpFvxHnZmTT2Vf4zkET3E2aJYWBr7CQCSLminOyVh4993sAjJ78EOq3oSMM1Vi50p
	 WAxwSJC6pOJ+f4ZM90cYWSOJkU+HvULY2RL7vHt8glrdAxa0IZq5SdwHD52jSVouL0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="PaZ/Alq1";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB73606A326
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 06:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB73606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PaZ/Alq1
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1002578a12.2
        for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 22:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793859172; x=1794463972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
        b=PaZ/Alq1kh3xw1ohjhflP9BUJV9i9Uz4rNfF9+87nLm1GWLtWKOc1RcosX4kKyirct
         LHEWvOJDNs1xRgnqKSFUMTGRSZwoo02j1DHw0iCTbflv9z4J/U2VvJOSigAg0imVa52j
         /T7gBHBo8zfU6+MMZIX7xzOG0u4E6C/wjgXwZCzE/508J/sOtX92ensHcG8xk7kFi9jf
         WCLSXc4uP1mGibwZGpkRNL7NbANyY4acCuoNQjySOf5Uvpx0JAknsAjJcCG3L/M7/zue
         5thZ3KHQqUNr9hZp2PHs/FfAVUPYFRp2sRmP7qFmFmW9yiISxys1LZ63c7SykY8QCd+I
         9F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859172; x=1794463972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
        b=2iQnphVHvCWTlANUB1/67vm9gJcG+84aX/YHCnkgNbTRXmx0YDpMZeGqdlOEY1S7P1
         E1WwXeDUO36tAX+q3cV2Qy5XXU9gI8lIyZH0K5KEoTW4W/r7P0TIwlA4Qp6V5hcq5HxC
         ByjHrKpGP6P/JW6Y2dZ1wKCfA6J8p/PNtmpg24N5AgzA+hvxBBlNc0hnvrWYbIgHJQQI
         2Zhr7QemYyKS12lS1oAm7Ad85ytFa61jlLMxEhm3MdQI82LxS/x2gc4BTO9IEnv31VM8
         kT03mqWNPF4m9+mhxxH6XFEPFeUI18gmj6v/r/kz7Q268XtP+vFEOdztS6gxVwTqnDRL
         80cg==
X-Forwarded-Encrypted: i=1; AKwUvByr8GnnXfsFCWvN6TWwmcSONhXHv5eq/P7iQnwu2Y7u1X3brBKo/HyorIU+WOPGhfcjIAHfaS27Iv8N@vger.kernel.org
X-Gm-Message-State: APuU4Z+5x3V3rzgUhd/S0l/6hQt3a+tZ+PZW9ZnMp2PfHL1CVaW2ObrV
	Ih1fLneU5CnYsKJdU7G5oluf7JpDDCWMDCoViWrL9/vMWBRCwoxWuVUqkwHGVlw/4cM=
X-Gm-Gg: AYBFou2lVpW32kZYIxK+o8LMc3XsNBACuE2gLPeP/HpxMWPhmLVR/0i7a/P28lDGBC2
	vSMnhUFF7UsZUAhgvEx8nmGMqr6CFyNm41Bus/tbADwmO527m/A0ucqFSKNbSaynrpmwT3FXYBz
	DMZJlrsdZHDfsZDqyWRbSN1mmsT5Fz0n1W7HE0tZ4p3xblXdqSbtX/ukh0MwJRq+iCzz1nf4imP
	8dR8pK+yeuDbdoj/AE9cvcHRY3FrctNufaBhYFqFWrNlf2X4c24NfqLriiE6Hsl2fMWmK0Ini/5
	z52HWQHnE2p7JNPFSeoe/GhbfSfphwaF68qlF1wKgRgB8jSF26VIGX9f+SArVRO83AkssCodjv4
	hvxsolRx/49o7nRlkxnLcevNGCd+McPSgmV+duWw9a5eEo7UZ2o0B6G123nYgoo34KMM+LT88ZW
	yzV91CSX5eRQb+y/TR9oIp7PD7wdtm+6PkDPiczI9a7uOIBmvskWcko0O4m7jmK6SrHER/PMcTH
	Rrp/wovpy13asA1TyNhdZW65BevT/varGlmzQNYzjyR0bazQOkH8ccqstnMvYZRw5Ui2cog0XMU
	Kqlv4CXJtySp6/4mXR+71jOpMm9TpwbPXdtSBMTlvaAe8BJbeyksd/Hz2oTbjSxzvmmvyoofTKC
	blsyDzYjooKc=
X-Received: by 2002:a17:90b:37d0:b0:3ad:c4e9:7beb with SMTP id 98e67ed59e1d1-3ae8979d2d3mr14790005a91.43.1793859171930;
        Wed, 04 Nov 2026 22:12:51 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323a1fdsm2107528a91.5.2026.11.04.22.12.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 22:12:51 -0800 (PST)
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
Subject: [PATCH v2 3/5] loongarch/mm: disable device DAX vmemmap optimization
Date: Thu,  5 Nov 2026 14:12:15 +0800
Message-ID: <20261105061217.13302-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105061217.13302-1-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
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

LoongArch selects ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP but not
ARCH_WANT_OPTIMIZE_DAX_VMEMMAP. Its vmemmap_free() implementation is also
empty, so it cannot tear down optimized Device DAX mappings.

A later change removes the generic Device DAX architecture gate and lets
vmemmap_populate() decide whether a section can use optimization. Clear the
section compound order in the LoongArch path so Device DAX keeps using
unoptimized mappings.

This does not affect HugeTLB HVO: LoongArch does not support gigantic
pages, so HugeTLB does not use section-based vmemmap optimization there.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- New patch using section_vmemmap_optimization_disable() to keep Device
  DAX vmemmap optimization disabled on LoongArch (reported by Sashiko)
---
 arch/loongarch/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index f801f7097f03..ea769e479241 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -15,6 +15,7 @@
 #include <linux/memblock.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
+#include <linux/vmemmap-optimization.h>
 #include <linux/mman.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
@@ -143,6 +144,7 @@ void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap)
 {
+	section_vmemmap_optimization_disable(start, end);
 #if CONFIG_PGTABLE_LEVELS == 2
 	return vmemmap_populate_basepages(start, end, node, NULL);
 #else
-- 
2.54.0

