Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKJFy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 May 2020 05:05:54 -0400
Message-ID: <2dbdf71e427a4b1df365412df34c773bc57528a9.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH -next] s390/cio: Remove unused inline
 functionidset_sch_get_first
From: Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Date: Mon, 11 May 2020 11:05:27 +0200
In-Reply-To: <20200508140643.30540-1-yuehaibing@huawei.com>
References: <20200508140643.30540-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: YueHaibing <yuehaibing@huawei.com>, vneethv@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, gustavo@embeddedor.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Thank you.
This patch will be part of the s390's next patch submission.

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>

Regards,
Vineeth


On Fri, 2020-05-08 at 22:06 +0800, YueHaibing wrote:
> commit 8ebd51a705c5 ("s390/cio: idset.c: remove some unused
> functions")
> left behind this, remove it
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/s390/cio/idset.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
> index 77d0ea7b381b..45f9c0736be4 100644
> --- a/drivers/s390/cio/idset.c
> +++ b/drivers/s390/cio/idset.c
> @@ -59,18 +59,6 @@ static inline int idset_contains(struct idset *set,
> int ssid, int id)
>  	return test_bit(ssid * set->num_id + id, set->bitmap);
>  }
>  
> -static inline int idset_get_first(struct idset *set, int *ssid, int
> *id)
> -{
> -	int bitnum;
> -
> -	bitnum = find_first_bit(set->bitmap, set->num_ssid * set-
> >num_id);
> -	if (bitnum >= set->num_ssid * set->num_id)
> -		return 0;
> -	*ssid = bitnum / set->num_id;
> -	*id = bitnum % set->num_id;
> -	return 1;
> -}
> -
>  struct idset *idset_sch_new(void)
>  {
>  	return idset_new(max_ssid + 1, __MAX_SUBCHANNEL + 1);
