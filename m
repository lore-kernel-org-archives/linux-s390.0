Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60529C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A70161440
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 17:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352830AbhI3RtF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Sep 2021 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352811AbhI3RtE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Sep 2021 13:49:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A8AC06176C
        for <linux-s390@vger.kernel.org>; Thu, 30 Sep 2021 10:47:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so2227129pjb.1
        for <linux-s390@vger.kernel.org>; Thu, 30 Sep 2021 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+IS0gEgo7hipR9gibsQw5KtPLx6dQXKFRc1+dywoXVA=;
        b=m0rDM0cnK0yrtL29pL81MAGf7w2Yed+jc4KUJF0fL6YCvGOj2OOT/73pX0N1cuLGzf
         ECJdJfF5q+Tu3Vs0H54vg8YCX4POSPt/jTDx97+sRolpUheG7qnd3LACShH3YDUGL+oL
         edpJws/IQ1QQ+9i+FXscZHebVHzxRo9Z53ybE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+IS0gEgo7hipR9gibsQw5KtPLx6dQXKFRc1+dywoXVA=;
        b=jfegGOW2mqVzALdc+dYDTWVdAPFdQZS9BOecVhhUFvpUCsaziwGS9g9zZxpcJ2PV13
         jPj8JeJov8Pky1sSpWyvUaOMcnPfqafOknwN3oZZcuV4UC/N0ygvXeDdLVQhHD8rRdgZ
         RuqXbAOJ6py+pFOreWgHfriCGmV/yGzoEd7A+vtvrwv5TwVjiDhDKGHmdRwqqERRBaxy
         Hq7r/9i6rLIs9c5VpLQLGG9BoDFWGl/2TH+la8UIh63nrj0wNSoG0Lv3b9dLgaH77bnj
         XeBS2H9FdE3MARXK0EgyOmt3e6g4DnIGX105zliuFc3h2ZVBjSlugs8sGxELt5/VUPxU
         spQA==
X-Gm-Message-State: AOAM5309VkTP0JzFWOzApcloXH/NJcIklajKawbr6FO0ipDLEPWJUgQM
        9j/UUjENm0n4hFgeHHYIydzdXBdOl7P/1Q==
X-Google-Smtp-Source: ABdhPJwKcuP6DGDrVJJap2YBfnw9gJ29cZ6T8aj/WEWFIltD4Sz9lDFqVeOwFghXxQzDWleVwS3vJg==
X-Received: by 2002:a17:902:e74d:b0:13e:77cd:a300 with SMTP id p13-20020a170902e74d00b0013e77cda300mr2394421plf.80.1633024041447;
        Thu, 30 Sep 2021 10:47:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x19sm3606048pfn.105.2021.09.30.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 10:47:20 -0700 (PDT)
Date:   Thu, 30 Sep 2021 10:47:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Subject: Re: [RFC PATCH 4/8] powerpc: add CPU field to struct thread_info
Message-ID: <202109301045.15DDDA0B@keescook>
References: <20210914121036.3975026-1-ardb@kernel.org>
 <20210914121036.3975026-5-ardb@kernel.org>
 <CAMj1kXEojbQbNzCP39KT4EzFAyW3J1Tfm_stCZ+fGo8_SO90PA@mail.gmail.com>
 <87ee99lii7.fsf@mpe.ellerman.id.au>
 <87pmst1rn9.fsf@mpe.ellerman.id.au>
 <CAMj1kXFXtbD3=L+QvCnwbyFr-qbWivZ0wRGT0N4LNxANPD8x4g@mail.gmail.com>
 <878rzf0zmb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rzf0zmb.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 30, 2021 at 08:46:04AM +1000, Michael Ellerman wrote:
> Ard Biesheuvel <ardb@kernel.org> writes:
> > On Tue, 28 Sept 2021 at 02:16, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >>
> >> Michael Ellerman <mpe@ellerman.id.au> writes:
> >> > Ard Biesheuvel <ardb@kernel.org> writes:
> >> >> On Tue, 14 Sept 2021 at 14:11, Ard Biesheuvel <ardb@kernel.org> wrote:
> >> >>>
> >> >>> The CPU field will be moved back into thread_info even when
> >> >>> THREAD_INFO_IN_TASK is enabled, so add it back to powerpc's definition
> >> >>> of struct thread_info.
> >> >>>
> >> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> >>
> >> >> Michael,
> >> >>
> >> >> Do you have any objections or issues with this patch or the subsequent
> >> >> ones cleaning up the task CPU kludge for ppc32? Christophe indicated
> >> >> that he was happy with it.
> >> >
> >> > No objections, it looks good to me, thanks for cleaning up that horror :)
> >> >
> >> > It didn't apply cleanly to master so I haven't tested it at all, if you can point me at a
> >> > git tree with the dependencies I'd be happy to run some tests over it.
> >>
> >> Actually I realised I can just drop the last patch.
> >>
> >> So that looks fine, passes my standard quick build & boot on qemu tests,
> >> and builds with/without stack protector enabled.
> >>
> >
> > Thanks.
> >
> > Do you have any opinion on how this series should be merged? Kees Cook
> > is willing to take them via his cross-arch tree, or you could carry
> > them if you prefer. Taking it via multiple trees at the same time is
> > going to be tricky, or take two cycles, with I'd prefer to avoid.
> 
> I don't really mind. If Kees is happy to take it then that's OK by me.
> 
> If Kees put the series in a topic branch based off rc2 then I could
> merge that, and avoid any conflicts.

I've created:

git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/thread_info/cpu

it includes a --no-ff merge commit, which I'm not sure is desirable? Let
me know if I should adjust this, or if Linus will yell about this if I
send him a PR containing a merge commit? I'm not sure what's right here.

Thanks!

-- 
Kees Cook
