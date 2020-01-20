Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37301 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726589AbgATMHQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Jan 2020 07:07:16 -0500
Subject: Re: [kvm-unit-tests PATCH v3 5/9] s390x: smp: Wait for cpu setup to
 finish
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-6-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5943555a-7f77-06f5-bf0d-b0fd246eb5c6@redhat.com>
Date: Mon, 20 Jan 2020 13:07:08 +0100
MIME-Version: 1.0
In-Reply-To: <20200117104640.1983-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 17.01.20 11:46, Janosch Frank wrote:
> We store the user provided psw address into restart new, so a psw
> restart does not lead us through setup again.
> 
> Also we wait on smp_cpu_setup() until the cpu has finished setup
> before returning. This is necessary for z/VM and LPAR where sigp is
> asynchronous.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  lib/s390x/smp.c  | 2 ++
>  s390x/cstart64.S | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index 84e681d..9dad146 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -204,6 +204,8 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>  
>  	/* Start processing */
>  	smp_cpu_restart_nolock(addr, NULL);
> +	/* Wait until the cpu has finished setup and started the provided psw */
> +	while (lc->restart_new_psw.addr != psw.addr) { mb(); }

while (lc->restart_new_psw.addr != psw.addr)
	mb();



-- 
Thanks,

David / dhildenb
