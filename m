From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH 6/7] drivers: oprofile: Avoids building driver from direct
 make command
Date: Wed, 26 Sep 2018 09:26:09 +0200
Message-ID: <bf054e64b8284ce5da5f0c361fbb3ee6@sf-tec.de>
References: <20180926015305.GA14994@WindFlash>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926015305.GA14994@WindFlash>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Cc: lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-parisc-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

Leonardo Brás wrote:
> Creates new Makefile to avoid building driver if
> 'make drivers/oprofile/' is called directly.
> 
> This driver is usually built from arch/$ARCH and seems to have
> no meaning building alone.
> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/oprofile/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 drivers/oprofile/Makefile
> 
> diff --git a/drivers/oprofile/Makefile b/drivers/oprofile/Makefile
> new file mode 100644
> index 000000000000..6b36c93e9762
> --- /dev/null
> +++ b/drivers/oprofile/Makefile
> @@ -0,0 +1 @@
> +#Does nothing, since the source is called from arch/$ARCH/ tree.
> \ No newline at end of file
     ^^^^^^^^^^^^^^^^^^^^^^^^^

Is that intentional or bogus?

Eike
