Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEFB395AD8
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845158; cv=none; b=uXG4+YckjIIms1MKkGl8K1IT68MqwrxIMz1XCmMTVq8ojkmu3KUZ4bn76vp/ztrGIpISFOrqPPo8Fr7xOxLQTYeO19L8rmMZ5QHQgxHWhazHiQLHTEjTNZZCcWVhATnRnb6L+bfq6kdcINrdKzY0wRyVGQXJFnWJH6QPxC7t150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845158; c=relaxed/simple;
	bh=Zcn8O1erPuSdDnXyXFymHAYFaLae2f2+vOh43hT0kQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPNopad+craKWF1O6FyES0bIdBitmJkadIneyi22tayrXY+HUhpWT99dkSzQh1v/Ip3SCFwYkGrw4PuPzDWxZeYlee13S4biU9MvhrGosYz28ZtTnCP61LD9YwNtCVU0Qo+v6f707+fckbBbe8nbdLjsZ6jjcrxlLnr7FBzEmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Stz6n6MW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMALMmIM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Stz6n6MW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMALMmIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785845154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MKpfy5ngorVqbj+qf8v5CmiQT/j6dhAeNWojtcyJWQ=;
	b=Stz6n6MWhRtr/PC82EV+/NB6DqC0gl6zHlAldhR645+srckGA+UyB94hUsZ/PNnQ0IBCU2
	gJTjdTOXXmID/jfXGUj0NAItHbyRWmBgMAatDFfBrUL3x66twsDr/3+HGSvjETG3NxgDKs
	XQZVDUwWnDSEaoM6bb1FpVooPWcle78=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-G0KU1ookP2qCROV1Sy6O2g-1; Tue, 04 Aug 2026 08:05:53 -0400
X-MC-Unique: G0KU1ookP2qCROV1Sy6O2g-1
X-Mimecast-MFC-AGG-ID: G0KU1ookP2qCROV1Sy6O2g_1785845152
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso20947625e9.0
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785845152; x=1786449952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MKpfy5ngorVqbj+qf8v5CmiQT/j6dhAeNWojtcyJWQ=;
        b=gMALMmIMGhsOWE09Di5u3dFbxkUKvOJmHguRc88lNDsV3F+LtSCWcOj7dt0VMNRM50
         kAbR8X9w1Q1cVGJ0m7rMwgm5GvAIbMfEcnPfB7w07Ak1wG/RZTISnxZyNg3iLsg2XamU
         pB+EqBEXbS8HpDOn8FS+3OjUxYmneC4D0K6eMN6wwxzghh/zlXjqOtGaeK7JdjNeF/+5
         xXuo8k2tWrHNXM4uL+ZxnlxcwHwMT6lt7XX2LY9XUP/VZCRbI117hkDLY+AGHsoKcJ5G
         E0KN+KZf81g0aVO2CvCWVohIuNLWgxw0oT2D+l1DNn0RT+Gc1uK1EMiKru98/xPOUyrl
         zevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845152; x=1786449952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6MKpfy5ngorVqbj+qf8v5CmiQT/j6dhAeNWojtcyJWQ=;
        b=AE6N3KmzX8El2aiDQmrSBWqk0GxXd0kMYXCFiCU1TvDT+d932hAgsgzZFAYGawwqr0
         vG9vuixXoCULp+9AWTKJB5Op/TUb+U/IywaRhYSX/LN30W8oTa8tuDERX3pp++G/o/95
         5qe5GB7qmM35uui3mFfhguXKSzPk/32IZbu5LLs9/fUvbmpqpzrwYri2JTKUQ7LoBKbD
         FDBqQMrX/m/Bd7DbqdmHYZ9wLnBADBsZINw7UBlV/keWV00J/fIUnj+7QJJWtak4XqRq
         739j6c/dq1lg9L85kj15AcUWFh/dFhyO3GIFcg6t1218EpDySW+kpSkPiaB0LZBSGJQr
         3RSw==
