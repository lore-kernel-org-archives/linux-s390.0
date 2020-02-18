Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgBRJvF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:51:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I9nTwi015637
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:51:04 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y87e6bp57-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:51:04 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Tue, 18 Feb 2020 09:51:02 -0000
Subject: Re: [RFC v2 0/2] fces event support in cio
References: <20200218092317.49846-1-vneethv@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Date: Tue, 18 Feb 2020 10:50:58 +0100
MIME-Version: 1.0
In-Reply-To: <20200218092317.49846-1-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8fddc7ba-5032-4c6f-4e9f-8dcf2fb6facf@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: linux-s390@vger.kernel.org

On 18.02.2020 10:23, Vineeth Vijayan wrote:
> Compared to the previous version of this RFC(RFC v1 0/2] support
> FC-Endpoint Security events), there is a change in the information we
> passed to the consumer-devices using path-event. 
> 
> Previously we used to share the exact event of fces, which is derived
> from the sei_area->ccdf[0]. In this patch, instead of sending the right
> event, simply inform the ccwdev about the occurance of 'fces event'
> using path_event. The ccwdev then query more information about the
> fces-event using the chsc_scud() call and notify based on the reply.
> 
> Sebastian Ott (1):
>   s390/cio: handle changes related to endpoint security
> 
> Vineeth Vijayan (1):
>   s390/cio: add support for fces status notification
> 
>  arch/s390/include/asm/ccwdev.h |  1 +
>  drivers/s390/cio/chp.h         |  1 +
>  drivers/s390/cio/chsc.c        | 73 ++++++++++++++++++++++++++++++++++
>  drivers/s390/cio/device.c      | 19 ++++++++-
>  4 files changed, 93 insertions(+), 1 deletion(-)

Please disregard this RFC for now - the patches need some more internal
discussions before they are ready for external review.


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
