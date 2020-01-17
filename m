Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46607 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgAQK3P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Jan 2020 05:29:15 -0500
Subject: Re: [kvm-unit-tests PATCH v2 7/7] s390x: smp: Dirty fpc before
 initial reset test
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-8-frankja@linux.ibm.com>
 <0ddfb1ce-16e4-017f-078b-80146bfa29a6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3f034419-2342-0571-ea68-0474d45ba552@redhat.com>
Date: Fri, 17 Jan 2020 11:29:06 +0100
MIME-Version: 1.0
In-Reply-To: <0ddfb1ce-16e4-017f-078b-80146bfa29a6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 17/01/2020 11.20, David Hildenbrand wrote:
> On 16.01.20 13:05, Janosch Frank wrote:
>> Let's dirty the fpc, before we test if the initial reset sets it to 0.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  s390x/smp.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index ce3215d..97a9dda 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -179,6 +179,9 @@ static void test_emcall(void)
>>  /* Used to dirty registers of cpu #1 before it is reset */
>>  static void test_func_initial(void)
>>  {
>> +	asm volatile(
>> +		"	sfpc	%0\n"
>> +		: : "d" (0x11) : );
> 
> FWIW, I'd make this one easier to read
> 
> asm volatile("sfpc %0\n" :: "d" (0x11));

By the way, since it's only one line, you can also drop the \n here.

 Thomas