X-Forwarded-Encrypted: i=1; AHgh+RovMa3/8HlA86MwwlMbVfCiLWSUqTSTEJaLw0ymAxVgRz0CVkOFYj7ihs0aA6nZld9/wc0K4kuLEQl3@vger.kernel.org
X-Gm-Message-State: AOJu0YwO9hJUg4uFsNKeg7CkSIg8D6gI3pc29OjARlF/uTIygYpBfuOh
	rzgcN3eGiyAdGtbUL+UifH5JlQoqEChXkiocKVnn/t2OsvBBYJZBK8zi4LrM1dNZFlwhhrog0Ge
	sCNwmNX7Gjb8TwhY5LuKRVnBvrchIOhzj+HTi4iFj0VuGSk94iKyTHaoqPnw6MiY=
X-Gm-Gg: AR+sD11Lbdzd8CUjQj6aCUUS3GjVUBv8x389xJ16Rq5dixo9e03CtpWZxjR7NfQzeOD
	uuHnBD8DlGggqqQjPEO+C9zapg3xbGgvAR+7r6lodSap2nN0V4yuYjsELo+v6GuKT+xep4rWnfi
	dJEyRBgQkKhKoKTa+pftjV3odi8KBYz3WKCIiSgStVEXcuifLXfLdJnpWalv6mHYZeUQffZS3jI
	XNjrwdATzZkjruN9Q9LNjxMsMCH2H2OudrnEYwFpWBGVyHzuMUPmFt79QfneX/7P5MUOzhPYjsY
	cnlLdoaE31evkRPuPpLCHtJsNCJMKyJ6H2MZE+oSSDbmzik0rY+eIIMyssm1+fKeMMCMDzmHI5l
	zURTy6eW5cDGldmf/534XLNmT7Rc6T+SO1GBiVNNi7D+jkB5FNFZkubUm6skZ/sComev1M6y5ya
	xfsVc=
X-Received: by 2002:a05:600c:840f:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-4980c60705amr298312235e9.0.1785845151890;
        Tue, 04 Aug 2026 05:05:51 -0700 (PDT)
X-Received: by 2002:a05:600c:840f:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-4980c60705amr298311535e9.0.1785845151462;
        Tue, 04 Aug 2026 05:05:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fd8df5sm88354535e9.9.2026.08.04.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:05:50 -0700 (PDT)
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
Subject: [PATCH v2 6/6] kvm: return -EFAULT for writes to !VM_WRITE IO mappings
Date: Tue,  4 Aug 2026 14:05:28 +0200
Message-ID: <20260804120529.1730187-7-pbonzini@redhat.com>
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

KVM's behavior when the guest writes to a non-writable VMA is inconsistent.
For regular, page-backed mappings it returns KVM_PFN_ERR_FAULT and thus
returns -EFAULT to userspace (which is ABI, and relied upon by tests);
for VM_IO/VM_PFNMAP mappings instead it returns KVM_PFN_ERR_RO_FAULT
and thus exits to userspace with KVM_EXIT_MMIO.

This behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM:
do not assume PTE is writable after follow_pfn"), and even if it has been
in place for five years it is unlikely that it is relied upon by userspace,
since it is inconsistent with KVM itself.  Change hva_to_pfn() to return
KVM_PFN_ERR_FAULT for all non-writable VMAs, and restrict KVM_EXIT_MMIO
to the case of an explicitly read-only memslot.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b7c21a48a45c..da5b0bb62590 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2999,15 +2999,10 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 	 * or the page might be absent.
 	 */
 
-	if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ))) {
+	if (vma == NULL ||
+	    unlikely(!(vma->vm_flags & VM_READ)) ||
+	    ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE)))) {
 		pfn = KVM_PFN_ERR_FAULT;
-	} else if ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE))) {
-		/*
-		 * Exit to userspace for PROT_READ mappings in a writable
-		 * memslot, as this is part of the API.
-		 */
-		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
-			KVM_PFN_ERR_FAULT;
 	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
 		r = hva_to_pfn_remapped(vma, kfp, &pfn);
 		if (r == -EAGAIN)
-- 
2.55.0

