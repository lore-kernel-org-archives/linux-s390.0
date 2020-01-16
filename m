Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgAPMUE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 07:20:04 -0500
Subject: Re: [kvm-unit-tests PATCH v2 5/7] s390x: smp: Wait for cpu setup to
 finish
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-6-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1a0cc6bf-07ad-2020-aee7-84df693b5317@redhat.com>
Date: Thu, 16 Jan 2020 13:19:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200116120513.2244-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 16.01.20 13:05, Janosch Frank wrote:
> We store the user provided psw address into restart new, so a psw
> restart does not lead us through setup again.
> 
> Also we wait on smp_cpu_setup() until the cpu has finished setup
> before returning. This is necessary for z/VM and LPAR where sigp is
> asynchronous.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/smp.c  | 2 ++
>  s390x/cstart64.S | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index f984a34..0a0bc1c 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -199,6 +199,8 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>  
>  	/* Start processing */
>  	smp_cpu_restart_nolock(addr, NULL);
> +	/* Wait until the cpu has finished setup and started the provided psw */
> +	while (lc->restart_new_psw.addr != psw.addr) { mb(); }
>  out:
>  	spin_unlock(&lock);
>  	return rc;
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 86dd4c4..9af6bb3 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -159,6 +159,8 @@ smp_cpu_setup_state:
>  	xgr	%r1, %r1
>  	lmg     %r0, %r15, GEN_LC_SW_INT_GRS
>  	lctlg   %c0, %c0, GEN_LC_SW_INT_CRS
> +	/* We should only go once through cpu setup and not for every restart */
> +	stg	%r14, GEN_LC_RESTART_NEW_PSW + 8
>  	br	%r14
>  
>  pgm_int:
> 


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
