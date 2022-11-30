Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17432C4321E
	for <linux-s390@archiver.kernel.org>; Wed, 30 Nov 2022 23:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiK3XKF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiK3XKA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Nov 2022 18:10:00 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D397031
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:09:46 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y23-20020aa78057000000b00574277cb386so163049pfm.16
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4d3Yt8bltpBTGQfRvysGuV0Qwes6q1E1oAAkIYt6v1U=;
        b=R2EUvQh/d5tOiXan3raQzQlRv7gR1ONI/pTsvNFLPNlIvb1HQkPh0aZeDhUMSwPjU6
         WmKXxIVdA8mWbdpdJ9mQWSFS0GaxhUMED8VA7z9aivgbFGgRyi5KO45SYxDJSk//Lrmi
         TvHQq/KXHoU6IG02YXxnz+VoMPrjzvItFwl89sStfSe8vLDomvkTbOfZZylixHCAfv3w
         Jgwxv2s/jYVL/cbZz1XyHU/++UQYcJaWUXGIWbWEnIOtbM+sQTznmLBg+6U7bpNOdsk9
         JFaEVxGzY3mhCDrcWoTbsIO4wRxo80HsCG5wPORw/u3RxuNka0IHsD1GSswNFX6QovYX
         0b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4d3Yt8bltpBTGQfRvysGuV0Qwes6q1E1oAAkIYt6v1U=;
        b=pUb6dUxNK2M+OFLgZue1ZPgdEzGE502ILTJPDWH90TjwxpaezAWdVX3CemF/UEHLQc
         sWqsElJ6UPR0VCm8Q+SE6d2Xe254ZUB5/Hr9EUUtdXOpeDz3ichPmKF5F6svDZ0eO9wx
         P5/creZfzipgfgNSKHIF10aNAPQFB34P7in1oQ78MYF4Ffb6j5bsrXJNiO9d2rNJek3/
         1lJVk3Q55A8R7TwUqhkIW0GZ7lARGDGYeBEA98pGBpBeCBCpq9kHAwEunAsw1d6BRJvP
         96FnQMrfjq1ooL9ngz5/RW3PYD17banxhnOyjm/HhYwCZcfJeEqAXQsxvsyBc3NRA+M+
         7BAQ==
X-Gm-Message-State: ANoB5pkZDT3vN/KVMXy21CTMJQaWFHz0S/Nk0VT50Ms2MI1E9fO5LggW
        CG3p8fw7ndbC6l6C7RKzH945Zkr/pDQ=
X-Google-Smtp-Source: AA0mqf6cW2WJ5WC9E3zUsYjnyVQVpmP5HVamx7IIHapO1XeJ3XE2sYBO0ex7mjdiJNAJDhKt2nf1vvfpKec=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d58d:b0:188:ff21:e76b with SMTP id
 k13-20020a170902d58d00b00188ff21e76bmr9022156plh.60.1669849786225; Wed, 30
 Nov 2022 15:09:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:08:49 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-6-seanjc@google.com>
Subject: [PATCH v2 05/50] KVM: s390: Unwind kvm_arch_init() piece-by-piece()
 if a step fails
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

In preparation for folding kvm_arch_hardware_setup() into kvm_arch_init(),
unwind initialization one step at a time instead of simply calling
kvm_arch_exit().  Using kvm_arch_exit() regardless of which initialization
step failed relies on all affected state playing nice with being undone
even if said state wasn't first setup.  That holds true for state that is
currently configured by kvm_arch_init(), but not for state that's handled
by kvm_arch_hardware_setup(), e.g. calling gmap_unregister_pte_notifier()
without first registering a notifier would result in list corruption due
to attempting to delete an entry that was never added to the list.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e4890e04b210..221481a09742 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -498,11 +498,11 @@ int kvm_arch_init(void *opaque)
 
 	kvm_s390_dbf_uv = debug_register("kvm-uv", 32, 1, 7 * sizeof(long));
 	if (!kvm_s390_dbf_uv)
-		goto out;
+		goto err_kvm_uv;
 
 	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view) ||
 	    debug_register_view(kvm_s390_dbf_uv, &debug_sprintf_view))
-		goto out;
+		goto err_debug_view;
 
 	kvm_s390_cpu_feat_init();
 
@@ -510,25 +510,32 @@ int kvm_arch_init(void *opaque)
 	rc = kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
 	if (rc) {
 		pr_err("A FLIC registration call failed with rc=%d\n", rc);
-		goto out;
+		goto err_flic;
 	}
 
 	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM)) {
 		rc = kvm_s390_pci_init();
 		if (rc) {
 			pr_err("Unable to allocate AIFT for PCI\n");
-			goto out;
+			goto err_pci;
 		}
 	}
 
 	rc = kvm_s390_gib_init(GAL_ISC);
 	if (rc)
-		goto out;
+		goto err_gib;
 
 	return 0;
 
-out:
-	kvm_arch_exit();
+err_gib:
+	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM))
+		kvm_s390_pci_exit();
+err_pci:
+err_flic:
+err_debug_view:
+	debug_unregister(kvm_s390_dbf_uv);
+err_kvm_uv:
+	debug_unregister(kvm_s390_dbf);
 	return rc;
 }
 
-- 
2.38.1.584.g0f3c55d4c2-goog

