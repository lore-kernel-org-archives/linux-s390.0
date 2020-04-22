Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbgDVJMk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 05:12:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M92t6x118704
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 05:12:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ggr3g56e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 05:12:38 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 22 Apr 2020 10:12:13 +0100
Subject: Re: [kvm-unit-tests PATCH v5 05/10] s390x: export the clock
 get_clock_ms() utility
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-6-git-send-email-pmorel@linux.ibm.com>
 <20200422100539.5a4f3a2f.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 22 Apr 2020 11:12:34 +0200
MIME-Version: 1.0
In-Reply-To: <20200422100539.5a4f3a2f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8e8bdbf9-f706-092a-4cde-c76f71f35f26@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-04-22 10:05, Cornelia Huck wrote:
> On Thu, 20 Feb 2020 13:00:38 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> Let's move get_clock_ms() to lib/s390/asm/time.h, so it can be used in
>> multiple places.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   lib/s390x/asm/time.h | 26 ++++++++++++++++++++++++++
>>   s390x/intercept.c    | 11 +----------
>>   2 files changed, 27 insertions(+), 10 deletions(-)
>>   create mode 100644 lib/s390x/asm/time.h
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks for the review,
Regards,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
