Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9944C433FE
	for <linux-s390@archiver.kernel.org>; Wed,  2 Nov 2022 23:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiKBXUS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiKBXUC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Nov 2022 19:20:02 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF02652
        for <linux-s390@vger.kernel.org>; Wed,  2 Nov 2022 16:19:29 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k16-20020a635a50000000b0042986056df6so98066pgm.2
        for <linux-s390@vger.kernel.org>; Wed, 02 Nov 2022 16:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SRqZjl0CVbTa6NG2E64G3dLAUo/Pz8pk6hIhLm2VMUc=;
        b=N/AO+DlAJnQ9J/vtwHmeA+LWmW2X38Xvh1eLG4RWzywbm32Vf0IsEJKwUIfrABuxFl
         0EKhIzYrEfkzCVSFK3biZb9XwWk4XwwJS/OnHHvaR70SNUpWUpE57FN4sbTk/TPj35x/
         cAJkeY4R4md/H6BBXnN0tlgqyVYRq72kGCHMOXzsnn+VDv0nws/iLVsXJU1fSeeLEY4w
         /5W7IzSHqdo5Jkh7TgJ/2kp0Wml2Tqdg9OOSx8bwuC9pmrXmMmqnDL37uTYdYPfVtwii
         poXkBmFS7imW8u09oi9MQ4pJzJGTl8VmWIvB/CfRCk2mynsmxJDVg6mdWRwKUMtA9Dq0
         KkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRqZjl0CVbTa6NG2E64G3dLAUo/Pz8pk6hIhLm2VMUc=;
        b=GU6l/EpvJ/donqEoWiNWp2eWaf0oUrzdLL6ZVeAJ1Q0imTL+SVpg0Jp3oyqnmcShtE
         2rh1PdsMS86gtWPp2qFkL4ECU2Y1ob5A36p2ViYXsr2TrPPWr/z5z4rDlpd4M4U5ZhI/
         1jNWuQOYhNSGpRQqE1RoJxJ8aU/jzIw04glBWg9oVEfhO0p4Q6du6ZWF0Ct5ZRuVhYVC
         6bwTQimDgp0+P737Z6JEEqA8PCDQJ26u1gY9jDYceYTt4RfsUub046wYQffCfWbxhsVq
         i5D37T3H2+rz5njUvmBtZREsIQ+yWmC37Ia0EMUNnGSLZN8lYSq4vo6sV5EhURDR6yhG
         18xw==
X-Gm-Message-State: ACrzQf1ygADUxm2q9ZUFRmOvl9Hcwsyp9ry3Itgg37ea2GGA4aP5Dmnp
        akIkuma+jYMv/i1YytziWSjCENqzmF4=
X-Google-Smtp-Source: AMsMyM4EhVfOAXnvh3uqqR+GrfRtTcz5EdIn8ldyko2v+yjX0B25rXaAkhDgO2YLd/AhKl4jKmJJf3AFTk4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d89:b0:56c:a2b:f1c2 with SMTP id
 z9-20020a056a001d8900b0056c0a2bf1c2mr27838704pfw.45.1667431169395; Wed, 02
 Nov 2022 16:19:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:18:36 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-10-seanjc@google.com>
Subject: [PATCH 09/44] KVM: Drop arch hardware (un)setup hooks
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Drop kvm_arch_hardware_setup() and kvm_arch_hardware_unsetup() now that
all implementations are nops.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h   |  1 -
 arch/arm64/kvm/arm.c                |  5 -----
 arch/mips/include/asm/kvm_host.h    |  1 -
 arch/mips/kvm/mips.c                |  5 -----
 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/powerpc.c          |  5 -----
 arch/riscv/include/asm/kvm_host.h   |  1 -
 arch/riscv/kvm/main.c               |  5 -----
 arch/s390/kvm/kvm-s390.c            | 10 ----------
 arch/x86/kvm/x86.c                  | 10 ----------
 include/linux/kvm_host.h            |  2 --
 virt/kvm/kvm_main.c                 |  7 -------
 12 files changed, 53 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 45e2136322ba..5d5a887e63a5 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -859,7 +859,6 @@ static inline bool kvm_system_needs_idmapped_vectors(void)
 
 void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu);
 
-static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 94d33e296e10..2ee729f54ce0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -63,11 +63,6 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
 }
 
