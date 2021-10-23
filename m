Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0DCC433F5
	for <linux-s390@archiver.kernel.org>; Sat, 23 Oct 2021 16:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1414360F9E
	for <linux-s390@archiver.kernel.org>; Sat, 23 Oct 2021 16:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhJWQHf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 23 Oct 2021 12:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhJWQHe (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 23 Oct 2021 12:07:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51A1E6109E;
        Sat, 23 Oct 2021 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635005115;
        bh=a0FullCysk1UJY/SuwNW+JkwKz1DX5zFsZR7u65jCCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YcA0X7ZJT9KPq++0vy4Zc9YPjW55ngCXT3XYqy0oc0V32YWSyFzKjWH46Wfk6JUB6
         PCIDwfEBeDkcsFDGtdhqthdSSccuQ4eBo6P/LqmrXl9bChhrw5voAlYoYh7iNIzAji
         I/i5bgtEUMvO3AEqG3qlH4MZ1DNT15pXqUIREZ0Yj9fWIMtdEKWa5Dl0hx2Av4mXBx
         aZYfYYaL5Ja4lDViVX9MnZlv3E1cOX3kebEmYI6h4HSEkK5Cu3dI3EbNPUElSQ0S/m
         arVBv2qit0AEO2JDL2ItsVAj0xcsKg0bg0oX/nPHGUknfGsiTy2YfqGtAARZUCZBYT
         WlW6qCwcUiNFA==
Received: by mail-wm1-f43.google.com with SMTP id 193-20020a1c01ca000000b00327775075f7so7440134wmb.5;
        Sat, 23 Oct 2021 09:05:15 -0700 (PDT)
X-Gm-Message-State: AOAM53104sgHT455SKw/nCLQ+2DmR7UQH8Q0rOPpZBlfJr0HxHgiM5nl
        PG6STbi3Srwj7X7BDwhMJA7ar3RAApKwyU2XHuc=
X-Google-Smtp-Source: ABdhPJzw9bHMXdBR8sTpnXzuM1z62QqWWvXCArLgXmJmvR/CFzjvKRNvYnRPFIYed1aqogH5ms1MCPnMvzTwp0uq874=
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr36618604wmq.82.1635005113773;
 Sat, 23 Oct 2021 09:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211022120058.1031690-1-arnd@kernel.org> <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
In-Reply-To: <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 23 Oct 2021 18:04:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
Message-ID: <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
Subject: Re: [PATCH] locking: remove spin_lock_flags() etc
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Oct 23, 2021 at 3:37 AM Waiman Long <longman@redhat.com> wrote:
>> On 10/22/21 7:59 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > As this is all dead code, just remove it and the helper functions built
> > around it. For arch/ia64, the inline asm could be cleaned up, but
> > it seems safer to leave it untouched.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Does that mean we can also remove the GENERIC_LOCKBREAK config option
> from the Kconfig files as well?

 I couldn't figure this out.

What I see is that the only architectures setting GENERIC_LOCKBREAK are
nds32, parisc, powerpc, s390, sh and sparc64, while the only architectures
implementing arch_spin_is_contended() are arm32, csky and ia64.

The part I don't understand is whether the option actually does anything
useful any more after commit d89c70356acf ("locking/core: Remove break_lock
field when CONFIG_GENERIC_LOCKBREAK=y").

      Arnd
