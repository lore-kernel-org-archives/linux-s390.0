Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:45462 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728065AbfGNQ0b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 14 Jul 2019 12:26:31 -0400
From: Petr Tesarik <PTesarik@suse.com>
Subject: Re: [PATCH 2/2] s390: add Linux banner to the compressed image
Date: Sun, 14 Jul 2019 15:52:52 +0000
Message-ID: <20190714175041.194c98be@ezekiel.suse.cz>
References: <cover.1562950641.git.ptesarik@suse.com>
        <aa477dd145aa2beb37fe813619b0723744a22a0a.1562950641.git.ptesarik@suse.com>
        <your-ad-here.call-01563114933-ext-9422@work.hours>
In-Reply-To: <your-ad-here.call-01563114933-ext-9422@work.hours>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E90DAA65F4A33468644BAEFA921F303@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Philipp Rudo <prudo@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laura Abbott <labbott@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Raymund Will <rw@suse.com>

On Sun, 14 Jul 2019 16:35:33 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Fri, Jul 12, 2019 at 07:21:01PM +0200, Petr Tesarik wrote:
> > Various tools determine the kernel version from a given binary by
> > scanning for the Linux banner string. This does not work if the
> > banner string is compressed, but we can link it once more into the
> > uncompressed portion of bzImage.
> > 
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >  arch/s390/boot/compressed/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
> > index fa529c5b4486..9bc4685477c5 100644
> > --- a/arch/s390/boot/compressed/Makefile
> > +++ b/arch/s390/boot/compressed/Makefile
> > @@ -11,6 +11,7 @@ UBSAN_SANITIZE := n
> >  KASAN_SANITIZE := n
> >  
> >  obj-y	:= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) piggy.o info.o
> > +obj-y   += ../../../../init/banner.o  
> 
> We don't reuse objects from another build stage, we rebuild them with
> distinct decompressor's build flags.
> $ git grep "ctype.[oc]" -- arch/s390/boot
> arch/s390/boot/Makefile:obj-y   += ctype.o text_dma.o
> arch/s390/boot/ctype.c:#include "../../../lib/ctype.c"

Those flags do not make a difference for a simple object file like the
Linux banner, but I get your point, and I cannot see an issues with
rebuilding the banner for the decompressor.

> Besides that, there is a special CONFIG_KERNEL_UNCOMPRESSED mode, with
> which "strings vmlinuz | grep 'Linux version'" I assume you are using
> would still yield result. Adding the second version of banner would
> produce duplicated result in this case.

Sure, and AFAICT that's not a problem. But the point here is that the
production kernel should be compressed for all those well-known
reasons, but such image is then not recognized.

> But even before discussing solutions I would like to understand the
> problem first. Which specific tools are you referring to? What are they
> good for? And how do they get the kernel version from other architectures
> compressed images?

The tool I'm aware of is called get_kernel_version. It's built as part
of openSUSE aaa_base and is used at install time. I'm not quite sure
how it is used, but I have added Raymund Will to Cc; he can provide
more information. There's also an open bug for it:

  https://bugzilla.opensuse.org/show_bug.cgi?id=1139939

As for other architectures, I only know about x86. The x86 compressed
binary contains a header with various pointers, among them a pointer to
the kernel version string, so it must be added to the decompressor (cf.
arch/x86/boot/version.c).

If you prefer to have a similar header for other architectures, then
that would be fine with me, but it's a bit more involved, because it
would set up a new ABI...

HTH,
Petr T
