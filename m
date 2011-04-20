Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] bitops: add ifdef CONFIG_GENERIC_FIND_BIT_LE guard
Date: Wed, 20 Apr 2011 16:31:39 +0200
References: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201104201631.40017.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Wednesday 20 April 2011, Akinobu Mita wrote:
> index 946a21b..bd2253e 100644
> --- a/include/asm-generic/bitops/le.h
> +++ b/include/asm-generic/bitops/le.h
> @@ -30,6 +30,8 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
>  
>  #define BITOP_LE_SWIZZLE       ((BITS_PER_LONG-1) & ~0x7)
>  
> +#ifdef CONFIG_GENERIC_FIND_BIT_LE
> +
>  extern unsigned long find_next_zero_bit_le(const void *addr,
>                 unsigned long size, unsigned long offset);
>  extern unsigned long find_next_bit_le(const void *addr,
> @@ -38,6 +40,8 @@ extern unsigned long find_next_bit_le(const void *addr,
>  #define find_first_zero_bit_le(addr, size) \
>         find_next_zero_bit_le((addr), (size), 0)
>  
> +#endif /* CONFIG_GENERIC_FIND_BIT_LE */
> +
>  #else
>  #error "Please fix <asm/byteorder.h>"
>  #endif

The style that we normally use in asm-generic is to test the macro itself
for existence, so in asm-generic, do:

#ifndef find_next_zero_bit_le
extern unsigned long find_next_zero_bit_le(const void *addr,
                 unsigned long size, unsigned long offset);
#endif

and in the architectures, write

static inline unsigned long find_next_zero_bit_le(const void *addr,
                 unsigned long size, unsigned long offset)
#define find_next_zero_bit_le find_next_zero_bit_le

I guess we can do the #ifdef separately for each of the three macros,
or choose one of them to use as a key.

	Arnd
