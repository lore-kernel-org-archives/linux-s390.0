Return-Path: <SRS0=l+Y/=SD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
In-Reply-To: <20190325144737.703921-1-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Apr 2019 10:19:09 +0200
Message-ID: <CAMuHMdXa1qvNzAOFNBs4s6uNvNU4PX8O17K-c12eLni698Lf_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rich Felker <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Firoz Khan <firoz.khan@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Richard Henderson <rth@twiddle.net>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, Parisc List <linux-parisc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, alpha <linux-alpha@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 25, 2019 at 3:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Add the io_uring and pidfd_send_signal system calls to all architectures.
>
> These system calls are designed to handle both native and compat tasks,
> so all entries are the same across architectures, only arm-compat and
> the generic tale still use an old format.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 4 ++++

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
