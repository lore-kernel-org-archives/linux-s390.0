Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B88C47094
	for <linux-s390@archiver.kernel.org>; Thu, 10 Jun 2021 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4661D600EF
	for <linux-s390@archiver.kernel.org>; Thu, 10 Jun 2021 17:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFJR3w (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Jun 2021 13:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhFJR3w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Jun 2021 13:29:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A508DC061760
        for <linux-s390@vger.kernel.org>; Thu, 10 Jun 2021 10:27:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j2so4444591lfg.9
        for <linux-s390@vger.kernel.org>; Thu, 10 Jun 2021 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLnQvFD4x7DNDj+NEJ3O+AkctP1r/V6a1b3Mdx886HU=;
        b=rYFqapPgHlrCQ4YV5UAaF9vTXxJW71bDJszf6XXAAypmGGRdGy7rfe1/NkQ88jkidv
         zj0sX27ZlwVd1QclSX13XE640t7tzrvWWWb1G2tctffoctIf1fhooZ7Z71CevX/0YxEF
         tuOvnyEYg0UtYKXQV9KQGDQGVcEUJKGE2o7Ere77VbhsmdIPiI7RPZHMj8zFUV6O58ia
         ZHRxLj73Uxg2A+dJQSroGT/BW6I99RPB91M1y0pZsGyl/MLduTCcimMeMfbZQU+j52PK
         73cqjjeLjcblTMTYG4JtB0oQ0j/azuNLDIYH6CGSA+Lzz/w3wgp0j+picMdZdSjO0idh
         bqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLnQvFD4x7DNDj+NEJ3O+AkctP1r/V6a1b3Mdx886HU=;
        b=H14k0PWG5b8MFHQj+kAf0m1YXcJ+Ohc8zlPqdlwO9k/yyCRaXzb2I6UNisimbZ7Ufy
         2EkEnt3fkVY7dgF/LLDxBoNFe08pKxb8OEZSG5HMGHTvzO+Vl9lGjfOUQM2JoSQIDJSP
         Ghs1OSJ5lPKzJiHS66wY0SpRM+ijXl0s7E0Y77ktbZYj1EpnvzPYTFFScaMJJv+jPpBe
         fQ9hsXUe0MQqQL0A+fN3HiJj6YMdVWY49tdK2Kr5ZFe0lJ1P73/vs7Xxas9Hth5wHDNY
         qj11FXysWKHD0wB3uGWLasuVkCN/pjwPykyl8BFyWadTqRW8SwrBz8g0hgXvHlPyrEvs
         xt0g==
X-Gm-Message-State: AOAM531XS/iozgm+tML2WUWtWk5J5GwEOHPgJlk1XgvdLa3AS5eReMty
        1ywI1/1aDvZ9cqCKtrs7gDBBAzDn+3oRMY0+5kXcMQ==
X-Google-Smtp-Source: ABdhPJxMYyFCrOdc3qDmqDYkOsRd9Ou7KT5iYSlyqMweabXy+tFPPqYLyS4hzfuDF71PLN1Lon73E77keupLBsrNlto=
X-Received: by 2002:a05:6512:33c4:: with SMTP id d4mr2754345lfg.536.1623346073785;
 Thu, 10 Jun 2021 10:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-3-jingzhangos@google.com> <345170fd-636c-f1be-7dc3-69467e51d872@redhat.com>
In-Reply-To: <345170fd-636c-f1be-7dc3-69467e51d872@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 10 Jun 2021 12:27:41 -0500
Message-ID: <CAAdAUthr+An=SWZLDfWQ1nfnAr-PdAJgSuBmK2iypa1a3+Ay5g@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] KVM: stats: Add fd-based API to read binary stats data
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Paolo,

On Thu, Jun 10, 2021 at 11:42 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/06/21 23:14, Jing Zhang wrote:
> > +struct _kvm_stats_header {
> > +     __u32 name_size;
> > +     __u32 count;
> > +     __u32 desc_offset;
> > +     __u32 data_offset;
> > +};
> > +
>
> Keeping this struct in sync with kvm_stats_header is a bit messy.  If
> you move the id at the end of the header, however, you can use the same
> trick with the zero-sized array that you used for _kvm_stats_desc.
>
Good point. Will do.
> > +struct kvm_vm_stats_data {
> > +     unsigned long value[0];
> > +};
> > +
>
> I posted the patch to switch the VM statistics to 64-bit; you can rebase
> on top of it.
Cool!
>
> > +#define KVM_GET_STATS_FD  _IOR(KVMIO,  0xcc, struct kvm_stats_header)
>
> This should be _IO(KVMIO, 0xcc) since it does not have an argument.
>
Will correct it.
> > +#define STATS_DESC(stat, type, unit, scale, exp)                            \
> > +     {                                                                      \
> > +             {                                                              \
> > +                     .flags = type | unit | scale,                          \
> > +                     .exponent = exp,                                       \
> > +                     .size = 1                                              \
> > +             },                                                             \
> > +             .name = stat,                                                  \
>
> Here you can use
>
>         type | BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |
>         unit | BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |
>         scale | BUILD_BUG_ON_ZERO(scale & ~KVM_STATS_SCALE_MASK) |
>
> to get a little bit of type checking.
Sure, will do.
>
> Paolo
>

Thanks,
Jing
