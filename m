Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 1 Jun 2019 12:21:25 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/4] s390: do not pass $(LINUXINCLUDE) to
 gen_opcode_table.c
References: <20190517075428.13496-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517075428.13496-1-yamada.masahiro@socionext.com>
Message-Id: <20190601102125.GB3600@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 17, 2019 at 04:54:24PM +0900, Masahiro Yamada wrote:
> I guess HOSTCFLAGS_gen_opcode_table.o was blindly copied from
> HOSTCFLAGS_gen_facilities.o
> 
> The reason of adding $(LINUXINCLUDE) to HOSTCFLAGS_gen_facilities.o
> is because gen_facilities.c references some CONFIG options. (Kbuild
> does not cater to this for host tools automatically.)
> 
> On the other hand, gen_opcode_table.c does not reference CONFIG
> options at all. So, there is no good reason to pass $(LINUXINCLUDE).
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/tools/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
> index 2342b84b3386..4ff6a2124522 100644
> --- a/arch/s390/tools/Makefile
> +++ b/arch/s390/tools/Makefile
> @@ -15,7 +15,7 @@ hostprogs-y		    += gen_facilities
>  hostprogs-y		    += gen_opcode_table
> 
>  HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
> -HOSTCFLAGS_gen_opcode_table.o += -Wall $(LINUXINCLUDE)
> +HOSTCFLAGS_gen_opcode_table.o += -Wall
> 
>  # Ensure output directory exists
>  _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')

Applied, thanks.
