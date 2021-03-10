Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAD7C433E9
	for <linux-s390@archiver.kernel.org>; Wed, 10 Mar 2021 21:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F3464FCD
	for <linux-s390@archiver.kernel.org>; Wed, 10 Mar 2021 21:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhCJVoY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhCJVoG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Mar 2021 16:44:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BE4C061760
        for <linux-s390@vger.kernel.org>; Wed, 10 Mar 2021 13:44:06 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m22so36070890lfg.5
        for <linux-s390@vger.kernel.org>; Wed, 10 Mar 2021 13:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+At1OFsJvT0JOYczrtSDaeg1RlqRvgFnN9ibJip5xME=;
        b=qkR47YAxd7W+12meJHOokTY86zM5TK5Wusnmh13Uxu6NKYuWOWiLQGc+P2AFImuiLA
         ORloLJ5jSdrdT/bdHqp0DqklfhSIS7mEsK7M0vc6oJuwRJflhTJDhz132bRJTuHxQ+kO
         RInZN11KZCoVG6SxxC7xs6XJmagTxp4jzMdyWhd7EKrDtUQBY/A2tTYflsQ1uYhuPyd3
         zAAkVHP8jzsjKtNt8i07AloD2E4Y+rbcN6P6aA+VHiEEec2aQ0pLVAnU5FG2ZdTYiTPl
         Vuh0I/S8kIlI0b/tAdley4Z5qQ9yZunB4iev6lY8EGMaF3EkJrMb2vFP3F+H3DRihlGh
         rj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+At1OFsJvT0JOYczrtSDaeg1RlqRvgFnN9ibJip5xME=;
        b=TXjOT4PzugE5dycjeJS6DBLpzXd8VG+2OvVUwabXXCYIJN4b2dOIj8CvWQ9Ae+gn7o
         ArfNptS1TfoxxsF9Ccx1MTzL97pXyYqLqWJLSe47p8Bm3XFDlws+aKWcezrzgKTcNA10
         d5Nc2ibGk10BWJvif+VwI/T8yE+DbQKpFHMZJ4zMx2aZYkYRPAzSF4rSMiTzEmNulhAJ
         /cFy2Dvh9M3PgVh58rCmwqgC+bPqGJ7+muur14F47wK5/Jf6z32wh+72cCdz81Df6T2M
         +kJu6M30acul5RD06BK8TNy14LFRM6xLPVHXIf9v0Op2OFR2GmKgue1Ld7SP9hGGzkur
         LGPA==
X-Gm-Message-State: AOAM532C6H1EjImxSv5abFuj4GHImeAD7y1R0f/Ic+QBmoEtau5gHaMv
        GxJ47EM/l/65H9UYBKn6LlDqocQ8X4FyKPng5GfbDg==
X-Google-Smtp-Source: ABdhPJzfPcaCkdhotikZXLd9A3857WsFY8DpxVP062dOT18HhG4a9S9hO0jkkklXHezJ/dUgXnUVkP98iZMz90iTzX0=
X-Received: by 2002:a19:4345:: with SMTP id m5mr302440lfj.178.1615412644377;
 Wed, 10 Mar 2021 13:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20210310003024.2026253-1-jingzhangos@google.com>
 <20210310003024.2026253-4-jingzhangos@google.com> <875z1zxb11.wl-maz@kernel.org>
 <a475d935-e404-93dd-4c6d-a5f8038d8f4d@redhat.com> <8735x3x7lu.wl-maz@kernel.org>
 <2749fe68-acbb-8f4d-dc76-4cb23edb9b35@redhat.com> <871rcmhq43.wl-maz@kernel.org>
 <fd37d21f-f3ae-d370-f8e1-cf552be3b2ee@redhat.com>
In-Reply-To: <fd37d21f-f3ae-d370-f8e1-cf552be3b2ee@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Wed, 10 Mar 2021 15:43:53 -0600
Message-ID: <CAAdAUtjQHh3CEedcjZ5qQ72JZiacjogPoaKBO03vNbiQo=u5+g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] KVM: stats: Add ioctl commands to pull statistics
 in binary format
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, KVM <kvm@vger.kernel.org>,
        KVM ARM <kvmarm@lists.cs.columbia.edu>,
        Linux MIPS <linux-mips@vger.kernel.org>,
        KVM PPC <kvm-ppc@vger.kernel.org>,
        Linux S390 <linux-s390@vger.kernel.org>,
        Linux kselftest <linux-kselftest@vger.kernel.org>,
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

On Wed, Mar 10, 2021 at 11:44 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/03/21 18:31, Marc Zyngier wrote:
> >> Maintaining VM-global counters would require an atomic instruction and
> >> would suffer lots of cacheline bouncing even on architectures that
> >> have relaxed atomic memory operations.
> > Which is why we have per-cpu counters already. Making use of them
> > doesn't seem that outlandish.
>
> But you wouldn't be able to guarantee consistency anyway, would you?
> You *could* copy N*M counters to userspace, but there's no guarantee
> that they are consistent, neither within a single vCPU nor within a
> single counter.
>
> >> Speed/efficiency of retrieving statistics is important, but let's keep
> >> in mind that the baseline for comparison is hundreds of syscalls and
> >> filesystem lookups.
> >
> > Having that baseline in the cover letter would be a good start, as
> > well as an indication of the frequency this is used at.
>
> Can't disagree, especially on the latter which I have no idea about.
>
> Paolo
>
Marc, Paolo, thanks for the comments. I will add some more information
in the cover letter.

Thanks,
Jing
