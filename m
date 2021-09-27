Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037D5C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 23:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E69611BD
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 23:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhI0XPI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:15:08 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:59197 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhI0XPH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Sep 2021 19:15:07 -0400
X-Greylist: delayed 36081 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2021 19:15:07 EDT
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HJJN212Dmz4xVP;
        Tue, 28 Sep 2021 09:13:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1632784407;
        bh=CSBhgRacMH4wdNz2+6sz+UADE1Z/+Rt10XRo6G7F4qc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SpP9Ag4cak7uAXRzz2oEmCUoFYobVM1YDaU7H2umvim4BfissG2tOopwTVM+QWkPz
         ghgj6oLQBTg5oDf2NWjGYSmE9cyVG2OnhS4PGKCG0kZdLg1y7LnWfeAAXywPMS731F
         QZkED7zLRXNCfN+p5XJsCb/mEfuBMhjK0vBM2M/FronydUaFEXBcGAzRon4NUZDdUi
         c5+mvpDKJwLSK8UzkrhrUYXZtS7fX7Bjmd8BdVkDlYlrHSSNC7PnfeGdU05fUui1SA
         nmOZ+MwplIXOJUwftG2odSSkbquxMriRVgTLz1E8nWEaxVgFqlAtsezQzR2t7KNQX7
         ksfYi+D9EIhBA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Keith Packard <keithpac@amazon.com>,
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
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Subject: Re: [RFC PATCH 4/8] powerpc: add CPU field to struct thread_info
In-Reply-To: <CAMj1kXEojbQbNzCP39KT4EzFAyW3J1Tfm_stCZ+fGo8_SO90PA@mail.gmail.com>
References: <20210914121036.3975026-1-ardb@kernel.org>
 <20210914121036.3975026-5-ardb@kernel.org>
 <CAMj1kXEojbQbNzCP39KT4EzFAyW3J1Tfm_stCZ+fGo8_SO90PA@mail.gmail.com>
Date:   Tue, 28 Sep 2021 09:13:20 +1000
Message-ID: <87ee99lii7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:
> On Tue, 14 Sept 2021 at 14:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> The CPU field will be moved back into thread_info even when
>> THREAD_INFO_IN_TASK is enabled, so add it back to powerpc's definition
>> of struct thread_info.
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Michael,
>
> Do you have any objections or issues with this patch or the subsequent
> ones cleaning up the task CPU kludge for ppc32? Christophe indicated
> that he was happy with it.

No objections, it looks good to me, thanks for cleaning up that horror :)

It didn't apply cleanly to master so I haven't tested it at all, if you can point me at a
git tree with the dependencies I'd be happy to run some tests over it.

cheers
