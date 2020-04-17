Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728593AbgDQPjv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 11:39:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HFYKhC082773
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 11:39:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30fe50jeh8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 11:39:50 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 17 Apr 2020 16:39:28 +0100
Subject: Re: [PATCH v1 1/1] MAINTAINERS: add a reviewer for KVM/s390
References: <20200417152936.772256-1-imbrenda@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 17 Apr 2020 17:39:44 +0200
MIME-Version: 1.0
In-Reply-To: <20200417152936.772256-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5e0efa79-940e-6a43-fc71-532210e2d2e3@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, frankja@linux.ibm.com
Cc: pbonzini@redhat.com, cohuck@redhat.com, david@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org


On 17.04.20 17:29, Claudio Imbrenda wrote:
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6851ef7cf1bd..48e0147f9dd8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9326,6 +9326,7 @@ M:	Christian Borntraeger <borntraeger@de.ibm.com>
>  M:	Janosch Frank <frankja@linux.ibm.com>
>  R:	David Hildenbrand <david@redhat.com>
>  R:	Cornelia Huck <cohuck@redhat.com>
> +R:	Claudio Imbrenda <imbrenda@linux.ibm.com>
>  L:	kvm@vger.kernel.org
>  S:	Supported
>  W:	http://www.ibm.com/developerworks/linux/linux390/
> 

You cant have enough of the "R:"s 
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
