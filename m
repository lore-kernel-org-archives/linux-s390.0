Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726679AbfFXLzL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Jun 2019 07:55:11 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OBqrZR178707
        for <linux-s390@vger.kernel.org>; Mon, 24 Jun 2019 07:55:09 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2taumcq0vj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 24 Jun 2019 07:55:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 24 Jun 2019 12:55:07 +0100
Subject: Re: [PATCH] vfio-ccw: make convert_ccw0_to_ccw1 static
References: <20190624090721.16241-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 24 Jun 2019 13:55:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190624090721.16241-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dceaeaf9-b961-c4c7-45e5-d8dc31b68b31@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org


On 24.06.19 11:07, Cornelia Huck wrote:
> Reported by sparse.
> 
> Fixes: 7f8e89a8f2fd ("vfio-ccw: Factor out the ccw0-to-ccw1 transition")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> On top of my vfio-ccw branch.
> 
> s390 arch maintainers: let me know if I should queue it and send
> a pull request, or if you prefer to apply it directly.

I still have to sort out some tooling for the s390 tree and I applied it directly.
Thanks

> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 9cddc1288059..a7b9dfd5b464 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -161,7 +161,7 @@ static inline void pfn_array_idal_create_words(
>  	idaws[0] += pa->pa_iova & (PAGE_SIZE - 1);
>  }
>  
> -void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
> +static void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
>  {
>  	struct ccw0 ccw0;
>  	struct ccw1 *pccw1 = source;
> 
