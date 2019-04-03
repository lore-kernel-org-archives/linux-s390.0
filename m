Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v2] ubsan: Avoid unnecessary 128-bit shifts
References: <201904030545.x335jQJO015258@sdf.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1cea9e60-204a-44d5-96dc-606c0738c621@rasmusvillemoes.dk>
Date: Wed, 3 Apr 2019 08:50:06 +0200
MIME-Version: 1.0
In-Reply-To: <201904030545.x335jQJO015258@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: George Spelvin <lkml@sdf.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 03/04/2019 07.45, George Spelvin wrote:
> 
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index e4162f59a81c..a7eb55fbeede 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -89,8 +89,8 @@ static bool is_inline_int(struct type_descriptor *type)
>  static s_max get_signed_val(struct type_descriptor *type, unsigned long val)
>  {
>  	if (is_inline_int(type)) {
> -		unsigned extra_bits = sizeof(s_max)*8 - type_bit_width(type);
> -		return ((s_max)val) << extra_bits >> extra_bits;
> +		unsigned extra_bits = sizeof(val)*8 - type_bit_width(type);
> +		return (signed long)val << extra_bits >> extra_bits;
>  	}

Maybe add some #ifdef BITS_PER_LONG == 64 #define sign_extend_long
sign_extend[32/64] stuff to linux/bitops.h and write this as
sign_extend_long(val, type_bit_width(type)-1)? Or do it locally in
lib/ubsan.c so that "git grep" will tell that it's available once the
next potential user comes along.

Btw., ubsan.c is probably compiled without instrumentation, but it would
be a nice touch to avoid UB in the implementation anyway (i.e., the left
shift should be done in the unsigned type, then cast to signed and
right-shifted).

Rasmus
