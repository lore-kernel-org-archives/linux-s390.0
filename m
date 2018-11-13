Date: Wed, 14 Nov 2018 00:10:43 +0100
From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH 05/17] mips: Remove support for BZIP2 and LZMA compressed
 kernel
Message-ID: <20181113231043.cv3qpjivxsefxpny@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
 <20181109190304.8573-5-kilobyte@angband.pl>
 <20181113224545.pamrezqxy2ay62k7@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181113224545.pamrezqxy2ay62k7@pburton-laptop>
Return-Path: <kilobyte@angband.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nick Terrell <terrelln@fb.com>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 13, 2018 at 10:45:54PM +0000, Paul Burton wrote:
> On Fri, Nov 09, 2018 at 08:02:52PM +0100, Adam Borowski wrote:
> > @@ -122,7 +104,6 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
> >  
> >  targets += vmlinux.its
> >  targets += vmlinux.gz.its
> > -targets += vmlinux.bz2.its
> >  targets += vmlinux.lzmo.its
> >  targets += vmlinux.lzo.its
> 
> It looks to me like this "vmlinux.lzmo.its" was a typo & ought to have
> been vmlinux.lzma.its, and thus ought to be removed.

Good catch!

The whole series was bz2 only at first, grepping for lzma missed this.

> Apart from that I'm fine with this in general:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>

Thanks.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢰⠒⠀⣿⡁ “This is gonna be as easy as cheating on an ethics exam!”
⢿⡄⠘⠷⠚⠋⠀     -Cerise Brightmoon
⠈⠳⣄⠀⠀⠀⠀
