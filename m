Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 13 Dec 2017 09:33:17 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/decompressor: add fortify_panic as x86 has.
References: <20171207103727.9461-1-msuchanek@suse.de>
 <20171207135507.275c5809@mschwideX1>
 <20171211140904.2f023b3c@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20171211140904.2f023b3c@kitsune.suse.cz>
Message-Id: <20171213083317.GA6931@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Dec 11, 2017 at 02:09:04PM +0100, Michal Such=E1nek wrote:
> Hello,
>=20
> On Thu, 7 Dec 2017 13:55:07 +0100
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>=20
> > On Thu,  7 Dec 2017 11:37:27 +0100
> > Michal Suchanek <msuchanek@suse.de> wrote:
> >=20
> > > Fix following error:
> > >=20
> > >   LD      arch/s390/boot/compressed/vmlinux
> > > drivers/s390/char/sclp_early_core.o: In function `memcpy':
> > > ../include/linux/string.h:340: undefined reference to
> > > `fortify_panic' make[4]: ***
> > > [../arch/s390/boot/compressed/Makefile:29:
> > > arch/s390/boot/compressed/vmlinux] Error 1
> > >=20
> > > Fixes: 79962038dffa ("s390: add support for FORTIFY_SOURCE")
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > >  arch/s390/boot/compressed/misc.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/arch/s390/boot/compressed/misc.c
> > > b/arch/s390/boot/compressed/misc.c index cecf38b9ec82..e79c4499c548
> > > 100644 --- a/arch/s390/boot/compressed/misc.c
> > > +++ b/arch/s390/boot/compressed/misc.c
> > > @@ -174,3 +174,7 @@ unsigned long decompress_kernel(void)
> > >  	return (unsigned long) output;
> > >  }
> > >=20
> > > +void fortify_panic(const char *name)
> > > +{
> > > +	error("detected buffer overflow");
> > > +} =20
> >=20
> > Odd, the current linux master tree builds just fine with
> > CONFIG_FORTIFY_SOURCE=3Dy. There *is* a reference to fortify_panic in
> > drivers/s390/char/sclp_early.o. This object is included in the link
> > for the compressed vmlinux, but the function  that contains the call
> > to fortify_panic is not included in the compressed image. I wonder
> > what causes this difference in behavior.
> >=20
> > The patch makes sense though and I will add it to the queue.
> >=20
>=20
> It probably depends on the config.
>=20
> FWIW attaching the config that fails to build for me.

Yes, with that configuration it is reproducable. However I disagree with
the fix. We have a call to fortify_panic() within sclp_early_core.c which
is our console driver. If that would ever trigger the result would be an
endless loop (error() would call the console driver again). This would
repeat until we hit an addressing exception or code gets overwritten due to
the ever increasing stack. At some point we simply have to trust the
code. That's also why I disabled FORTIFY_SOURCE for a couple of other files
which contain early code.

Therefore the simple solution would be to just disable FORTIFY_SOURCE for
the early sclp code as well.

The patch below will do that:

From 4ec2a3fd66bb5b1da35807bc2e382f9b8d9eebb8 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 13 Dec 2017 09:21:59 +0100
Subject: [PATCH] s390/sclp: disable FORTIFY_SOURCE for early sclp code

Michal Suchanek reported the following compile error with
FORTIFY_SOURCE enabled:

drivers/s390/char/sclp_early_core.o: In function `memcpy':
include/linux/string.h:340: undefined reference to `fortify_panic'

To fix this simply disable FORTIFY_SOURCE on the early sclp code as
well, which I forgot on the initial commit.

Fixes: 79962038dffa ("s390: add support for FORTIFY_SOURCE")
Reported-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 drivers/s390/char/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
index 05ac6ba15a53..614b44e70a28 100644
--- a/drivers/s390/char/Makefile
+++ b/drivers/s390/char/Makefile
@@ -17,6 +17,8 @@ CFLAGS_REMOVE_sclp_early_core.o	+=3D $(CC_FLAGS_MARCH)
 CFLAGS_sclp_early_core.o		+=3D -march=3Dz900
 endif
=20
+CFLAGS_sclp_early_core.o		+=3D -D__NO_FORTIFY
+
 obj-y +=3D ctrlchar.o keyboard.o defkeymap.o sclp.o sclp_rw.o sclp_quiesce=
.o \
 	 sclp_cmd.o sclp_config.o sclp_cpi_sys.o sclp_ocf.o sclp_ctl.o \
 	 sclp_early.o sclp_early_core.o
--=20
2.13.5
