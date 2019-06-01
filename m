Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 1 Jun 2019 12:21:56 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 3/4] s390: drop redundant directory creation from tools
 Makefile
References: <20190517075428.13496-1-yamada.masahiro@socionext.com>
 <20190517075428.13496-3-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517075428.13496-3-yamada.masahiro@socionext.com>
Message-Id: <20190601102156.GD3600@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 17, 2019 at 04:54:26PM +0900, Masahiro Yamada wrote:
> As you can see in scripts/Kbuild.include, the filechk creates the
> parent directory of the target as needed.
> 
> This Makefile does not need to explicitly create the directory.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/tools/Makefile | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
> index 8fb66c99840a..4864ea5e6ceb 100644
> --- a/arch/s390/tools/Makefile
> +++ b/arch/s390/tools/Makefile
> @@ -16,9 +16,6 @@ hostprogs-y		    += gen_opcode_table
> 
>  HOSTCFLAGS_gen_facilities.o += $(LINUXINCLUDE)
> 
> -# Ensure output directory exists
> -_dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
> -

Applied, thanks.
