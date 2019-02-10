From: Ran Rozenstein <ranro@mellanox.com>
Subject: RE: [PATCH net-next v5 09/12] socket: Add SO_TIMESTAMPING_NEW
Date: Sun, 10 Feb 2019 15:43:16 +0000
Message-ID: <AM4PR0501MB2769C4BE6CF1C5B051068D0BC56B0@AM4PR0501MB2769.eurprd05.prod.outlook.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
 <20190202153454.7121-10-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190202153454.7121-10-deepa.kernel@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "chris@zankel.net" <chris@zankel.net>, "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "rth@twiddle.net" <rth@twiddle.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "ubraun@linux.ibm.com" <ubraun@linux.ibm.com>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

> Subject: [PATCH net-next v5 09/12] socket: Add SO_TIMESTAMPING_NEW
>=20
> Add SO_TIMESTAMPING_NEW variant of socket timestamp options.
> This is the y2038 safe versions of the SO_TIMESTAMPING_OLD for all
> architectures.
>=20
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Acked-by: Willem de Bruijn <willemb@google.com>


Hi,

I have app that include:=20
	#include <linux/errqueue.h>

It now fail with this error:
	In file included from timestamping.c:6:0:
	/usr/include/linux/errqueue.h:46:27: error: array type has incomplete elem=
ent type 'struct __kernel_timespec'
	  struct __kernel_timespec ts[3];
                			           ^~
I tried to do the trivial fix, to include time.h:
In include/uapi/linux/errqueue.h
	#include <linux/time.h>
	#include <linux/types.h>

But it just add some other noises:
                In file included from /usr/include/linux/errqueue.h:5:0,
                                 from timestamping.c:6:
                /usr/include/linux/time.h:10:8: error: redefinition of ?str=
uct timespec?
                 struct timespec {
                        ^~~~~~~~
                In file included from /usr/include/sys/select.h:39:0,
                                 from /usr/include/sys/types.h:197,
                                 from /usr/include/stdlib.h:279,
                                 from timestamping.c:2:
                /usr/include/bits/types/struct_timespec.h:8:8: note: origin=
ally defined here
                 struct timespec
                        ^~~~~~~~
                In file included from /usr/include/linux/errqueue.h:5:0,
                                 from timestamping.c:6:
                /usr/include/linux/time.h:16:8: error: redefinition of ?str=
uct timeval?
                 struct timeval {
                        ^~~~~~~
                In file included from /usr/include/sys/select.h:37:0,
                                 from /usr/include/sys/types.h:197,
                                 from /usr/include/stdlib.h:279,
                                 from timestamping.c:2:
                /usr/include/bits/types/struct_timeval.h:8:8: note: origina=
lly defined here
                 struct timeval
                        ^~~~~~~


Can you please advise how to solve it?

Thanks,
Ran


> diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errqueue.=
h
> index c0151200f7d1..d955b9e32288 100644
> --- a/include/uapi/linux/errqueue.h
> +++ b/include/uapi/linux/errqueue.h
> @@ -41,6 +41,10 @@ struct scm_timestamping {
>  	struct timespec ts[3];
>  };
>=20
> +struct scm_timestamping64 {
> +	struct __kernel_timespec ts[3];
> +};
> +
>  /* The type of scm_timestamping, passed in sock_extended_err ee_info.
>   * This defines the type of ts[0]. For SCM_TSTAMP_SND only, if ts[0]
>   * is zero, then this is a hardware timestamp and recorded in ts[2].
