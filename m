Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgKSIch (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 03:32:37 -0500
Subject: Re: [kvm-unit-tests PATCH 1/5] s390x: Add test_bit to library
References: <20201117154215.45855-1-frankja@linux.ibm.com>
 <20201117154215.45855-2-frankja@linux.ibm.com>
 <6d61a28d-d822-b9b5-8ec6-1ea0dca1ed70@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <b2ca7724-3390-fedc-4c4f-367ecbdea682@linux.ibm.com>
Date: Thu, 19 Nov 2020 09:32:29 +0100
MIME-Version: 1.0
In-Reply-To: <6d61a28d-d822-b9b5-8ec6-1ea0dca1ed70@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On 11/19/20 9:26 AM, Thomas Huth wrote:
> On 17/11/2020 16.42, Janosch Frank wrote:
>> Query/feature bits are commonly tested via MSB bit numbers on
>> s390. Let's add test bit functions, so we don't need to copy code to
>> test query bits.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/asm/bitops.h   | 16 ++++++++++++++++
>>  lib/s390x/asm/facility.h |  3 ++-
>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/asm/bitops.h b/lib/s390x/asm/bitops.h
>> index e7cdda9..a272dd7 100644
>> --- a/lib/s390x/asm/bitops.h
>> +++ b/lib/s390x/asm/bitops.h
>> @@ -7,4 +7,20 @@
>>  
>>  #define BITS_PER_LONG	64
>>  
>> +static inline bool test_bit(unsigned long nr,
>> +			    const volatile unsigned long *ptr)
>> +{
>> +	const volatile unsigned char *addr;
>> +
>> +	addr = ((const volatile unsigned char *)ptr);
>> +	addr += (nr ^ (BITS_PER_LONG - 8)) >> 3;
>> +	return (*addr >> (nr & 7)) & 1;
>> +}
>> +
>> +static inline bool test_bit_inv(unsigned long nr,
>> +				const volatile unsigned long *ptr)
>> +{
>> +	return test_bit(nr ^ (BITS_PER_LONG - 1), ptr);
>> +}
> 
> I think you should mention in the patch description that these functions
> match the implementations in the kernel (and thus are good for kernel
> developers who are used to these).

There are only so many ways one can write 4 lines of code :-)

> 
> Thus I think you should also now add a license statement to this file
> ("SPDX-License-Identifier: GPL-2.0" or so).

Definitely, thanks for reminding me

> 
> With these modifications:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks
