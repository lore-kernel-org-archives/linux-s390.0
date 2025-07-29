Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365A298CB7
	for <linux-s390@vger.kernel.org>; Tue, 29 Jul 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810966; cv=none; b=eJk/dZ/W5rTLWsup4ySm7AlM3IpEwGr/0RfteE7PFUkx/XxAC8F7bwRYBZA6MZet4WhNChSCx37gRrrstxkJ7Ns4UGCgQ7NEiCEelOPG46mjMRTrO4k3KGT3HETngDNJLCo5qid6QS7nAt8SFpLtMit13vce5+s+jkeGlPufDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810966; c=relaxed/simple;
	bh=Tw3eT5+iSuoQ8qKLRQi8HnYPIAcfpsKb0i0ErGvCLhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tDHHr4OlX6+0KszlvPwAdq0CwdWRzXQfV/zdvPy6UJvn8KHm1TeZDG5UPLH99b/ty21ROJ5VmuZ8Qge52iqDmu9hFDq0YnhM+v/mz+PQw3aJ6QULTkknB8xMJ9mM5XWAWx+7RlYlz+WiU4YgpQAbaIFGdgjbxqCbrbKzx3Q9SSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngM5zMq6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngM5zMq6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso4300854a12.3
        for <linux-s390@vger.kernel.org>; Tue, 29 Jul 2025 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753810963; x=1754415763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=28d3iRVWXUX6sIuoOntS0GSvjTzmcc+IeE+Mf6uMd/w=;
        b=ngM5zMq6YKJIGjfoPeb4omh4kIgptqTb9R3/bxZIf8O2iWTPT5yetDDFSR5hDZ1JMH
         yT57duoRh4RGl3IvP+hE0QxZ7dInYPoX3xFdiKCFg9YkaNVPwD8JM5fsFu9DJ5BAgXTr
         Ug9Xb0rBpnJI1E4e4fZc13uFj+HV3RrwI2lbfY+62GNO2qRe8hoo1BanZBx4UuREFFH9
         EcROBLPS6yDJT/ssLExYzyjsnWd6ZYlC0nC78Adl5Qnd8TVlhACJ19+/qIZOJYL0DwLA
         X0kgOypBwrjuOiT/BYAQNhaYg7v9E5uKcx9zqN3Rnjc6ELZ+VhUOKU2nmnr7hT+brk0u
         zLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753810963; x=1754415763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28d3iRVWXUX6sIuoOntS0GSvjTzmcc+IeE+Mf6uMd/w=;
        b=AFYnvYE+z7HGdHp7ieqUdEWRlpA9s/qJDgrc4aGHE0spDY1Q22XeyC8+cSgBZxCxfd
         GXz0K/uKX/7bzyDTCM4eDDb4AaTcnlsiX0qpaj/vF8LLLtk4npkB+jXq0uEhiF61GXR5
         LRtzTn1TeIjsax5JJCICfGGwCKp79R4qiiQcd/q5dVD46kSbe2xSAFpsfV/3VawqArGT
         tlRCjL0CkgTl2vmCGUJyf+WSoI/hX7/zVq5KMg4PKobDR2Th/z/Bfdr5oMj3gT30dFgZ
         0UzU8e48VnrG1+NHJkLC04C72xQUygeXo/M9augHtzOxncrb5TuJRKM7P1mfgLZwcSbr
         20OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMzVubwRg6bGwM/uE2fHZdyFF8IqJA4aN9MqX7JPpOrIyf4Okr/wwoh8YsSo04fGgN9nkTN+OiQnIH@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMiLRhE6QNJ1apwuXDAul1UTaHupBYcnh8kbzlLMbv3u9HmJU
	EPSUAKBxGgLU0HI/maJIMLQDcuWWSCfa9OkwRAt7v+MFTvMQjxdwcf/xMO30ndmCjauExaYi95v
	n+uV8AQ==
X-Google-Smtp-Source: AGHT+IGrgXqonk21Zb71xxleI4T0pEaWNxg21m5l9HHcgxwGP0sMZOCP8Yhgfitp+Fk5/XHGu56nse7Bq+I=
X-Received: from pjsc23.prod.google.com ([2002:a17:90a:bf17:b0:2e0:915d:d594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac5:b0:31f:2efe:ced3
 with SMTP id 98e67ed59e1d1-31f5de2f623mr482833a91.5.1753810963229; Tue, 29
 Jul 2025 10:42:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 10:42:33 -0700
In-Reply-To: <20250729174238.593070-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729174238.593070-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729174238.593070-2-seanjc@google.com>
Subject: [PATCH 1/6] KVM: s390/vfio-ap: Use kvm_is_gpa_in_memslot() instead of
 open coded equivalent
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Andy Lutomirski <luto@kernel.org>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-sgx@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-s390@vger.kernel.org
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/include/asm/kvm_host.h  | 2 ++
 arch/s390/kvm/priv.c              | 8 ++++++++
 drivers/s390/crypto/vfio_ap_ops.c | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index cb89e54ada25..449bc34e7cc3 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -719,6 +719,8 @@ bool kvm_s390_pv_cpu_is_protected(struct kvm_vcpu *vcpu);
 extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
 extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
 
+bool kvm_s390_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa);
+
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 					 struct kvm_memory_slot *slot) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9253c70897a8..7773e1e323bc 100644
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
+EXPORT_SYMBOL_GPL_FOR_MODULES(kvm_s390_is_gpa_in_memslot, "vfio_ap");
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
2.50.1.552.g942d659e1b-goog

