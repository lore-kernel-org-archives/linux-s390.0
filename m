Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 7 Nov 2016 08:03:22 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] s390: squash facilities_src.h into gen_facilities.c
References: <1478403928-20799-1-git-send-email-yamada.masahiro@socionext.com>
 <1478403928-20799-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478403928-20799-2-git-send-email-yamada.masahiro@socionext.com>
Message-Id: <20161107070322.GA4075@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Sascha Silbe <silbe@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Nov 06, 2016 at 12:45:28PM +0900, Masahiro Yamada wrote:
> We generally expect headers in arch/$(ARCH)/include/asm directory
> are included from kernel sources, but facilities_src.h is not;
> it is included from the arch/s390/tools/gen_facilities.c tool.
> 
> There is no reason to expose this header to the public include path.
> Furthermore, facilities_src.h makes sure to be included only from
> gen_facilities.c by the following:
> 
>   #ifndef S390_GEN_FACILITIES_C
>   #error "This file can only be included by gen_facilities.c"
>   #endif
> 
> This check can be removed by merging the two files.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Both patches:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Martin, can you please pick them up?
