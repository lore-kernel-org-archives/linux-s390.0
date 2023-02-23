Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56926C636D6
	for <linux-s390@archiver.kernel.org>; Thu, 23 Feb 2023 09:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjBWJyv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjBWJyl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Feb 2023 04:54:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DD134308
        for <linux-s390@vger.kernel.org>; Thu, 23 Feb 2023 01:54:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so7661354wmc.5
        for <linux-s390@vger.kernel.org>; Thu, 23 Feb 2023 01:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mAI7GZiBb7iDC4DRNXr8MXcTGzYlBwIWTXO3a37K9fA=;
        b=6rqEsmJobKimBOx+ObGs4Y9oYCoGGA+7PUJSCUc+XzhAJr7k8trhGNeL9l///zHG9h
         zKi4GFdApLZMJxwwGKyAK5T4vZVP0aQ3XXyt/OWPp5oueU3BzBJzSR5QoLC+/Xx2iJgz
         5hm79+32XzmlSgEMuCRgCF6jE20gfyjKVSWE2hFVc6aKlMZQREWTRqXyzaVmSBj/MhzH
         AXlVDuu21E6Hjr/kwbOkk278Lu43ZitZTQ7OHZU1h8q5OpD5tJY9ufRMnPPJf2Rq79nz
         v4bZ2eQSQps7BpX5yAyoX5mS+40xRdAoLwhab6GQ6F1yPaND58wp3xipYKvUJEcT++Q8
         E7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAI7GZiBb7iDC4DRNXr8MXcTGzYlBwIWTXO3a37K9fA=;
        b=DZeszvG+tiB7dcPtKN1sMoo4mGH5GRc8RZPFc46V2RmVpV52lL/O813ZYRmf0ke6vi
         MRbutFnUaiMOWji2br1a9b68cjQVZXUYrj1X3W+/vMSzKt0V4obH7rz5m9FrW+OY728u
         yaizYunylISS52VR+hL3+4upo7/ibO+jZHQcE1R6z02FyigLknvyGXwUn4YH1CntLPEF
         p8djMxXmgTFzD83ZhxUgJltrVoeOhDTwOaPrFeHe5q2MLTd6rVC0Ery9D7nPsA8vbAky
         8P1H7zYBl3SyxS6xhF6YmlLClNl8gY235RJYQ/jP2HCvY0TXySBiLiUmdf8R9/Jk852b
         9/6w==
X-Gm-Message-State: AO0yUKXBcgtcifLNRpBIn/PG1+mUiCg3r+FME92UD4b9X5nIvW4VELnd
        i7EHyQXJ/28BBCcbEGMeXRqNkVNdtUjICPT4vylO7A==
X-Google-Smtp-Source: AK7set+bh83ESZvs/5JP0HBfjTnQ76DE1v1RkcKyYbYV7gCfY3t7LNoC9ir4Jaga+QNOEzC6TCzSn38PMw2DLd3UjM4=
X-Received: by 2002:a05:600c:3b9c:b0:3df:df03:45be with SMTP id
 n28-20020a05600c3b9c00b003dfdf0345bemr826148wms.7.1677146076791; Thu, 23 Feb
 2023 01:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-4-alexghiti@rivosinc.com> <Y+zXIgwO5wteLQZ5@shell.armlinux.org.uk>
 <f3e1585c-0d9d-4709-9b21-74a63d8cc9ac@app.fastmail.com>
In-Reply-To: <f3e1585c-0d9d-4709-9b21-74a63d8cc9ac@app.fastmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 23 Feb 2023 10:54:26 +0100
Message-ID: <CAHVXubgsvjxGbgM6AcxfsHDsHT0iL2pAemGMr5t8KVLKiqC3RA@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] arm: Remove COMMAND_LINE_SIZE from uapi
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Arnd,

On Wed, Feb 15, 2023 at 2:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 15, 2023, at 13:59, Russell King (Oracle) wrote:
> > On Tue, Feb 14, 2023 at 08:49:04AM +0100, Alexandre Ghiti wrote:
> >> From: Palmer Dabbelt <palmer@rivosinc.com>
> >>
> >> As far as I can tell this is not used by userspace and thus should not
> >> be part of the user-visible API.
> >>
> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > Looks good to me. What's the merge plan for this?
>
> The easiest way is probably if I merge it through the whole
> series through the asm-generic tree. The timing is a bit
> unfortunate as we're just ahead of the merge window, so unless
> we really need this in 6.3, I'd suggest that Alexandre resend
> the series to me in two weeks with the Acks added in and I'll
> pick it up for 6.4.

Sorry for the response delay, I was waiting to see if Palmer would
merge my KASAN patchset in 6.3 (which he does): I have to admit that
fixing the command line size + the KASAN patchset would allow 6.3 to
run on syzkaller, which would be nice.

If I don't see this merged in 6.3, I'll send another round as you
suggested in 1 week now :)

Thanks!

Alex

>
>      Arnd
