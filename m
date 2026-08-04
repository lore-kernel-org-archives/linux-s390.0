Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB2397E89
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845143; cv=none; b=A1wa58xV5Wk12tJ+R1cMOJzWZQuTy/38B9dEjoPms7BL/FKU9erF+f6XccWoInucoE31omaJff9QtI4QNLS69Jf4vc2tWpaK8zqcOxqZsOrkB5+P6kec8OW+tLHdJjjDycMmnC96aU4vujsiNN1p90KYr4hkO/CoIvXZ9z/1taM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845143; c=relaxed/simple;
	bh=tWhbpLrndV3dvFj6rw3wUEqAvQhUNv7Z7XChRUIb0M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pkel2Io61bFG0FWqCvF3VWeOSzebO0ZHGpHx+oefbjDcTq8/DnpbMubuND+bdYSVgqXcLMgWqALuSWNu09m+nWb0bPw8QnYyrYBEiZNFaEy5pnhMn+NSTYd2WPu6bLPTXKMn6qjYiOk88nbgYap8ZxNcI9hHxVYckkmo/1wgnCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHLPLsk4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uDdqbUZv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHLPLsk4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uDdqbUZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785845140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=taQNLA8VzPi8pIAuKLKHCaHnQR8Qtlo0OLpkQO4wnlM=;
	b=ZHLPLsk4NNkZ1MUg20CMCvFb47FhYoquPXJtd1knMZSb7GQRhdBQ2RFYyEhz3TN9fh6zrg
	SWvBRUNTHZHZRVz1LLnFHlwebUWD+GpyMtnfOamxDBHuNpyf0G7h5VK6vNOPrGFKUCjNM9
	0p1pP3CbfFBSr2B1kmyPZgycKM/+mFw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-au_IYzvaPo2i8-2R7o0pbg-1; Tue, 04 Aug 2026 08:05:39 -0400
X-MC-Unique: au_IYzvaPo2i8-2R7o0pbg-1
X-Mimecast-MFC-AGG-ID: au_IYzvaPo2i8-2R7o0pbg_1785845138
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so33952885e9.3
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785845138; x=1786449938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=taQNLA8VzPi8pIAuKLKHCaHnQR8Qtlo0OLpkQO4wnlM=;
        b=uDdqbUZvYP79RqimY1ZqTEuTXAixIlW/QtJ7a4KlNLDotqiHC1jC+BqaNbdrzoB8iP
         cU+AHAMYM89wwmVfsuSmTWMfB2/Fx34ztmYWncP0qP1zK32pIaOH9F/xITa1sfSTE/gu
         ndWjrHWkUfTLCpWYWdkXxS+Nd1po8h50lTtsj9o2CyLeCsSM6FYnnl1uBQEdAg6nPNhI
         lblviG/InhzcdCosHgo3agQfYY5c/+oKxQPbzW7EO8dIquZ8LX6maNtNVJ9hDC7FY49t
         5I0I1tJH9MkIOd8zQNWwNqDi/ouIyyGx551nNd9HdphXflkxVPFuaJ7HjIH+8RH5EoxQ
         10Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845138; x=1786449938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=taQNLA8VzPi8pIAuKLKHCaHnQR8Qtlo0OLpkQO4wnlM=;
        b=Rc1/VBiOuNPV1ZYJIslLaU503bcZBplqEopVmiBNZsHI8LSPB3i1EIWx9QMid56+H8
         x9UGiZopMKfdQmNgvfnWD+4d01R3P+4HY2aDTTFt+VqrsQyXQlJ1+5+Cm/G41Vned6h1
         w05VU3tBUIrfI3BZPl+BTDD1/bdDuExTtxi0QI8gI3Pu5gtUdWf3m+LSJ4bz/JlZ9VsE
         yaRAjeq+c7UR4zuu1sNA077Lkt3rA146U6nICPQ5EfNmHyWWC07MK7jR49Eck9Kib5Aw
         gXSmer0rB4B5tUDXsbQQAqwVCBdk+3hRriUa7XeQqdBBl90ONAXeYHig7BSqkHvD2sJF
         dudg==
X-Forwarded-Encrypted: i=1; AHgh+RrvDJeTXBLCsmZB8Pg1/CWrankB4ZjXyU1sXjrMOtaALkwhoe7oSbF8ifz8vyUFcLGg8jLIWRXwTCR6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+m2xGr0OHiAFj285YoAxT001wS7e7EMADgg6uSfHwyyFqgWKK
	aq0cdC06uy4QVlFNCP0RQeMrPJGZ/mT/R8HLTRCNUlR8xTL7IZKwZez3+6IHWZL8lEshIZHOV60
	SUDURV3zWOf9l+jiLJ3oNO/YdheFsFg3gTfwvHPTbtVZVnDsGqZjMvKv5WijXlrU=
