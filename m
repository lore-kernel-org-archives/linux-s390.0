Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97897C47088
	for <linux-s390@archiver.kernel.org>; Wed, 30 Nov 2022 23:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiK3XJn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiK3XJm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Nov 2022 18:09:42 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F79D5AE1E
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:09:41 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x6-20020a17090a46c600b002190cdd7bcdso184932pjg.6
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lSEuQC4fsPjkdtnYDeQfd/vZVTy0qc8mLVWrI2CwrIE=;
        b=LMXa1KavlLIPKm1O338OzmSfdiHcECfTdj20rMtDEH+lfDJSFJhQMyyiEeUk04KyjS
         THAs8aeulvKYPo7lA32gfVqJl/QX3PY7ib8sgaj4Pvo4cfNxQJm28NxV50VxtM37FuZv
         u7SNAeiI+m8cgjrUiBg7wJxoPwHMZLyx4z5zzJVAdYB5b5TVKiOE8DQmTOE93UnjR0x6
         v7KwZrdqHiBTUALLLRFcXHQn6LhnWmgLoZpbAdwuKZKQCHk46qBwUS9Afdts0dNnMgCD
         yr/YhWMvzdjaadccrilOoEPdqxhs6lMrLM/VgTXUhLW1qaCXkx2eJvsLyG4zepJOJSSK
         eycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSEuQC4fsPjkdtnYDeQfd/vZVTy0qc8mLVWrI2CwrIE=;
        b=NkajbD5Scq7PzsbmLn48ADWQdw4mFbp2pw9oORyRSJGwxdznMc87G3ahnRUzOzv7yL
         BrKEtNsW1W1C6k2QF7pU1qkp/ndb5kB2S3VER9VRea/y/jufy0x7Uj0FlhL5uYOp9Ka4
         mMm47HVARJm9Rwi3jMxPodPhYXJWl3/pA5Oo+vxyLjivoxLYJXcrXaO4B+VPef7Z89aK
         O66KZEIObRFOWvq3BEyJiC/R1ORehDUkeKEzMOwdSBE8GvbE3Mkd9XEqfwpfUofW2qOX
         CPwo7/eoFJIhFxncrlHX53/Qi9HCBp6taXL3tncDlhisMbucr6HqzTyq4dP2AdNKykPb
         nXrg==
X-Gm-Message-State: ANoB5pn4sz0rushiN5tSYr5bZ2dQn+g/wskH8ssiMm3XHFQFRQN/DLc5
        uNdur7e/VOY6zX1Z8ELv+H8OkhIGtVI=
X-Google-Smtp-Source: AA0mqf5/wgDP/8zZO17OyVNcvbHpUQjMB4GbOO0uy/0pkoSTXNKOuo3YYJAOzIWIiFtrZoAfFu+zlI3eWn8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1586:0:b0:575:f08b:7a9f with SMTP id
 128-20020a621586000000b00575f08b7a9fmr3765310pfv.60.1669849780652; Wed, 30
 Nov 2022 15:09:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:08:46 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-3-seanjc@google.com>
Subject: [PATCH v2 02/50] KVM: Initialize IRQ FD after arch hardware setup
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
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>
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
        linux-kernel@vger.kernel.org, Yuan Yao <yuan.yao@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Move initialization of KVM's IRQ FD workqueue below arch hardware setup
as a step towards consolidating arch "init" and "hardware setup", and
eventually towards dropping the hooks entirely.  There is no dependency
on the workqueue being created before hardware setup, the workqueue is
used only when destroying VMs, i.e. only needs to be created before
/dev/kvm is exposed to userspace.

Move the destruction of the workqueue before the arch hooks to maintain
symmetry, and so that arch code can move away from the hooks without
having to worry about ordering changes.

Reword the comment about kvm_irqfd_init() needing to come after
kvm_arch_init() to call out that kvm_arch_init() must come before common
KVM does _anything_, as x86 very subtly relies on that behavior to deal
with multiple calls to kvm_init(), e.g. if userspace attempts to load
kvm_amd.ko and kvm_intel.ko.  Tag the code with a FIXME, as x86's subtle
requirement is gross, and invoking an arch callback as the very first
action in a helper that is called only from arch code is silly.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b60abb03606b..43e2e4f38151 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5852,24 +5852,19 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 	int r;
 	int cpu;
 
+	/*
+	 * FIXME: Get rid of kvm_arch_init(), vendor code should call arch code
+	 * directly.  Note, kvm_arch_init() _must_ be called before anything
+	 * else as x86 relies on checks buried in kvm_arch_init() to guard
+	 * against multiple calls to kvm_init().
+	 */
 	r = kvm_arch_init(opaque);
 	if (r)
-		goto out_fail;
-
-	/*
-	 * kvm_arch_init makes sure there's at most one caller
-	 * for architectures that support multiple implementations,
-	 * like intel and amd on x86.
-	 * kvm_arch_init must be called before kvm_irqfd_init to avoid creating
-	 * conflicts in case kvm is already setup for another implementation.
-	 */
-	r = kvm_irqfd_init();
-	if (r)
-		goto out_irqfd;
+		return r;
 
 	if (!zalloc_cpumask_var(&cpus_hardware_enabled, GFP_KERNEL)) {
 		r = -ENOMEM;
-		goto out_free_0;
+		goto err_hw_enabled;
 	}
 
 	r = kvm_arch_hardware_setup(opaque);
@@ -5913,9 +5908,13 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 		}
 	}
 
+	r = kvm_irqfd_init();
+	if (r)
+		goto err_irqfd;
+
 	r = kvm_async_pf_init();
 	if (r)
-		goto out_free_4;
+		goto err_async_pf;
 
 	kvm_chardev_ops.owner = module;
 
@@ -5946,6 +5945,9 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 	kvm_vfio_ops_exit();
 err_vfio:
 	kvm_async_pf_deinit();
+err_async_pf:
+	kvm_irqfd_exit();
+err_irqfd:
 out_free_4:
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
@@ -5957,11 +5959,8 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 	kvm_arch_hardware_unsetup();
 out_free_1:
 	free_cpumask_var(cpus_hardware_enabled);
-out_free_0:
-	kvm_irqfd_exit();
-out_irqfd:
+err_hw_enabled:
 	kvm_arch_exit();
-out_fail:
 	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_init);
@@ -5986,9 +5985,9 @@ void kvm_exit(void)
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_STARTING);
 	on_each_cpu(hardware_disable_nolock, NULL, 1);
+	kvm_irqfd_exit();
 	kvm_arch_hardware_unsetup();
 	kvm_arch_exit();
-	kvm_irqfd_exit();
 	free_cpumask_var(cpus_hardware_enabled);
 	kvm_vfio_ops_exit();
 }
-- 
2.38.1.584.g0f3c55d4c2-goog

