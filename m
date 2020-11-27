Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730635AbgK0OS6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Nov 2020 09:18:58 -0500
Subject: Re: [PATCH] scsi: zfcp: fix indentation coding style issue
References: <20201127130646.11427-1-yevhen.viktorov@virginmedia.com>
From: Steffen Maier <maier@linux.ibm.com>
Message-ID: <5e866838-9b62-f1fe-d2a5-70c0df232857@linux.ibm.com>
Date: Fri, 27 Nov 2020 15:17:36 +0100
MIME-Version: 1.0
In-Reply-To: <20201127130646.11427-1-yevhen.viktorov@virginmedia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Yevhen Viktorov <yevhen.viktorov@virginmedia.com>
Cc: bblock@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Thanks, will queue it for our next cleanup submission.

On 11/27/20 2:06 PM, Yevhen Viktorov wrote:
> code indent should use tabs where possible
> 
> Signed-off-by: Yevhen Viktorov <yevhen.viktorov@virginmedia.com>
> ---
>   drivers/s390/scsi/zfcp_def.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
> index da8a5ceb615c..a2a59cbb330a 100644
> --- a/drivers/s390/scsi/zfcp_def.h
> +++ b/drivers/s390/scsi/zfcp_def.h
> @@ -157,7 +157,7 @@ struct zfcp_adapter {
>   	u32			fsf_lic_version;
>   	u32			adapter_features;  /* FCP channel features */
>   	u32			connection_features; /* host connection features */
> -        u32			hardware_version;  /* of FCP channel */
> +	u32			hardware_version;  /* of FCP channel */
>   	u32			fc_security_algorithms; /* of FCP channel */
>   	u32			fc_security_algorithms_old; /* of FCP channel */
>   	u16			timer_ticks;       /* time int for a tick */
> @@ -181,7 +181,7 @@ struct zfcp_adapter {
>   	rwlock_t		erp_lock;
>   	wait_queue_head_t	erp_done_wqh;
>   	struct zfcp_erp_action	erp_action;	   /* pending error recovery */
> -        atomic_t                erp_counter;
> +	atomic_t                erp_counter;
>   	u32			erp_total_count;   /* total nr of enqueued erp
>   						      actions */
>   	u32			erp_low_mem_count; /* nr of erp actions waiting
> @@ -217,7 +217,7 @@ struct zfcp_port {
>   	u32		       d_id;	       /* D_ID */
>   	u32		       handle;	       /* handle assigned by FSF */
>   	struct zfcp_erp_action erp_action;     /* pending error recovery */
> -        atomic_t               erp_counter;
> +	atomic_t               erp_counter;
>   	u32                    maxframe_size;
>   	u32                    supported_classes;
>   	u32                    connection_info;
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