X-Gm-Gg: AR+sD13/SI+vhC4nBRS4oGbhxQFxsOHnZswh5RLLzhKiRtuugMAx0zetmDx5hq+Mnoi
	oFqXxgbW3iSL5iNqr6DcCro2zRGhsMTZQc3O3okErmQfC1shRQ/xobVod4u31DZ9lWY1PNjREWb
	t/KSR8hUdjTr3ox4gLzu4zddDoJOvAM1cCEVYuQ+aMZxXdXm/jWsvPzitGL5JnUDbZ9r+H1aHYN
	1sHJJk7U3CBS6xOvAD/ClixMJf868Q3tpTxil4HLKM5acXNdJZEv22kZ2ChI3nc8KpcvDNqMeo0
	f+Ps/DUQ9kupaSIqKJ7w8wkdwUgxGr+/VfHT6PstdJIv+CibyaAe6c/4PBXgkiN4zIa0K0/tS9b
	eYCXjK8u6xCOygVUVOv5IGtBOcKzjCmSOI3CHzqicJGVBwbYMxIi0tCN7lVDiKG7JZW5BYAHP6s
	Afbvw=
X-Received: by 2002:a05:600c:6298:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-499484a7693mr122467195e9.9.1785845137698;
        Tue, 04 Aug 2026 05:05:37 -0700 (PDT)
X-Received: by 2002:a05:600c:6298:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-499484a7693mr122465915e9.9.1785845136990;
        Tue, 04 Aug 2026 05:05:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm453070475e9.3.2026.08.04.05.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:05:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christian Koenig <christian.koenig@amd.com>,
	David Hildenbrand <david@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Fei Li <fei1.li@intel.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Peter Xu <peterx@redhat.com>,
	Sergio Lopez <slp@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
Date: Tue,  4 Aug 2026 14:05:24 +0200
Message-ID: <20260804120529.1730187-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This ensures that KVM or VFIO correctly see a writable PTE when
they request one.  Otherwise, a guest write to an unpopulated
PTE from a mapping backed by a DRM GEM BO triggers a VM exit
with EFAULT.

The code actually is simpler, because the same logic already
applied to the hugepage mapping case using vmf_insert_pfn_pmd().

Reported-by: Sergio Lopez <slp@redhat.com>
Link: https://lore.kernel.org/kvm/20260729072044.25796-1-slp@redhat.com/
Tested-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 38 ++++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index c989459eb215..c81be3e97317 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -589,11 +589,25 @@ static void drm_gem_shmem_record_mkwrite(struct vm_fault *vmf)
 	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
 }
 
+/*
+ * Because the vm_ops have a .pfn_mkwrite() callback, vma_set_page_prot()
+ * has cleared the write bit from vma->vm_page_prot.  vmf_insert_pfn()
+ * would install a read-only entry even for a write fault, relying on a
+ * second fault to reach .pfn_mkwrite() and upgrade it, but that second
+ * fault never happens for fixup_user_fault() callers that directly
+ * walk the page tables with follow_pfnmap_start().  To ensure that
+ * they don't see the read-only entry, pass FAULT_FLAG_WRITE info down
+ * to install a writable entry right away.  Because .pfn_mkwrite() is
+ * not invoked, record the write afterwards.
+ */
 static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 				 unsigned long pfn)
 {
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	vm_fault_t ret = VM_FAULT_FALLBACK;
+
 	if (!order) {
-		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+		ret = vmf_insert_pfn_mkwrite(vmf->vma, vmf->address, pfn, write);
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	} else if (order == PMD_ORDER) {
 		unsigned long paddr = pfn << PAGE_SHIFT;
@@ -601,27 +615,15 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 
 		if (aligned &&
 		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
-			vm_fault_t ret;
-
 			pfn &= PMD_MASK >> PAGE_SHIFT;
-
-			/* Unlike PTEs which are automatically upgraded to
-			 * writeable entries, the PMD upgrades go through
-			 * .huge_fault(). Make sure we pass the "write" info
-			 * along in that case.
-			 * This also means we have to record the write fault
-			 * here, instead of in .pfn_mkwrite().
-			 */
-			ret = vmf_insert_pfn_pmd(vmf, pfn,
-						 vmf->flags & FAULT_FLAG_WRITE);
-			if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
-				drm_gem_shmem_record_mkwrite(vmf);
-
-			return ret;
+			ret = vmf_insert_pfn_pmd(vmf, pfn, write);
 		}
 #endif
 	}
-	return VM_FAULT_FALLBACK;
+
+	if (ret == VM_FAULT_NOPAGE && write)
+		drm_gem_shmem_record_mkwrite(vmf);
+	return ret;
 }
 
 static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned int order)
-- 
2.55.0

