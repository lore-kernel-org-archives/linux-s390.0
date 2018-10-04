From: Leonardo Bras <leobras.c@gmail.com>
Subject: Re: [PATCH v3 5/7] drivers: s390: Avoids building drivers if ARCH is
 not s390.
Date: Wed, 3 Oct 2018 22:00:49 -0300
Message-ID: <CADvQ+rHDB390FWW5cPrmJqDobkv-R2K1B7-potVtTLp0RfUS-Q@mail.gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com> <20180928020816.11251-6-leobras.c@gmail.com>
 <20181001124617.GA3185@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001124617.GA3185@osiris>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 1, 2018 at 9:46 AM Heiko Carstens <heiko.carstens@de.ibm.com> w=
rote:
>
> On Thu, Sep 27, 2018 at 11:08:14PM -0300, Leonardo Br=C3=A1s wrote:
> > Avoids building s390 drivers if 'make drivers/s390/' is called but
> > ARCH is not s390.
> >
> > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > ---
> >  drivers/s390/Makefile | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/s390/Makefile b/drivers/s390/Makefile
> > index a863b0462b43..0575f02dba45 100644
> > --- a/drivers/s390/Makefile
> > +++ b/drivers/s390/Makefile
> > @@ -3,7 +3,7 @@
> >  # Makefile for the S/390 specific device drivers
> >  #
> >
> > -obj-y +=3D cio/ block/ char/ crypto/ net/ scsi/ virtio/
> > -
> > -drivers-y +=3D drivers/s390/built-in.a
> > -
> > +ifeq ($(ARCH),s390)
> > +     obj-y +=3D cio/ block/ char/ crypto/ net/ scsi/ virtio/
> > +     drivers-y +=3D drivers/s390/built-in.a
> > +endif
>
> And then somebody wants to build with e.g. "make drivers/s390/cio/" and i=
t
> still doesn't work. So _if_ this should be supported then it should work
> with all directory levels and all configuration options. Otherwise this i=
s
> going to be a never ending story.
>


It makes sense.
I proposed this change to help me solving a problem described here
(https://lkml.org/lkml/2018/10/3/707), and for this it was enough if it did=
n't
build when "make drivers/s390/" was called.

Sorry I didn't send the e-mail with the reason earlier.

For solving my problem it was not necessary, but if you think it's interest=
ing,
I could refactor all drivers/s390 Makefiles to make them all build only if
we are dealing with the s390 architecture.

What do you think?

Thanks for the reply,

Leonardo Bras
