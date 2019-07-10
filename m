Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbfGJGpA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Jul 2019 02:45:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6A6ibgn117472
        for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2019 02:44:58 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tn8fv51ff-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2019 02:44:58 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Wed, 10 Jul 2019 07:44:55 +0100
Subject: Re: [PATCH] s390/zcrypt: remove the exporting of
 ap_query_configuration
References: <20190709122507.11158-1-efremov@linux.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Wed, 10 Jul 2019 08:44:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190709122507.11158-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <a71450e5-892c-3841-22d6-9f5c7b2d4ca4@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Denis Efremov <efremov@linux.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 09.07.19 14:25, Denis Efremov wrote:
> The function ap_query_configuration is declared static and marked
> EXPORT_SYMBOL, which is at best an odd combination. Because the
> function is not used outside of the drivers/s390/crypto/ap_bus.c
> file it is defined in, this commit removes the EXPORT_SYMBOL() marking.
>
> Fixes: f1b0a4343c41 ("s390/zcrypt: Integrate ap_asm.h into include/asm/ap.h.")
> Fixes: 050349b5b71d ("s390/zcrypt: externalize AP config info query")
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index b9fc502c58c2..379e43b79006 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -208,7 +208,6 @@ static inline int ap_query_configuration(struct ap_config_info *info)
>  		return -EINVAL;
>  	return ap_qci(info);
>  }
> -EXPORT_SYMBOL(ap_query_configuration);
>  
>  /**
>   * ap_init_configuration(): Allocate and query configuration array.
This function was exported a while ago for KVM code. However, never used.
So removing the export is the right thing. Thanks Denis

Heiko/Vasily will you pick this patch please?

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
