Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E838248F6F
	for <linux-s390@vger.kernel.org>; Fri, 19 Sep 2025 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242002; cv=none; b=BLJIVZUV8ZO5qfyeUjpQd6QHVMA6p+wp/YNpnW6T8SKZhZpnGkZdr3o++790Dr0v7BdLDG/8SKw+Us4VRVEJDnACrzU884/yITknfb8xqP0cYIYkVB8rjRPYRU/UiY5OZrqCheqKDj5sEZjV0DlMhOkfrHqxNJaurk0530KAdbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242002; c=relaxed/simple;
	bh=QPe7hL/QhQ8FyrgrV1HSwe5wRNrlTS+CZ/xfYX1N1xw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PyHhDBzDv9k/utIv6KGlOIH2lQjOx04QDgcMT4f/8a3gFQdahRKtgldDWJdNWB6SmEw4zkzMNlpXj7z6VQ/thSUXkWeDx4cRkM4ie1E67B2ydr7DWzcYaSVfaho1XKjrYFTwF/KkuUUrllEd8wCUPY1E3V4ILDt4lIT+9bg1yug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emPcs2ug; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emPcs2ug"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c4aso1444389a91.1
        for <linux-s390@vger.kernel.org>; Thu, 18 Sep 2025 17:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758242000; x=1758846800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=50iAb3TbAebOi3cXMklwS6LjjlcHrLpQ5f/WYr9Gs1U=;
        b=emPcs2ugS9/JFUjcWyMPoqb6e4ejF+UxrZWZxvsDb8rGtNwBRDHUdZnv4EiZ3Aaq+y
         dJb9tshFsBbY/5/slfj+eKZoI4m8I8Oy06bRg/u3hKhCyoa+UJTHvhFYVYPOfhie/m6a
         f1xZSaVVjBjgmtjjlPop7ECjY1jzd1eksegoYnCkMcQMErUanT4C/0B0P5m8acJGdkYA
         +nAinTRgXU8pIvdO1sYcCbbBEqpE1IMmWj3Sq7XezSZxL4un5A0bycSLRhfiA4p3somk
         gwoGAa24Uqbvj6pWPByznSCWupkgpNNbWft9BqDN9Tyu5RwvQMOkoLXXiJOJ3MlMlGOB
         y3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242000; x=1758846800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50iAb3TbAebOi3cXMklwS6LjjlcHrLpQ5f/WYr9Gs1U=;
        b=rx1xmbyHEHoyJkMTguDJG/dxJfWXCeS8dHBGjCkRGyI7Exr0IcHvonPUfSS96VfYCh
         nnIUFxK7j8OMPiVaP0fdwx3Xz9/XKQmBjaPZCIkurJCTMp25A026Eyg8/jHSpwC3AW0g
         VJgGkn8C5Bj/0ttDiFHHO3cdPrEtFxPSD4+50Xxcw9xI02yKD59iZW/pvLc2cNlvrQzk
         ds1Rp14YPqHsEeqYabvKzVKJEsrJd+fWMJogLojvV17eyMUWWFV7BunAFvmVjWHTdK/K
         IhXgposEyMCvOK3nocOukcJ33QSkx74rnH9vhocl/M7WGzqYgEpyWXsR6joewYf7+zZ7
         9qBg==
X-Forwarded-Encrypted: i=1; AJvYcCXqxa/t4Kokd2DeS1WGq3iDOVpQB5q9BxJIXXdP512vU2cMw2wfak9TdljoDDkcUXCDBiozgpuJPg2R@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjjVF6o5zyg4YDTSaLND70vCWBghk5cusZv7n73IZVg9e5J9P
	ZW4Rj1V5qt2INSLqjtlFGcyId7DKeuA4ihObQSXv2LdMJMV2o8gI/WL+MPTI30QzoF1djFxS6C9
	678G4Vw==
X-Google-Smtp-Source: AGHT+IHWbOdo8qoTOqbS20QiAs/keKKGZuQU4AXsDlIYjlpZHJfwwwTHdlmwpscoisSH/f9YdBDDPaf6ydo=
X-Received: from pjbsi16.prod.google.com ([2002:a17:90b:5290:b0:32e:8ff7:495])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3508:b0:32e:7340:a7f7
 with SMTP id 98e67ed59e1d1-33097fd0f2bmr1581820a91.2.1758241999747; Thu, 18
 Sep 2025 17:33:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:33:01 -0700
In-Reply-To: <20250919003303.1355064-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919003303.1355064-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919003303.1355064-4-seanjc@google.com>
Subject: [PATCH v2 3/5] KVM: x86: Move kvm_intr_is_single_vcpu() to lapic.c
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

