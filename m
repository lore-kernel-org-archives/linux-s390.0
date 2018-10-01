From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v3 5/7] drivers: s390: Avoids building drivers if ARCH is
 not s390.
Date: Mon, 1 Oct 2018 14:46:17 +0200
Message-ID: <20181001124617.GA3185@osiris>
References: <20180928020816.11251-1-leobras.c@gmail.com>
 <20180928020816.11251-6-leobras.c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928020816.11251-6-leobras.c@gmail.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc: lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2018 at 11:08:14PM -0300, Leonardo Br=E1s wrote:
> Avoids building s390 drivers if 'make drivers/s390/' is called but
> ARCH is not s390.
>=20
> Signed-off-by: Leonardo Br=E1s <leobras.c@gmail.com>
> ---
>  drivers/s390/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/s390/Makefile b/drivers/s390/Makefile
> index a863b0462b43..0575f02dba45 100644
> --- a/drivers/s390/Makefile
> +++ b/drivers/s390/Makefile
> @@ -3,7 +3,7 @@
>  # Makefile for the S/390 specific device drivers
>  #
> =20
> -obj-y +=3D cio/ block/ char/ crypto/ net/ scsi/ virtio/
> -
> -drivers-y +=3D drivers/s390/built-in.a
> -
> +ifeq ($(ARCH),s390)
> +	obj-y +=3D cio/ block/ char/ crypto/ net/ scsi/ virtio/
> +	drivers-y +=3D drivers/s390/built-in.a
> +endif

And then somebody wants to build with e.g. "make drivers/s390/cio/" and it
still doesn't work. So _if_ this should be supported then it should work
with all directory levels and all configuration options. Otherwise this is
going to be a never ending story.
