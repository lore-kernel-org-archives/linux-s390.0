Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92201C4332F
	for <linux-s390@archiver.kernel.org>; Mon,  7 Nov 2022 03:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiKGDFS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 6 Nov 2022 22:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiKGDFR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 6 Nov 2022 22:05:17 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE1160EB
        for <linux-s390@vger.kernel.org>; Sun,  6 Nov 2022 19:05:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id t25so26688983ejb.8
        for <linux-s390@vger.kernel.org>; Sun, 06 Nov 2022 19:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YDkpvmLdCcNS/SK5D2IL8ltTmU7MAjuwj9on9XdxjqM=;
        b=O2GdYT7cMyZAwXXzVaGGer2516sCwb8nVa+3zH1uKyisQxoW9HAvhvHCOOJeufiTbl
         F3Np7E0Q60MoiXXzv7QKKfVpPuct8EOqbYhrz0wkX1SdRI+8oB73JExLBlUhlEORndI0
         oR5Ci6Q9Zji0dGkOeDy61S11yj8qgzFtdaxDEMNt1vXTTwBDofXJXEd/zzO2opd/NDJm
         j1f/gZ4KRV3uPIBqcQXujsk4akPpTe+2a2n4m0j+UpZ//j9kycunMnHpdO3L/Ji7eqnQ
         U523Q+8cijpVSXguZZnGJMRJTHTEr5k6EgUTEZqzTJSespExVQpXPGZ+H7/pFHIEuIGk
         PlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDkpvmLdCcNS/SK5D2IL8ltTmU7MAjuwj9on9XdxjqM=;
        b=NKGzgkQtHd0nBJKj6zJGVsdxjjT55vUWs3LZ65u40Vay/nTVzCNvuVgsCF4tHXManR
         1Zn1IYdncpeihpQpw+xVnP0mcSvBo7QqeT0ImKJ53QxnvLitzmlfeS5S5+llRgVkEN/n
         lz56jr8UYtgQ3yTlYiTB2OdaNcXKEv4Y4iXA7gqSgJf32dyTYdlDCdt6DI2BwRgf3YhM
         f7veZAi1SKgwERG7oj/KLrwcvgVQN0T5MtbRDfltzzCLvZ3JxANbm6jmrKKxuwlQzgmS
         sfswZwDNF0ygOeOrWIJPbS9e1V6QNDqSphVxVx/BQiGOCxSvQ61GWjCt+JVV7MCLhXIl
         tstw==
X-Gm-Message-State: ACrzQf2I/PzUqAx5E9JNCiQn5uxNDIvPvmeh5vmPuXJJE/iARNe04F7W
        rUyiJ+OZyw0K0PlUd+3BXOBX4m+4iOmiI5pkbiy3/g==
X-Google-Smtp-Source: AMsMyM525hQagKYMIlOIdqQEy/Sx/ht089FGqr8YQw810BAnhG6hulq/sfu3BFpHCBMEkVy5m+xwSwFEwA0SvamrVJs=
X-Received: by 2002:a17:906:eec7:b0:733:189f:b07a with SMTP id
 wu7-20020a170906eec700b00733189fb07amr46182007ejb.230.1667790314965; Sun, 06
 Nov 2022 19:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com> <20221102231911.3107438-23-seanjc@google.com>
In-Reply-To: <20221102231911.3107438-23-seanjc@google.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 7 Nov 2022 08:35:03 +0530
Message-ID: <CAAhSdy01NfFuHCsA1mrcxERL+=8F=PQbD_Nu7qvdKQOyQ_p9Tw@mail.gmail.com>
Subject: Re: [PATCH 22/44] KVM: RISC-V: Do arch init directly in riscv_kvm_init()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        James Morse <james.morse@arm.com>,
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

On Thu, Nov 3, 2022 at 4:49 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Fold the guts of kvm_arch_init() into riscv_kvm_init() instead of
> bouncing through kvm_init()=>kvm_arch_init().  Functionally, this is a
> glorified nop as invoking kvm_arch_init() is the very first action
> performed by kvm_init().
>
> Moving setup to riscv_kvm_init(), which is tagged __init, will allow
> tagging more functions and data with __init and __ro_after_init.  And
> emptying kvm_arch_init() will allow dropping the hook entirely once all
> architecture implementations are nops.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/main.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index a146fa0ce4d2..cb063b8a9a0f 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -66,6 +66,15 @@ void kvm_arch_hardware_disable(void)
>  }
>
>  int kvm_arch_init(void *opaque)
> +{
> +       return 0;
> +}
> +
> +void kvm_arch_exit(void)
> +{
> +}
> +
> +static int __init riscv_kvm_init(void)
>  {
>         const char *str;
>
> @@ -110,15 +119,6 @@ int kvm_arch_init(void *opaque)
>
>         kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
>
> -       return 0;
> -}
> -
> -void kvm_arch_exit(void)
> -{
> -}
> -
> -static int __init riscv_kvm_init(void)
> -{
>         return kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
>  }
>  module_init(riscv_kvm_init);
> --
> 2.38.1.431.g37b22c650d-goog
>