Move kvm_intr_is_single_vcpu() to lapic.c, drop its export, and make its
"fast" helper local to lapic.c.  kvm_intr_is_single_vcpu() is only usable
if the local APIC is in-kernel, i.e. it most definitely belongs in the
local APIC code.

No functional change intended.

Fixes: 2f5fb6b965b3 ("KVM: x86: Dedup AVIC vs. PI code for identifying target vCPU")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ---
 arch/x86/kvm/irq.c              | 28 ----------------------------
 arch/x86/kvm/lapic.c            | 33 +++++++++++++++++++++++++++++++--
 arch/x86/kvm/lapic.h            |  4 ++--
 4 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 17772513b9cc..00a210130fba 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2412,9 +2412,6 @@ void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
 
-bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
-			     struct kvm_vcpu **dest_vcpu);
-
 static inline bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
 {
 	/* We can only post Fixed and LowPrio IRQs */
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index a6b122f732be..153134893301 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -354,34 +354,6 @@ int kvm_set_routing_entry(struct kvm *kvm,
 	return 0;
 }
 
-bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
-			     struct kvm_vcpu **dest_vcpu)
-{
-	int r = 0;
-	unsigned long i;
-	struct kvm_vcpu *vcpu;
-
-	if (kvm_intr_is_single_vcpu_fast(kvm, irq, dest_vcpu))
-		return true;
-
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (!kvm_apic_present(vcpu))
-			continue;
-
-		if (!kvm_apic_match_dest(vcpu, NULL, irq->shorthand,
-					irq->dest_id, irq->dest_mode))
-			continue;
-
-		if (++r == 2)
-			return false;
-
-		*dest_vcpu = vcpu;
-	}
-
-	return r == 1;
-}
-EXPORT_SYMBOL_GPL(kvm_intr_is_single_vcpu);
-
 void kvm_scan_ioapic_irq(struct kvm_vcpu *vcpu, u32 dest_id, u16 dest_mode,
 			 u8 vector, unsigned long *ioapic_handled_vectors)
 {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3b76192b24e9..b5e47c523164 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1237,8 +1237,9 @@ bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
  *	   interrupt.
  * - Otherwise, use remapped mode to inject the interrupt.
  */
-bool kvm_intr_is_single_vcpu_fast(struct kvm *kvm, struct kvm_lapic_irq *irq,
-			struct kvm_vcpu **dest_vcpu)
+static bool kvm_intr_is_single_vcpu_fast(struct kvm *kvm,
+					 struct kvm_lapic_irq *irq,
+					 struct kvm_vcpu **dest_vcpu)
 {
 	struct kvm_apic_map *map;
 	unsigned long bitmap;
@@ -1265,6 +1266,34 @@ bool kvm_intr_is_single_vcpu_fast(struct kvm *kvm, struct kvm_lapic_irq *irq,
 	return ret;
 }
 
+bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
+			     struct kvm_vcpu **dest_vcpu)
+{
+	int r = 0;
+	unsigned long i;
+	struct kvm_vcpu *vcpu;
+
+	if (kvm_intr_is_single_vcpu_fast(kvm, irq, dest_vcpu))
+		return true;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!kvm_apic_present(vcpu))
+			continue;
+
+		if (!kvm_apic_match_dest(vcpu, NULL, irq->shorthand,
+					irq->dest_id, irq->dest_mode))
+			continue;
+
+		if (++r == 2)
+			return false;
+
+		*dest_vcpu = vcpu;
+	}
+
+	return r == 1;
+}
+EXPORT_SYMBOL_GPL(kvm_intr_is_single_vcpu);
+
 int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 			     struct kvm_lapic_irq *irq, struct dest_map *dest_map)
 {
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 50123fe7f58f..282b9b7da98c 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -236,8 +236,8 @@ void kvm_wait_lapic_expire(struct kvm_vcpu *vcpu);
 void kvm_bitmap_or_dest_vcpus(struct kvm *kvm, struct kvm_lapic_irq *irq,
 			      unsigned long *vcpu_bitmap);
 
-bool kvm_intr_is_single_vcpu_fast(struct kvm *kvm, struct kvm_lapic_irq *irq,
-			struct kvm_vcpu **dest_vcpu);
+bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
+			     struct kvm_vcpu **dest_vcpu);
 void kvm_lapic_switch_to_sw_timer(struct kvm_vcpu *vcpu);
 void kvm_lapic_switch_to_hv_timer(struct kvm_vcpu *vcpu);
 void kvm_lapic_expired_hv_timer(struct kvm_vcpu *vcpu);
-- 
2.51.0.470.ga7dc726c21-goog

