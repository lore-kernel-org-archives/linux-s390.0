Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbgCBVVP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Mar 2020 16:21:15 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022LJgDt085911
        for <linux-s390@vger.kernel.org>; Mon, 2 Mar 2020 16:21:13 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yfjf4bwgw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Mar 2020 16:21:13 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 2 Mar 2020 21:21:11 -0000
Date: Mon, 2 Mar 2020 22:21:05 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
 <1583160524.8544.91.camel@linux.ibm.com>
 <CAKv+Gu_E9O05xB7i2Y8KiMJUjtZoq54GxSbHnyTFePcF6fqQNA@mail.gmail.com>
 <1583161018.8544.96.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1583161018.8544.96.camel@linux.ibm.com>
Message-Id: <20200302212105.GH4035@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, linux-integrity <linux-integrity@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-efi <linux-efi@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Mar 02, 2020 at 09:56:58AM -0500, Mimi Zohar wrote:
> On Mon, 2020-03-02 at 15:52 +0100, Ard Biesheuvel wrote:
> > On Mon, 2 Mar 2020 at 15:48, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > index beea77046f9b..cafa66313fe2 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -230,6 +230,7 @@ config X86
> > > >       select VIRT_TO_BUS
> > > >       select X86_FEATURE_NAMES                if PROC_FS
> > > >       select PROC_PID_ARCH_STATUS             if PROC_FS
> > > > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI
> > >
> > > Not everyone is interested in enabling IMA or requiring IMA runtime
> > > policies.  With this patch, enabling IMA_ARCH_POLICY is therefore
> > > still left up to the person building the kernel.  As a result, I'm
> > > seeing the following warning, which is kind of cool.
> > >
> > > WARNING: unmet direct dependencies detected for
> > > IMA_SECURE_AND_OR_TRUSTED_BOOT
> > >   Depends on [n]: INTEGRITY [=3Dy] && IMA [=3Dy] && IMA_ARCH_POLICY [=
=3Dn]
> > >   Selected by [y]:
> > >   - X86 [=3Dy] && EFI [=3Dy]
> > >
> > > Ard, Michael, Martin, just making sure this type of warning is
> > > acceptable before upstreaming this patch.  I would appreciate your
> > > tags.
> > >
> >=20
> > Ehm, no, warnings like these are not really acceptable. It means there
> > is an inconsistency in the way the Kconfig dependencies are defined.
> >=20
> > Does this help:
> >=20
> >   select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI && IMA_ARCH_POLICY
> >=20
> > ?
>=20
> Yes, that's fine for x86. =EF=BF=BDMichael, Martin, do you want something
> similar or would you prefer actually selecting IMA_ARCH_POLICY?

For s390 something like

	select IMA_SECURE_AND_OR_TRUSTED_BOOT if IMA_ARCH_POLICY

should be fine.

Thanks,
Heiko
