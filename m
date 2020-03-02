Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:59481 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgCBXYD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Mar 2020 18:24:03 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
In-Reply-To: <1583161018.8544.96.camel@linux.ibm.com>
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com> <1583160524.8544.91.camel@linux.ibm.com> <CAKv+Gu_E9O05xB7i2Y8KiMJUjtZoq54GxSbHnyTFePcF6fqQNA@mail.gmail.com> <1583161018.8544.96.camel@linux.ibm.com>
Date: Tue, 03 Mar 2020 10:23:59 +1100
Message-ID: <87lfois5m8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: Nayna Jain <nayna@linux.ibm.com>, linux-integrity <linux-integrity@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-efi <linux-efi@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Mimi Zohar <zohar@linux.ibm.com> writes:
> On Mon, 2020-03-02 at 15:52 +0100, Ard Biesheuvel wrote:
>> On Mon, 2 Mar 2020 at 15:48, Mimi Zohar <zohar@linux.ibm.com> wrote:
>> >
>> > On Wed, 2020-02-26 at 14:10 -0500, Nayna Jain wrote:
>> > > Every time a new architecture defines the IMA architecture specific
>> > > functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the=
 IMA
>> > > include file needs to be updated. To avoid this "noise", this patch
>> > > defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, all=
owing
>> > > the different architectures to select it.
>> > >
>> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> > > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
>> > > Cc: Ard Biesheuvel <ardb@kernel.org>
>> > > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> > > Cc: Philipp Rudo <prudo@linux.ibm.com>
>> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
>> > > ---
>> > >  arch/powerpc/Kconfig           | 2 +-
>> > >  arch/s390/Kconfig              | 1 +
>> > >  arch/x86/Kconfig               | 1 +
>> > >  include/linux/ima.h            | 3 +--
>> > >  security/integrity/ima/Kconfig | 9 +++++++++
>> > >  5 files changed, 13 insertions(+), 3 deletions(-)
>> > >
>> > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> > > index 497b7d0b2d7e..b8ce1b995633 100644
>> > > --- a/arch/powerpc/Kconfig
>> > > +++ b/arch/powerpc/Kconfig
>> > > @@ -246,6 +246,7 @@ config PPC
>> > >       select SYSCTL_EXCEPTION_TRACE
>> > >       select THREAD_INFO_IN_TASK
>> > >       select VIRT_TO_BUS                      if !PPC64
>> > > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT   if PPC_SECURE_BOOT
>> > >       #
>> > >       # Please keep this list sorted alphabetically.
>> > >       #
>> > > @@ -978,7 +979,6 @@ config PPC_SECURE_BOOT
>> > >       prompt "Enable secure boot support"
>> > >       bool
>> > >       depends on PPC_POWERNV
>> > > -     depends on IMA_ARCH_POLICY
>> > >       help
>> > >         Systems with firmware secure boot enabled need to define sec=
urity
>> > >         policies to extend secure boot to the OS. This config allows=
 a user
>> > > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> > > index 8abe77536d9d..90ff3633ade6 100644
>> > > --- a/arch/s390/Kconfig
>> > > +++ b/arch/s390/Kconfig
>> > > @@ -195,6 +195,7 @@ config S390
>> > >       select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>> > >       select SWIOTLB
>> > >       select GENERIC_ALLOCATOR
>> > > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT
>> > >
>> > >
>> > >  config SCHED_OMIT_FRAME_POINTER
>> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> > > index beea77046f9b..cafa66313fe2 100644
>> > > --- a/arch/x86/Kconfig
>> > > +++ b/arch/x86/Kconfig
>> > > @@ -230,6 +230,7 @@ config X86
>> > >       select VIRT_TO_BUS
>> > >       select X86_FEATURE_NAMES                if PROC_FS
>> > >       select PROC_PID_ARCH_STATUS             if PROC_FS
>> > > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI
>> >
>> > Not everyone is interested in enabling IMA or requiring IMA runtime
>> > policies.  With this patch, enabling IMA_ARCH_POLICY is therefore
>> > still left up to the person building the kernel.  As a result, I'm
>> > seeing the following warning, which is kind of cool.
>> >
>> > WARNING: unmet direct dependencies detected for
>> > IMA_SECURE_AND_OR_TRUSTED_BOOT
>> >   Depends on [n]: INTEGRITY [=3Dy] && IMA [=3Dy] && IMA_ARCH_POLICY [=
=3Dn]
>> >   Selected by [y]:
>> >   - X86 [=3Dy] && EFI [=3Dy]
>> >
>> > Ard, Michael, Martin, just making sure this type of warning is
>> > acceptable before upstreaming this patch.  I would appreciate your
>> > tags.
>> >
>>=20
>> Ehm, no, warnings like these are not really acceptable. It means there
>> is an inconsistency in the way the Kconfig dependencies are defined.
>>=20
>> Does this help:
>>=20
>>   select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI && IMA_ARCH_POLICY
>>=20
>> ?
>
> Yes, that's fine for x86. =C2=A0Michael, Martin, do you want something
> similar or would you prefer actually selecting IMA_ARCH_POLICY?

For powerpc this should be all we need:

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 497b7d0b2d7e..a5cfde432983 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -976,12 +976,13 @@ config PPC_MEM_KEYS
=20
 config PPC_SECURE_BOOT
 	prompt "Enable secure boot support"
 	bool
 	depends on PPC_POWERNV
 	depends on IMA_ARCH_POLICY
+	select IMA_SECURE_AND_OR_TRUSTED_BOOT
 	help
 	  Systems with firmware secure boot enabled need to define security
 	  policies to extend secure boot to the OS. This config allows a user
 	  to enable OS secure boot on systems that have firmware support for
 	  it. If in doubt say N.
=20

cheers
