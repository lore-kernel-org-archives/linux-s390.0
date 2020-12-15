Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731767AbgLOSxO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Dec 2020 13:53:14 -0500
Subject: Re: [PATCH] lib/zlib: fix inflating zlib streams on s390
References: <20201215155551.894884-1-iii@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <ea249b70-5b47-8e7c-b667-1146d20a0a65@de.ibm.com>
Date: Tue, 15 Dec 2020 19:52:27 +0100
MIME-Version: 1.0
In-Reply-To: <20201215155551.894884-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

On 15.12.20 16:55, Ilya Leoshkevich wrote:
> Decompressing zlib streams on s390 fails with "incorrect data check"
> error.
> 
> Userspace zlib checks inflate_state.flags in order to byteswap checksums
> only for zlib streams, and s390 hardware inflate code, which was ported
> from there, tries to match this behavior. At the same time, kernel zlib
> does not use inflate_state.flags, so it contains essentially random
> values. For many use cases either zlib stream is zeroed out or checksum
> is not used, so this problem is masked, but at least SquashFS is still
> affected.
> 
> Fix by always passing a checksum to and from the hardware as is, which
> matches zlib_inflate()'s expectations.
> 
> Fixes: 126196100063 ("lib/zlib: add s390 hardware support for kernel zlib_inflate")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

With a zlib compressed squashfs:

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

We should add

Cc: <stable@vger.kernel.org> # 5.6

> ---
>  lib/zlib_dfltcc/dfltcc_inflate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/zlib_dfltcc/dfltcc_inflate.c b/lib/zlib_dfltcc/dfltcc_inflate.c
> index db107016d29b..fb60b5a6a1cb 100644
> --- a/lib/zlib_dfltcc/dfltcc_inflate.c
> +++ b/lib/zlib_dfltcc/dfltcc_inflate.c
> @@ -125,7 +125,7 @@ dfltcc_inflate_action dfltcc_inflate(
>      param->ho = (state->write - state->whave) & ((1 << HB_BITS) - 1);
>      if (param->hl)
>          param->nt = 0; /* Honor history for the first block */
> -    param->cv = state->flags ? REVERSE(state->check) : state->check;
> +    param->cv = state->check;
>  
>      /* Inflate */
>      do {
> @@ -138,7 +138,7 @@ dfltcc_inflate_action dfltcc_inflate(
>      state->bits = param->sbb;
>      state->whave = param->hl;
>      state->write = (param->ho + param->hl) & ((1 << HB_BITS) - 1);
> -    state->check = state->flags ? REVERSE(param->cv) : param->cv;
> +    state->check = param->cv;
>      if (cc == DFLTCC_CC_OP2_CORRUPT && param->oesc != 0) {
>          /* Report an error if stream is corrupted */
>          state->mode = BAD;
> 
