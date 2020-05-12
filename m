Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] lib: fix bitmap_parse() on 64-bit big endian archs
References: <1589296890-13064-1-git-send-email-agordeev@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <36afa828-70a5-19da-328c-83ae86436235@de.ibm.com>
Date: Tue, 12 May 2020 17:58:20 +0200
MIME-Version: 1.0
In-Reply-To: <1589296890-13064-1-git-send-email-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, Karsten Graul <kgraul@linux.ibm.com>



On 12.05.20 17:21, Alexander Gordeev wrote:
> Commit 2d626158 ("lib: rework bitmap_parse()") does
> not take into account order of halfwords on 64-bit
> big endian architectures.

Karsten reported that this broke receive packet steering in 5.5 and later.
So we should add cc stable and a Fixes tag.
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  lib/bitmap.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 89260aa..a725e46 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -717,6 +717,19 @@ static const char *bitmap_get_x32_reverse(const char *start,
>  	return end;
>  }
>  
> +#if defined(__BIG_ENDIAN) && defined(CONFIG_64BIT)
> +static void save_x32_chunk(unsigned long *maskp, u32 chunk, int chunk_idx)
> +{
> +	maskp += (chunk_idx / 2);
> +	((u32 *)maskp)[(chunk_idx & 1) ^ 1] = chunk;
> +}
> +#else
> +static void save_x32_chunk(unsigned long *maskp, u32 chunk, int chunk_idx)
> +{
> +	((u32 *)maskp)[chunk_idx] = chunk;
> +}
> +#endif
> +
>  /**
>   * bitmap_parse - convert an ASCII hex string into a bitmap.
>   * @start: pointer to buffer containing string.
> @@ -738,7 +751,8 @@ int bitmap_parse(const char *start, unsigned int buflen,
>  {
>  	const char *end = strnchrnul(start, buflen, '\n') - 1;
>  	int chunks = BITS_TO_U32(nmaskbits);
> -	u32 *bitmap = (u32 *)maskp;
> +	int chunk_idx = 0;
> +	u32 chunk;
>  	int unset_bit;
>  
>  	while (1) {
> @@ -749,9 +763,11 @@ int bitmap_parse(const char *start, unsigned int buflen,
>  		if (!chunks--)
>  			return -EOVERFLOW;
>  
> -		end = bitmap_get_x32_reverse(start, end, bitmap++);
> +		end = bitmap_get_x32_reverse(start, end, &chunk);
>  		if (IS_ERR(end))
>  			return PTR_ERR(end);
> +
> +		save_x32_chunk(maskp, chunk, chunk_idx++);
>  	}
>  
>  	unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
> 
