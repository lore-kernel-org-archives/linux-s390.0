Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgGPI6N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 04:58:13 -0400
Subject: Re: [kvm-unit-tests PATCH v13 9/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1594887809-10521-1-git-send-email-pmorel@linux.ibm.com>
 <1594887809-10521-10-git-send-email-pmorel@linux.ibm.com>
 <d60336e9-9038-89b3-f1d6-82c9ee4b3aaa@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <83702244-22df-35c9-4154-7f6113e4393d@linux.ibm.com>
Date: Thu, 16 Jul 2020 10:58:06 +0200
MIME-Version: 1.0
In-Reply-To: <d60336e9-9038-89b3-f1d6-82c9ee4b3aaa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, drjones@redhat.com



On 2020-07-16 10:46, Thomas Huth wrote:
> On 16/07/2020 10.23, Pierre Morel wrote:
>> After a channel is enabled we start a SENSE_ID command using
>> the SSCH instruction to recognize the control unit and device.
>>
>> This tests the success of SSCH, the I/O interruption and the TSCH
>> instructions.
>>
>> The SENSE_ID command response is tested to report 0xff inside
>> its reserved field and to report the same control unit type
>> as the cu_type kernel argument.
>>
>> Without the cu_type kernel argument, the test expects a device
>> with a default control unit type of 0x3832, a.k.a virtio-net-ccw.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
> [...]
>> +/*
>> + * css_residual_count
>> + * Return the residual count, if it is valid.
>> + *
>> + * Return value:
>> + * Success: the residual count
>> + * Not meaningful: -1 (-1 can not be a valid count)
>> + */
>> +int css_residual_count(unsigned int schid)
>> +{
>> +
>> +	if (!(irb.scsw.ctrl & (SCSW_SC_PENDING | SCSW_SC_PRIMARY)))
>> +		goto invalid;
>> +
>> +	if (irb.scsw.dev_stat)
>> +		if (irb.scsw.sch_stat & ~(SCSW_SCHS_PCI | SCSW_SCHS_IL))
>> +			goto invalid;
>> +
>> +	return irb.scsw.count;
>> +
>> +invalid:
>> +	return -1;
>> +}
> 
> I still think this would look nicer without gotos. Anyway,

You are right.
Thanks to let me modify this later.

> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
