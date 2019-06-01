Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 1 Jun 2019 12:21:37 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/4] s390: drop unneeded -Wall addition from tools
 Makefile
References: <20190517075428.13496-1-yamada.masahiro@socionext.com>
 <20190517075428.13496-2-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517075428.13496-2-yamada.masahiro@socionext.com>
Message-Id: <20190601102137.GC3600@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 17, 2019 at 04:54:25PM +0900, Masahiro Yamada wrote:
> The top level Makefile adds -Wall globally for all host tools:
> 
>   KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
> 
> I see two "-Wall" added for compiling these tools.
> 
> Of course, it is allowed to pass the same option multiple times, but
> we do not need to do so.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/tools/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
> index 4ff6a2124522..8fb66c99840a 100644
> --- a/arch/s390/tools/Makefile
> +++ b/arch/s390/tools/Makefile
> @@ -14,8 +14,7 @@ kapi:	$(kapi-hdrs-y)
>  hostprogs-y		    += gen_facilities
>  hostprogs-y		    += gen_opcode_table
> 
> -HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
> -HOSTCFLAGS_gen_opcode_table.o += -Wall
> +HOSTCFLAGS_gen_facilities.o += $(LINUXINCLUDE)

Applied, thanks.
