Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727480AbfLMQuJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Dec 2019 11:50:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDGhnuB124354
        for <linux-s390@vger.kernel.org>; Fri, 13 Dec 2019 11:50:08 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxspc4u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 13 Dec 2019 11:50:07 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 13 Dec 2019 16:50:06 -0000
Subject: Re: [kvm-unit-tests PATCH v4 9/9] s390x: css: ping pong
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-10-git-send-email-pmorel@linux.ibm.com>
 <20191213105009.482bab48.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 13 Dec 2019 17:50:02 +0100
MIME-Version: 1.0
In-Reply-To: <20191213105009.482bab48.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bb6c04a1-501c-16c4-107b-f10ac9d1e41d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-13 10:50, Cornelia Huck wrote:
> On Wed, 11 Dec 2019 16:46:10 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> To test a write command with the SSCH instruction we need a QEMU device,
>> with control unit type 0xC0CA. The PONG device is such a device.
>>
>> This type of device responds to PONG_WRITE requests by incrementing an
>> integer, stored as a string at offset 0 of the CCW data.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   s390x/css.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/s390x/css.c b/s390x/css.c
>> index 7b9bdb1..a09cdff 100644
>> --- a/s390x/css.c
>> +++ b/s390x/css.c
>> @@ -26,6 +26,9 @@
>>   
>>   #define CSS_TEST_INT_PARAM	0xcafec0ca
>>   #define PONG_CU_TYPE		0xc0ca
>> +/* Channel Commands for PONG device */
>> +#define PONG_WRITE	0x21 /* Write */
>> +#define PONG_READ	0x22 /* Read buffer */
>>   
>>   struct lowcore *lowcore = (void *)0x0;
>>   
>> @@ -302,6 +305,48 @@ unreg_cb:
>>   	unregister_io_int_func(irq_io);
>>   }
>>   
>> +static void test_ping(void)
>> +{
>> +	int success, result;
>> +	int cnt = 0, max = 4;
>> +
>> +	if (senseid.cu_type != PONG_CU) {
>> +		report_skip("No PONG, no ping-pong");
>> +		return;
>> +	}
>> +
>> +	result = register_io_int_func(irq_io);
>> +	if (result) {
>> +		report(0, "Could not register IRQ handler");
>> +		return;
>> +	}
>> +
>> +	while (cnt++ < max) {
>> +		snprintf(buffer, BUF_SZ, "%08x\n", cnt);
>> +		success = start_subchannel(PONG_WRITE, buffer, 8);
> 
> Magic value? Maybe introduce a #define for the lengths of the
> reads/writes?

OK, and I also do not need a buffer so big.

> 
> [This also got me thinking about your start_subchannel function
> again... do you also want to allow flags like e.g. SLI? It's not
> unusual for commands to return different lengths of data depending on
> what features are available; it might be worthwhile to allow short data
> if you're not sure that e.g. a command returns either the short or the
> long version of a structure.]

I would prefer to keep simple it in this series if you agree.

AFAIU the current QEMU implementation use a fix length and if a short 
read occurs it is an error.
Since we test on PONG, there should be no error.

I agree that for a general test we should change this, but currently the 
goal is just to verify that the remote device is PONG.

If we accept variable length, we need to check the length of what we 
received, and this could need some infrastructure changes that I would 
like to do later.

When the series is accepted I will begin to do more complicated things like:
- checking the exceptions for wrong parameters
   This is the first I will add.
- checking the response difference on flags (SLI, SKP)
- using CC and CD flags for chaining
- TIC, NOP, suspend/resume and PCI

These last one will be fun, we can also trying to play with prefetch 
while at it. :)

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
