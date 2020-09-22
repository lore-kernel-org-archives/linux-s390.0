Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbgIVKrQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Sep 2020 06:47:16 -0400
Subject: Re: [PATCH] s390/zcrypt: Fix a size determination in
 zcrypt_unlocked_ioctl()
References: <20200922103059.859-1-zhenzhong.duan@gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <0091c0b5-ea48-dce2-1180-49a6b87113e4@de.ibm.com>
Date: Tue, 22 Sep 2020 12:47:05 +0200
MIME-Version: 1.0
In-Reply-To: <20200922103059.859-1-zhenzhong.duan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Zhenzhong Duan <zhenzhong.duan@gmail.com>, linux-kernel@vger.kernel.org
Cc: freude@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org

On 22.09.20 12:30, Zhenzhong Duan wrote:
> With new ioctl(ZCRYPT_PERDEV_REQCNT) introduced, kernel use dynamic
> allocation for the 256 element array of unsigned integers for the number
> of successfully completed requests per device. It's not a static array of
> 64 elements any more.
> 
> Fixes: af4a72276d49 ("s390/zcrypt: Support up to 256 crypto adapters.")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>

Thanks for the patch, but we have a similar patch already queued internally.
(Found with coccicheck). 
> ---
>  drivers/s390/crypto/zcrypt_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index 4dbbfd88262c..5c3f3f89e2f3 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -1449,7 +1449,7 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
>  		if (!reqcnt)
>  			return -ENOMEM;
>  		zcrypt_perdev_reqcnt(reqcnt, AP_DEVICES);
> -		if (copy_to_user((int __user *) arg, reqcnt, sizeof(reqcnt)))
> +		if (copy_to_user((int __user *) arg, reqcnt, sizeof(u32) * AP_DEVICES))
>  			rc = -EFAULT;
>  		kfree(reqcnt);
>  		return rc;
> 
