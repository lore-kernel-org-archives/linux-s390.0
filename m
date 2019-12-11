Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49000 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729131AbfLKMdC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Dec 2019 07:33:02 -0500
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: smp: Setup CRs from cpu 0
References: <20191211115923.9191-1-frankja@linux.ibm.com>
 <20191211115923.9191-3-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <75eadbf8-1159-1c3f-12c4-bda518adb2ef@redhat.com>
Date: Wed, 11 Dec 2019 13:32:54 +0100
MIME-Version: 1.0
In-Reply-To: <20191211115923.9191-3-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

On 11.12.19 12:59, Janosch Frank wrote:
> Grab the CRs (currently only 0, 1, 7, 13) from cpu 0, so we can
> bringup the new cpu in DAT mode or set other control options.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/smp.c  | 5 ++++-
>  s390x/cstart64.S | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index e17751a..4dfe7c6 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -191,7 +191,10 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>  	cpu->lowcore->sw_int_grs[15] = (uint64_t)cpu->stack + (PAGE_SIZE * 4);
>  	lc->restart_new_psw.mask = 0x0000000180000000UL;
>  	lc->restart_new_psw.addr = (uint64_t)smp_cpu_setup_state;
> -	lc->sw_int_crs[0] = 0x0000000000040000UL;
> +	lc->sw_int_crs[0] = stctg(0);
> +	lc->sw_int_crs[1] = stctg(1);
> +	lc->sw_int_crs[7] = stctg(7);
> +	lc->sw_int_crs[13] = stctg(13);

Wouldn't it be better to also be able to specify the CRs explicitly here?

-- 
Thanks,

David / dhildenb
