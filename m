Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Mar 2018 12:43:53 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 11/11] kexec_file: Move purgatories sha256 to common code
Message-ID: <20180309044353.GC3246@dhcp-128-65.nay.redhat.com>
References: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
 <20180226151620.20970-12-prudo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226151620.20970-12-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

On 02/26/18 at 04:16pm, Philipp Rudo wrote:
> The code to verify the new kernels sha digest are applicable for all
> architectures. Move it to common code.
> 
> Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
> ---
>  arch/x86/purgatory/Makefile                    |  3 +++
>  arch/x86/purgatory/purgatory.c                 |  2 +-
>  {arch/x86/purgatory => include/linux}/sha256.h | 10 +++++++++-
>  {arch/x86/purgatory => lib}/sha256.c           |  4 ++--
>  4 files changed, 15 insertions(+), 4 deletions(-)
>  rename {arch/x86/purgatory => include/linux}/sha256.h (63%)
>  rename {arch/x86/purgatory => lib}/sha256.c (99%)
> 
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 2f15a2ac4209..414eed6b5065 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -6,6 +6,9 @@ purgatory-y := purgatory.o stack.o setup-x86_$(BITS).o sha256.o entry64.o string
>  targets += $(purgatory-y)
>  PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
>  
> +$(obj)/sha256.o: $(srctree)/lib/sha256.c
> +	$(call if_changed_rule,cc_o_c)
> +
>  LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
>  targets += purgatory.ro
>  
> diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
> index 470edad96bb9..025c34ac0d84 100644
> --- a/arch/x86/purgatory/purgatory.c
> +++ b/arch/x86/purgatory/purgatory.c
> @@ -11,9 +11,9 @@
>   */
>  
>  #include <linux/bug.h>
> +#include <linux/sha256.h>
>  #include <asm/purgatory.h>
>  
> -#include "sha256.h"
>  #include "../boot/string.h"
>  
>  unsigned long purgatory_backup_dest __section(.kexec-purgatory);
> diff --git a/arch/x86/purgatory/sha256.h b/include/linux/sha256.h
> similarity index 63%
> rename from arch/x86/purgatory/sha256.h
> rename to include/linux/sha256.h
> index 2867d9825a57..43a20ac33688 100644
> --- a/arch/x86/purgatory/sha256.h
> +++ b/include/linux/sha256.h
> @@ -13,9 +13,17 @@
>  #include <linux/types.h>
>  #include <crypto/sha.h>
>  
> +/* Stand-alone implementation of the SHA256 algorithm. It is designed to
> + * have as little dependencies as possible so it can be used in the
> + * kexec_file purgatory. In other cases you should use the implementation in
> + * crypto/.
> + *
> + * For details see lib/sha256.c
> + */

should move to use preferred comment format:
/*
 * Stand-alone ...
 * ...
 */

> +
>  extern int sha256_init(struct sha256_state *sctx);
>  extern int sha256_update(struct sha256_state *sctx, const u8 *input,
> -				unsigned int length);
> +			 unsigned int length);
>  extern int sha256_final(struct sha256_state *sctx, u8 *hash);
>  
>  #endif /* SHA256_H */
> diff --git a/arch/x86/purgatory/sha256.c b/lib/sha256.c
> similarity index 99%
> rename from arch/x86/purgatory/sha256.c
> rename to lib/sha256.c
> index 548ca675a14a..4400c832e2aa 100644
> --- a/arch/x86/purgatory/sha256.c
> +++ b/lib/sha256.c
> @@ -16,9 +16,9 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/sha256.h>
> +#include <linux/string.h>
>  #include <asm/byteorder.h>
> -#include "sha256.h"
> -#include "../boot/string.h"

Hmm, I'm not sure if moving to linux/string.h will have some side
effects..

>  
>  static inline u32 Ch(u32 x, u32 y, u32 z)
>  {
> -- 
> 2.13.5
> 

Thanks
Dave
