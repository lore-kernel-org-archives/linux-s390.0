Return-Path: <SRS0=zSf/=T4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Tue, 28 May 2019 15:12:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/5] kconfig: make arch/*/configs/defconfig the default
 of KBUILD_DEFCONFIG
Message-ID: <20190528141232.GC32006@arrakis.emea.arm.com>
References: <20190527143725.12542-1-yamada.masahiro@socionext.com>
 <20190527143725.12542-4-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190527143725.12542-4-yamada.masahiro@socionext.com>
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-s390@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Albert Ou <aou@eecs.berkeley.edu>, Vincent Chen <deanbo422@gmail.com>, linux-kbuild@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Heiko Carstens <heiko.carstens@de.ibm.com>, Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Firoz Khan <firoz.khan@linaro.org>, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Guo Ren <guoren@kernel.org>, Matt Turner <mattst88@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 27, 2019 at 11:37:24PM +0900, Masahiro Yamada wrote:
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b025304bde46..970c41a30ed3 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -30,8 +30,6 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
>    endif
>  endif
>  
> -KBUILD_DEFCONFIG := defconfig
> -
>  # Check for binutils support for specific extensions
>  lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
