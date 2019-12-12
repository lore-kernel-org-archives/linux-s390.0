Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58003 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729652AbfLLOQk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 09:16:40 -0500
Subject: Re: [kvm-unit-tests PATCH 1/2] s390x: smp: Use full PSW to bringup
 new cpu
References: <20191211115923.9191-1-frankja@linux.ibm.com>
 <20191211115923.9191-2-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fd066ef5-7255-be67-d280-9c6c2b23089e@redhat.com>
Date: Thu, 12 Dec 2019 15:16:32 +0100
MIME-Version: 1.0
In-Reply-To: <20191211115923.9191-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

On 11.12.19 12:59, Janosch Frank wrote:
> Up to now we ignored the psw mask and only used the psw address when
> bringing up a new cpu. For DAT we need to also load the mask, so let's
> do that.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/smp.c  | 2 ++
>  s390x/cstart64.S | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index f57f420..e17751a 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -185,6 +185,8 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>  	cpu->stack = (uint64_t *)alloc_pages(2);
>  
>  	/* Start without DAT and any other mask bits. */
> +	cpu->lowcore->sw_int_psw.mask = psw.mask;
> +	cpu->lowcore->sw_int_psw.addr = psw.addr;
>  	cpu->lowcore->sw_int_grs[14] = psw.addr;
>  	cpu->lowcore->sw_int_grs[15] = (uint64_t)cpu->stack + (PAGE_SIZE * 4);
>  	lc->restart_new_psw.mask = 0x0000000180000000UL;
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 86dd4c4..e6a6bdb 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -159,7 +159,7 @@ smp_cpu_setup_state:
>  	xgr	%r1, %r1
>  	lmg     %r0, %r15, GEN_LC_SW_INT_GRS
>  	lctlg   %c0, %c0, GEN_LC_SW_INT_CRS
> -	br	%r14
> +	lpswe	GEN_LC_SW_INT_PSW
>  
>  pgm_int:
>  	SAVE_REGS
> 

Queued to

https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next

Thanks!

-- 
Thanks,

David / dhildenb
