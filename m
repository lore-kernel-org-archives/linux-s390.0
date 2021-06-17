Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD1C49EA2
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 15:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2AE613A9
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhFQPxv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhFQPxu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Jun 2021 11:53:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575EFC061768
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 08:51:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p7so11260293lfg.4
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvwd9EpkhUinpwzSVnooHeUgUpNvfxheNpkid5yzIx8=;
        b=TxvTgcPI/Ra/tWUZA++LM92n/9N9cTc45nFEoGhah5rZzdxemGKBDvrRYYHnH4ElJt
         yeZYKEj3Lqkp+BP0P4ZFMlqAtvCYjKX6t4G5pL+NGvO/8eHXkyErvHJikNhQ82xaQoTq
         E4tiTMkcq1rkKtM7nLr4Upaq/GGoVKkfONVtDcs0f22HJaAYQy3Ug/8crI/5MUkmS78c
         IwGqnKxMKmqptWtKPTUMbqXncfLP3Px4QgECquw11X7E+Y33meqrsX+9oDDbuFcIx+yl
         gLr7fO7ADbTI7Co5iaDp6TxfEujoOq3bCRAkkK4lGCAoIfkQAfzZGLE2WYNQ+ctC+FK+
         Bvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvwd9EpkhUinpwzSVnooHeUgUpNvfxheNpkid5yzIx8=;
        b=sPey/h3jRSBoMbmRXmus0GHGk95WSguv0N/pkgrF8BQAgrEmiJAWR/92pKEZuUkf9n
         qrcjat1TvI8jPRqpJ/Xdn+NJs0AfIHvQNFSnlFavpb8jIEb7FsEgVL2ANJ20kcrrlm6n
         Yc7a0IS7jws7xDL42rtWV9rzwcL3EsrOXJA9dFQeHWv1DSmPZJNMvVKGAxe1loTvGL4I
         gg0jH7zr8FWOAAgUgdb79LKsmqqFmboALek0vYhb3ZvLBQzLjMj5D6fnvIutQAi8bwta
         8gGK4uMOHNw2yMrwNrvUEVkBnMJXdwwhQiZFWAHuNXUBaNnAb7arGeX8Jn+8FMv6prUw
         eRdQ==
X-Gm-Message-State: AOAM532MSn00+U0W4Y4iK7+N0KUkIlz0ebKHeDxb4E7r5dwqaGESpW2m
        I78O47TCNAbIK4EjjWM6MX6XPm5oXFrErfVLPyhOEQ==
X-Google-Smtp-Source: ABdhPJyUT96ejYRqWFIHeQAvBlwr1aj1uzNjIHt1HENKbAjxRBM9g7oEN8mmzhRuuz1Vfgjz72FeQyENnMW8V6GZXWk=
X-Received: by 2002:a05:6512:3ea:: with SMTP id n10mr4497632lfq.178.1623945100161;
 Thu, 17 Jun 2021 08:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com> <YMrmqOxDWJ2/8sfD@kroah.com>
 <be506135-5bc3-31bd-1b20-063f01f41df1@redhat.com> <YMszVQEK8LHiAT+9@kroah.com>
In-Reply-To: <YMszVQEK8LHiAT+9@kroah.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 17 Jun 2021 10:51:27 -0500
Message-ID: <CAAdAUth+osvNAzhGGY3u8fH4b2=PnLKQNFSfF6W92y--uYFOVg@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 17, 2021 at 6:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 17, 2021 at 01:19:50PM +0200, Paolo Bonzini wrote:
> > On 17/06/21 08:07, Greg KH wrote:
> > > > The statistics data itself could be read out by userspace telemetry
> > > > periodically without any extra parsing or setup effort.
> > > Do you have a pointer to userspace code that can do such a thing that
> > > others can use?  We do not like adding apis to the kernel without at
> > > least seeing the user of those apis, especially for complex things like
> > > this.
> > >
> > > Ideally you would include some library code in the kernel tree itself
> > > that everyone can use for this for their own programs.  You have
> > > provided a test which is great, but how do we know it works for "real"
> > > usages?
> >
> > I am pretty sure that Google is using this internally, but we are also going
> > to work on QEMU and Libvirt support for this.
>
> We need an "external user" for something as complex as this to be able
> to see if it actually works or not.  Otherwise we have to just guess :(
We have plans to add some library code in kernel selftests and also some
simple tools to let everyone get a feeling of the new API.

>
> thanks,
>
> greg k-h

Thanks,
Jing
