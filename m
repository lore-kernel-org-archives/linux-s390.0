Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] ubsan: Avoid unnecessary 128-bit shifts
References: <201904010857.x318v8J4007902@sdf.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <93362dd2-2b9d-d958-7488-4fa7dd48534a@virtuozzo.com>
Date: Tue, 2 Apr 2019 19:41:27 +0300
MIME-Version: 1.0
In-Reply-To: <201904010857.x318v8J4007902@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: George Spelvin <lkml@sdf.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 4/1/19 11:57 AM, George Spelvin wrote:
> Double-word sign-extending shifts by a variable amount are a
> non-trivial amount of code and complexity.  Doing signed long shifts
> before the cast to (s_max) greatly simplifies the object code.
> 
> (Yes, I know "signed" is redundant.  It's there for emphasis.)
> 
> The complex issue raised by this patch is that allows s390 (at
> least) to enable CONFIG_ARCH_SUPPORTS_INT128.
> 
> If you enable that option, s_max becomes 128 bits, and gcc compiles
> the pre-patch code with a call to __ashrti3.  (And, on some gcc
> versions, __ashlti3.)  Which isn't implemented, ergo link error.
> 
> Enabling that option allows 64-bit widening multiplies which
> greatly simplify a lot of timestamp scaling code in the kernel,
> so it's desirable.
> 
> But how to get there?
> 
> One option is to implement __ashrti3 on the platforms that need it.
> But I'm inclined to *not* do so, because it's inefficient, rare,
> and avoidable.  This patch fixes the sole instance in the entire
> kernel, which will make that implementation dead code, and I think
> its absence will encourage Don't Do That, Then going forward.
> 
> But if we don't implement it, we've created an awkward dependency
> between patches in different subsystems, and that needs handling.
> 
> Option 1: Submit this for 5.2 and turn on INT128 for s390 in 5.3.
> Option 2: Let the arches cherry-pick this patch pre-5.2.
> 
> My preference is for option 2, but that requires permission from
> ubsan's owner.  Andrey?
> 

Fine by me:
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com> 

> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: linux-s390@vger.kernel.org
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  lib/ubsan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index e4162f59a81c..43ce177a5ca7 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -89,8 +89,8 @@ static bool is_inline_int(struct type_descriptor *type)
>  static s_max get_signed_val(struct type_descriptor *type, unsigned long val)
>  {
>  	if (is_inline_int(type)) {
> -		unsigned extra_bits = sizeof(s_max)*8 - type_bit_width(type);
> -		return ((s_max)val) << extra_bits >> extra_bits;
> +		unsigned extra_bits = sizeof(val)*8 - type_bit_width(type);
> +		return (s_max)((signed long)val << extra_bits >> extra_bits);

Cast to s_max is redundant.                      

>  	}
>  
>  	if (type_bit_width(type) == 64)
> 
