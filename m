Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369323;
	b=r2na+A8SXObQlIhvF+8/iHWd++warQM9sOwsFl13fH76dWVz+XL9723sPcYMcJ8699h2
	 dG4+WZ6/IzP2le6QMVX/AOAJcWR8s4QtemxrIYIKDAX16R11LZKHaWG2prPVby3m7mX+5
	 BcEY55f6xHbNWGZTF3dV3rimEs8bEB/TYo5U2h5ewdx+/VVLyfz643uSFLlHiKLa2rmyT
	 ZDivlsqmk89aKqXI1Xbb7wzQsHloJrRWjpihcsXyGQcjq0qSlt3DPKTw4X+rw2mKqQ3Ae
	 jlayzMBsdfXUfvXwJMISkL8CQzsmWgTuNUeEznHrdYV6LIsF5QehDCKfPyLVLCb1Arg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HwaJdDbl3ziEIlNq+4GJpu2/q8X3inKh6ZLd1kzHiJY=;
	b=Ij5XIVOm8EYX1OTq5OVZRKDq9m+3T1KzVXzdQqDpncKoX0CWrX3THRejJCp9Bsz/qxbJ
	 wYqge8VxaHxVmMYQhZiQ8QMch54YYqGneUlxO49+p8no/DKKgjLPA2aEMD2a0SmlwFbiC
	 KnVFO1IfY48ppiSRHbD8QEXSGXOKMsxylgriMB5zb3l0N8GKs+my/SEPHuqzFwIMwhhlg
	 QkbcSn58MDBClqy2fe1KDa9UhOQlqd2hSN3yw+KyH1N9WEHrn7MSIxDpFbl/cIVEpQch6
	 ffSiQK47uKoznH6zJH9TKMXEDS6MjTQs1PE9m6WJ8eGRj6xDplFrCU6TAqI+cn/RONw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OwS3urju;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49458606A335
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 14:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49458606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OwS3urju
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e608cd460eso4697825ad.3
        for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793369322; x=1793974122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HwaJdDbl3ziEIlNq+4GJpu2/q8X3inKh6ZLd1kzHiJY=;
        b=OwS3urjuUrvSiOyNpbPRyV5+yb97Dmbnye0H9EYkDb2sZd1s4VzouqlTAxN6340XSy
         t/C39SBqyvQ8G5DFZxja0x04UnO1tmevAQk03mlOIZm99P7Cfyfeu2wv/zQhIAyMYPfW
         z9t4HFg48ryTsi/1iXlI5HDFKOKkg02ltREEIAMnxgxEIrozI4m5bJi5F3TtOG6GFXBe
         5I3E4WiqZA9Gp/EtA+/ECkBxn4tXpEpuhBBLK4N0d4+vmvPETbW8Qr27leebB+3d5bTC
         ogtU5MWkLbA94QFUfZ/tqtbUyGEIdH4KGO9IrzBJzD6kWgYdZO2Rw/bNWMn3zFezNDKE
         kYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369322; x=1793974122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HwaJdDbl3ziEIlNq+4GJpu2/q8X3inKh6ZLd1kzHiJY=;
        b=xkOjg0H3mAvGDgtviLYgx519L4D7klGsLIVMSDMUw8Uab7FaTa4R9BDtUTFiCgylHl
         UniJL2hB46HO/3OgInZS1lbD6iDdCIlmXkio/5yChKpn8c1liuNrQwwY6NT+rXDXCkn8
         DyflkI4vmDsn+anuqP+dDN5LOumEJFF3x5EsTGED0bfy6HxXxzK4+7uc+E/43F7VS7QR
         QwwsA9PbUxHUBxXJEMgBS4C82ERKSGMNcRs9sJO7S8KsdywbOy8RP4U7TtknOAIRwAWz
         y+Mu60faPGb9cVwFIZ74xtMSvQGdhsViu+EO7Av++JHqd75a0aPU7FFeavRHsfx1OhW+
         pFNg==
