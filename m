Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6461C433FE
	for <linux-s390@archiver.kernel.org>; Wed,  2 Nov 2022 23:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiKBXV5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiKBXUb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Nov 2022 19:20:31 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D76958D
        for <linux-s390@vger.kernel.org>; Wed,  2 Nov 2022 16:19:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q1-20020a17090aa00100b002139a592adbso2499584pjp.1
        for <linux-s390@vger.kernel.org>; Wed, 02 Nov 2022 16:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yE/4Y9j/oYhrNnppN3pBbrFR3yZQeQID1rXlzF1UIrs=;
        b=ay8cPyDCIqaMfo0DK1yGgX9Wb9Bl9/1fVHbdhv2aAy1cj0+xuZ97OrHcZUeV1cFb37
         6xEzJJ8+vktqwJnTtuH1USFvq8dlhSmN+zODY90fpIycgDYl660YnoWyBjRJ4shxmyzm
         eiIMz6ZQ5l1bjRGivO4fA9kceUx/9ETkzTfr9tWJ9HyO6sppdHxDi6fl6UdHy8ptqT6P
         DK4l+CKIMpqMLCpZJAWwhuO/obSacLjdsxWR0MNI7G5lNuNRlHspSUm1vSdSmF25/DFv
         q5eNxeOVs/atfRGxPMYHZj9KnffzNZveBs/Mh+BUBe8auRPPWp99Q7jjD7exn9MfTR0m
         9eDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yE/4Y9j/oYhrNnppN3pBbrFR3yZQeQID1rXlzF1UIrs=;
        b=OTfwPDZDecbqCcMq1IZnH1k/JpXSoW2q7MmPkzMPtDDygEMBuMm+x0b5WzIpyreIGP
         c1vByioquQWpsyGXWoMAbc3kR4VcJXlPoLeQi0H0FzpliOW1QYXNydXaFWW2GvJ6QIZl
         DQLAObUYSWal+Gzf61V456k7gPRoyvkJN1BBUe5ay9TuiwTgMJGUznLJHMOBNWrVWK8a
         frBZhM/gKYSVbeDQkIbShKQH1Gbi9tQOzNlbhgXTU8EuSxoESUx0j4nBIhLKJ+/FvvQo
         Ii/258BVNdTasXfU5T7nf8e5LNmatA110TXEZ/89hunO5+O65WL1gqcXo2Ct4IqOyqG+
         RRiQ==
X-Gm-Message-State: ACrzQf1rL9jCX9498zctRp5PVvH4eTtQnaabxG3wSRfubS6UOkMU58n/
        zId0w42TgQrM/nbrbzO8+zVq/V03+9M=
X-Google-Smtp-Source: AMsMyM5/m9Qv5qe0i9jmB6ZTvP1qiSAaI3rCUeMWt3X4Tz8UOP4pahzgtmW58pUMKKKCCfw0sH3ElrsKh+M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:d412:0:b0:56c:6f25:8b12 with SMTP id
 a18-20020a62d412000000b0056c6f258b12mr27322827pfh.60.1667431181026; Wed, 02
 Nov 2022 16:19:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:18:43 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-17-seanjc@google.com>
Subject: [PATCH 16/44] KVM: arm64: Unregister perf callbacks if hypervisor
 finalization fails
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

Undo everything done by init_subsystems() if a later initialization step
fails, i.e. unregister perf callbacks in addition to unregistering the
power management notifier.

Fixes: bfa79a805454 ("KVM: arm64: Elevate hypervisor mappings creation at EL2")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 73644def7780..f400a8c029dd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1839,12 +1839,21 @@ static int init_subsystems(void)
 	kvm_register_perf_callbacks(NULL);
 
 out:
+	if (err)
+		hyp_cpu_pm_exit();
+
 	if (err || !is_protected_kvm_enabled())
 		on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
 
 	return err;
 }
 
+static void teardown_subsystems(void)
+{
+	kvm_unregister_perf_callbacks();
+	hyp_cpu_pm_exit();
+}
+
 static void teardown_hyp_mode(void)
 {
 	int cpu;
@@ -2237,7 +2246,7 @@ int kvm_arch_init(void *opaque)
 
 	err = init_subsystems();
 	if (err)
-		goto out_subs;
+		goto out_hyp;
 
 	if (!in_hyp_mode) {
 		err = finalize_hyp_mode();
@@ -2258,7 +2267,7 @@ int kvm_arch_init(void *opaque)
 	return 0;
 
 out_subs:
-	hyp_cpu_pm_exit();
+	teardown_subsystems();
 out_hyp:
 	if (!in_hyp_mode)
 		teardown_hyp_mode();
-- 
2.38.1.431.g37b22c650d-goog

