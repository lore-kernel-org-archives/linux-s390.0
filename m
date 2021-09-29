Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D63AC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 29 Sep 2021 23:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752FB6124F
	for <linux-s390@archiver.kernel.org>; Wed, 29 Sep 2021 23:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347474AbhI2XMJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347525AbhI2XMI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 29 Sep 2021 19:12:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4AC061768
        for <linux-s390@vger.kernel.org>; Wed, 29 Sep 2021 16:10:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 133so4320108pgb.1
        for <linux-s390@vger.kernel.org>; Wed, 29 Sep 2021 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aI/ouOII6CJjBOkddynqFqEUpoEDYOKQCNZi7fDl2EE=;
        b=VSQ018jC6qTgHIau1QRTnTodwijVCmralRN9fgDiBIeacF49JRsX9nwdaRGov2W45Z
         Wy+M5+L4KO+HmwabrN4YtS8Cl9AyP2CMw+UiJRSYwHlncurAgHBGnkAiyjiSOeVQBWSa
         ikc6wX7yBW/i3FUnCULlToPllc9632H2aOQSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aI/ouOII6CJjBOkddynqFqEUpoEDYOKQCNZi7fDl2EE=;
        b=vMMJLrFC+pT/ln3bP8NgWkVUaE5xhsJTsjvAzxG4Dbfb8VMXYTRyxYVrs8YyDknRoV
         CR/Jz6XzV6CIBphzn70eD1m84LbBIxyOz6L22TmvC6EdBlGUdrL7MlUkzdkcbdY68LdG
         n3upwauBbmUgGyxO82qGQGDYnOoiXYM7EYozu6lEtFpQH6vGHXbnIJGJTXZ+wHleLKKh
         rG1FmJF6N02ee7m6NWfKStsEQNbrxh5jYzx33Es/Eq8f+DkH1tWHA+9KoCxZ2y4Fqjx+
         /BZ0RsLK1pMauxrz9srn1Jc35dgFSIsQSgh5PI0xZcPIeQNMctzx/LeEg4urS3Yd4qy+
         d8KQ==
X-Gm-Message-State: AOAM531MA+ICPv8xoxorH3P7W8xYZ83eZOWYPsaMqLheXAogoDJ8ZAMF
        oWdHumda+ZuArTiPmlek2Fe3dQ==
X-Google-Smtp-Source: ABdhPJzdhyqm0dfgODuwIED6/X8gNqLcW4VX+6LUmwnQa2guV3xeth3+9Or0kqN52antddtK95SaVQ==
X-Received: by 2002:a65:6389:: with SMTP id h9mr2112359pgv.83.1632957025919;
        Wed, 29 Sep 2021 16:10:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f16sm602774pjj.56.2021.09.29.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 16:10:25 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:10:24 -0700
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
Message-ID: <202109291609.BC02B39AFF@keescook>
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

If that helps, yeah, I can make a separate stable branch. Thanks!

-Kees

-- 
Kees Cook
