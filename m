Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728209AbfIDHZc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Sep 2019 03:25:32 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x847MFGm025120
        for <linux-s390@vger.kernel.org>; Wed, 4 Sep 2019 03:25:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ut80s1r9y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2019 03:25:30 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 4 Sep 2019 08:25:28 +0100
Subject: Re: [PATCH 1/1] s390: vfio-ap: fix warning reset not completed
References: <20190903133618.9122-1-pasic@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 4 Sep 2019 09:25:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190903133618.9122-1-pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9af2dd28-a2ce-769c-f90c-dd079c967022@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>

On 03.09.19 15:36, Halil Pasic wrote:
> The intention seems to be to warn once when we don't wait enough for the
> reset to complete. Let's use the right retry counter to accomplish that
> semantic.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>

Thanks applied.

I will let it sit in our tree for some days as I want to see if we actually
hit the WARN_ON now. So if there is an rc8 this will be part of the next 
merge window, otherwise this will somewhat come later.
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 0604b49a4d32..5c0f53c6dde7 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1143,7 +1143,7 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>  				msleep(20);
>  				status = ap_tapq(apqn, NULL);
>  			}
> -			WARN_ON_ONCE(retry <= 0);
> +			WARN_ON_ONCE(retry2 <= 0);
>  			return 0;
>  		case AP_RESPONSE_RESET_IN_PROGRESS:
>  		case AP_RESPONSE_BUSY:
> 
