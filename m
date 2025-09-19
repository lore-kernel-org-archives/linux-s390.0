Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044D244698
	for <linux-s390@vger.kernel.org>; Fri, 19 Sep 2025 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758241999; cv=none; b=DZCEUjPAvUqZdhxsfA04f0grEqh8C1gGk6dw7LD7oTJymKnRyL0OJiDvAEC3ezUSnn/tRrsJyAj6APiBvVwQY3Ivfmd+2BFLhD6B+c470S51K93lYEuPtd5SN8t3cWi8IBEjggNX+N45CoeL6+EzzfNWq84QgZZT5gZeKaffFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758241999; c=relaxed/simple;
	bh=m6dZI+ZwLyJuMwFLGjc1a+3t+gzyy/UmgZ+fCf2theI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GjJ6n8LNpfcOkjxKw1Sa1FdEyvssPi2zbSgTglI5vJpqjU4xRYi5+3oZANm/SbCQ1Xr0zaZktePZI0U6oO7NFp2MwwZSrqcuNDMphzTE7z+mCfk5RmveFhGYPDCHzzZMXOCpEZH4+SzJo6HMGWv11ZJqc2X1XLgk2g1ao0eIw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Muxm8NI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Muxm8NI"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2665e11e120so16655815ad.0
        for <linux-s390@vger.kernel.org>; Thu, 18 Sep 2025 17:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758241996; x=1758846796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tMuCCcykP7UyXODG1nuaeEehr/fAveTIKF4KZJ2JmiU=;
        b=1Muxm8NI7RHKOTd4QACW8HQP0tBNeUW3j7PCWux+Km8kSHYB9V2iinGlXfgYTJdYtG
         nKSQdbOqf+EcitVX21CghDQpulyKTRmApW4OgMHAhltzIIQnNRpLVwe7Aj1dD3RLIy/J
         zLTad9Le+Zr62TNBMwYLcO8I2P+7qZLvfA7XO8dcmmqvOhrXsnoXGkopr4HBI6We+zuv
         x/oGE6wkurO4cKWt0kwyBpyBkT9sRisF2TEAQ7LxBnifu4T3E3CbQD74ELsq1J4MX+Bl
         pZvwS6bA+SoI9+0KAhwH+GIT82Ay1dhVecNiDp+50xBf/XLvOJ8bVm2S6dv/Tbw0iJMs
         lQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758241996; x=1758846796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMuCCcykP7UyXODG1nuaeEehr/fAveTIKF4KZJ2JmiU=;
        b=srB2vJKbX44e3N+zb8+/Zo1OFqCO4ZBdTvx51jgQ4Ptycelql46HQ8xRGi4BQGYxqa
         k7401dC+oFxEEoE3zor6JI5Ki9ErQFhNptmmfZKK/d3WDrvf6qg4ZbYreKKD5qF59+Y0
         m7DAOpGESwMRIu5f2gKNY0XIqXHvZOeseUdLZ+xqDpglEAMh8CV4USQGsccerZjdTkZx
         LRaT75QSFzcZgzBz/D11aD8EPzLP1tUh3Gz5YZ+ramRNh4YVlZnOtI4tbtjRRNs91yqD
         wcPHscEraV2fTREPT8WGh5CHYMDM57VXdBuDCmP+GHRrPlC8uzICPoRS8BCfHqAL166l
         3jxA==
X-Forwarded-Encrypted: i=1; AJvYcCUFwddHMFi28DKImNcMJ2ahXuPxvBrxLk9SN7+1/9scaMTI7P+Z556JlhiQmhGtpsjDvdOjCWMLergd@vger.kernel.org
X-Gm-Message-State: AOJu0YytMz4KceSOztpItR9qNV+fXH2FUoIqyt2I+nSNTnCirKOt0F2D
	mNDzq5h0BOtkPaBlr/tja5bRV9sVtzM2psh/lommp1Uk2lgW1OZIn4rmD5ympucZrpe8mnXFv0t
	L+QcfmA==
X-Google-Smtp-Source: AGHT+IFzlv5dXL7dtF1e+eMqZ1ge+J+8LQ3uyWOVWDPWtrQZD4mZKX7IbeJApn+FgKkV2SAzI1W4lLt65x4=
X-Received: from pjbok3.prod.google.com ([2002:a17:90b:1d43:b0:330:8b1f:c4e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:bd87:b0:250:5ff5:3f4b
 with SMTP id d9443c01a7336-269ba467e97mr13530515ad.15.1758241996301; Thu, 18
 Sep 2025 17:33:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:32:59 -0700
In-Reply-To: <20250919003303.1355064-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919003303.1355064-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919003303.1355064-2-seanjc@google.com>
Subject: [PATCH v2 1/5] KVM: s390/vfio-ap: Use kvm_is_gpa_in_memslot() instead
 of open coded equivalent
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use kvm_is_gpa_in_memslot() to check the validity of the notification
indicator byte address instead of open coding equivalent logic in the VFIO
AP driver.

Opportunistically use a dedicated wrapper that exists and is exported
expressly for the VFIO AP module.  kvm_is_gpa_in_memslot() is generally
unsuitable for use outside of KVM; other drivers typically shouldn't rely
on KVM's memslots, and using the API requires kvm->srcu (or slots_lock) to
be held for the entire duration of the usage, e.g. to avoid TOCTOU bugs.
handle_pqap() is a bit of a special case, as it's explicitly invoked from
KVM with kvm->srcu already held, and the VFIO AP driver is in many ways an
extension of KVM that happens to live in a separate module.

Providing a dedicated API for the VFIO AP driver will allow restricting
the vast majority of generic KVM's exports to KVM submodules (e.g. to x86's
kvm-{amd,intel}.ko vendor mdoules).

No functional change intended.

Acked-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/include/asm/kvm_host.h  | 2 ++
 arch/s390/kvm/priv.c              | 8 ++++++++
 drivers/s390/crypto/vfio_ap_ops.c | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index f870d09515cc..ee25eeda12fd 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -722,6 +722,8 @@ extern int kvm_s390_enter_exit_sie(struct kvm_s390_sie_block *scb,
 extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
 extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
 
+bool kvm_s390_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa);
+
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 					 struct kvm_memory_slot *slot) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9253c70897a8..9a71b6e00948 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -605,6 +605,14 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 	}
 }
 
+#if IS_ENABLED(CONFIG_VFIO_AP)
+bool kvm_s390_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
+{
+	return kvm_is_gpa_in_memslot(kvm, gpa);
+}
+EXPORT_SYMBOL_FOR_MODULES(kvm_s390_is_gpa_in_memslot, "vfio_ap");
+#endif
+
 /*
  * handle_pqap: Handling pqap interception
  * @vcpu: the vcpu having issue the pqap instruction
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 766557547f83..eb5ff49f6fe7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -354,7 +354,7 @@ static int vfio_ap_validate_nib(struct kvm_vcpu *vcpu, dma_addr_t *nib)
 
 	if (!*nib)
 		return -EINVAL;
-	if (kvm_is_error_hva(gfn_to_hva(vcpu->kvm, *nib >> PAGE_SHIFT)))
+	if (!kvm_s390_is_gpa_in_memslot(vcpu->kvm, *nib))
 		return -EINVAL;
 
 	return 0;
-- 
2.51.0.470.ga7dc726c21-goog

