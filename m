Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52071 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbgDXKIJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 06:08:09 -0400
Subject: Re: [PATCH v2 05/10] s390x: smp: Loop if secondary cpu returns into
 cpu setup again
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-6-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2d08ea4f-7251-0867-7f48-81642e551c79@redhat.com>
Date: Fri, 24 Apr 2020 12:08:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200423091013.11587-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 23.04.20 11:10, Janosch Frank wrote:
> Up to now a secondary cpu could have returned from the function it was
> executing and ending up somewhere in cstart64.S. This was mostly
> circumvented by an endless loop in the function that it executed.
> 
> Let's add a loop to the end of the cpu setup, so we don't have to rely
> on added loops in the tests.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  s390x/cstart64.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 9af6bb3..ecffbe0 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -161,7 +161,9 @@ smp_cpu_setup_state:
>  	lctlg   %c0, %c0, GEN_LC_SW_INT_CRS
>  	/* We should only go once through cpu setup and not for every restart */
>  	stg	%r14, GEN_LC_RESTART_NEW_PSW + 8
> -	br	%r14
> +	brasl	%r14, %r14
> +	/* If the function returns, just loop here */
> +0:	j	0
>  
>  pgm_int:
>  	SAVE_REGS
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
