Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56412 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726719AbgGUHMp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jul 2020 03:12:45 -0400
Subject: Re: [kvm-unit-tests PATCH 1/3] s390x: Add custom pgm cleanup function
References: <20200717145813.62573-1-frankja@linux.ibm.com>
 <20200717145813.62573-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c8a26cde-5e1f-5e49-c631-2bed93d911ea@redhat.com>
Date: Tue, 21 Jul 2020 09:12:34 +0200
MIME-Version: 1.0
In-Reply-To: <20200717145813.62573-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

On 17/07/2020 16.58, Janosch Frank wrote:
> Sometimes we need to do cleanup which we don't necessarily want to add
> to interrupt.c, so lets add a way to register a cleanup function.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/interrupt.h | 1 +
>  lib/s390x/interrupt.c     | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
> index 4cfade9..b2a7c83 100644
> --- a/lib/s390x/asm/interrupt.h
> +++ b/lib/s390x/asm/interrupt.h
> @@ -15,6 +15,7 @@
>  #define EXT_IRQ_EXTERNAL_CALL	0x1202
>  #define EXT_IRQ_SERVICE_SIG	0x2401
>  
> +void register_pgm_int_func(void (*f)(void));
>  void handle_pgm_int(void);
>  void handle_ext_int(void);
>  void handle_mcck_int(void);
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 243b9c2..36ba720 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -16,6 +16,7 @@
>  
>  static bool pgm_int_expected;
>  static bool ext_int_expected;
> +static void (*pgm_int_func)(void);
>  static struct lowcore *lc;
>  
>  void expect_pgm_int(void)
> @@ -51,8 +52,16 @@ void check_pgm_int_code(uint16_t code)
>  	       lc->pgm_int_code);
>  }
>  
> +void register_pgm_int_func(void (*f)(void))
> +{
> +	pgm_int_func = f;
> +}
> +
>  static void fixup_pgm_int(void)
>  {
> +	if (pgm_int_func)
> +		return (*pgm_int_func)();
> +
>  	switch (lc->pgm_int_code) {
>  	case PGM_INT_CODE_PRIVILEGED_OPERATION:
>  		/* Normal operation is in supervisor state, so this exception
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
