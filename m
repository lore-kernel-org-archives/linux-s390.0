Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813163AFB0C
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845152; cv=none; b=FuLkNQtLTCyuPauUV8E164+FeXmZYrnMDdp9+BKt0xeYt8XMAFqHB11JZdkR4T40Gc+EM1iZwpxyA4o/qacBmy+uy38BMy3F6ot+1b6CQpSlL6vwpsRZoZjwfrTpc2QhV0iBAoO4G/B+G1J5HIHBcFbhoM3wVfVnEjcd5oBY3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845152; c=relaxed/simple;
	bh=ShgJllGtoj3B6lj3SHwP+387ixSZNj2YWvPFDV6BseQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDzYlItNyHFXs0rg23Ce0StbzRb1aga4NIRJQNxqBtj4JMeFXldlZHlx3uI1PdCTWk2ftwAMgrmAgmOpTlbZ2/E5WlkrShQJ+hh2ghZ5WriJJKWdEUNTYQpTNtjo8VZ5bop8g6r9mfu289ncVzf5Soy2byX8jYBXfCQfkRCQALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MszBLhOc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAIhJJ5i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MszBLhOc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAIhJJ5i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785845149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VbhR/EeseCGUhv0h0yNN2Py/m+SxPzo7FfzMk4g7pY=;
	b=MszBLhOchY+md6HmcvB2QW3Xk1e//FqRIkZja+HjmNF+t5AbfT1AFfixhPAlozz03174U+
	Uv//u617+Xyy/yOc8YDYT7UVNxa3XWTZ++ifPtQjOPOpx70+zbD72dO6XrshLrTst39D9w
	mJ6NQ4giMwPTMPohHy2anHNZUp33d3E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-T0S3FnSaMNu6WaURmtvP9w-1; Tue, 04 Aug 2026 08:05:47 -0400
X-MC-Unique: T0S3FnSaMNu6WaURmtvP9w-1
X-Mimecast-MFC-AGG-ID: T0S3FnSaMNu6WaURmtvP9w_1785845146
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f4601af62so2019146f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785845146; x=1786449946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VbhR/EeseCGUhv0h0yNN2Py/m+SxPzo7FfzMk4g7pY=;
        b=cAIhJJ5iypZOUTPkcOfJVA/+T+eNpiURGumey1wvCCiEqCPTbkXpjDSGd2kXAlHDgI
         it6fL70CYJYt++jBX6Pg7dkNwpXmtH4S8MZJHfIyPz7qSzaoI7AJWObi6LyXq1QAfh/N
         Nr2H8i0KrzVACddd0yxSRxEE6+k/odK4HgyRlQphWwyA20wzRZgCDegc5FmKqS2c5ye6
         RpHmIy+9gHvLWdHzrHXywY3ZWc4sDBUJ7s6R48hgs3rRopd8PtRMx2yA9PQRiWon403Q
         VhxLqw3teQZewLTMwxlTswIepR9ZxT8+XJNtkWPVglCnSf0NucOUpwbbhFuuxmtfrjBV
         3ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845146; x=1786449946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VbhR/EeseCGUhv0h0yNN2Py/m+SxPzo7FfzMk4g7pY=;
        b=EptKFD6207Ym+oV0XdR++N1EzURf6BSJSIBAW0APLph6eRqhVeCETihqyhwT7pMxZ6
         51ibv5VQMfzopBRl14vriGIwSTYGNHdsAtud8xJKhxrcU32tkycDdKC1B7lr6SYq2g+B
         rv5BYojeymMxQ3ADZcsHaMg5jA7KeMtWr+WniqihNTiVQkHjEnzo3UN/M1vnsysfOJ3K
         P0nh5cuZrOa488m0bffS4bUKd5HbZwWWBOdkVcBhEWlR4/8KiUU9VCkPrkh0eZ81chKR
         HvuC88Yvu08qOhV5SmsV9vEaFZWEWBBpPcPhfDAyKs1BdgNDyIYwSrcrnLbD8WDFoqXP
         Ummg==
X-Forwarded-Encrypted: i=1; AHgh+RqAppek3cW7DzLedUnlRhVI7HH55tFAkwd3Iu+3BuaCd5NSZNDhLVt3fWo5NXMDj/1pbrZkGkA34H8o@vger.kernel.org
X-Gm-Message-State: AOJu0YxW58Lf7Ho0MRurEYwn4ugwGOjfiT9Vg7JuDyEhNcGmNTy11arC
	I9YlZ2vSIIc71k60MKxSDuNDPqXhcBNG1G4Mpo6YdSWmqHops1ZpKcyMbf8RG3dWJTUYMxKwUbL
	DPA4xyX53b8+CvV6B2Ss54Temf+B39A3WU6Mso3XemgZuw2yXqXJ0xiWX1/2eVLQ=
