Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbgD1Iu2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 04:50:28 -0400
Subject: Re: [kvm-unit-tests PATCH v6 10/10] s390x: css: ping pong
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-11-git-send-email-pmorel@linux.ibm.com>
 <ecd95341-0cc2-1aee-239d-5de63cf6e7e1@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <6591ec0d-5b44-1d85-a314-c6b9f87b7952@linux.ibm.com>
Date: Tue, 28 Apr 2020 10:50:20 +0200
MIME-Version: 1.0
In-Reply-To: <ecd95341-0cc2-1aee-239d-5de63cf6e7e1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-04-27 15:14, Janosch Frank wrote:
> On 4/24/20 12:45 PM, Pierre Morel wrote:
>> To test a write command with the SSCH instruction we need a QEMU device,
>> with control unit type 0xC0CA. The PONG device is such a device.
>>
>> This type of device responds to PONG_WRITE requests by incrementing an
>> integer, stored as a string at offset 0 of the CCW data.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

>> +static void test_ping(void)
>> +{
>> +	int success, result;
>> +	int cnt = 0, max = 4;
>> +
>> +	if (senseid.cu_type != PONG_CU) {
>> +		report_skip("No PONG, no ping-pong");
> 
> "Device is not a pong device."

:( so far for poetry


> 
>> +		return;
>> +	}
>> +
>> +	result = register_io_int_func(irq_io);
>> +	if (result) {
>> +		report(0, "Could not register IRQ handler");
>> +		return;
>> +	}
> 
> I'm not sure if it's worth checking the return values or even having a
> check in register_io_int_func() in the first place.

I wait for reviewers/maintainers having already given their reviewed-by 
to the interrupt registration patch to give their opinion.
Then I change it if needed.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
