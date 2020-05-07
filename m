Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgEGMdm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 08:33:42 -0400
Subject: Re: [PATCH -next] s390/ism: fix error return code in ism_probe()
References: <20200507094307.14102-1-weiyongjun1@huawei.com>
From: Ursula Braun <ubraun@linux.ibm.com>
Message-ID: <f4a7bc6b-75f1-73a9-5351-3af876a50dec@linux.ibm.com>
Date: Thu, 7 May 2020 14:33:30 +0200
MIME-Version: 1.0
In-Reply-To: <20200507094307.14102-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wei Yongjun <weiyongjun1@huawei.com>, Julian Wiedmann <jwi@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>



On 5/7/20 11:43 AM, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the smcd_alloc_dev()
> error handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks Wei Yongjun - your patch is fine. It will be part of our next patch submission.

Regards, Ursula

> ---
>  drivers/s390/net/ism_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index c75112ee7b97..c7fade836d83 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -521,8 +521,10 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	ism->smcd = smcd_alloc_dev(&pdev->dev, dev_name(&pdev->dev), &ism_ops,
>  				   ISM_NR_DMBS);
> -	if (!ism->smcd)
> +	if (!ism->smcd) {
> +		ret = -ENOMEM;
>  		goto err_resource;
> +	}
>  
>  	ism->smcd->priv = ism;
>  	ret = ism_dev_init(ism);
> 
> 
> 
