Date: Mon, 12 Nov 2018 05:22:00 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 02/17] x86: Add support for ZSTD-compressed kernel
Message-ID: <20181112042200.GA96061@gmail.com>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
 <20181109190304.8573-2-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109190304.8573-2-kilobyte@angband.pl>
Return-Path: <mingo.kernel.org@gmail.com>
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
To: Adam Borowski <kilobyte@angband.pl>
Cc: linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
List-ID: <linux-s390.vger.kernel.org>


* Adam Borowski <kilobyte@angband.pl> wrote:

> From: Nick Terrell <terrelln@fb.com>
> 
> Integrates the ZSTD decompression code to the x86 pre-boot code.
> 
> Zstandard requires slightly more memory during the kernel decompression
> on x86 (192 KB vs 64 KB), and the memory usage is independent of the
> window size.
> 
> Zstandard requires memory proportional to the window size used during
> compression for decompressing the ramdisk image, since streaming mode is
> used. Newer versions of zstd (1.3.2+) list the window size of a file
> with `zstd -lv <file>'. The absolute maximum amount of memory required
> is just over 8 MB.
> 
> Signed-off-by: Nick Terrell <terrelln@fb.com>
> ---
>  Documentation/x86/boot.txt        | 6 +++---
>  arch/x86/Kconfig                  | 1 +
>  arch/x86/boot/compressed/Makefile | 5 ++++-
>  arch/x86/boot/compressed/misc.c   | 4 ++++
>  arch/x86/boot/header.S            | 8 +++++++-
>  arch/x86/include/asm/boot.h       | 6 ++++--
>  6 files changed, 23 insertions(+), 7 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 4c881c850125..af2efb256527 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -526,8 +526,14 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
>  # the size-dependent part now grows so fast.
>  #
>  # extra_bytes = (uncompressed_size >> 8) + 65536
> +#
> +# ZSTD compressed data grows by at most 3 bytes per 128K, and only has a 22
> +# byte fixed overhead but has a maximum block size of 128K, so it needs a
> +# larger margin.
> +#
> +# extra_bytes = (uncompressed_size >> 8) + 131072
>  
> -#define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 65536)
> +#define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 131072)

This change would also affect other decompressors, not just ZSTD, 
correct?

Might want to split this change out into a separate preparatory patch to 
allow it to be bisected to, or at least mention it in the changelog more 
explicitly?

Thanks,

	Ingo
