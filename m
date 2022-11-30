Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B0EC4708D
	for <linux-s390@archiver.kernel.org>; Wed, 30 Nov 2022 23:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiK3XQT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiK3XPx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Nov 2022 18:15:53 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4CAA320E
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:11:26 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id m9-20020a63ed49000000b00477f449365fso70712pgk.15
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=X0tmq9TjsMbdzf016NYPEZWLDrtJgEerkZwlPByjvHs=;
        b=ffiAil8tYfi3nQXQblraVPD6jbdbOOCVG7uQkkKJrYkDL25R/TkQAeFRDogqa/QMMv
         6wZOWt9R/eeSPWTlpWV3IYmrtl04WJOPJAhS7DhGuKTgLTJnehBcyBsLWlgRsCVFi/Ix
         ksxZjkBOqqqo9hOr9qKhrYgS8WLlfTE4UM6Vkkhhf880kZVvVEdvLhl4X0FaFYBb/6vC
         1lACz1AHExA2AbJQILx7vCyuTDoL44EAFEV/X6CifJwvfMkGg0ai47n8Yg94c4IO+cHQ
         jlRTeSXfVKpq0j3GPFNIBJZpOCvznvIZyM5DfqXmXJnRlhyCma48IFWCHmjS0A3NCAbs
         hdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0tmq9TjsMbdzf016NYPEZWLDrtJgEerkZwlPByjvHs=;
        b=yf7Fnrtej6K4vDefB4JCdHjT5NCjlldVv/Erw4gm9zptd1TsEnxMGLo/TxZLsd3oMF
         SYN0l2z28q4D2W8xSMO84mCci4tMEfziBQvNNZguEeNEXisJE0eoGlJN0cWUsJocGRKN
         uFAOAI3pmtnUd3S7X/Jdqw1zOvlbjQU9uyT+tuQwdd+KYX10lK4r7b0z7wDtQPWT/Egu
         BJqC9/P5x2vslPINWyrsEvch8VhTHmXdfWrqEItXB36XpLu2Z4/ZzhNyoT8XdzrHLOxH
         BwcKbCNPuDl3+us6YZbuHBfDqm9us3kwVDKZ3GlUS8MRpyNMYhq7qKrBr5+QQv6kv8bc
         cziA==
X-Gm-Message-State: ANoB5pmXoW+lIEP+ASoBMsgSoUhcUMyI10QIVOH8ro7t+3lpFHjZOpVX
        sYqlncbTrbaeb2+0DloSOTcdeJ+9qPA=
X-Google-Smtp-Source: AA0mqf4tYdOmumtBwzOsj2b757evhXiqjnmJBxVweHABwP7YhX6XXp+28OecLtWsiEbLYyMEiAceUWRYidE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8487:0:b0:56c:3bb4:28a8 with SMTP id
 u7-20020aa78487000000b0056c3bb428a8mr44633084pfn.83.1669849852226; Wed, 30
 Nov 2022 15:10:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:09:27 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-44-seanjc@google.com>
Subject: [PATCH v2 43/50] KVM: Ensure CPU is stable during low level hardware enable/disable
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

Use the non-raw smp_processor_id() in the low hardware enable/disable
helpers as KVM absolutely relies on the CPU being stable, e.g. KVM would
end up with incorrect state if the task were migrated between accessing
cpus_hardware_enabled and actually enabling/disabling hardware.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d985b24c423b..a46d61e9c053 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5028,7 +5028,7 @@ static struct miscdevice kvm_dev = {
 
 static void hardware_enable_nolock(void *junk)
 {
-	int cpu = raw_smp_processor_id();
+	int cpu = smp_processor_id();
 	int r;
 
 	if (cpumask_test_cpu(cpu, cpus_hardware_enabled))
@@ -5070,7 +5070,7 @@ static int kvm_online_cpu(unsigned int cpu)
 
 static void hardware_disable_nolock(void *junk)
 {
-	int cpu = raw_smp_processor_id();
+	int cpu = smp_processor_id();
 
 	if (!cpumask_test_cpu(cpu, cpus_hardware_enabled))
 		return;
-- 
2.38.1.584.g0f3c55d4c2-goog

