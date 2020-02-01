Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50476 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbgBASxO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Feb 2020 13:53:14 -0500
Subject: Re: [kvm-unit-tests PATCH v5 2/7] s390x: smp: Fix ecall and emcall
 report strings
References: <20200201152851.82867-1-frankja@linux.ibm.com>
 <20200201152851.82867-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <15009dae-26eb-e6f6-25c6-c1dc9f0ee170@redhat.com>
Date: Sat, 1 Feb 2020 19:53:01 +0100
MIME-Version: 1.0
In-Reply-To: <20200201152851.82867-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 01/02/2020 16.28, Janosch Frank wrote:
> Instead of "smp: ecall: ecall" we now get "smp: ecall: received".
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index e37eb56..93a9594 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -125,7 +125,7 @@ static void ecall(void)
>  	load_psw_mask(mask);
>  	set_flag(1);
>  	while (lc->ext_int_code != 0x1202) { mb(); }
> -	report(1, "ecall");
> +	report(1, "received");
>  	set_flag(1);
>  }
>  
> @@ -160,7 +160,7 @@ static void emcall(void)
>  	load_psw_mask(mask);
>  	set_flag(1);
>  	while (lc->ext_int_code != 0x1201) { mb(); }
> -	report(1, "ecall");
> +	report(1, "received");
>  	set_flag(1);
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>
