Return-Path: <linux-arch-owner@vger.kernel.org>
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] [v2] arch: add pidfd and io_uring syscalls everywhere
Date: Mon, 15 Apr 2019 17:19:11 +0000
Message-ID: <20190415171910.ezhsqmncj2eiw7cc@pburton-laptop>
References: <20190415143007.2989285-1-arnd@arndb.de>
In-Reply-To: <20190415143007.2989285-1-arnd@arndb.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BFCBE85B6EE3C42A598251C8BA649BF@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190415171911.1vD2t8-a6142Oer8TEXQVfpC1SflRnkp9gG_6r0PYX0@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Firoz Khan <firoz.khan@linaro.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Arnd,

On Mon, Apr 15, 2019 at 04:22:57PM +0200, Arnd Bergmann wrote:
> Add the io_uring and pidfd_send_signal system calls to all architectures.
>=20
> These system calls are designed to handle both native and compat tasks,
> so all entries are the same across architectures, only arm-compat and
> the generic tale still use an old format.
>=20
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> (s390)
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes since v1:
> - fix s390 table
> - use 'n64' tag in mips-n64 instead of common.

Thanks for taking care of this:

  Acked-by: Paul Burton <paul.burton@mips.com> # MIPS

Thanks,
    Paul
