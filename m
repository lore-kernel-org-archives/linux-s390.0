Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35634 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725972AbgAUGT3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jan 2020 01:19:29 -0500
Subject: Re: [kvm-unit-tests PATCH v8 5/6] s390x: lib: fix program interrupt
 handler if sclp_busy was set
References: <20200120184256.188698-1-imbrenda@linux.ibm.com>
 <20200120184256.188698-6-imbrenda@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <490d9ca5-feff-039d-e257-5a17d7ec0112@redhat.com>
Date: Tue, 21 Jan 2020 07:19:18 +0100
MIME-Version: 1.0
In-Reply-To: <20200120184256.188698-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 20/01/2020 19.42, Claudio Imbrenda wrote:
> Fix the program interrupt handler for the case where sclp_busy is set.
> 
> The interrupt handler will attempt to write an error message on the
> console using the SCLP, and will wait for sclp_busy to become false
> before doing so. If an exception happenes between setting the flag and
> the SCLP call, or if the call itself raises an exception, we need to
> clear the flag so we can successfully print the error message.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  lib/s390x/interrupt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 05f30be..ccb376a 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -106,10 +106,13 @@ static void fixup_pgm_int(void)
>  
>  void handle_pgm_int(void)
>  {
> -	if (!pgm_int_expected)
> +	if (!pgm_int_expected) {
> +		/* Force sclp_busy to false, otherwise we will loop forever */
> +		sclp_handle_ext();
>  		report_abort("Unexpected program interrupt: %d at %#lx, ilen %d\n",
>  			     lc->pgm_int_code, lc->pgm_old_psw.addr,
>  			     lc->pgm_int_id);
> +	}
>  
>  	pgm_int_expected = false;
>  	fixup_pgm_int();
> 

Acked-by: Thomas Huth <thuth@redhat.com>
