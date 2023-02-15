Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002FFC6379F
	for <linux-s390@archiver.kernel.org>; Wed, 15 Feb 2023 13:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBONFU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Feb 2023 08:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBONFT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Feb 2023 08:05:19 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8071C5AF;
        Wed, 15 Feb 2023 05:05:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 140225C0138;
        Wed, 15 Feb 2023 08:05:18 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 08:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676466318; x=1676552718; bh=NzdIn9sEy/
        TdUrl/ZdBVY4dMEk2Tnlph7NyUne+YOMM=; b=kl/EA19HJlIDNFEV5sMsHqgYTD
        FmlSiYGtsM1si6Xo7AfnbewsjK2qzM/exTVK7KRlph5xczdJTxspqQBBiSgDyUar
        0/fSOmeAkWXOKykdvq7ZjBD1IsDSNgHuJMr9jdqrxMZ427iK2YQWYazGyhNarvV+
        rz/pcQHi1wVqtUZnkL8uCj8I88gq6xd2D9S7lmvnrmDM5SQ0W1z+Qb3C6+wYAIM2
        AfuYHCBl3neJoKLQlQN5Mzxky+jYkkG9DLm7gfrh3K+BaB31NxErj+DDl06h26FZ
        Lbk631TihMW1/uvBaERmFnuy7Zo7bE+o4kaGFaECXI9tlwQzxtwDlstkclqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676466318; x=1676552718; bh=NzdIn9sEy/TdUrl/ZdBVY4dMEk2T
        nlph7NyUne+YOMM=; b=Fj3/LiQbjc3zZVeQEFPn1JLksyP6OJKAqEthWeUwUdOy
        k7x0KqWkvb7b77D7xfan3iRDT3xhukpp4mvtLGJE/kVQChQOH1qp0nR/LnBR87Y1
        XDD47Zd1e+ArsjIbVJ2HC/gIqlxwXE9Yv3XVaU+KSxDHebKRD7UtGlZtwkd1DH9P
        2nl2CBlmUDumzN3QpVUsRj24U1jFxVa/Bkw0HG9aN7GFtyhzTAEI6Kui+fW06SlI
        P27LTtLWzSbpaclrnRpKS2BxaaFWBrD0e9YkEyfIAAX4SmnRcQLa6PTiOGSb1f3q
        k2vytFCMGUqoYhQef2Aclc0m2mYrSBprvVoJFASZqQ==
X-ME-Sender: <xms:jdjsYw9m_ZZsFO_5c5Pd1ylgJoL8Dvqk5ZfoTF-Atn-E4YFmoNNuPw>
    <xme:jdjsY4sKYFNbv9Slvsd2ZSvojAln9VwICtxOY-c86ybeStqbcIF2yBlXKQfb3ql0L
    ttVrNZokp4k-e_8mpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:jdjsY2C34QKGBUcu2e31zKraZgxkTcq4-FVgBT8tGLrCPeymxYZjBA>
    <xmx:jdjsYwfAPpbYgwHd2HTJ7aCsxvJvBh-p6_yJabiRCbos57UwQvqpxw>
    <xmx:jdjsY1PR9a2oLnXpZv0k-1MxkAGOxeCMTMxXrfe6yu-vXKU2xBVGFA>
    <xmx:jtjsY2qAv6rV3GNPCdCVMpowNK7FNaJ1cebkCNThGk34_KZ0ObXYMQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 79450B60086; Wed, 15 Feb 2023 08:05:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <f3e1585c-0d9d-4709-9b21-74a63d8cc9ac@app.fastmail.com>
In-Reply-To: <Y+zXIgwO5wteLQZ5@shell.armlinux.org.uk>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-4-alexghiti@rivosinc.com>
 <Y+zXIgwO5wteLQZ5@shell.armlinux.org.uk>
Date:   Wed, 15 Feb 2023 14:04:59 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Russell King" <linux@armlinux.org.uk>,
        "Alexandre Ghiti" <alexghiti@rivosinc.com>
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chris Zankel" <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@rivosinc.com>
Subject: Re: [PATCH v3 03/24] arm: Remove COMMAND_LINE_SIZE from uapi
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 15, 2023, at 13:59, Russell King (Oracle) wrote:
> On Tue, Feb 14, 2023 at 08:49:04AM +0100, Alexandre Ghiti wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>> 
>> As far as I can tell this is not used by userspace and thus should not
>> be part of the user-visible API.
>> 
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> Looks good to me. What's the merge plan for this?

The easiest way is probably if I merge it through the whole
series through the asm-generic tree. The timing is a bit
unfortunate as we're just ahead of the merge window, so unless
we really need this in 6.3, I'd suggest that Alexandre resend
the series to me in two weeks with the Acks added in and I'll
pick it up for 6.4.

     Arnd
