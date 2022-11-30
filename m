Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED9CC4321E
	for <linux-s390@archiver.kernel.org>; Wed, 30 Nov 2022 23:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiK3XN1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiK3XMm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Nov 2022 18:12:42 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFFE9C606
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:10:35 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u15-20020a170902e5cf00b001899d29276eso7519192plf.10
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo4Z77dzNvKrehTzYt4K2iI8Cmx6h54XHztU8GehcL8=;
        b=hivL5TC6LdtOW2OmuNQou4Gy4U4tXiu2+6M2wfmsMZujN2ItoQgS8dZtbchvpp7Sy7
         gQP8KJQ85CZqnMEDc6KXPFPpNulQ0aQGew3NpHF0ryb6ACX+mCcZQj6XUPxiNhI1xHp0
         rD08FH6W6Tc9mMBWGEmLcFaU5I8qQn9La/dT9kb2EVRIeOnNi6kCex/5Q2SGr2bRQoGy
         G1EteOn3rd3vULZF1PgE4auaSNRlpUDh4ixH2iWSNr973dhsYVWWF6gRbX3Yo5SuVqh0
         qNdORoE9jtDj45oUX7KBmjx++vi1W+JogYW4rHwuh1tKXtb0Sz6z/D5a80vr3bmmUG42
         8e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vo4Z77dzNvKrehTzYt4K2iI8Cmx6h54XHztU8GehcL8=;
        b=GCObWqPfk0TBsiT0x8flU0KRMdNOkclMap2M/pDt8ztryVsxVsYeNx4ZzodAVBBuon
         nW+vfaAqZVogA7Vbkh7XEywMj5pCLmPbvt7g59nTH8kBU1vT70TmhRTOVDep40yf8F2u
         FFtd21BqfeEUnlP0F5VnHYfhvvZKy8a9iK7toC2WTjQwIsBcX8vltdh+Syv7XgHulk05
         tI/B0g+pKzoCnQl24ba8Xf0m0HtFlg2khSPVZFmTjLaH95lCvQkGn/D9XGY8P3D/VNqx
         7cr5jWJYOMxdlWXE0Gauxsnz5Lhfx0X42x0xYM/dAGmkECgl4T4u9P2toMgR+UYm3afJ
         hL2Q==
X-Gm-Message-State: ANoB5pneNaTKdT5OR2ZqcDEQa4eWw8pIML/QQEGQ+1/7oRzwWn7wprKw
        rhGQasjItsadQ1AlOS6dCi2DKEMSSiY=
X-Google-Smtp-Source: AA0mqf57HeX+xXTuMleSA1eLy2x+uTa7n6xyJaGs3rJOB3hWgy2t3owM2xuaTXoQ+YAD0k4pCSHrJ5hlSv0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:f89:b0:219:5b3b:2b9f with SMTP id
 ft9-20020a17090b0f8900b002195b3b2b9fmr848562pjb.2.1669849834864; Wed, 30 Nov
 2022 15:10:34 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:09:17 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-34-seanjc@google.com>
Subject: [PATCH v2 33/50] KVM: x86: Use KBUILD_MODNAME to specify vendor
 module name
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

Use KBUILD_MODNAME to specify the vendor module name instead of manually
writing out the name to make it a bit more obvious that the name isn't
completely arbitrary.  A future patch will also use KBUILD_MODNAME to
define pr_fmt, at which point using KBUILD_MODNAME for kvm_x86_ops.name
further reinforces the intended usage of kvm_x86_ops.name.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 arch/x86/kvm/vmx/vmx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d9a54590591d..a875cf7b2942 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4695,7 +4695,7 @@ static int svm_vm_init(struct kvm *kvm)
 }
 
 static struct kvm_x86_ops svm_x86_ops __initdata = {
-	.name = "kvm_amd",
+	.name = KBUILD_MODNAME,
 
 	.hardware_unsetup = svm_hardware_unsetup,
 	.hardware_enable = svm_hardware_enable,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b6f08a0a1435..229a9cf485f0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8102,7 +8102,7 @@ static void vmx_vm_destroy(struct kvm *kvm)
 }
 
 static struct kvm_x86_ops vmx_x86_ops __initdata = {
-	.name = "kvm_intel",
+	.name = KBUILD_MODNAME,
 
 	.hardware_unsetup = vmx_hardware_unsetup,
 
-- 
2.38.1.584.g0f3c55d4c2-goog

