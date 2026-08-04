Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF443AA507
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845148; cv=none; b=aQx62NhKNvn41jF97QqmDcITG053QNAHFO4WmM7MOfIwEJXUwjVINkcO2lOg8egZapF5PH7V2kIlNOXwgR5QF4kzuDOZkZp3+tmwxMYVNIWJTQjDD94Om8ismSgS0vn5NQVkTf/DatXn80WsHeZfUpNy40jhFhzQByByO2LGiDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845148; c=relaxed/simple;
	bh=qhkR2v3EkAztMd7zn4yTHh4XbDWdyGkn7YKKdVCCJyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWULw2BdGKHSs+Fi4LEohIhkXtO6RAz3N3AIteWfLthLjJk7BpBfYcX6KJo0st9ma9/gIBHHhCTcJdotDWumemGWGJGVq7qYIgH+CKeptPJ9kIW0MS5dA8ydkoz+5JyA6NyD+Gh3DTTet7CN47LnxNYC39oC7ZM3Mu5kAZAzY1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLo1cM+t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xw4bPWhW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLo1cM+t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xw4bPWhW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785845146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZAgqjN1G77tAGGqT1Vu5xvpE2S1pmBmpjJ+rMqalos=;
	b=MLo1cM+tcsmR3HNNFLeJy3qM0lM80YEzymPFnhHMr9OM3C32AJU5YACPEkeZLl7w/s8e/F
	oomAJzY1a9ZRZ3pcRK/iWK5TqqO+QQoh7KPChe6x+K1PRRgPZXGpvyuaoNvRvIzKRbuvhA
	k1BEoX0Drk6h9jdjdqiq/ic9c+1bKf8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-DODoYSDJN8q5BgWA6jKB_w-1; Tue, 04 Aug 2026 08:05:33 -0400
X-MC-Unique: DODoYSDJN8q5BgWA6jKB_w-1
X-Mimecast-MFC-AGG-ID: DODoYSDJN8q5BgWA6jKB_w_1785845133
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so21105335e9.1
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 05:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785845132; x=1786449932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AZAgqjN1G77tAGGqT1Vu5xvpE2S1pmBmpjJ+rMqalos=;
        b=Xw4bPWhW5YhH4Hbuq1Zzw9eyP1K5934gjy2faqt+1W0dGTLCvjgyVjxj57+XHM1UQg
         +O+fJH+kTZtaqFhjKX5zIotBkFK6hlf3+09VU9QxwRyt5ENJBpQZbV85xglnogJdf7yc
         v2YIN/eqCdG/7TZJOOXar3LmbF4SVVpgnRrn/P+oNjoHpZNbx5pkqxDOztWlVP5prssL
         gIlCczdj32EXl9w9UR03OHonik/Ks/w6kpFBPEWwuQadRz9yFtnh75eOLvjOiFLx5u56
         yitXwrc5nLdli/Pufu/E7MA3uNd8NAx9ThYpLSbjJEizOKOV4c8M9oT3KYZr4azqij74
         xdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845132; x=1786449932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZAgqjN1G77tAGGqT1Vu5xvpE2S1pmBmpjJ+rMqalos=;
        b=XWuxJupOVOMXLxh+0a/Kps8lqKZPf+8C13bUPTVQiVzRU0+013O1MizowkD5I4qDlN
         54UKI+vHVUOgXEK/1gV03YUO7DVxQXg0OAomTfmFF1MwJd/S8DR2YmmfaH3Tlna57f1a
         SYvFOkOxxK/kTAgAZrjhwr2Q/NsNcRpnj66uTnVil4sGslIOPRPzSvpHB5gz8Pe3Nn3y
         tmAJEtaCuA3py6/Tgej+0Rd53zrXOOwr0VBJLg8bRp4SbsV1KclfSEaivAfAXA6zTkPG
         VJf44k/u8lkhAAT3HKtEjCxCEuXMXRIu8cMBydJ4f1n9AWMz5RfI5YQGuvfWOHP6NxTM
         KUgQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHGwSjS5aN77mBP7/SvQr3GuFT1qDQkSMRoflmS/77eJT+yUMl3NlR/DMTDir3aYTF75tp7ZSvpGZ/@vger.kernel.org
X-Gm-Message-State: AOJu0YwjvyGhGmcOMgNjmP8RHaiRgSJ2+xtQNSdXwlvWftLW+aKgmnFQ
	yiTr5DWsMn5/wG6qw7CzWCozz7RWgnZLseNS9bIIqan9YLAeZo9wHxVAu889f05FunIEocVqo69
	WKxOST2YTz3Ct/PWrjDkkoBgDNqDUpy57DQf0sj6AB+Xz4WLhKO1R51MADMSxvG8=
X-Gm-Gg: AR+sD102qt4SThO+h19RCKG+RmnxM4qwN2njM6X9JLcSOw9356z+hz13pAcicghVL0j
	ecvbjWbYAAjvaGppU74IoJrvhFDgBzd1d71qpE8mSdvctxXb7gmPrLCDxSF4+wDXckxr3r18HGk
	h58LlvaIeJJN6uKIQyXg5heJHLQ8dN0Ul8zDNrj+ObZJ2E9BJ4AXtBTiRh9s53KfXY0Cx/idSHY
	owWm1nt1T4Gq6lv5qrfkKYrltnPJiy5Dt9NPiWOgm9egOoKlqdfzZ95bIpXeTLudjYJB2iAS4EY
	MTOCbuV7cnzUj9psFsZqzPPXnIAsNMqz3nKtrlmeeZB0ZXrm/83ZMjL2jTqIN3x5Zflnpb4qjLs
	2xZ2SuHM65gfPVFhKPKL1usCdSh2x8n2RzxWvcC4S7A6Mez71PHAE+JS2R06NPjW7hBBXUMAR9I
	O1FaE=