-int kvm_arch_hardware_setup(void *opaque)
-{
-	return 0;
-}
-
 int kvm_arch_check_processor_compat(void *opaque)
 {
 	return 0;
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 5cedb28e8a40..28f0ba97db71 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -888,7 +888,6 @@ extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
 extern int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
 			     struct kvm_mips_interrupt *irq);
 
-static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 					 struct kvm_memory_slot *slot) {}
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a25e0b73ee70..af29490d9740 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -135,11 +135,6 @@ void kvm_arch_hardware_disable(void)
 	kvm_mips_callbacks->hardware_disable();
 }
 
-int kvm_arch_hardware_setup(void *opaque)
-{
-	return 0;
-}
-
 int kvm_arch_check_processor_compat(void *opaque)
 {
 	return 0;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index caea15dcb91d..5d2c3a487e73 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -877,7 +877,6 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_CREATE_DEVICE
 
 static inline void kvm_arch_hardware_disable(void) {}
-static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b850b0efa201..74ea5687ecbc 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -441,11 +441,6 @@ int kvm_arch_hardware_enable(void)
 	return 0;
 }
 
-int kvm_arch_hardware_setup(void *opaque)
-{
-	return 0;
-}
-
 int kvm_arch_check_processor_compat(void *opaque)
 {
 	return kvmppc_core_check_processor_compat();
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index dbbf43d52623..8c771fc4f5d2 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -229,7 +229,6 @@ struct kvm_vcpu_arch {
 	bool pause;
 };
 
-static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index df2d8716851f..a146fa0ce4d2 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -25,11 +25,6 @@ int kvm_arch_check_processor_compat(void *opaque)
 	return 0;
 }
 
-int kvm_arch_hardware_setup(void *opaque)
-{
-	return 0;
-}
-
 int kvm_arch_hardware_enable(void)
 {
 	unsigned long hideleg, hedeleg;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1aaee15211f2..7fcd2d3b3558 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -321,16 +321,6 @@ static struct notifier_block kvm_clock_notifier = {
 	.notifier_call = kvm_clock_sync,
 };
 
-int kvm_arch_hardware_setup(void *opaque)
-{
-	return 0;
-}
-
-void kvm_arch_hardware_unsetup(void)
-{
-
-}
-
 static void allow_cpu_feat(unsigned long nr)
 {
 	set_bit_inv(nr, kvm_s390_available_cpu_feat);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 80ee580a9cd4..40d4bfaa17a4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11985,16 +11985,6 @@ void kvm_arch_hardware_disable(void)
 	drop_user_return_notifiers();
 }
 
-int kvm_arch_hardware_setup(void *opaque)
-{
-	return 0;
-}
-
-void kvm_arch_hardware_unsetup(void)
-{
-
-}
-
 int kvm_arch_check_processor_compat(void *opaque)
 {
 	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 18592bdf4c1b..9b52bd40be56 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1447,8 +1447,6 @@ static inline void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu) {}
 
 int kvm_arch_hardware_enable(void);
 void kvm_arch_hardware_disable(void);
-int kvm_arch_hardware_setup(void *opaque);
-void kvm_arch_hardware_unsetup(void);
 int kvm_arch_check_processor_compat(void *opaque);
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f592dd4ce8f2..27ce263a80e4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5843,10 +5843,6 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 	if (r)
 		return r;
 
-	r = kvm_arch_hardware_setup(opaque);
-	if (r < 0)
-		goto err_hw_setup;
-
 	if (!zalloc_cpumask_var(&cpus_hardware_enabled, GFP_KERNEL)) {
 		r = -ENOMEM;
 		goto err_hw_enabled;
@@ -5939,8 +5935,6 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 out_free_2:
 	free_cpumask_var(cpus_hardware_enabled);
 err_hw_enabled:
-	kvm_arch_hardware_unsetup();
-err_hw_setup:
 	kvm_arch_exit();
 	return r;
 }
@@ -5969,7 +5963,6 @@ void kvm_exit(void)
 	on_each_cpu(hardware_disable_nolock, NULL, 1);
 	kvm_irqfd_exit();
 	free_cpumask_var(cpus_hardware_enabled);
-	kvm_arch_hardware_unsetup();
 	kvm_arch_exit();
 }
 EXPORT_SYMBOL_GPL(kvm_exit);
-- 
2.38.1.431.g37b22c650d-goog