X-Gm-Gg: AR+sD13uSYY7YenFW8Y3uTrVDlHD1Cq/VYKnkqwiegMqY47kahp0uo6cNTwN/z64eMJ
	r72ZeWvXeQA0AzQmFTbJqC4PXI8okc2fCqvARFTwqTiieLmjJaj3qINca029Ix1CkPJ2OokmBRU
	OCfYwyu/9ZYAf7Zq2EoI3T4CsXMuKUYZSpeD+/TFzOZ+3v7ddg8zrw8Oc6Xv1NE4Xv/hP6Ma5Eg
	VqqhnKZng1aNCppaPxrxsJqTCcsH/UPFpRSVdZgNQtuM9Op1rJwMF0xA0YR+yD19YBMUDrriG0J
	8ghuhRWUUJkFH+qKmwqBqKsJttfzEEwzUAnsotMLHE3sODkA23a7jeReDdDzRpEFZSyx20qk4af
	zEQmQd7xZ3Tewj7TCtufy+tc45sY+ac2XTsX2VmGPQrldStwM0hTrtDEa2DgucMs9zQ6NNLSyjW
	0GmSI=
X-Received: by 2002:a05:6000:2989:20b0:47f:7154:9dfc with SMTP id ffacd0b85a97d-47fd72a8e68mr29813798f8f.9.1785845146082;
        Tue, 04 Aug 2026 05:05:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2989:20b0:47f:7154:9dfc with SMTP id ffacd0b85a97d-47fd72a8e68mr29813677f8f.9.1785845145601;
        Tue, 04 Aug 2026 05:05:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562667sm45367660f8f.24.2026.08.04.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:05:43 -0700 (PDT)
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
Subject: [PATCH v2 4/6] kvm: apply VM_READ/VM_WRITE checks to all VMA types
Date: Tue,  4 Aug 2026 14:05:26 +0200
Message-ID: <20260804120529.1730187-5-pbonzini@redhat.com>
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

The VM_READ and VM_WRITE flags are checked only at the very end of
hva_to_pfn().  For both the hva_to_pfn_remapped() case and for regular
mappings, this adds unnecessary cases and inconsistent error behavior.

For hva_to_pfn_remapped(), the code is relying on fixup_user_fault() to
detect this situation.  This is fragile because hva_to_pfn_remapped()
returns different error codes for a !VM_WRITE VMA depending on whether
the PTE happens to be mapped:

* if the PTE is present, follow_pfnmap_start() sets args.writable to
  false and KVM_PFN_ERR_RO_FAULT is returned;

* if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) returns
  -EFAULT after checking vma_permits_fault(), and hva_to_pfn() ends
  up returning KVM_PFN_ERR_FAULT.

With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.  Likewise,
a PROT_NONE pfnmap VMA would be mapped into the guest if the PTE was
pte_present()[1] when the guest attempted to read it; with the patch
instead KVM uniformly returns KVM_PFN_ERR_FAULT.  Doing the check early
avoids these special cases and also sidesteps the issue pointed out at
https://sashiko.dev/#/patchset/20260731160514.1101989-1-pbonzini%40redhat.com.

For regular mappings a PROT_READ VMA, if placed in a writable memslot,
would return KVM_PFN_ERR_FAULT instead of KVM_PFN_ERR_RO_FAULT when
the guest writes to it.  This would cause a -EFAULT exit to userspace,
instead of triggering emulation as the VM_IO|VM_PFNMAP arm would do;
however it should be considered part of the KVM API because mmu_stress_test
relies on it.

Still, even with this snag about the returned pfn error code, pull the
vm_flags checks in front so that they are done for all VMAs and the
above inconsistency goes away for the VM_IO|VM_PFNMAP case.

[1] on x86, for example, such a page would have _PAGE_PRESENT clear
  but _PAGE_PROTNONE set

Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..576bcb21be3a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2925,17 +2925,6 @@ static int hva_to_pfn_slow(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
 	return npages;
 }
 
-static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
-{
-	if (unlikely(!(vma->vm_flags & VM_READ)))
-		return false;
-
-	if (write_fault && (unlikely(!(vma->vm_flags & VM_WRITE))))
-		return false;
-
-	return true;
-}
-
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
 {
@@ -3008,20 +2997,29 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 retry:
 	vma = vma_lookup(current->mm, kfp->hva);
 
-	if (vma == NULL)
+	/*
+	 * GUP failed.  It could be an inaccessible mapping, a pfnmap one,
+	 * or the page might be absent.
+	 */
+
+	if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ))) {
 		pfn = KVM_PFN_ERR_FAULT;
-	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
+	} else if ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE))) {
+		/*
+		 * Exit to userspace for PROT_READ mappings in a writable
+		 * memslot, as this is part of the API.
+		 */
+		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
+			KVM_PFN_ERR_FAULT;
+	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
 		r = hva_to_pfn_remapped(vma, kfp, &pfn);
 		if (r == -EAGAIN)
 			goto retry;
 		if (r < 0)
 			pfn = KVM_PFN_ERR_FAULT;
 	} else {
-		if ((kfp->flags & FOLL_NOWAIT) &&
-		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
-			pfn = KVM_PFN_ERR_NEEDS_IO;
-		else
-			pfn = KVM_PFN_ERR_FAULT;
+		pfn = kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEEDS_IO :
+			KVM_PFN_ERR_FAULT;
 	}
 	mmap_read_unlock(current->mm);
 	return pfn;
-- 
2.55.0

