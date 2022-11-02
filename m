Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E532EC4167D
	for <linux-s390@archiver.kernel.org>; Wed,  2 Nov 2022 23:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKBXWA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiKBXUe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Nov 2022 19:20:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0AD646C
        for <linux-s390@vger.kernel.org>; Wed,  2 Nov 2022 16:19:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l188-20020a2525c5000000b006cbcff0ab41so394731ybl.4
        for <linux-s390@vger.kernel.org>; Wed, 02 Nov 2022 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jjwuYM33wa0dwVWFlLHKwYhVaHzm2FgiCKOfn+QDNQ4=;
        b=Fhq9PEIX8LJQUbJ64jTN1JvSF4aDYgMhxvOWYGX1iAWoV/lvAdG5LOXuNivkfQWmaN
         XoYRELj0iLXTcGUgDHg9R/bhGsJRvY0Qx7IEF0y4w7dFOPQtmSUB+O6PUVY8/MhozQfF
         AX6SYnVZgv9nJGu4JJBc65UftCLAjC1MJHk1aUCf2yILUXt8A+rMwOgyzW8jvMWXgkl0
         LgkleUhB3pCNMAS+BVFzOjuYh6vlw9PADZ2etUZ8fiuYZCiK9hkRPf6dczcVLTjo6nqb
         SNGwaGeIsaxofOZxTFjiZYanOv3dUMmT9VRhi3xCUQ51Z2IYrlwrIcc2Hbem0XHCdIi2
         UM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjwuYM33wa0dwVWFlLHKwYhVaHzm2FgiCKOfn+QDNQ4=;
        b=0lbSPaQAKypdz+j9me1pqEHXv0RLb14McaIsOhFGso3GI7Rwwlx13c4Tw/ddI/lvd1
         5r3IT5PO4sbgmn3IllzHlQ9ErWcKZdDxmlR45CDNPEt3OG1x3cooSz3rki0Do9iG+ztM
         sJ2t09Fg2rAs46iZ9rLORh+ZOiAdhoT5f0ms9PVzWYfr3DPWMTtUnaEwEt98gQLDF9mg
         j9IHsRgNH2MLlMh+vvan53Rc0llIE4vjCK2sYuT8+zn3MPWOZ3lJX1811riuDxOEahkx
         mDQaKwO+X1Samyv3FNNTDXTuCpYoeqZg1Woz7YKu+cak8wHLUODpoOoMHM4FR7ZXwV/R
         xzMw==
X-Gm-Message-State: ACrzQf2UOpuWvSldQQuRpZHrkgELFzZR/yx3OtRI0OPT69w72vuUK3BJ
        gvT3+bLmgEMrqDO80A2gS1kUKhg+ox4=
X-Google-Smtp-Source: AMsMyM6G8+cpsdlQ24WmBjSm0uN0SQ0FUjj6LFQ9PdnISN+9XlJSF9tKC3IM7fcpwDmLrOspg5L0a2rB188=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:e695:0:b0:6cb:895b:5a35 with SMTP id
 d143-20020a25e695000000b006cb895b5a35mr25441755ybh.573.1667431179587; Wed, 02
 Nov 2022 16:19:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:18:42 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-16-seanjc@google.com>
Subject: [PATCH 15/44] KVM: arm64: Free hypervisor allocations if vector slot
 init fails
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

Teardown hypervisor mode if vector slot setup fails in order to avoid
leaking any allocations done by init_hyp_mode().

Fixes: b881cdce77b4 ("KVM: arm64: Allocate hyp vectors statically")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 0c328af064dd..73644def7780 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2232,18 +2232,18 @@ int kvm_arch_init(void *opaque)
 	err = kvm_init_vector_slots();
 	if (err) {
 		kvm_err("Cannot initialise vector slots\n");
-		goto out_err;
-	}
-
-	err = init_subsystems();
-	if (err)
 		goto out_hyp;
+	}
+
+	err = init_subsystems();
+	if (err)
+		goto out_subs;
 
 	if (!in_hyp_mode) {
 		err = finalize_hyp_mode();
 		if (err) {
 			kvm_err("Failed to finalize Hyp protection\n");
-			goto out_hyp;
+			goto out_subs;
 		}
 	}
 
@@ -2257,8 +2257,9 @@ int kvm_arch_init(void *opaque)
 
 	return 0;
 
-out_hyp:
+out_subs:
 	hyp_cpu_pm_exit();
+out_hyp:
 	if (!in_hyp_mode)
 		teardown_hyp_mode();
 out_err:
-- 
2.38.1.431.g37b22c650d-goog

