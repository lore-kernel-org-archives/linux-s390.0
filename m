Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0613EC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 16 Feb 2022 17:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiBPRXW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:23:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiBPRXU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Feb 2022 12:23:20 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 09:23:07 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6E1D0051;
        Wed, 16 Feb 2022 09:23:07 -0800 (PST)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3K9E-1oKhju2rbe-010MBe; Wed, 16 Feb 2022 18:18:00 +0100
Received: by mail-wm1-f43.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso2141534wmj.2;
        Wed, 16 Feb 2022 09:18:00 -0800 (PST)
X-Gm-Message-State: AOAM5325pPJDChl3bxB7oFWlHQyjJXdwXW3Io6YScXDMD+1vXwKQgcKw
        UfRqpSqoOPsuREMwUgAVkuGd8tNq63O/5sTzPVc=
X-Google-Smtp-Source: ABdhPJyc/mWw7BZcqDmPeOb0/9e0zsIX4UzDnjikuc6xYXH+Y45DLjEbP22nAVw01wqU4hWYYZzBcFWGXH0CiAOKTKo=
X-Received: by 2002:a1c:21c5:0:b0:37d:40d0:94c7 with SMTP id
 h188-20020a1c21c5000000b0037d40d094c7mr2504948wmh.1.1645031880257; Wed, 16
 Feb 2022 09:18:00 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
 <YgtQkjRe7fbXI/lS@infradead.org> <alpine.DEB.2.21.2202150901170.34636@angie.orcam.me.uk>
 <Yg0YHHk7NVWjedgn@infradead.org> <alpine.DEB.2.21.2202161631020.34636@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2202161631020.34636@angie.orcam.me.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Feb 2022 18:17:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3F4x6XX9oZG+6L6NDYOMWv5O-vr2dN6=VF0SLGJzPMLQ@mail.gmail.com>
Message-ID: <CAK8P3a3F4x6XX9oZG+6L6NDYOMWv5O-vr2dN6=VF0SLGJzPMLQ@mail.gmail.com>
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0J4CkhRYRqmiNQDhtOXHNB5hJvR2kCEpr3fA06jnXgfco5wfpvD
 OWbR5p9X0MypMklaJkEeJx1YEW/QFwaPIWR9OhEofYOU8MGKl7UmLna2KlsX58zdZhn/1zL
 D4xakeWESeF7dNfdNDghbba/up3qASvGL4n/DHXf7K3Jk69tqa6h/ddtrsNj2b2O0WmawhC
 gUCCNvrurenqSPAvOalgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mxTjeh7cw0k=:YdMqR9xU21uqF0WHwfS9DG
 pv4lmaFk/0ek8xbZNXqeMW7Bq2Js36Y2Yq9B38aiXdJw15r0AAN2LSG3h+Z2ZRL01SqATaNfG
 U9tPqm2Lp5QATG97dLAQYF5orX+lJfhhpA4CKuPJmcwQ2sv37PBuHZJEMYvPXLj19P7C4NHma
 Dio+ivY8tpFtGZqwDYPsdL4/hQWv4WLwW1Ex/g/BG245qyO/BHZiXAi5zgAVb4HQBacxInNoj
 Ya6AarY6QZYNsZ3cO2ijN1rXNExs+9hElH6hE3q7x7e162LNGw5/iMfZaSvo9M6RcPHbvcuG2
 eCQfoO4Ms15eeDB3J5UbIsQYwk4jfVRCbdUENWWO/5rWUeUv2VGoyp5FzRTL3Yv38GmURJAnP
 C9ZOYo6AjpuTYbIDjVx3/CGKWTKGShdgvQnriWLbuhrKQnW07SFScE72WqFxLDTGEXpQ98rIb
 eP81dXmcZw5cjR+GOG14A2yT8niv2tdZa4WJ0+I+8NWcWthkNS7TaswgfXMm/6tpSJu+YAaw5
 SV4ubkn/eS7NTsgG05S0FCM/RX3f/jizvJwQ/lNvwsEkOKc7i6B/eFetKMI1ch+XKwBjITerk
 NXCnOG00bBm3Rt0bJCJG05TO+OIrDscjDpTtXmPWtobBo6D6mxe7yR6LDOfEzHsJB4JN3aoCG
 0Low45QinS1jtTBjlTEXxkquQAug6BLjXFg2EnRQcrpIXwoR8UVAHp50ngMFbLyEfX8RMGFHX
 Sd0Okpm+j9CJG9/0/13LgvGjuVEGfxc8E6GEDoKLVI/Ilu49sOiwjlF1xEpbwsaZOmoUKxV8h
 EgzDcmlVYHFHbeBHrRaOd5+Zkj7Az8B3uKnDiZ6llHomIkc2CtmT8K5owiwSZ2DwQvO/1heUf
 XhhyUz6tubm/TEPfPQawLSmQhruT+VQnga3bRiFKVeG6glg4o25eXMAhQjd/HeeEh1z2jFdcC
 N4jHAROxkyA==
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 16, 2022 at 5:35 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Wed, 16 Feb 2022, Christoph Hellwig wrote:
>
> > > > Instead of adding generic-y just ad a mandatory-y in
> > > > include/asm-generic/Kbuild.
> > >
> > >  I'm inconvinced.  Not all archs want it, 5 don't.
> >
> > Which is exactly what mandatory-y is for.  Provide the asm-generic
> > version by default, but let architectures override it.
>
>  I don't think so.  Those 5 architectures don't want it at all; 7 other
> ones have their own versions.
>
>  Otherwise we could blanket-list all asm-generic headers as mandatory-y.

I think ideally the PCI driver should be a separate file from the rest, or
possibly it could get split up even further.

parport_pc_probe_port()/parport_pc_unregister_port() are already exported
by the driver and used by some of the front-ends. The parport_pc_pci_driver
looks like it could easily go into one file using module_pci_driver(), while
the platform driver stays in the existing file and the legacy detection logic
goes into a third one. The powerpc and sparc versions could technically
also be separate drivers, but I wouldn't take the rework that far.

       Arnd
