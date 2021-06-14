Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1518C48BE6
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 09:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8066261245
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 09:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhFNJxq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 05:53:46 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:34437 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbhFNJxp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Jun 2021 05:53:45 -0400
Received: by mail-oo1-f52.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so2503485ool.1
        for <linux-s390@vger.kernel.org>; Mon, 14 Jun 2021 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ozeCrBWe056dvCFaSIn+YQtzRjUNyCG2jQsSBdsH6g=;
        b=K2qC92mVnZ7jUjofUEv4H+1w+qvltenXJMO5pP5zAQH9F9zzM6cma5PhaHyikSIE3D
         dgQc6WK4VWss1I8rQpcUAa+kknrISK1OThLKqPD0Ynu3YYr8NHxDjWdGBi55WyPUNLif
         i3JnBKWMJgfPTrRirLFRa8yVdEoj3gif50MFdkhnQ7QcHt3pdY8TR72cKPAlAymhZAhy
         fE+SeGXJkHhWdl5z0so4A3sE6OP4b04IsNaed/cw6QlyOjQcCpURRrlseuX+X6B4TqU1
         wFpbS04rbYoW9naTxekf9c4HpCWGlieaJNAtYseO4lXhzKvQiMv8Gd3ijQNtsUu8qwFY
         4JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ozeCrBWe056dvCFaSIn+YQtzRjUNyCG2jQsSBdsH6g=;
        b=DH/hQBY0UKN72Nb2fLm0IfMnGLKqOEmv7nMweV0VkAxEvZU6PbhhIYYiOl2qA5FPYf
         DGqDCPEj9ookjzjzH52rwNUS0YWpl1Sc6oTUr94KsVE9hUaKznCi1VRw8Evpng2+qfRr
         RdU7WZ7fcZ8Ciu8l/kxdS2tE7Drp8PzAmf4lDW4w50FriJfX9czXfQE3XGFhtvbRns4W
         QByPg6uVsZOa5pBjv/JNmn6o8T1a46kvJXnNSYqK7VQDO7LWCFbCYUIaL1kwG9mW4C0n
         8QxYqW30gkDrnaojJoQJ8DwCeMGsBTx/ZyRP/++lVTUApZC6ySxDVnO1Ux/vDFZT0nTk
         SX2A==
X-Gm-Message-State: AOAM531duw19JXQnwd2UvHWqw54fgo/QBCPvKrxL0rXR8mFHpuqVcdt+
        JF95+BPJgs+KElaRq2qDOcX2kp8Dd/vvRSQJIXfysQ==
X-Google-Smtp-Source: ABdhPJyJwQ95jW5MLr7rUkCdRFLkVYE33n19WoUneoHj3ZP6RKTjyoGOcQr4wTLfnQTTpVHh3eZs+F2r0ncYGstNVYw=
X-Received: by 2002:a4a:5482:: with SMTP id t124mr12435372ooa.42.1623664227170;
 Mon, 14 Jun 2021 02:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210614025351.365284-1-jingzhangos@google.com> <20210614025351.365284-2-jingzhangos@google.com>
In-Reply-To: <20210614025351.365284-2-jingzhangos@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 14 Jun 2021 10:49:50 +0100
Message-ID: <CA+EHjTybUkOVVByL5r_MwLfzc_aaPybY8AzdCLYmS8aiR-RkSA@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: stats: Make sure no missing or mismatched binary
 stats definition
To:     Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jing,

On Mon, Jun 14, 2021 at 3:53 AM Jing Zhang <jingzhangos@google.com> wrote:
>
> Add static check to make sure the number of stats descriptors equals
> the number of stats defined in vm/vcpu stats structures.
> Add offset field in stats descriptor to let us define stats
> descriptors freely, don't have to be in the same order as
> stats in vm/vcpu stats structures.
> Also fix some missing/mismatched stats from previous patch.
>
> Signed-off-by: Jing Zhang <jingzhangos@google.com>

I tested this for arm64, and it does assert if there's a mismatch. I
couldn't find any missing statistics under any of the architectures
either.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 5e77f32abef5..692af9177c9f 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1296,119 +1296,152 @@ struct _kvm_stats_desc {
>         { n, offsetof(struct kvm_vcpu, stat.generic.x),                        \
>           KVM_STAT_VCPU, ## __VA_ARGS__ }
>
> -#define STATS_DESC(stat, type, unit, base, exp)                               \
> +#define STATS_DESC_COMMON(type, unit, base, exp)                              \
> +       .flags = type | unit | base |                                          \
> +           BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |                   \
> +           BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |                   \
> +           BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),                    \
> +       .exponent = exp,                                                       \
> +       .size = 1
> +

nit: you seem to be mixing tabs and spaces here

> +#define VM_GENERIC_STATS_DESC(stat, type, unit, base, exp)                    \
>         {                                                                      \
>                 {                                                              \
> -                       .flags = type | unit | base |                          \
> -                           BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |   \
> -                           BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |   \
> -                           BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),    \
> -                       .exponent = exp,                                       \
> -                       .size = 1                                              \
> +                       STATS_DESC_COMMON(type, unit, base, exp),              \
> +                       .offset = offsetof(struct kvm_vm_stat, generic.stat)   \
>                 },                                                             \
> -               .name = stat,                                                  \
> +               .name = #stat,                                                 \
>         }

nit: also here, mixing of tabs and spaces

Tested-by: Fuad Tabba <tabba@google.com> #arm64
Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad
