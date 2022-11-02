Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6763C433FE
	for <linux-s390@archiver.kernel.org>; Wed,  2 Nov 2022 23:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiKBXWT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiKBXUl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Nov 2022 19:20:41 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E6D65D1
        for <linux-s390@vger.kernel.org>; Wed,  2 Nov 2022 16:19:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o2-20020a170903210200b001872421f5b9so225674ple.11
        for <linux-s390@vger.kernel.org>; Wed, 02 Nov 2022 16:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KSp9zIzHXrxcJceHX59wYlpimn2+3DBl6/EkdM22YDo=;
        b=GazJIJPM/pHmiFZ05wEIEUmIWAlYuh2ZlyTopcNekluhV4UHGi1yTDkMNANFS1jscV
         sHaoW06GH/7QoV/u1MZ9MSnC1FGAiLQO/y23W8/5eah4jm88WvvNxPaF2O5WlqNX6AA2
         8Gs4UT7UUi7/ZwHf5DCZWbM2vulQhHbwn2WtGD6rJzl/FOBfxZ8G3NM+geD74+eDAUum
         o1o3demNZa7SFz5SsAwJ7XKog0NdlraaEfYhRzZpffEE3gOpiTfLkShIIvuV3L13yEjN
         xam914sm21iReYi10+r23ej5bJnTbIKx2d2irwZwjp5ibbzs0gCmvLJoawOipg8dYos5
         2Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSp9zIzHXrxcJceHX59wYlpimn2+3DBl6/EkdM22YDo=;
        b=XcPhU1+9az0vpBM46iKhsGm1zFTBRRSu6q18XyZIDaPdLhOu76BrEmB/DLHrR4h01i
         dYnLfG1jQ0oWnkcI0ncYxJSnayifXfWCD/HFpDAmw7NMNEfQETJ6Nlc+YzVDEI37Jy8j
         0UPmp8rgGPQA7Pd3wvAOCRpmoEf1PDFYpQ1PCXuWa8+UIS+NUA+A3YzAw96UrqBaPVVU
         KKTWf8+gB3Jm16aHukJ1rWWicp1Zsi6DBU2bxLROl5b3DRrSQaeN55TSn5zLhNEdo4+Y
         WMpRqnKXgH0t6T/euja7anNNMVmVs0afUM9KiJ6Fa42Ewl8hVX2qFWrrpjwxE43+Yfqz
         Qhxg==
X-Gm-Message-State: ACrzQf1qaiOfwPuD2t4akPxvR94lUqtspo2BqT2gTAUEGIfYzWHtJE55
        3BArJFiHfrKPqwYUzCwFM0j9aWm0Zlw=
X-Google-Smtp-Source: AMsMyM5Lv2JMFeAlRDTbvWUtcHml4s/PYrbj2uJcHSHWkZsi31gUm2Ed915QDdWGieIzAX5rFOQTrQSszmI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:e0b:b0:56c:8c13:2a54 with SMTP id
 bq11-20020a056a000e0b00b0056c8c132a54mr27442020pfb.17.1667431182821; Wed, 02
 Nov 2022 16:19:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:18:44 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-18-seanjc@google.com>
Subject: [PATCH 17/44] KVM: arm64: Do arm/arch initialiation without bouncing
 through kvm_init()
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

Move arm/arch specific initialization directly in arm's module_init(),
now called kvm_arm_init(), instead of bouncing through kvm_init() to
reach kvm_arch_init().  Invoking kvm_arch_init() is the very first action
performed by kvm_init(), i.e. this is a glorified nop.

Making kvm_arch_init() a nop will allow dropping it entirely once all
other architectures follow suit.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index f400a8c029dd..bfa2dcd3db11 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2190,7 +2190,7 @@ void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *cons)
 /**
  * Initialize Hyp-mode and memory mappings on all CPUs.
  */
-int kvm_arch_init(void *opaque)
+int kvm_arm_init(void)
 {
 	int err;
 	bool in_hyp_mode;
@@ -2264,6 +2264,14 @@ int kvm_arch_init(void *opaque)
 		kvm_info("Hyp mode initialized successfully\n");
 	}
 
+	/*
+	 * FIXME: Do something reasonable if kvm_init() fails after pKVM
+	 * hypervisor protection is finalized.
+	 */
+	err = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	if (err)
+		goto out_subs;
+
 	return 0;
 
 out_subs:
@@ -2276,10 +2284,15 @@ int kvm_arch_init(void *opaque)
 	return err;
 }
 
+int kvm_arch_init(void *opaque)
+{
+	return 0;
+}
+
 /* NOP: Compiling as a module not supported */
 void kvm_arch_exit(void)
 {
-	kvm_unregister_perf_callbacks();
+
 }
 
 static int __init early_kvm_mode_cfg(char *arg)
@@ -2320,10 +2333,4 @@ enum kvm_mode kvm_get_mode(void)
 	return kvm_mode;
 }
 
-static int arm_init(void)
-{
-	int rc = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-	return rc;
-}
-
-module_init(arm_init);
+module_init(kvm_arm_init);
-- 
2.38.1.431.g37b22c650d-goog

