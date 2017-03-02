From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 03/14] arm64: Use set_memory.h header
Date: Thu, 2 Mar 2017 14:07:48 +0000
Message-ID: <20170302140747.GK19632@leverpostej>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-4-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488413706-9739-4-git-send-email-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Dani
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 01, 2017 at 04:14:55PM -0800, Laura Abbott wrote:
> 
> The set_memory_* functions have moved to set_memory.h. Use that header
> explicitly.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/arm64/mm/pageattr.c      | 1 +
>  arch/arm64/net/bpf_jit_comp.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 8def55e..12ab86d 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -18,6 +18,7 @@
>  
>  #include <asm/pgtable.h>
>  #include <asm/tlbflush.h>
> +#include <asm/set_memory.h>

Nit: alphabetical order, please.

>  
>  struct page_change_data {
>  	pgprot_t set_mask;
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index a785554..84e4a91 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -26,6 +26,7 @@
>  
>  #include <asm/byteorder.h>
>  #include <asm/cacheflush.h>
> +#include <asm/set_memory.h>
>  #include <asm/debug-monitors.h>

Nit: likewise.

Otherwise, this looks fine to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  
>  #include "bpf_jit.h"
> -- 
> 2.7.4
> 
