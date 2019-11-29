Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33910 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725892AbfK2MB6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 Nov 2019 07:01:58 -0500
Subject: Re: [kvm-unit-tests PATCH v2 3/9] s390x: irq: make IRQ handler weak
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-4-git-send-email-pmorel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <33be2bbd-ea3b-4a93-3ce3-9dee36a531d1@redhat.com>
Date: Fri, 29 Nov 2019 13:01:49 +0100
MIME-Version: 1.0
In-Reply-To: <1574945167-29677-4-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com

On 28.11.19 13:46, Pierre Morel wrote:
> Having a weak function allows the tests programm to declare its own
> IRQ handler.
> This is helpfull for I/O tests to have the I/O IRQ handler having
> its special work to do.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  lib/s390x/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 3e07867..d70fde3 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -140,7 +140,7 @@ void handle_mcck_int(void)
>  		     lc->mcck_old_psw.addr);
>  }
>  
> -void handle_io_int(void)
> +__attribute__((weak)) void handle_io_int(void)
>  {
>  	report_abort("Unexpected io interrupt: at %#lx",
>  		     lc->io_old_psw.addr);
> 

The clear alternative would be a way to register a callback function.
That way you can modify the callback during the tests. As long as not
registered, wrong I/Os can be caught easily here. @Thomas?

-- 
Thanks,

David / dhildenb
