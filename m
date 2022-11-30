Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41515C4708D
	for <linux-s390@archiver.kernel.org>; Wed, 30 Nov 2022 23:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiK3XQQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiK3XPo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Nov 2022 18:15:44 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A10A1A3B
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:11:24 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i19-20020a63e913000000b004705d1506a6so77823pgh.13
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/jaxWTFPxmj21+X8Hbtmuwlu7GhNr4CXW1v8XgKCn2o=;
        b=jQgxp+u6SHc5NMy81OYePF88zDxKuqUxtOVxluvPTQI3MEuiQG2uqtD9RQG6VmOJ8F
         kk/Pbv5hy6CTAGXGAAE4oRsWW1h1FNSdzY+gt8AUeNr14OcCE+UIvjb6UQ7TpiTMFIF0
         izlNrD0kV5SMk0eBnY4nR4B5h0mn3eoylpGXZ25XCA4WeenN75ctGGp49AtZXHGvUS+T
         qZhLro5p9fp3cB2diacdo0hy8LHABjsSmVzRqwSHAFnoRTmJG580sa0oMGIlwLbpLirz
         qqtAn0DlcrzmZfTLixcwk1Q4OO5vUHO9P7L17dYxokTmYYn2YF9q+ofLTjNmrrQIy8bI
         XJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jaxWTFPxmj21+X8Hbtmuwlu7GhNr4CXW1v8XgKCn2o=;
        b=af7YRvkujcjZrN1ULmMUc9Kq5/7Tpq+K6ExuU/h8i9MO34GVviU5teddD031+gmCLT
         q05KAPHKV6fijsoMJg2zfFsZMEog5RXOhyk83X3maIGdGBkcrkRPj3ie8Ss0gurkpTtG
         GR0MCeKmhzSLfJBx6uZrglFPUkknhJHLVEGLP7eY7PxkxlciQwIfx94KOuBmfN2hLE/B
         kXA0WQ/gkAXlnrWbqKS4Ht9CMPSNUTWGESkV4afMBGBAvIrv+WUL6iKct8SWdVwQaqGF
         s8JvHonEjuDLVJdvn8uzmxoAceOC91vmXysbrEwbfxAAT5ZNIV/LU9Hf6REKh+IXauAD
         hdOQ==
X-Gm-Message-State: ANoB5pmc6gm1EnukM7FFWsqgmhdI5LvDdKkDaoC7iyLUur08j+3mMwdQ
        JcPe4Mfwo120FwRDvVbebd4qamOzsZE=
X-Google-Smtp-Source: AA0mqf6+Bap4v8ExdEec6znsKgSVG1g77x3d69DLe55WoTiV/xIM01OoU5c9uuVoqdfTkLa+0jZkKz1t3dk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:6904:b0:185:3f7a:50cc with SMTP id
 j4-20020a170902690400b001853f7a50ccmr43659852plk.99.1669849850498; Wed, 30
 Nov 2022 15:10:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:09:26 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-43-seanjc@google.com>
Subject: [PATCH v2 42/50] KVM: Disable CPU hotplug during hardware enabling/disabling
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

From: Chao Gao <chao.gao@intel.com>

Disable CPU hotplug when enabling/disabling hardware to prevent the
corner case where if the following sequence occurs:

  1. A hotplugged CPU marks itself online in cpu_online_mask
  2. The hotplugged CPU enables interrupt before invoking KVM's ONLINE
     callback
  3  hardware_{en,dis}able_all() is invoked on another CPU

the hotplugged CPU will be included in on_each_cpu() and thus get sent
through hardware_{en,dis}able_nolock() before kvm_online_cpu() is called.

        start_secondary { ...
                set_cpu_online(smp_processor_id(), true); <- 1
                ...
                local_irq_enable();  <- 2
                ...
                cpu_startup_entry(CPUHP_AP_ONLINE_IDLE); <- 3
        }

KVM currently fudges around this race by keeping track of which CPUs have
done hardware enabling (see commit 1b6c016818a5 "KVM: Keep track of which
cpus have virtualization enabled"), but that's an inefficient, convoluted,
and hacky solution.

Signed-off-by: Chao Gao <chao.gao@intel.com>
[sean: split to separate patch, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c  | 11 ++++++++++-
 virt/kvm/kvm_main.c | 12 ++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dad30097f0c3..d2ad383da998 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9281,7 +9281,16 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 
 static int kvm_x86_check_processor_compatibility(void)
 {
-	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+	int cpu = smp_processor_id();
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+	/*
+	 * Compatibility checks are done when loading KVM and when enabling
+	 * hardware, e.g. during CPU hotplug, to ensure all online CPUs are
+	 * compatible, i.e. KVM should never perform a compatibility check on
+	 * an offline CPU.
+	 */
+	WARN_ON(!cpu_online(cpu));
 
 	if (__cr4_reserved_bits(cpu_has, c) !=
 	    __cr4_reserved_bits(cpu_has, &boot_cpu_data))
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f26ea779710a..d985b24c423b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5098,15 +5098,26 @@ static void hardware_disable_all_nolock(void)
 
 static void hardware_disable_all(void)
 {
+	cpus_read_lock();
 	raw_spin_lock(&kvm_count_lock);
 	hardware_disable_all_nolock();
 	raw_spin_unlock(&kvm_count_lock);
+	cpus_read_unlock();
 }
 
 static int hardware_enable_all(void)
 {
 	int r = 0;
 
+	/*
+	 * When onlining a CPU, cpu_online_mask is set before kvm_online_cpu()
+	 * is called, and so on_each_cpu() between them includes the CPU that
+	 * is being onlined.  As a result, hardware_enable_nolock() may get
+	 * invoked before kvm_online_cpu(), which also enables hardware if the
+	 * usage count is non-zero.  Disable CPU hotplug to avoid attempting to
+	 * enable hardware multiple times.
+	 */
+	cpus_read_lock();
 	raw_spin_lock(&kvm_count_lock);
 
 	kvm_usage_count++;
@@ -5121,6 +5132,7 @@ static int hardware_enable_all(void)
 	}
 
 	raw_spin_unlock(&kvm_count_lock);
+	cpus_read_unlock();
 
 	return r;
 }
-- 
2.38.1.584.g0f3c55d4c2-goog

