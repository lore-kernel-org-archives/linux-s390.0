Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.58
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865770;
	b=jwAcehtNgP1g6jpKXu+S2NM8bteg/a/FCiGOTaD+75elZf6beV7jA4ocIFR9gZW4bJMr
	 8tkQuv4Q5ypyquFds+vlQNhy4B/kfhBliFBZsQc9Gc3m2GKcyXXt8LWzIgjhUfB2c2jiR
	 rBtNj7zbW7neDahV6AsOqjnvka3eIdCFq3YB/bsLx+yd/9XCuqxeibYzHMW0bQviq6GWT
	 Pw1VkeIWaRPSy1C3Ohi1eL6aUSEmsKxbZvRBstNtGW/x1GV5/vZaO3NfkIfRRgSR6aeSt
	 vGA697Nl1Gxm/3dNLBvGRPS6oWF6J7zq1l1TJbmzvfpW2ICDptfr1au/Qq6OW8sKEJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865770;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CxtCL2T8KiQqlFgNcp5VFWE9VcQtrK6ENswsXI1n4JM=;
	b=Ak+jWaC12jDLwEQU5NcV2/cCkB8Cv7BQ6gt+ofUORN9m/NCt6hW5CRmz9y47vjnvRysz
	 dk8dzweVdOo8Zcp3HB54D6rSHcvZYFSPq7TiKch1aB3mF9iK0IYasKdcEg3CcsZDiEqb1
	 Jnr4dUeuaC17CClCPm2kuzxrtEjQTcXwlTgIr4MMqn33+n0XArItpmn8VvVy5nOj+7/+a
	 QDRpcPuKOWmbqKW98ITcAUuY4MQw8aHIr8MxTaXOAWltos4Y5q24ZTKVT5XlEJPSoaoPZ
	 dA7pWvD33IzcLJdXw7TBU/ZvUvH1uaoeAlyLBaQ6ah/Ql5aTUCusAQkuawyXOvKPfLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qumxXpnF;
	arc=none smtp.remote-ip=95.215.58.58
Received: from mta1.migadu.com (out-58.mta1.migadu.com [95.215.58.58])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE5606A31B
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 08:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60AE5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qumxXpnF
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7jP/rJr+RjhHJpfHb2z4eMviiB8ovnJGAObKcXmPABg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793865767; v=1; x=1794470567;
 b=qumxXpnFUFKkkDyNUaOVORlqtd3XqCGh5A2m9LCjo1SrNd+9biBl2y4GqdZA9jIIbuxl1dW0
 7scWFr23yOz6QmgTCLbC5BRoXs/2mbbp7M/w6UY0J5JhjKuLDmz8pM5g2VIOduIxGndZ8esKH3M
 vJztjno+jhAX8iKR2MFMmK8E=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c7e6f45eb6351582;
	Thu, 05 Nov 2026 08:02:46 +0000
X-Mizu-Trace-ID: c7e6f45eb6351582
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: sashiko-bot@kernel.org,
	songmuchun@bytedance.com
Cc: david@kernel.org,
	maddy@linux.ibm.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	osalvador@suse.de,
	qi.zheng@linux.dev,
	muchun.song@linux.dev,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	linux-mm@kvack.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com
Subject: Re: [PATCH v2 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Date: Thu,  5 Nov 2026 16:02:41 +0800
Message-ID: <20261105080241.57241-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <sashiko-outbox-198652@kernel.org>
References: <sashiko-outbox-198652@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 05, 2026 at 07:16:48AM +0000, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>- [Low] mm: undeclared vmemmap in section_vmemmap_optimization_disable()
>- [Low] mm: define vmemmap_optimizable_order() before section_vmemmap_optimizable()
>--

IIUC, on LoongArch, asm/pgtable.h includes vmemmap-optimization.h before
defining vmemmap.

How about taking a PFN and page count instead, and leaving the conversion
to the callers?

---8<---
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index c91afce46136..5a3a225135be 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -143,7 +143,8 @@ void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap)
 {
-	section_vmemmap_optimization_disable(start, end);
+	section_vmemmap_optimization_disable(page_to_pfn((struct page *)start),
+					     (end - start) / sizeof(struct page));
 #if CONFIG_PGTABLE_LEVELS == 2
 	return vmemmap_populate_basepages(start, end, node, NULL);
 #else
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 4d6928f717cf..43c98aec29aa 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -283,7 +283,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		return radix__vmemmap_populate(start, end, node, altmap);
 #endif
 
-	section_vmemmap_optimization_disable(start, end);
+	section_vmemmap_optimization_disable(page_to_pfn((struct page *)start),
+					     (end - start) / sizeof(struct page));
 	return __vmemmap_populate(start, end, node, altmap);
 }
 
diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
index 9d9f7a67d195..0501234ab16b 100644
--- a/include/linux/vmemmap-optimization.h
+++ b/include/linux/vmemmap-optimization.h
@@ -76,11 +76,9 @@ static inline bool section_vmemmap_optimizable(const struct mem_section *section
 	return vmemmap_optimizable_order(section_compound_order(section));
 }
 
-static inline void section_vmemmap_optimization_disable(unsigned long start,
-		unsigned long end)
+static inline void section_vmemmap_optimization_disable(unsigned long pfn,
+							unsigned long nr_pages)
 {
-	unsigned long pfn = page_to_pfn((struct page *)start);
-	unsigned long nr_pages = (end - start) / sizeof(struct page);
 	struct mem_section *section = __pfn_to_section(pfn);
 
 	if (nr_pages < PAGES_PER_SECTION) {
@@ -119,8 +117,8 @@ static inline bool section_vmemmap_optimizable(const struct mem_section *section
 	return false;
 }
 
-static inline void section_vmemmap_optimization_disable(unsigned long start,
-		unsigned long end)
+static inline void section_vmemmap_optimization_disable(unsigned long pfn,
+							unsigned long nr_pages)
 {
 }
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 5777f2e29684..64bc346d0fc5 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -474,7 +474,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 
 	/* Altmap-backed vmemmap pages cannot be optimized. */
 	if (altmap)
-		section_vmemmap_optimization_disable(start, end);
+		section_vmemmap_optimization_disable(pfn, nr_pages);
 	r = vmemmap_populate(start, end, nid, altmap);
 	if (r < 0)
 		return NULL;
---

Cheers, Lance
