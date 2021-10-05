Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63FBC433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 01:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3306610A3
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 01:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhJEB5b (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Oct 2021 21:57:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:60133 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhJEB53 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Oct 2021 21:57:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HNgdx17Hfz4xbX;
        Tue,  5 Oct 2021 12:55:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1633398938;
        bh=gYlu6Qv+8m83iP3aG7acEoyr8D3DPbZlTHZ8jerl4Jw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oI6DgPAmrS6eid+iQKQamhFupmXA2CScxqKHRX+CJjC8/0fF1BV9+LamvP9D9eSE9
         npjDtMfC1MNcKzde3tkhkeuyG4S9CqgWI+LezmFwIFfQSxbUaY4NuejzURphht7FGp
         ek1oZ95ogFF9mgsmHq93KfvqDA7s9lg+SefS7Uu4jQH2xweVqk/OBZLY5w4Y8cz5FF
         jyvaNEhNFclinElquxf3fKJ2na1IGJxwQje4Hg2exFycrlUGHsDHKTaqoiruy7a9vc
         DhFa9QFOiNLbuIgQmTX/jgFIHs3lgRjeXXAezx290U6sPOlbkpQN1FwNvR9TVFpWGR
         ggckHw/xPBG0Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>
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
In-Reply-To: <202109301045.15DDDA0B@keescook>
References: <20210914121036.3975026-1-ardb@kernel.org>
 <20210914121036.3975026-5-ardb@kernel.org>
 <CAMj1kXEojbQbNzCP39KT4EzFAyW3J1Tfm_stCZ+fGo8_SO90PA@mail.gmail.com>
 <87ee99lii7.fsf@mpe.ellerman.id.au> <87pmst1rn9.fsf@mpe.ellerman.id.au>
 <CAMj1kXFXtbD3=L+QvCnwbyFr-qbWivZ0wRGT0N4LNxANPD8x4g@mail.gmail.com>
 <878rzf0zmb.fsf@mpe.ellerman.id.au> <202109301045.15DDDA0B@keescook>
Date:   Tue, 05 Oct 2021 12:55:31 +1100
Message-ID: <87ilycqlpo.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Thu, Sep 30, 2021 at 08:46:04AM +1000, Michael Ellerman wrote:
>> Ard Biesheuvel <ardb@kernel.org> writes:
>> > On Tue, 28 Sept 2021 at 02:16, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> >>
>> >> Michael Ellerman <mpe@ellerman.id.au> writes:
>> >> > Ard Biesheuvel <ardb@kernel.org> writes:
>> >> >> On Tue, 14 Sept 2021 at 14:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>> >> >>>
>> >> >>> The CPU field will be moved back into thread_info even when
>> >> >>> THREAD_INFO_IN_TASK is enabled, so add it back to powerpc's definition
>> >> >>> of struct thread_info.
>> >> >>>
>> >> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> >> >>
>> >> >> Michael,
>> >> >>
>> >> >> Do you have any objections or issues with this patch or the subsequent
>> >> >> ones cleaning up the task CPU kludge for ppc32? Christophe indicated
>> >> >> that he was happy with it.
>> >> >
>> >> > No objections, it looks good to me, thanks for cleaning up that horror :)
>> >> >
>> >> > It didn't apply cleanly to master so I haven't tested it at all, if you can point me at a
>> >> > git tree with the dependencies I'd be happy to run some tests over it.
>> >>
>> >> Actually I realised I can just drop the last patch.
>> >>
>> >> So that looks fine, passes my standard quick build & boot on qemu tests,
>> >> and builds with/without stack protector enabled.
>> >>
>> >
>> > Thanks.
>> >
>> > Do you have any opinion on how this series should be merged? Kees Cook
>> > is willing to take them via his cross-arch tree, or you could carry
>> > them if you prefer. Taking it via multiple trees at the same time is
>> > going to be tricky, or take two cycles, with I'd prefer to avoid.
>> 
>> I don't really mind. If Kees is happy to take it then that's OK by me.
>> 
>> If Kees put the series in a topic branch based off rc2 then I could
>> merge that, and avoid any conflicts.
>
> I've created:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/thread_info/cpu
>
> it includes a --no-ff merge commit, which I'm not sure is desirable? Let
> me know if I should adjust this, or if Linus will yell about this if I
> send him a PR containing a merge commit? I'm not sure what's right here.

It looks good to me.

I don't think Linus will be bothered about that merge. It has useful
information, ie. explains why you're merging it and that arch
maintainers have acked it, and quotes Ard's cover letter.

cheers
