Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7DDC4708D
	for <linux-s390@archiver.kernel.org>; Wed, 30 Nov 2022 23:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiK3XKC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiK3XJp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Nov 2022 18:09:45 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA675AE36
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:09:44 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x21-20020a62fb15000000b0057451601be4so153442pfm.19
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=E8JVGgtDpa1adQbcFKdjF0h5x+zc5eW3OzNDv17W+I0=;
        b=DS5tl3JZt5ENZ41z8LWoU7l/LLAZg0bKxr9NB64mArQBR7Z4xQ54gwA8E1Foi7ucUI
         WLpYLHet6DIopxUbH10y1vLmghI4adUhheVz2l+sfpolKRTogMb2+JXMX5kC+1I07F/z
         xq02cwtlNoKx8xWnfdsY/DFfLTDmRaQZCHvCCDtocOPTXWGXE+6cy/K/TTmkXZECJ1T5
         UPbbMU++Q0JdnDp6PdsJU4We1R6snVfDObMmpUXwD7SotdnLb3fRUaZHvapd0uWqxFq9
         B+vmtfzyaE3KTk8T/zN+WUL7QMUukMAgZHVrZIfnA64+0ySQ/W2zwvQkWpKfKL7fFmQx
         zvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8JVGgtDpa1adQbcFKdjF0h5x+zc5eW3OzNDv17W+I0=;
        b=1vSp8+DJNX1jLZ6mRJl53GAFKlk8EvlwICvptDYsA48/JTdZGRGin7uekxacOrX9hm
         3E/EM2XZ3YtkqLlgqZNuWsDrKz9zKWhgn7n5QeqYk4Ure/SDXOeWghz2iSxel7EQhaoE
         V2Z5hM1JVIx10WBUCZT8tZGQJrrypEXVn7g+FlUv92o/8IiO1xTxg1MKXyZ9D0sa+4R5
         Toa7fEwNpTiSLAQcsk8X7FQX4W6aYePNWeHrM84tZSUHjM5SW4QuX7nuf31Ub/dQkgyX
         2nyx0VGTweB0R/wOJX1oO11Po6Q3eeAq23JubPcnXcMLFtDt+Ad4a07Bq4loEw0/53NB
         8IDQ==
X-Gm-Message-State: ANoB5pleTSvH3yY2veyZZcelQxS4k+ekCS/ZcBpvaAF5LunskjCK2SjK
        U7hwWEoqzSH4eg9a9DODHK8ubS6qoww=
X-Google-Smtp-Source: AA0mqf6Q0BFR2rWNLKbL3PfSbJ45azh4M9K0FqaT09LmFusT3iMI987lBa2MWHLHJI40i8Y0hHfQV/M7a6M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e887:b0:189:1fcf:6ceb with SMTP id
 w7-20020a170902e88700b001891fcf6cebmr43466277plg.45.1669849784316; Wed, 30
 Nov 2022 15:09:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:08:48 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-5-seanjc@google.com>
Subject: [PATCH v2 04/50] KVM: Teardown VFIO ops earlier in kvm_exit()
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

Move the call to kvm_vfio_ops_exit() further up kvm_exit() to try and
bring some amount of symmetry to the setup order in kvm_init(), and more
importantly so that the arch hooks are invoked dead last by kvm_exit().
This will allow arch code to move away from the arch hooks without any
change in ordering between arch code and common code in kvm_exit().

That kvm_vfio_ops_exit() is called last appears to be 100% arbitrary.  It
was bolted on after the fact by commit 571ee1b68598 ("kvm: vfio: fix
unregister kvm_device_ops of vfio").  The nullified kvm_device_ops_table
is also local to kvm_main.c and is used only when there are active VMs,
so unless arch code is doing something truly bizarre, nullifying the
table earlier in kvm_exit() is little more than a nop.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ded88ad6c2d8..988f7d92db2e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5980,6 +5980,7 @@ void kvm_exit(void)
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
+	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
 	unregister_syscore_ops(&kvm_syscore_ops);
 	unregister_reboot_notifier(&kvm_reboot_notifier);
@@ -5989,7 +5990,6 @@ void kvm_exit(void)
 	free_cpumask_var(cpus_hardware_enabled);
 	kvm_arch_hardware_unsetup();
 	kvm_arch_exit();
-	kvm_vfio_ops_exit();
 }
 EXPORT_SYMBOL_GPL(kvm_exit);
 
-- 
2.38.1.584.g0f3c55d4c2-goog

