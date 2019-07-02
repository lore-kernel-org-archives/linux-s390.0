Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbfGBOHm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jul 2019 10:07:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62E5tEH004605
        for <linux-s390@vger.kernel.org>; Tue, 2 Jul 2019 10:07:40 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tg72jvkuc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 02 Jul 2019 10:07:40 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <alifm@linux.ibm.com>;
        Tue, 2 Jul 2019 15:07:39 +0100
Subject: Re: [RFC v1 3/4] vfio-ccw: Set pa_nr to 0 if memory allocation fails
 for pa_iova_pfn
References: <cover.1561997809.git.alifm@linux.ibm.com>
 <19d813c58e0c45df3f23d8b1033e00b5ac5c7779.1561997809.git.alifm@linux.ibm.com>
 <20190702104550.7d2e7563.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 2 Jul 2019 10:07:35 -0400
MIME-Version: 1.0
In-Reply-To: <20190702104550.7d2e7563.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <96b27fc4-5899-b17e-0a93-31e7b69f80a7@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 07/02/2019 04:45 AM, Cornelia Huck wrote:
> On Mon,  1 Jul 2019 12:23:45 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> So we clean up correctly.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_cp.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
>> index cab1be9..c5655de 100644
>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>> @@ -72,8 +72,10 @@ static int pfn_array_alloc(struct pfn_array *pa, u64 iova, unsigned int len)
>>   				  sizeof(*pa->pa_iova_pfn) +
>>   				  sizeof(*pa->pa_pfn),
>>   				  GFP_KERNEL);
>> -	if (unlikely(!pa->pa_iova_pfn))
>> +	if (unlikely(!pa->pa_iova_pfn)) {
>> +		pa->pa_nr = 0;
>>   		return -ENOMEM;
>> +	}
>>   	pa->pa_pfn = pa->pa_iova_pfn + pa->pa_nr;
>>   
>>   	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;
> 
> This looks like an older error -- can you give a Fixes: tag? (Yeah, I
> know I sound like a broken record wrt that tag... :)
> 
Yes, this is an older error. And yup I will add a fixes tag :)
