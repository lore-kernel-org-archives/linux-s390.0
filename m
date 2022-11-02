Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DE3C433FE
	for <linux-s390@archiver.kernel.org>; Wed,  2 Nov 2022 23:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKBXWk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKBXUq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Nov 2022 19:20:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67370AE58
        for <linux-s390@vger.kernel.org>; Wed,  2 Nov 2022 16:19:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 69-20020a250548000000b006cc9d755afaso343987ybf.16
        for <linux-s390@vger.kernel.org>; Wed, 02 Nov 2022 16:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CzSf5zn0WCjHNHnOQoVFnBDZCb0UJEWJAWP5e8x7mpU=;
        b=qayOPbuABiIuhyUyS81pM4aIXP0zbbDCyOAoStlcDM54io6H46scG/b+AOJZ083vkp
         7VUQSDA3F1PV+eczWk9jhX07na0Ee5Y/y96fcuWnjX0SDylBmMM507BoItRwczIvX47w
         quWZbFbuSFsnuRxvRxHTWN2VK6E9IoRaN3Rn0730zHfCEZF81HBccJpL9kyZIy1KxZA/
         662DkzEQNlhCKGQQORLsI62wqsjL9SN7t5eET3UjVYfrxzuz8jEkm9iuoDgYatGUaOSX
         hwFfEfHx7Y5bc5lWLW7ELIceyIhTn7UMBpI42o+ooA3Zs7kMfZ0227v/cGHQHHsdYmrl
         HIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzSf5zn0WCjHNHnOQoVFnBDZCb0UJEWJAWP5e8x7mpU=;
        b=D5TbFmCp/NZHu554HCHIaqGAOkDnsxO1thLHmhgnUrmvJb/fZoGbxB1FBklbYVeLjO
         b0zpDpGaYtbP9lPOKfHYA5DRo7eIpuVBaaDwaD5MZi59UbK+M25bkkd7MYrsWJfsvPU/
         ogX+6Vqeq9Zhqr+6cz4yU8rbuBTPrCcqdPjDe/gzn2M7/JwNbveKaD8H8XITTPViyeEO
         cCYapJdjjLujzwbNcPbMxPH3dNzwJThrpN/ID8Go27ryBGEeg5J5R9XF9NyOZRYRcNJN
         cZri08HPMzaIKDVBRh7a6xRS9o5UzEfOvI7H2WDqVRkxWhEiHtGfj8gC0nLKk8c6fb1f
         I3MQ==
X-Gm-Message-State: ACrzQf2L2JV45NGIbdCl95E9KeGM9AxKchhJonyC2RP9cgakOm9funIF
        m1oJFkruGzYUp+1Rn0cLL9P+opll/so=
X-Google-Smtp-Source: AMsMyM5QAC+6uL9KNRnm9M5TXJQCSY2aBJVNt4dTDVzjRpTyYTEDmCTYsEFvvoqsJQdz2eHBvIeRC0Fos4c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:2544:0:b0:360:c270:15a1 with SMTP id
 l65-20020a812544000000b00360c27015a1mr24717446ywl.67.1667431196650; Wed, 02
 Nov 2022 16:19:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:18:52 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-26-seanjc@google.com>
Subject: [PATCH 25/44] KVM: s390: Do s390 specific init without bouncing
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

Move the guts of kvm_arch_init() into a new helper, __kvm_s390_init(),
and invoke the new helper directly from kvm_s390_init() instead of
bouncing through kvm_init().  Invoking kvm_arch_init() is the very
first action performed by kvm_init(), i.e. this is a glorified nop.

Moving setup to __kvm_s390_init() will allow tagging more functions as
__init, and emptying kvm_arch_init() will allow dropping the hook
entirely once all architecture implementations are nops.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/kvm/kvm-s390.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7fcd2d3b3558..e1c9980aae78 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -461,7 +461,7 @@ static void kvm_s390_cpu_feat_init(void)
 	 */
 }
 
-int kvm_arch_init(void *opaque)
+static int __kvm_s390_init(void)
 {
 	int rc = -ENOMEM;
 
@@ -519,7 +519,7 @@ int kvm_arch_init(void *opaque)
 	return rc;
 }
 
-void kvm_arch_exit(void)
+static void __kvm_s390_exit(void)
 {
 	gmap_unregister_pte_notifier(&gmap_notifier);
 	gmap_unregister_pte_notifier(&vsie_gmap_notifier);
@@ -533,6 +533,16 @@ void kvm_arch_exit(void)
 	debug_unregister(kvm_s390_dbf_uv);
 }
 
+int kvm_arch_init(void *opaque)
+{
+	return 0;
+}
+
+void kvm_arch_exit(void)
+{
+
+}
+
 /* Section: device related */
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg)
@@ -5634,7 +5644,7 @@ static inline unsigned long nonhyp_mask(int i)
 
 static int __init kvm_s390_init(void)
 {
-	int i;
+	int i, r;
 
 	if (!sclp.has_sief2) {
 		pr_info("SIE is not available\n");
@@ -5650,12 +5660,23 @@ static int __init kvm_s390_init(void)
 		kvm_s390_fac_base[i] |=
 			stfle_fac_list[i] & nonhyp_mask(i);
 
-	return kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	r = __kvm_s390_init();
+	if (r)
+		return r;
+
+	r = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	if (r) {
+		__kvm_s390_exit();
+		return r;
+	}
+	return 0;
 }
 
 static void __exit kvm_s390_exit(void)
 {
 	kvm_exit();
+
+	__kvm_s390_exit();
 }
 
 module_init(kvm_s390_init);
-- 
2.38.1.431.g37b22c650d-goog

