Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A625C2B9F4
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 13:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0375E60FE5
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 13:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhFNNbq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:31:46 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:41581 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhFNNbm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Jun 2021 09:31:42 -0400
Received: by mail-lj1-f181.google.com with SMTP id z22so20133521ljh.8
        for <linux-s390@vger.kernel.org>; Mon, 14 Jun 2021 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5Z/aRJGZDJZL2EoNoPXOS7QUgj78LrAb9XaHxJadEA=;
        b=JiV08GosC2hu0mBkUDRXU/N884IpJJ34SBN+GRNPcDZ65ZIK3IlpEE+snOmDGdRceK
         tudF5VzHPI6svSmHaten143+9jq6T8AneF3vjk5jm6TokSrvzJRR+eF6OJpOVQBUvYT1
         9ZgGKOXkazUUV9TzXB6CrvcL9grdWhXTsvpH4wnjEsjBtT1E651Zg5KBC1IQQ5ONl8FY
         +qfgCELQ+ZU3YQy0jhDIBvIyerCR4IcHkRsx2vXw06ZDq4fS+xn+SMx1DMdeoVaJIi7J
         8CJfkJm5Dz4CksAOqr8NLGYnhhvejzLauWaVYAnUm9fzIR3Y3DWTdYjtDKVoKSP7oYdf
         Httg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5Z/aRJGZDJZL2EoNoPXOS7QUgj78LrAb9XaHxJadEA=;
        b=MnUqx4uks9prejSiCqdPOJor5yw9yepc3lwyI+0Vq05keTrQJ0GDCN++jHeFJFJvce
         zzlcVEJob6itsnmjZtjBmGj2VzCKCoRppG6TonjcSom9hSgBYvLGSKLs28EGV2sVyJqE
         geP54ALPfx82asZw8axlrsROFaX84DoUu0nniQoNkSSrNHueBhjEtQnfwCYmaNNWoAM+
         S7wQmZp4IqU6KLw+Z84ORyrx4FApKUr/K27bQsp54tehUJlZQb6VdMZhO2c7EbMVRv1B
         F1CMEc7hrKGHXu3gds4xs/HbyR3cF6y8ZVQpEsXp8cJQMtJmzdCme9Ys0fHpT7OI07gp
         IZTQ==
X-Gm-Message-State: AOAM531tH+dbpr7MREN8NM7dqK4v6tMG1dod2NWoQB9cQI4Vcyvq5X7c
        iGwSlBDzsp6+iBbt+n0TWx/8HEs/wFuiZtexquJuWQ==
X-Google-Smtp-Source: ABdhPJzkTobUBO7OfrBdhTzHUcheq0UTf5Nx2DXYGm1qPTWlKyDMAcFAsG0mMq2AInD+nV0hjIJk0U4MuH67YXYy1fY=
X-Received: by 2002:a2e:8814:: with SMTP id x20mr13996006ljh.394.1623677318799;
 Mon, 14 Jun 2021 06:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210614025351.365284-1-jingzhangos@google.com>
 <20210614025351.365284-2-jingzhangos@google.com> <CA+EHjTybUkOVVByL5r_MwLfzc_aaPybY8AzdCLYmS8aiR-RkSA@mail.gmail.com>
In-Reply-To: <CA+EHjTybUkOVVByL5r_MwLfzc_aaPybY8AzdCLYmS8aiR-RkSA@mail.gmail.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Mon, 14 Jun 2021 08:28:26 -0500
Message-ID: <CAAdAUthx2Hpqx6nLg8JeAO5XwVyBL7Dr6Et244LDUv1=99NgrQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: stats: Make sure no missing or mismatched binary
 stats definition
To:     Fuad Tabba <tabba@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Fuad,

On Mon, Jun 14, 2021 at 4:50 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Jing,
>
> On Mon, Jun 14, 2021 at 3:53 AM Jing Zhang <jingzhangos@google.com> wrote:
> >
> > Add static check to make sure the number of stats descriptors equals
> > the number of stats defined in vm/vcpu stats structures.
> > Add offset field in stats descriptor to let us define stats
> > descriptors freely, don't have to be in the same order as
> > stats in vm/vcpu stats structures.
> > Also fix some missing/mismatched stats from previous patch.
> >
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
>
> I tested this for arm64, and it does assert if there's a mismatch. I
> couldn't find any missing statistics under any of the architectures
> either.
>
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 5e77f32abef5..692af9177c9f 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1296,119 +1296,152 @@ struct _kvm_stats_desc {
> >         { n, offsetof(struct kvm_vcpu, stat.generic.x),                        \
> >           KVM_STAT_VCPU, ## __VA_ARGS__ }
> >
> > -#define STATS_DESC(stat, type, unit, base, exp)                               \
> > +#define STATS_DESC_COMMON(type, unit, base, exp)                              \
> > +       .flags = type | unit | base |                                          \
> > +           BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |                   \
> > +           BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |                   \
> > +           BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),                    \
> > +       .exponent = exp,                                                       \
> > +       .size = 1
> > +
>
> nit: you seem to be mixing tabs and spaces here
>
> > +#define VM_GENERIC_STATS_DESC(stat, type, unit, base, exp)                    \
> >         {                                                                      \
> >                 {                                                              \
> > -                       .flags = type | unit | base |                          \
> > -                           BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |   \
> > -                           BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |   \
> > -                           BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),    \
> > -                       .exponent = exp,                                       \
> > -                       .size = 1                                              \
> > +                       STATS_DESC_COMMON(type, unit, base, exp),              \
> > +                       .offset = offsetof(struct kvm_vm_stat, generic.stat)   \
> >                 },                                                             \
> > -               .name = stat,                                                  \
> > +               .name = #stat,                                                 \
> >         }
>
> nit: also here, mixing of tabs and spaces
>
> Tested-by: Fuad Tabba <tabba@google.com> #arm64
> Reviewed-by: Fuad Tabba <tabba@google.com>
>
> Thanks,
> /fuad
Thanks for the review and testing!

Jing
