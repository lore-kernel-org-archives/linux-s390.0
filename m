Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5FAC48BD1
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 13:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC0461184
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 13:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhFKNnA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Jun 2021 09:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFKNm6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Jun 2021 09:42:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C71C0613A4
        for <linux-s390@vger.kernel.org>; Fri, 11 Jun 2021 06:40:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f30so8647750lfj.1
        for <linux-s390@vger.kernel.org>; Fri, 11 Jun 2021 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VAgpxI0j7t6r6tnNN0LDsrTuOsaMVKhAYb54Y9rji0=;
        b=R6HK/NJxHEZTezhNED+ResyUbr+sC601m/iO/yfsGQgv6ogP2SdmM5iYweIFBi+81P
         hyF9E/8Xrldy8fIf8GayGtdco3cQrPxbrr6+/VnjT57oUnU0JHiWvCKCdunlXn5JDwIx
         Jf8RrszvH2/kPhgoitfHztj1hflGpwARazZuN8JqgjX/r6rahbdqT704CgMt52xFNjx+
         jd9QIGoU6NqAn2WCvCywUPJNfMGD1iBAceqc3mhlCZfuY8wtzlxpHztJ47QiaBCsYC4L
         rLQblEYrRoF4996ROTgZ1ptPvyBrxnj2cPeGJJUJGJzpvgUobPC0lVTmbD92+xt19t9h
         QaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VAgpxI0j7t6r6tnNN0LDsrTuOsaMVKhAYb54Y9rji0=;
        b=LFyfJ252LSE3UZITQahITyl6CbO7L3xvS32JkkuTuD5l6bGAXepHvCkvT4wY7P87+h
         s0C6xuJKS6TaLlMkglvB808yAOtHBH4OO4qJzvHi4rmW8DBiM4RnlNonb/XtwKJo0xE2
         sx8+zF23l/MiFVnsuvjoiwbLuKuLIKQzpsfgE97BEEsQwTAbl75gQxtQ+suYknZI8/u6
         /5kCH2oKpJJEyXLW/Jnhqq+TIO+L5+hKFMcoPvoR7sKfkkrukcbX825LtSXPxt3jamQk
         0em8QtOtcSw6rN6cxIjtgd1OwkJA9OzCr1xmnGRQ7QepH83padnjdbbVr9fIv5BE/TeF
         zUvw==
X-Gm-Message-State: AOAM5320H/jd67U/Luc5l1TOjinc8muXvU9nP9gt0DN5FD98wCDP6DeR
        AV2NH9nS+Ha7L73vXUOHrv9jvCH5Cr8s0A+gD65CTQhikKg=
X-Google-Smtp-Source: ABdhPJyd/EWKehnkyt/vEE7X4dLTk7ydhohkYIDaOlTtBlusLIXCnO+/tsxRSHdwRgbB5WhF0L3bzLcFmsQAmgprGWM=
X-Received: by 2002:a19:ed18:: with SMTP id y24mr2814385lfy.359.1623418844699;
 Fri, 11 Jun 2021 06:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210611124624.1404010-1-jingzhangos@google.com> <d9d440f0-ac2d-5a90-4e90-5eaa365f422e@redhat.com>
In-Reply-To: <d9d440f0-ac2d-5a90-4e90-5eaa365f422e@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Fri, 11 Jun 2021 08:40:33 -0500
Message-ID: <CAAdAUthF98tacvqb-WR8xX4EJzjhu0yeM=-qVk7oViiOF12kEw@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] KVM statistics data fd-based binary interface
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

On Fri, Jun 11, 2021 at 8:35 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/06/21 14:46, Jing Zhang wrote:
> > This patchset provides a file descriptor for every VM and VCPU to read
> > KVM statistics data in binary format.
> > It is meant to provide a lightweight, flexible, scalable and efficient
> > lock-free solution for user space telemetry applications to pull the
> > statistics data periodically for large scale systems. The pulling
> > frequency could be as high as a few times per second.
> > In this patchset, every statistics data are treated to have some
> > attributes as below:
> >    * architecture dependent or generic
> >    * VM statistics data or VCPU statistics data
> >    * type: cumulative, instantaneous,
> >    * unit: none for simple counter, nanosecond, microsecond,
> >      millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
> > Since no lock/synchronization is used, the consistency between all
> > the statistics data is not guaranteed. That means not all statistics
> > data are read out at the exact same time, since the statistics date
> > are still being updated by KVM subsystems while they are read out.
>
> The binary interface itself looks good.  Can you do a follow-up patch to
> remove struct kvm_stats_debugfs_item and avoid the duplication?  I'd
> rather have that too before committing the code.
>
> Thanks,
>
> Paolo
>
Sure. Will do.

Thanks,
Jing
