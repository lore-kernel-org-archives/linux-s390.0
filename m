Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbfGYHHD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jul 2019 03:07:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6P76fab057552
        for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2019 03:07:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ty77c95ny-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2019 03:07:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 25 Jul 2019 08:06:59 +0100
Subject: Re: [PATCH 1/1] MAINTAINERS: vfio-ccw: Remove myself as the
 maintainer
References: <cover.1564003698.git.alifm@linux.ibm.com>
 <355a4ac2923ff3dcf2171cb23d477440bd010b34.1564003698.git.alifm@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 25 Jul 2019 09:06:54 +0200
MIME-Version: 1.0
In-Reply-To: <355a4ac2923ff3dcf2171cb23d477440bd010b34.1564003698.git.alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1f1011d3-2fd5-2152-cbf8-b44dd76ee75a@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>

So this is the qemu patch, right?

On 24.07.19 23:35, Farhan Ali wrote:
> I will not be able to continue with my maintainership responsibilities
> going forward, so remove myself as the maintainer.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index acbad13..fe2797a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1452,7 +1452,6 @@ F: include/hw/vfio/
>  vfio-ccw
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Eric Farman <farman@linux.ibm.com>
> -M: Farhan Ali <alifm@linux.ibm.com>
>  S: Supported
>  F: hw/vfio/ccw.c
>  F: hw/s390x/s390-ccw.c
> 
