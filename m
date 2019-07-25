Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388159AbfGYHjq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jul 2019 03:39:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6P7bkK8069413
        for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2019 03:39:45 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ty5fe72hu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2019 03:39:45 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 25 Jul 2019 08:39:43 +0100
Subject: Re: [PATCH 1/1] MAINTAINERS: vfio-ccw: Remove myself as the
 maintainer
References: <cover.1564003585.git.alifm@linux.ibm.com>
 <19aee1ab0e5bcc01053b515117a66426a9332086.1564003585.git.alifm@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 25 Jul 2019 09:39:39 +0200
MIME-Version: 1.0
In-Reply-To: <19aee1ab0e5bcc01053b515117a66426a9332086.1564003585.git.alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6756a778-34e3-9d9e-6383-20d09de63f75@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 24.07.19 23:32, Farhan Ali wrote:
> I will not be able to continue with my maintainership responsibilities
> going forward, so remove myself as the maintainer.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

applied to the s390 tree. Thanks for all your work.
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e90487..dd07a23 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13696,7 +13696,6 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
> 
>  S390 VFIO-CCW DRIVER
>  M:	Cornelia Huck <cohuck@redhat.com>
> -M:	Farhan Ali <alifm@linux.ibm.com>
>  M:	Eric Farman <farman@linux.ibm.com>
>  R:	Halil Pasic <pasic@linux.ibm.com>
>  L:	linux-s390@vger.kernel.org
> 
