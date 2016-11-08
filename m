Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 8 Nov 2016 08:45:28 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: remove unneeded dependency for gen_facilities
References: <1478570147-30873-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478570147-30873-1-git-send-email-yamada.masahiro@socionext.com>
Message-Id: <20161108074528.GB3528@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Paul Bolle <pebolle@tiscali.nl>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 08, 2016 at 10:55:47AM +0900, Masahiro Yamada wrote:
> The dependency between the object and the source is handled by
> scripts/Makefile.host, so only "hostprogs-y += gen_facilities"
> is fine.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/tools/Makefile | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
> index 6d9814c..4b5e1e4 100644
> --- a/arch/s390/tools/Makefile
> +++ b/arch/s390/tools/Makefile
> @@ -9,7 +9,5 @@ define filechk_facilities.h
>  	$(obj)/gen_facilities
>  endef
>  
> -$(obj)/gen_facilities.o: $(srctree)/arch/s390/tools/gen_facilities.c
> -
>  include/generated/facilities.h: $(obj)/gen_facilities FORCE
>  	$(call filechk,facilities.h)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Martin, can you pick this one up too, please?
