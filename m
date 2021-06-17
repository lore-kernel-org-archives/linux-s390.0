Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5CDC49EA2
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 14:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB551613CA
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 14:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhFQO6f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhFQO6e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Jun 2021 10:58:34 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65DAC061574
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 07:56:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n17so9463797ljg.2
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbTYKOXEoTjmKWk+fpZnI99Si3buCUHA1ir4ZzP+nnI=;
        b=kc50UfvlreBP4U5XFPb9bvzXsic67xc5PlptbeuPCrbP14fhRwj9rOBUGLN6p+dtZX
         SOP1ZY5unyfg5G3JMXQ9hNEF7K9BJdNpysaExPQ4ZGnlcljp5AKYoIS2AnJWN9HA/eWW
         lcShCvH37ITs73OSDSewiBRwVuWFOqCDZuZLvOsSFwyv8XeY/lnBVaai2CWHMzpJ0ZWY
         Y53GpWGGPDQii1rEcnb3vD8rPnS7JYgrBF/1Tz+6xjdeaKCB2GHwPT9jPUZBQxOpU2vJ
         uVx93iAJ9KIPSlbLvTT+iKfClmYBRlq2GejTdrownxtxHdZu6Y8+qgMycGlLKMFEmk5n
         Fe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbTYKOXEoTjmKWk+fpZnI99Si3buCUHA1ir4ZzP+nnI=;
        b=CNfzyPZZr39NAF1RmMQ2a0qtGMHeAFubeUwZbnoppNj6QJRdkirP4AmGruxoNsJeMi
         6wg/A5L0fIEGUwmdssIpYsWkBiJ9V2LPNzuvjmyMHfVBIiaDFuhDaAEtn4UJ5RETGYCI
         5HonGQzMEXD1CbQY4L8e2xpORyTnPnXmGGxiKArDial/YH9wXGYhl0k84FcTAQhHNzy5
         jYcj4PJpKcAzhuEuzri6TxpZdaVsq9tiKLozSM3IXRQGBPsx8jVXdAWr8khtqaorCpIX
         eqgRa4mYhQHzHuzaSt/QKZI9Dd0BAX+UjNoTtltpADcjfen1lkeAHWCvtZqb4yl0On5d
         ZnqA==
X-Gm-Message-State: AOAM533h2k8Si8Eii5wzNq3AePVkoOCPXRScJrIsE5ao6DxgvjKux/Gp
        mM7JD+K35h2BF4Gxa8jb03v2ATsp1IudA203VGAgjQ==
X-Google-Smtp-Source: ABdhPJyHZSoRzwk/uvauvQQuu1bVwpP27gPIjPYDoJYNtfXQcbgPRMFOMqegaGb6vFsOuSX995igEG4xKcInEvg9Wdg=
X-Received: by 2002:a2e:9b8f:: with SMTP id z15mr4952786lji.304.1623941783847;
 Thu, 17 Jun 2021 07:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-3-jingzhangos@google.com> <YMr4rArKvj3obDEM@kroah.com>
In-Reply-To: <YMr4rArKvj3obDEM@kroah.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 17 Jun 2021 09:56:12 -0500
Message-ID: <CAAdAUtiiQ0304vWR3Zm2XUKz374W4LY3=qdrFZCsQ27VkqMn9A@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] KVM: stats: Add fd-based API to read binary stats data
To:     Greg KH <gregkh@linuxfoundation.org>
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Greg,

On Thu, Jun 17, 2021 at 2:24 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 17, 2021 at 04:41:43AM +0000, Jing Zhang wrote:
> > Provides a file descriptor per VM to read VM stats info/data.
> > Provides a file descriptor per vCPU to read vCPU stats info/data.
>
> Shouldn't this be two separate patches, one for each thing as these are
> two different features being added?
>
Actually, it is really not easy to separate this change into two patches even by
following Paolo's suggestion. And it would be a surprise to userspace to see
only VM stats, no VCPU stats.
I guess it is the text that caused the confusion, I'll change the commit message
for this.
> Anyway, an implementation question for both of these:
>
> > +static ssize_t kvm_stats_read(struct _kvm_stats_header *header,
> > +             struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
> > +             char __user *user_buffer, size_t size, loff_t *offset)
> > +{
> > +     ssize_t copylen, len, remain = size;
>
> You are "burying" the fact that remain is initialized here, not nice, I
> totally missed it when reading this the first time.
>
> This should be:
>         ssize_t copylen;
>         ssize_t len;
>         ssize_t remain = size;
> to be obvious.
>
> Remember you will be looking at this code for the next 20 years, make it
> easy to read.
>
Nice! Will do.
> > +     size_t size_header, size_desc;
> > +     loff_t pos = *offset;
> > +     char __user *dest = user_buffer;
> > +     void *src;
> > +
> > +     size_header = sizeof(*header);
> > +     size_desc = header->header.count * sizeof(*desc);
> > +
> > +     len = size_header + size_desc + size_stats - pos;
> > +     len = min(len, remain);
> > +     if (len <= 0)
> > +             return 0;
> > +     remain = len;
> > +
> > +     /* Copy kvm stats header */
> > +     copylen = size_header - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)header + pos;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
>
> I thought you said that you would not provide the header for each read,
> if you keep reading from the fd.  It looks like you are adding it here
> to each read, or is there some "magic" with pos happening here that I do
> not understand?
>
> And if there is "magic" with pos, you should document it as it's not
> very obvious :)
>
Will do.
> > +     /* Copy kvm stats descriptors */
> > +     copylen = header->header.desc_offset + size_desc - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = (void *)desc + pos - header->header.desc_offset;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +     /* Copy kvm stats values */
>
> New lines between code blocks of doing things?
>
Will add lines between code blocks.
> And again, why copy the decriptor again?  or is it being skipped
> somehow?  Ah, I think I see how it's being skipped, if I look really
> closely.  But again, it's not obvious, and I could be wrong.  Please
> document this REALLY well.
>
> Write code for the developer first, compiler second.  Again, you are
> going to be maintaining it for 20+ years, think of your future self...
>
>
Sure, will document it.
> > +     copylen = header->header.data_offset + size_stats - pos;
> > +     copylen = min(copylen, remain);
> > +     if (copylen > 0) {
> > +             src = stats + pos - header->header.data_offset;
> > +             if (copy_to_user(dest, src, copylen))
> > +                     return -EFAULT;
> > +             remain -= copylen;
> > +             pos += copylen;
> > +             dest += copylen;
> > +     }
> > +
> > +     *offset = pos;
> > +     return len;
> > +}
>
> thanks,
>
> greg k-h
Thanks,
Jing
