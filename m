Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85289C7EE37
	for <linux-s390@archiver.kernel.org>; Fri,  3 Mar 2023 16:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCCQln (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Mar 2023 11:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCCQlk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Mar 2023 11:41:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E819729146;
        Fri,  3 Mar 2023 08:41:23 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F3885C00BD;
        Fri,  3 Mar 2023 11:41:21 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 03 Mar 2023 11:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677861681; x=1677948081; bh=cq
        QZ3RgaXf1BBbVEeoodJ6F1ZwSPMj6A5MLY/vjXzGA=; b=MBSCbCwUd8juCEDzj6
        X+v74NFX7yzWnWb/0gMj34SxPvFz8wyL7gywm5fAIqNKELJdPbh2PYOcHyJ8iqlR
        O8pzmDTMVyBQ9cMZhSKtn6qmb0KnUA81EK1dpH3SIrJLFelykD8o7UZrplrf66L7
        W9mg6q/stuxyiWKAwsz/FuGl0mIzCybvdEWEtwKs8vITdXabH94KVLj/yk4WWaiY
        PkScaQMl3egYObdw/lEOs1KQKTN4G4OIlbK8+qX/IrrGOL8Uq8CSP4LjajDkY11d
        KGKuxzD0Xlm/gwc/z8sKvDkaKXF/dcFxBRwiNzGxIDlYiagYG5UF8qoHNy+mGJFh
        GxRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677861681; x=1677948081; bh=cqQZ3RgaXf1BB
        bVEeoodJ6F1ZwSPMj6A5MLY/vjXzGA=; b=UVgk6Z8BckmZDASnwvaGoQorgyUq2
        pQEk7FSlPDa2e+Q6rFx7ZTuIeUij7y9Rrf9Jgh1cpCMAjevycM9AKxSI61k/v8pu
        5BgUmz43ShLEMosBdymSqmoT4llAbJWhUPur9BqQ+EvwN+g9cxgv0PSoeVrl3u/u
        zIloXjwNhKZwaJsdydfOwKJuRZYRnqEYNX9CUSOueTYvicXxGcaESX9Qxxhz2q7S
        y23I9CLQUnUCpw4C2ZRx4HGFKdPKZ3KpejAaTVQ+9VLjziJILZV7r4FYif1Od77P
        LCKDNeAD2rne62GXKt9BQv1wGyqBG0OLRFWwu3Fv7ICn92s37LvtH/j/w==
X-ME-Sender: <xms:MCMCZJAuWXjkvRapyHeNiOF30z0WZtCT2IUSh_DGzagx2t_9BoAGgA>
    <xme:MCMCZHhPhHJnQj7Jd9oDbBHLtdzlJQj6AQmaaUj1cJd5hx3-3fWQpnUe6W9Ais0gn
    IpB2WEfan7YoF3bQKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:MCMCZEn-u-vskm94MHqpwMb6efig7zWWVGLLDko7WXr67x0p1FHB0w>
    <xmx:MCMCZDxHsEO9oVcr-nwuh4K7Kk2bkAquoIbrRSs8lGUcL3kT4X9SJA>
    <xmx:MCMCZOQAoiH6g-an3IU4R8457T0ch4BofH0kMra3K7DfWRtLBv8Gbg>
    <xmx:MSMCZMdBiQQ4uXlsrvlAy8QwxkZd7eA3C2X8F_mN_fKZzwhl1Hermg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9A291B60086; Fri,  3 Mar 2023 11:41:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <c500840b-b57d-47f2-a3d9-41465b10ffae@app.fastmail.com>
In-Reply-To: <674bc31e-e4ed-988f-820d-54213d83f9c7@ghiti.fr>
References: <mhng-e8b09772-24e5-4729-a0bf-01a9e4c76636@palmer-ri-x1c9a>
 <21F95EC4-71EA-4154-A7DC-8A5BA54F174B@zytor.com>
 <674bc31e-e4ed-988f-820d-54213d83f9c7@ghiti.fr>
Date:   Fri, 03 Mar 2023 17:40:46 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexandre Ghiti" <alex@ghiti.fr>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Heiko Carstens" <hca@linux.ibm.com>
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Alexandre Ghiti" <alexghiti@rivosinc.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, gor@linux.ibm.com,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, "Sven Schnelle" <svens@linux.ibm.com>,
        ysato@users.osdn.me, "Rich Felker" <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        chris@zankel.net, "Max Filippov" <jcmvbkbc@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 00/24] Remove COMMAND_LINE_SIZE from uapi
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Mar 3, 2023, at 12:59, Alexandre Ghiti wrote:
> On 3/2/23 20:50, H. Peter Anvin wrote:
>> On March 1, 2023 7:17:18 PM PST, Palmer Dabbelt <palmer@dabbelt.com> wrote:

>>>>> Commit 622021cd6c560ce7 ("s390: make command line configurable"),
>>>>> I assume?
>>>> Yes, sorry for that. I got distracted while writing and used the wrong
>>>> branch to look this up.
>>> Alex: Probably worth adding that to the list in the cover letter as it looks like you were planning on a v4 anyway (which I guess you now have to do, given that I just added the issue to RISC-V).
>> The only use that is uapi is the *default* length of the command line if the kernel header doesn't include it (in the case of x86, it is in the bzImage header, but that is atchitecture- or even boot format-specific.)
>
> Is COMMAND_LINE_SIZE what you call the default length? Does that mean 
> that to you the patchset is wrong?

On x86, the COMMAND_LINE_SIZE value is already not part of a uapi header,
but instead (since bzImage format version 2.06) is communicated from
the kernel to the boot loader, which then knows how much data the
kernel will read (at most) from the command line.

Most x86 kernels these days are booted using UEFI, which I think has
no such interface, the firmware just passes the command line and a
length, but has no way of knowing if the kernel will truncate this.
I think that is the same as with any other architecture that passes
the command line through UEFI, DT or ATAGS, all of which use
length/value pairs.

Russell argued on IRC that this can be considered an ABI since a
boot loader may use its knowledge of the kernel's command line size
limit to reject long command lines. On the other hand, I don't
think that any boot loader actually does, they just trust that it
fits and don't have a good way of rejecting invalid configuration
other than truncating and/or warning.

One notable exception I found while looking through is the old
(pre-ATAGS) parameter structure on Arm, which uses COMMAND_LINE_SIZE
as part of the structure definition. Apparently this was deprecated
22 years ago, so hopefully the remaining riscpc and footbridge
users have all upgraded their bootloaders.

The only other case I could find that might go wrong is
m68knommu with a few files copying a COMMAND_LINE_SIZE sized
buffer from flash into a kernel buffer:

arch/m68k/coldfire/m5206.c:void __init config_BSP(char *commandp, int size)
arch/m68k/coldfire/m5206.c-{
arch/m68k/coldfire/m5206.c-#if defined(CONFIG_NETtel)
arch/m68k/coldfire/m5206.c-     /* Copy command line from FLASH to local buffer... */
arch/m68k/coldfire/m5206.c-     memcpy(commandp, (char *) 0xf0004000, size);
arch/m68k/coldfire/m5206.c-     commandp[size-1] = 0;
arch/m68k/coldfire/m5206.c-#endif /* CONFIG_NETtel */

     Arnd
