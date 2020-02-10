Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726991AbgBJSqv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 13:46:51 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AIj66N027452
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:46:50 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u9paaf8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:46:50 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 18:46:48 -0000
Subject: Re: [PATCH 1/1] s390/uv: Fix handling of length extensions
References: <20200210165439.3767-1-borntraeger@de.ibm.com>
 <20200210165439.3767-2-borntraeger@de.ibm.com>
 <20200210183152.40bfae24.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 19:46:42 +0100
MIME-Version: 1.0
In-Reply-To: <20200210183152.40bfae24.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c4467ccc-9d59-bab1-5231-d9bb766115c6@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>



On 10.02.20 18:31, Cornelia Huck wrote:
> On Mon, 10 Feb 2020 11:54:39 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> The query parameter block might contain additional information and can
>> be extended in the future. If the size of the block does not suffice we
>> get an error code of rc=0x100.  The buffer will contain all information
>> up to the specified size and the hypervisor/guest simply do not need the
>> additional information as they do not know about the new data.  That
>> means that we can (and must) accept rc=0x100 as success.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 5abb9351dfd9 ("s390/uv: introduce guest side ultravisor code")
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/boot/uv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
>> index af9e1cc93c68..c003593664cd 100644
>> --- a/arch/s390/boot/uv.c
>> +++ b/arch/s390/boot/uv.c
>> @@ -21,7 +21,7 @@ void uv_query_info(void)
>>  	if (!test_facility(158))
>>  		return;
>>  
>> -	if (uv_call(0, (uint64_t)&uvcb))
>> +	if (uv_call(0, (uint64_t)&uvcb) && uvcb.header.rc != 0x100)
> 
> Add a comment like
> 
> /* rc==0x100 means that there is additional data we do not process */

ack.

> 
> to avoid headscratching in the future?
> 
>>  		return;
>>  
>>  	if (IS_ENABLED(CONFIG_KVM)) {
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
