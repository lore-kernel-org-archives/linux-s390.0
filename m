Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbfIIPrY (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 9 Sep 2019 11:47:24 -0400
Subject: Re: [kvm-unit-tests PATCH v2 5/6] s390x: Prepare for external calls
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-6-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <093802cb-519b-144a-0c36-8faa2cbd08d8@redhat.com>
Date: Mon, 9 Sep 2019 17:47:21 +0200
MIME-Version: 1.0
In-Reply-To: <20190905103951.36522-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 05/09/2019 12.39, Janosch Frank wrote:
> With SMP we also get new external interrupts like external call and
> emergency call. Let's make them known.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
[...]
> @@ -108,15 +116,23 @@ void handle_pgm_int(void)
>  
>  void handle_ext_int(void)
>  {
> -	if (lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
> +	if (!ext_int_expected &&
> +	    lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
>  		report_abort("Unexpected external call interrupt: at %#lx",
>  			     lc->ext_old_psw.addr);
> -	} else {
> -		lc->ext_old_psw.mask &= ~PSW_MASK_EXT;
> +		return;
> +	}
> +
> +	if (lc->ext_int_code == EXT_IRQ_SERVICE_SIG) {
>  		lc->sw_int_cr0 &= ~(1UL << 9);
>  		sclp_handle_ext();
> -		lc->ext_int_code = 0;
>  	}
> +	if (lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {

I think you could simplify above line to "else {" ?

With that change:

Reviewed-by: Thomas Huth <thuth@redhat.com>
