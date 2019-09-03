Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbfICHiQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Sep 2019 03:38:16 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x837c9tI068005
        for <linux-s390@vger.kernel.org>; Tue, 3 Sep 2019 03:38:16 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usj5abgwr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2019 03:38:13 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 3 Sep 2019 08:37:53 +0100
Subject: Re: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable
 queue interrupts
References: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
 <20190830180250.79804f76.pasic@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 3 Sep 2019 09:37:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190830180250.79804f76.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ee41fd9f-6ba3-3f7d-7715-e5fe3a6d52f1@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com, frankja@linux.ibm.com, jjherne@linux.ibm.com



On 30.08.19 18:02, Halil Pasic wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Fri, 30 Aug 2019 16:03:42 +0200
> Subject: [PATCH 1/2] s390: vfio-ap: fix warning reset not completed
> 
> The intention seems to be to warn once when we don't wait enough for the
> reset to complete. Let's use the right retry counter to accomplish that
> semantic.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e3bcb43..dd07ebf 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1144,7 +1144,7 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>  				msleep(20);
>  				status = ap_tapq(apqn, NULL);
>  			}
> -			WARN_ON_ONCE(retry <= 0);
> +			WARN_ON_ONCE(retry2 <= 0);
>  			return 0;
>  		case AP_RESPONSE_RESET_IN_PROGRESS:
>  		case AP_RESPONSE_BUSY:

I think this patch alone makes certainly sense. Can you send that separately?
Or even better remove the retry parameter of that function. All users seem
to always pass in 1 as retry.
