Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 4 Aug 2017 11:26:08 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: drivers/s390/char/keyboard.c NULL pointer reference
References: <3b10f99f.aa01.15da8632dec.Coremail.sohu0106@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3b10f99f.aa01.15da8632dec.Coremail.sohu0106@126.com>
Message-Id: <20170804092608.GB3278@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: sohu0106 <sohu0106@126.com>
Cc: schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 03, 2017 at 09:57:38PM +0800, sohu0106 wrote:
>=20
>=20
> Local users able to send the NULL arg argument to kbd_ioctl(), which coul=
d cause kernel crash
>=20
>=20
>=20
>=20
> diff --git a/keyboard.c=A0
> b/keyboard.c
> index ba0e4f9..3ec16b1 100644
> --- a/keyboard.c
> +++ b/keyboard.c
> @@ -456,6 +456,8 @@ int kbd_ioctl(struct kbd_data *kbd, unsigned int cmd,=
 unsigned long arg)
> =A0 =A0 =A0 =A0 int perm;
> =A0
> =A0 =A0 =A0 =A0 argp =3D (void __user *)arg;
> + =A0 =A0 =A0 if( !argp )
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;

This doesn't make sense as well. All uaccess functions are able to handle
NULL pointers within user space.
