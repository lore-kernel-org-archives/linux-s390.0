Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgAPMRb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 07:17:31 -0500
Subject: Re: [kvm-unit-tests PATCH v2 3/7] s390x: Add cpu id to interrupt
 error prints
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-4-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1bf32ccd-4047-7676-2ef4-a3327bf3995f@redhat.com>
Date: Thu, 16 Jan 2020 13:17:23 +0100
MIME-Version: 1.0
In-Reply-To: <20200116120513.2244-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 16.01.20 13:05, Janosch Frank wrote:
> It's good to know which cpu broke the test.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/interrupt.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 05f30be..773752a 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -107,8 +107,8 @@ static void fixup_pgm_int(void)
>  void handle_pgm_int(void)
>  {
>  	if (!pgm_int_expected)
> -		report_abort("Unexpected program interrupt: %d at %#lx, ilen %d\n",
> -			     lc->pgm_int_code, lc->pgm_old_psw.addr,
> +		report_abort("Unexpected program interrupt: %d on cpu %d at %#lx, ilen %d\n",
> +			     lc->pgm_int_code, stap(), lc->pgm_old_psw.addr,
>  			     lc->pgm_int_id);

nit: "cpu: %d"

>  
>  	pgm_int_expected = false;
> @@ -119,8 +119,8 @@ void handle_ext_int(void)
>  {
>  	if (!ext_int_expected &&
>  	    lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
> -		report_abort("Unexpected external call interrupt (code %#x): at %#lx",
> -			     lc->ext_int_code, lc->ext_old_psw.addr);
> +		report_abort("Unexpected external call interrupt (code %#x): on cpu %d at %#lx",
> +			     stap(), lc->ext_int_code, lc->ext_old_psw.addr);

nit: "(code %#x) on cpu: %d" ...

Same comment for the ones below

Reviewed-by: David Hildenbrand <david@redhat.com>

>  		return;
>  	}
>  
> @@ -137,18 +137,18 @@ void handle_ext_int(void)
>  
>  void handle_mcck_int(void)
>  {
> -	report_abort("Unexpected machine check interrupt: at %#lx",
> -		     lc->mcck_old_psw.addr);
> +	report_abort("Unexpected machine check interrupt: on cpu %d at %#lx",
> +		     stap(), lc->mcck_old_psw.addr);
>  }
>  
>  void handle_io_int(void)
>  {
> -	report_abort("Unexpected io interrupt: at %#lx",
> -		     lc->io_old_psw.addr);
> +	report_abort("Unexpected io interrupt: on cpu %d at %#lx",
> +		     stap(), lc->io_old_psw.addr);
>  }
>  
>  void handle_svc_int(void)
>  {
> -	report_abort("Unexpected supervisor call interrupt: at %#lx",
> -		     lc->svc_old_psw.addr);
> +	report_abort("Unexpected supervisor call interrupt: on cpu %d at %#lx",
> +		     stap(), lc->svc_old_psw.addr);
>  }
> 

-- 
Thanks,

David / dhildenb
