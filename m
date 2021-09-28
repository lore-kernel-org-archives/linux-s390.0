Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E54EC433F5
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 00:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4928E611EF
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 00:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbhI1AR5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbhI1AR4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Sep 2021 20:17:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C246C061575;
        Mon, 27 Sep 2021 17:16:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HJKmX5spJz4xLs;
        Tue, 28 Sep 2021 10:16:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1632788176;
        bh=40Qjcb8alQIKNQ7ovWDvb3uMDNOj6u2mSouvybd+c8U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YE4vK5P9YiusbQolaISGGqbw4MSmlgr0kC9O4dDE4vhOWZ2Fmo0BVq9wmxsDcZ3hV
         W80h/uxllRg+IcULCeIMjbu3sqqPuAPrhZu9NMVfNoCPQsrpi2y4ER2uyYZY/53m0D
         fzEBhgCmKTGrvLM/c7bXFjD8K1vu/5nMylk9VLD1Z2g4eAhWey750rJgPZlLTesnu1
         rIaQj9Am5NVESisHbWmUMdEJgSwf5cPVGlWxWbpytvh99D8VzQKASAnBo3Awc53QqK
         yX8rx2Tk57NXkKKqSY+WGSvevVjmx5jEYC5fZ/F48e11+PeLesWlKR8my9tSeWcRt+
         yTiwhk81hk9gQ==
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
In-Reply-To: <87ee99lii7.fsf@mpe.ellerman.id.au>
References: <20210914121036.3975026-1-ardb@kernel.org>
 <20210914121036.3975026-5-ardb@kernel.org>
 <CAMj1kXEojbQbNzCP39KT4EzFAyW3J1Tfm_stCZ+fGo8_SO90PA@mail.gmail.com>
 <87ee99lii7.fsf@mpe.ellerman.id.au>
Date:   Tue, 28 Sep 2021 10:16:10 +1000
Message-ID: <87pmst1rn9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Ard Biesheuvel <ardb@kernel.org> writes:
>> On Tue, 14 Sept 2021 at 14:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>
>>> The CPU field will be moved back into thread_info even when
>>> THREAD_INFO_IN_TASK is enabled, so add it back to powerpc's definition
>>> of struct thread_info.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>
>> Michael,
>>
>> Do you have any objections or issues with this patch or the subsequent
>> ones cleaning up the task CPU kludge for ppc32? Christophe indicated
>> that he was happy with it.
>
> No objections, it looks good to me, thanks for cleaning up that horror :)
>
> It didn't apply cleanly to master so I haven't tested it at all, if you can point me at a
> git tree with the dependencies I'd be happy to run some tests over it.

Actually I realised I can just drop the last patch.

So that looks fine, passes my standard quick build & boot on qemu tests,
and builds with/without stack protector enabled.

cheers
