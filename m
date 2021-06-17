Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E0CC49EA2
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9783D60249
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 15:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhFQPok (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhFQPoj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Jun 2021 11:44:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E542AC061767
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 08:42:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r5so11295491lfr.5
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gA9TZaqOl3zy1dJIWszjf8FGUKT8ntsayRnFvsMmeKE=;
        b=rjGGx3hDJcU8YgExYPvnRbDmEiwqIoA9VdAEle1149lM7CLqEmmZ5IGx5C6v2xN+BK
         erAId3gLrIx3qvunWhwnAkobhgz7xQLbphUZnztf54+GCy7Rt9jJnsQ4GTCIxooMQ6Nh
         ypsifEZBI7FXjvlJpbG15frf50E6gOgOxPY59sppGE5Gm3EVOP58JfTBQFuDrNsThg4g
         pW9dY09XQK2DWc9As8xzDId9FTmLnsz2UlZubPkc0QCrvBCN+9v6DMkPxvgT1sLw2hcx
         nQ6ahn5n70P/Vnyg/uULHRQf/KKgKU03kAOJCg30VCluDTMdCeu/RDCuXgsbWPpmgNDS
         NGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gA9TZaqOl3zy1dJIWszjf8FGUKT8ntsayRnFvsMmeKE=;
        b=OVXKvf/bNCzUH+0J6jlP07RJD4WMM5q7rHbKmJrmZdR7xFd5VR9rk7zRMPVPrH8Igy
         NcsWo3rtLbCByxnjeQdVb0CS7BUSCFR3v8jDuM65NGFVzluY0FmS5A5Wjsposm1z++8O
         06xyuKg7MjemYkF0+cVo3+Uc4Jg0dDkqOY4V1IjXyUAB2Ait04awKS9EQuan90iZBxuF
         8CWcOnQ3Cf2fZa8AYhP/kH3atV4Gl37xyTfOG0RiM7wMbrdpIyyoEr0mgmFsSxreQMWz
         q2tdESN7zju9e9+X7ioRJ4Z2OCSqZwQK66/150dlvPZkwH7AayLUlePALX+D164uBmB3
         vUVw==
X-Gm-Message-State: AOAM531GYsysZZWm1PLVV6jZLW1XjXFWvq/MSFmqkhicSxrIQfAzYHCm
        9MqNG3CgTYOSiqWk8recYcHvOMpf0T7IahcYghSgiw==
X-Google-Smtp-Source: ABdhPJxIgtHTYijVD1CpTmwKu7GF1JsNiAyO8otRBPAhPiGuR1/vRj2f9gVDMVv2mwH8Qtqe0siOJfwZGA+WbyKt0Rk=
X-Received: by 2002:a05:6512:318d:: with SMTP id i13mr4638106lfe.407.1623944549075;
 Thu, 17 Jun 2021 08:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-3-jingzhangos@google.com> <YMr4rArKvj3obDEM@kroah.com>
 <CAAdAUtiiQ0304vWR3Zm2XUKz374W4LY3=qdrFZCsQ27VkqMn9A@mail.gmail.com> <5ae75b1b-4cba-d06f-625b-35b42f11ac03@redhat.com>
In-Reply-To: <5ae75b1b-4cba-d06f-625b-35b42f11ac03@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 17 Jun 2021 10:42:17 -0500
Message-ID: <CAAdAUtigLr+n_d+XZ3FUUXSSb7PmSFNY5+XKATQp2r0s4xiY8A@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] KVM: stats: Add fd-based API to read binary stats data
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, KVM <kvm@vger.kernel.org>,
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

On Thu, Jun 17, 2021 at 10:29 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 17/06/21 16:56, Jing Zhang wrote:
> > Actually, it is really not easy to separate this change into two patches even by
> > following Paolo's suggestion. And it would be a surprise to userspace to see
> > only VM stats, no VCPU stats.
>
> That does not matter.  Having two or three patches is useful because it
> makes review easier; they will never appear separately in a release.
>
> Paolo
>
Cool, then I'll separate them.

Thanks,
Jing
