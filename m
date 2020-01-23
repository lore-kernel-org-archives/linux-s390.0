Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726232AbgAWNcY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Jan 2020 08:32:24 -0500
Subject: Re: [kvm-unit-tests PATCH v4 6/9] s390x: smp: Loop if secondary cpu
 returns into cpu setup again
References: <20200121134254.4570-1-frankja@linux.ibm.com>
 <20200121134254.4570-7-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <73f8c5f6-327a-8ff5-c4e7-b1db46e3490f@redhat.com>
Date: Thu, 23 Jan 2020 14:32:14 +0100
MIME-Version: 1.0
In-Reply-To: <20200121134254.4570-7-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 21.01.20 14:42, Janosch Frank wrote:
> Up to now a secondary cpu could have returned from the function it was
> executing and ending up somewhere in cstart64.S. This was mostly
> circumvented by an endless loop in the function that it executed.
> 
> Let's add a loop to the end of the cpu setup, so we don't have to rely
> on added loops in the tests.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/cstart64.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 9af6bb3..5fd8d2f 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -162,6 +162,8 @@ smp_cpu_setup_state:
>  	/* We should only go once through cpu setup and not for every restart */
>  	stg	%r14, GEN_LC_RESTART_NEW_PSW + 8
>  	br	%r14
> +	/* If the function returns, just loop here */
> +0:	j	0
>  
>  pgm_int:
>  	SAVE_REGS
> 

This patch collides with a patch I have still queued

Author: Janosch Frank <frankja@linux.ibm.com>
Date:   Wed Dec 11 06:59:22 2019 -0500

    s390x: smp: Use full PSW to bringup new cpu
    
    Up to now we ignored the psw mask and only used the psw address when
    bringing up a new cpu. For DAT we need to also load the mask, so let's
    do that.
    
    Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
    Reviewed-by: David Hildenbrand <david@redhat.com>
    Message-Id: <20191211115923.9191-2-frankja@linux.ibm.com>
    Signed-off-by: David Hildenbrand <david@redhat.com>


In that patch we use a lpswe to jump to the target code, not a br. So the
return address will no longer be stored in %14 and this code here would stop working
AFAIKS.

Shall I drop that patch for now?

-- 
Thanks,

David / dhildenb