X-Forwarded-Encrypted: i=1; AKwUvBzksL/3S0cYHjmNtXtgunEFuwGfWtt+rzSC6lR6huJUktpLSwwHoEcWih2DK29UwxVTzIRIbNvzHw2O@vger.kernel.org
X-Gm-Message-State: AFq9FYLfthqWBwSaqssXWFq3NaVhafW3PGIu9TqYS4HeEXzV//oQYFXH
	5QOt37M5U7Cxmh6SDK0pl16z/A1qGS+vzqwqNyYLeqLBmYjr6uVnpz2xU26Vl+nctHs=
X-Gm-Gg: AYBFou3An7Iv3XGzuWL4BvxgKDvAPaE6WWnwdzD4sFMCWerqIugFyQ53HI2Ye33Lga6
	4MywLEg5H/4DSpth7l6eTCWcXqoypRPK1db3b2M+miemzpHz49wEtBNMUC7UWQIdnyJfT9qlK+C
	5cZiOlVpI6PpznRzAAxakvCRa+FqDmhwetm/ZcK2IP4sitk7sgbdRUp9+9CLth8gYtpNz39jnUg
	XIIKb/2J47A6Bdb/WKuyrTKCBPZXOUKzIbrmxHJSVxYQKahQjZ6/BU4ETvvlwqezMd4EhUXQ10f
	zuCHS6V0fMDrJBF5zkTNP4lENohc+nM46iQbfGXQnsFIeLE3vaLRysoU2Ho2W/F5Hm76dm8mYV2
	+2PydyeXrALqHx9tjmDOfXLSAzGkPuL68Sbrvx+pCozfNo1FmeSNo4jTONnLyC2akqD2jnUTwIk
	0Puj3Q9NixKuMZ+VL1tIy1SINziRaOIoLatH3Z7REK9cgVg4/4DDZa/TBFElSTpf6TGKsPhr1Fd
	+gMBh2G+uvBASsFhD4Ot/2e5SIpr1szV/NER0NuV579Z1OOatfh58keqZEFyOMblX13pQ06QSHW
	6WeHXFTqMZHiOyUHZjzxG1B5Ic3MHwi7ww3wp1dqp/ocsEAYzuYe
X-Received: by 2002:a17:903:1a8b:b0:2e9:401f:f0f8 with SMTP id d9443c01a7336-2eb364e9f6amr24067465ad.53.1793369322301;
        Fri, 30 Oct 2026 07:08:42 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3929b27bsm7601795ad.62.2026.10.30.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:08:41 -0700 (PDT)
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
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/4] powerpc/mm: drop powerpc vmemmap_can_optimize()
Date: Fri, 30 Oct 2026 22:07:18 +0800
Message-ID: <20261030140720.1256062-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030140720.1256062-1-songmuchun@bytedance.com>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
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

PowerPC no longer needs an architecture-specific vmemmap_can_optimize()
override for DAX vmemmap optimization.

Whether the optimized mapping can be used is now decided in the
architecture-specific vmemmap_populate() path. When PowerPC has to fall
back, such as on Hash MMU, it can simply clear the section compound order
there and disable the optimization for that section.

Drop the radix-specific vmemmap_can_optimize() override and rely on the
generic checks instead.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  5 -----
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 10 ----------
 arch/powerpc/mm/init_64.c                  |  1 +
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 8452a2714cb1..df67209b0c5b 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -351,10 +351,5 @@ int radix__create_section_mapping(unsigned long start, unsigned long end,
 				  int nid, pgprot_t prot);
 int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMORY_HOTPLUG */
-
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-#define vmemmap_can_optimize vmemmap_can_optimize
-bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-#endif
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 2924604fbb38..63f369d296b4 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -978,16 +978,6 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
-{
-	if (radix_enabled())
-		return __vmemmap_can_optimize(altmap, pgmap);
-
-	return false;
-}
-#endif
-
 int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 				unsigned long addr, unsigned long next)
 {
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 0e777d7dc332..509cc4190db7 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -282,6 +282,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		return radix__vmemmap_populate(start, end, node, altmap);
 #endif
 
+	section_set_compound_order(__pfn_to_section(page_to_pfn((struct page *)start)), 0);
 	return __vmemmap_populate(start, end, node, altmap);
 }
 
-- 
2.54.0

