Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD1CC47088
	for <linux-s390@archiver.kernel.org>; Wed, 30 Nov 2022 23:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiK3XLE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiK3XKZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Nov 2022 18:10:25 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534ED9803C
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:09:55 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ep17-20020a17090ae65100b00219702c495cso179066pjb.2
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ+yfhkspt7ZNo22OgQpawec1Ei4RCTiEbe5vknIrT0=;
        b=B3425sD5ssEx57pTtG98b8HpTdxzwssCBDuFcB0njTKI/XsYVhIlUT7t8VxfTZyCaj
         rNNcjy7ZkLO7sRu1croI6V17oM3JUWZ66KJz3dPOFnS6ZNXt9vF/ufrGiEJRrVh1rawx
         jBIyIycJ1nYQ/Tln+uKRdhBxUMbn2zrY+g01yeSgTRVjheiz5bWBhhhmJyUaJsAkE6GE
         dL6EhA0QNU/VHGk45s0/jNhjn17XdiiiF1JWKkMNdSlcYBJTXiZUBYEqCsiTUua4xdbH
         Vsh2/Hg502nb0uGz/tvW1rhibXANnp+7b1r3Lx8wxi+xiH/bRTNX1OQgA8zn4Jd+xIMD
         ResQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJ+yfhkspt7ZNo22OgQpawec1Ei4RCTiEbe5vknIrT0=;
        b=t7e1nAGZ7JcNPug+JlTO67R67WVmJqy9ucB2vkU57HgytpZw4eNfxapZPrJ9OeHxEG
         /B6PF7X1R/mt8Y5On80+P/LGR6zjPZh3G5rjxaoWs9mJ6GZCGnoUlucFa9UaCW2SSzl2
         CcBU18xEELo9vvVTHXloj3kBPdJKRH99wnoJ3BB4t21Y1BbZ70nU/GwAp9cbU//XYeF1
         gelKk0FKU1zRr8BwQ3hy6ZwQTmTNDNQcekHWmCH1nNms9D5Wk1wS2kfFnDjpqBcVQK/J
         tAKJz83QsDp7ZJw0VCGX3k9xEmmOebhzJ4SvS7vDZvdA149J0UGxo4z/H77oMbgs6cna
         D8GA==
X-Gm-Message-State: ANoB5pnkVSRM0Tu6lhhcOQRfr1q0IUdpgSEgwRl4fynrDLcrEzS+RGUN
        QKLni+9nuZNBYcKdj1RgIaHPZiumDsU=
X-Google-Smtp-Source: AA0mqf7QiNOgWP00XAD7anVxRZ3dDrQeLQqiZYyRJhfOxzgfK7hENIJxdqXXKq1jBfur3SWcS0zGNy7/Bfo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:27ab:b0:56c:71a4:efe with SMTP id
 bd43-20020a056a0027ab00b0056c71a40efemr48704277pfb.84.1669849794774; Wed, 30
 Nov 2022 15:09:54 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:08:54 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-11-seanjc@google.com>
Subject: [PATCH v2 10/50] KVM: VMX: Reset eVMCS controls in VP assist page
 during hardware disabling
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

Reset the eVMCS controls in the per-CPU VP assist page during hardware
disabling instead of waiting until kvm-intel's module exit.  The controls
are activated if and only if KVM creates a VM, i.e. don't need to be
reset if hardware is never enabled.

Doing the reset during hardware disabling will naturally fix a potential
NULL pointer deref bug once KVM disables CPU hotplug while enabling and
disabling hardware (which is necessary to fix a variety of bugs).  If the
kernel is running as the root partition, the VP assist page is unmapped
during CPU hot unplug, and so KVM's clearing of the eVMCS controls needs
to occur with CPU hot(un)plug disabled, otherwise KVM could attempt to
write to a CPU's VP assist page after it's unmapped.

Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 50 +++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cea8c07f5229..d85d175dca70 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -551,6 +551,33 @@ static int hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static void hv_reset_evmcs(void)
+{
+	struct hv_vp_assist_page *vp_ap;
+
+	if (!static_branch_unlikely(&enable_evmcs))
+		return;
+
+	/*
+	 * KVM should enable eVMCS if and only if all CPUs have a VP assist
+	 * page, and should reject CPU onlining if eVMCS is enabled the CPU
+	 * doesn't have a VP assist page allocated.
+	 */
+	vp_ap = hv_get_vp_assist_page(smp_processor_id());
+	if (WARN_ON_ONCE(!vp_ap))
+		return;
+
+	/*
+	 * Reset everything to support using non-enlightened VMCS access later
+	 * (e.g. when we reload the module with enlightened_vmcs=0)
+	 */
+	vp_ap->nested_control.features.directhypercall = 0;
+	vp_ap->current_nested_vmcs = 0;
+	vp_ap->enlighten_vmentry = 0;
+}
+
+#else /* IS_ENABLED(CONFIG_HYPERV) */
+static void hv_reset_evmcs(void) {}
 #endif /* IS_ENABLED(CONFIG_HYPERV) */
 
 /*
@@ -2496,6 +2523,8 @@ static void vmx_hardware_disable(void)
 	if (cpu_vmxoff())
 		kvm_spurious_fault();
 
+	hv_reset_evmcs();
+
 	intel_pt_handle_vmx(0);
 }
 
@@ -8462,27 +8491,8 @@ static void vmx_exit(void)
 	kvm_exit();
 
 #if IS_ENABLED(CONFIG_HYPERV)
-	if (static_branch_unlikely(&enable_evmcs)) {
-		int cpu;
-		struct hv_vp_assist_page *vp_ap;
-		/*
-		 * Reset everything to support using non-enlightened VMCS
-		 * access later (e.g. when we reload the module with
-		 * enlightened_vmcs=0)
-		 */
-		for_each_online_cpu(cpu) {
-			vp_ap =	hv_get_vp_assist_page(cpu);
-
-			if (!vp_ap)
-				continue;
-
-			vp_ap->nested_control.features.directhypercall = 0;
-			vp_ap->current_nested_vmcs = 0;
-			vp_ap->enlighten_vmentry = 0;
-		}
-
+	if (static_branch_unlikely(&enable_evmcs))
 		static_branch_disable(&enable_evmcs);
-	}
 #endif
 	vmx_cleanup_l1d_flush();
 
-- 
2.38.1.584.g0f3c55d4c2-goog

