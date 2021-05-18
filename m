Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EEFC433ED
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 16:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72AE5610E9
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 16:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350613AbhERQ24 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbhERQ2z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 12:28:55 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE45C061756
        for <linux-s390@vger.kernel.org>; Tue, 18 May 2021 09:27:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w15so12289798ljo.10
        for <linux-s390@vger.kernel.org>; Tue, 18 May 2021 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCHyX25nut1dXgrfKvPYZ4vLHkOFpNujX0A0DBHr6zA=;
        b=QQnYdPNPVB26qj7Ys12iD114pAArbDt9pCpdKRPqNfNWWhY6L+RXxxCV1QAy/7013Y
         rdZk/pvPuSWTxe5cV2yVN+qzIuhMHB4f9KgRvwVOE/0zgJoS7f6OtPQbeyQnK4rfmDao
         We7oSlerhFdZBoJUU0HWqL/We+yx8/1Dxdqx9Jnb4CK44kTGNedTGWoQSELf0ZxgymsI
         J5/nIa007Ed7SFBCwXhYwUMbb5gVF31pqKkXp8whelqyoYug4VtfNU8WqB1K1vW7oS2l
         S522kEQZFPyDnmehv/a8zHfx/8wTBn4kn/r33mvqZuzzfh4tlyZWPaiBDgcCUkvsH1yW
         0Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCHyX25nut1dXgrfKvPYZ4vLHkOFpNujX0A0DBHr6zA=;
        b=o8RRxXJ47qFmPUDol+uNWRCzmxpSOk2Ll+yWyGPV76Lw4rufOuqGiMjxh/6DPZFaR2
         K7O3EhKwvu1rnEzfInwjU6Oh+j4zDSiF8X2RzwXvfvojBQ+4OKMOI9cELPMN/MATGEov
         kO+sZ0puJ5B1nwLTbnOzuXquJ8iBm85gDUfJ6qjHFpLDn4zfE9JYSAbOI1fKcwXVfCZD
         FifUPnzxB+T0sxDctj6JuP3U4QfNcYkSZFqKlAOF4YDbabv2015H6Wgh2/5XzPjIYGo/
         IFEPjdksAqdgoN4CBJX5MHkAK+tCXUlasA3kqr8+wf4Q74V60gNLEfEwt01Vl4Ex9gwQ
         wnmA==
X-Gm-Message-State: AOAM531enFpipHSR4EJO51PoE9v/fxoFsJ4Lw/RMdRf9cadvDEhrmSWt
        KnuFj8PNfEkxlUVbkG0oAZdwrfshMaziOIopJ+02vOsjOL9WDWu8
X-Google-Smtp-Source: ABdhPJwMrV1eLucK07ggc7pKZYp2/4fRRvxCRtyoN4tBFxgPe2X3AL8Bz64jmu1CM19fdZ3EtBoPQ6h8vlutNeAyWRM=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr4934378ljg.74.1621355253213;
 Tue, 18 May 2021 09:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-2-jingzhangos@google.com> <CALzav=dGT7B7FWw_d5v3QaJxgfp6TZv7E4fdchG_7LKh+C17gg@mail.gmail.com>
 <CAAdAUtjyFhuh4iFJJOkkO20XXKqbcRO-S0ziFfUW1rHL-bkeZw@mail.gmail.com>
In-Reply-To: <CAAdAUtjyFhuh4iFJJOkkO20XXKqbcRO-S0ziFfUW1rHL-bkeZw@mail.gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 18 May 2021 09:27:06 -0700
Message-ID: <CALzav=dHjy8wnLckxifrjVDfVNBmqHcJgeS7PK6BnAp6UCyO5A@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] KVM: stats: Separate common stats from
 architecture specific ones
To:     Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 17, 2021 at 5:10 PM Jing Zhang <jingzhangos@google.com> wrote:
<snip>
> Actually the definition of kvm_{vcpu,vm}_stat are arch specific. There is
> no real structure for arch agnostic stats. Most of the stats in common
> structures are arch agnostic, but not all of them.
> There are some benefits to put all common stats in a separate structure.
> e.g. if we want to add a stat in kvm_main.c, we only need to add this stat
> in the common structure, don't have to update all kvm_{vcpu,vm}_stat
> definition for all architectures.

I meant rename the existing arch-specific struct kvm_{vcpu,vm}_stat to
kvm_{vcpu,vm}_stat_arch and rename struct kvm_{vcpu,vm}_stat_common to
kvm_{vcpu,vm}_stat.

So in  include/linux/kvm_types.h you'd have:

struct kvm_vm_stat {
  ulong remote_tlb_flush;
  struct kvm_vm_stat_arch arch;
};

struct kvm_vcpu_stat {
  u64 halt_successful_poll;
  u64 halt_attempted_poll;
  u64 halt_poll_invalid;
  u64 halt_wakeup;
  u64 halt_poll_success_ns;
  u64 halt_poll_fail_ns;
  struct kvm_vcpu_stat_arch arch;
};

And in arch/x86/include/asm/kvm_host.h you'd have:

struct kvm_vm_stat_arch {
  ulong mmu_shadow_zapped;
  ...
};

struct kvm_vcpu_stat_arch {
  u64 pf_fixed;
  u64 pf_guest;
  u64 tlb_flush;
  ...
};

You still have the same benefits of having an arch-neutral place to
store stats but the struct layout more closely resembles struct
kvm_vcpu and struct kvm.
