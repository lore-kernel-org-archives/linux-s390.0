Return-Path: <SRS0=0da5=TP=lists.infradead.org=linux-riscv-bounces+infradead-linux-riscv=archiver.kernel.org@kernel.org>
Date: Wed, 15 May 2019 10:45:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: move arch/s390/defconfig to
 arch/s390/configs/defconfig
In-Reply-To: <20190513021116.12191-1-yamada.masahiro@socionext.com>
References: <20190513021116.12191-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Message-Id: <20190515104557.1d5a389f@mschwideX1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+infradead-linux-riscv=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-riscv/>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-s390@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 May 2019 11:11:16 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> As of Linux 5.1, alpha and s390 are the last architectures that
> have defconfig in arch/*/ instead of arch/*/configs/.
> 
>   $ find arch -name defconfig | sort
>   arch/alpha/defconfig
>   arch/arm64/configs/defconfig
>   arch/csky/configs/defconfig
>   arch/nds32/configs/defconfig
>   arch/riscv/configs/defconfig
>   arch/s390/defconfig
> 
> The arch/$(ARCH)/defconfig is the hard-coded default in Kconfig,
> and I want to deprecate it after evacuating the remaining defconfig
> into the standard location, arch/*/configs/.
> 
> Define KBUILD_DEFCONFIG like other architectures, and move defconfig
> into the configs/ subdirectory.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I have added this patch to my linux/s390 tree and will push it upstream
soon. Thanks!

> ---
> 
>  arch/s390/Makefile                | 2 ++
>  arch/s390/{ => configs}/defconfig | 0
>  2 files changed, 2 insertions(+)
>  rename arch/s390/{ => configs}/defconfig (100%)
> 
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index df1d6a150f30..de8521fc9de5 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -10,6 +10,8 @@
>  # Copyright (C) 1994 by Linus Torvalds
>  #
> 
> +KBUILD_DEFCONFIG := defconfig
> +
>  LD_BFD		:= elf64-s390
>  KBUILD_LDFLAGS	:= -m elf64_s390
>  KBUILD_AFLAGS_MODULE += -fPIC
> diff --git a/arch/s390/defconfig b/arch/s390/configs/defconfig
> similarity index 100%
> rename from arch/s390/defconfig
> rename to arch/s390/configs/defconfig


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


_______________________________________________
linux-riscv mailing list
linux-riscv@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-riscv
