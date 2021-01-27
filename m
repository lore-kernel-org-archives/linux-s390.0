Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237064AbhA0MnH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Jan 2021 07:43:07 -0500
Date: Wed, 27 Jan 2021 13:41:00 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390/ap: remove unneeded semicolon
Message-ID: <your-ad-here.call-01611751260-ext-3517@work.hours>
References: <20210125095839.1720265-1-cy.fan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125095839.1720265-1-cy.fan@huawei.com>
List-ID: <linux-s390.vger.kernel.org>
To: Chengyang Fan <cy.fan@huawei.com>
Cc: hca@linux.ibm.com, linux-s390@vger.kernel.org, joe@perches.com, Harald Freudenberger <freude@linux.ibm.com>

On Mon, Jan 25, 2021 at 05:58:39PM +0800, Chengyang Fan wrote:
> Remove a superfluous semicolon after function definition.
> 
> Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
> ---
>  arch/s390/include/asm/ap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index aea32dda3d14..837d1699b109 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -368,7 +368,7 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
>  #if IS_ENABLED(CONFIG_ZCRYPT)
>  void ap_bus_cfg_chg(void);
>  #else
> -static inline void ap_bus_cfg_chg(void){};
> +static inline void ap_bus_cfg_chg(void){}
>  #endif
>  
>  #endif /* _ASM_S390_AP_H_ */
> -- 

Applied, thanks.