X-Received: by 2002:a7b:cc82:0:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4980c673d61mr252270885e9.12.1785845132449;
        Tue, 04 Aug 2026 05:05:32 -0700 (PDT)
X-Received: by 2002:a7b:cc82:0:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4980c673d61mr252270015e9.12.1785845132021;
        Tue, 04 Aug 2026 05:05:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec606sm99039055e9.14.2026.08.04.05.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:05:31 -0700 (PDT)
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
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/6] mm, drm: fix interaction of .pfn_mkwrite() with fixup_user_fault()
Date: Tue,  4 Aug 2026 14:05:22 +0200
Message-ID: <20260804120529.1730187-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This "v2" combines three series that I have previously posted separately to gather
reviews and tests:

- kvm: apply VM_READ/VM_WRITE checks to all VMA types
  https://lore.kernel.org/kvm/20260731175834.1121005-1-pbonzini@redhat.com/

- mm: pull writability check to follow_pfnmap_start()
  https://lore.kernel.org/kvm/20260731160514.1101989-1-pbonzini@redhat.com/T/#u

- mm, drm: ensure .fault() does not have to be followed by .pfn_mkwrite() for write faults
  https://lore.kernel.org/kvm/20260731164341.1109827-1-pbonzini@redhat.com/

All three, together, make it possible to write drivers that use .fault()
and .pfn_mkwrite() callbacks for VM_IO|VM_PFNMAP regions, and that also
interact correctly with users of fixup_user_fault().

The problem is that if you define .pfn_mkwrite(), vma_set_page_prot()
clears the writable PTE bit in vma->vm_page_prot, at which point
the .fault() callback has no way to create a writable PTE.  Users of
fixup_user_fault() will then see a read-only PTE and have no clue that
the page needs a *second* fault to reach its final status.

fixup_user_fault() itself does not have a good way to notice this, because
vma->vm_page_prot is an opaque pgprot_t, so the fix needs to be somewhere
else.  Other preexisting functions, namely vmf_insert_page_mkwrite()
as well as vmf_insert_pfn_pmd(), suggest that this has to be the driver.
In fact, of the five vm_ops that use .pfn_mkwrite() together with .fault(),
three are in file systems and are not buggy: all of them ultimately end
up in dax_fault_iter(), which uses vmf_insert_page_mkwrite() to correctly
insert the PTE.

The two problematic implementations instead are both in drm code.  One, in
drm_gem_shmem_helper, was reported as a KVM regression; the other, in
vmwgfx, was found by inspection of .pfn_mkwrite() implementors.
Both of these use pfn-mapped regions, but there is nothing like a
vmf_insert_pfn_mkwrite() function that they could use; the first part of
this series thus adjusts mm.h to provide two new functions for this
usecase---vmf_insert_pfn_prot_mkwrite() and vmf_insert_pfn_mkwrite()---and
then teaches drm's two users of .pfn_mkwrite() to call them.

This however leaves another case buggy where fixup_user_fault() is preceded
by follow_pfnmap_start().  Most callers of follow_pfnmap_start(), seeing
it return 0 for a PFN that is mapped read-only, would not attempt to
call fixup_user_fault() on it, and thus the PTE would not be upgraded
to writable.

This is arguably a bug in... almost all the callers of follow_pfnmap_start(),
but fixing it is much better achieved with a small improvement to the API;
if follow_pfnmap_start() is told by the caller that it needs the memory
for a write, most callers are simplified because they were doing such a check
anyway and now just see -EFAULT.  They then proceed to call fixup_user_fault()
and everyone is happy.  This is done in patch 5.

To sum up:

- patches 1-3 introduce the new MM API, and use it in the DRM .fault()
  callbacks to install writable PTEs in response to write faults

- patch 4 is a preparatory fix in KVM, eliminating inconsistencies in the
  handling of !VM_READ and !VM_WRITE VMAs; these would return different
  error codes for a !VM_WRITE VMA depending on whether the PTE happens
  to be mapped (but with wrong permissions).  This needs to be here
  because the next patch would introduce even more inconsistencies.
  
- patch 5 moves the check for writable PTEs from follow_pfnmap_start()'s
  callers to the function itself

- finally, patch 6 is a KVM addendum that will have to wait until
  the next merge window; it removes yet another inconsistency in
  KVM's handling of !VM_WRITE but is technically userspace-visible,
  and therefore it shouldn't be included in stable kernel releases
  unlike the rest.


Thanks,

Paolo


Paolo Bonzini (6):
  mm: export vmf_insert_pfn_prot_mkwrite(), change variants to inline
  drm/shmem_helper: use vmf_insert_pfn_mkwrite()
  drm/ttm, drm/vmwgfx: directly create writable PTEs when mkwrite is in
    use
  kvm: apply VM_READ/VM_WRITE checks to all VMA types
  mm: pull writability check to follow_pfnmap_start()
  kvm: return -EFAULT for writes to !VM_WRITE IO mappings

 arch/s390/pci/pci_mmio.c                   |   2 +
 drivers/gpu/drm/drm_gem_shmem_helper.c     |  38 +++---
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c |  42 +++---
 drivers/vfio/vfio_iommu_type1.c            |  17 ++-
 drivers/virt/acrn/mm.c                     |  10 +-
 include/linux/mm.h                         |  84 +++++++++++-
 mm/huge_memory.c                           |   2 +-
 mm/memory.c                                | 146 +++++++++++----------
 virt/kvm/kvm_main.c                        |  44 +++----
 10 files changed, 232 insertions(+), 160 deletions(-)

-- 
2.55.0

