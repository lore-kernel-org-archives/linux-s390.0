Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbgD1I1n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 04:27:43 -0400
Subject: Re: [kvm-unit-tests PATCH v6 07/10] s390x: css: msch, enable test
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-8-git-send-email-pmorel@linux.ibm.com>
 <cff917e0-f7e0-fd48-eda5-0cbe8173ae8a@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <abafd691-d9ab-33b2-c522-d37fecc3e881@linux.ibm.com>
Date: Tue, 28 Apr 2020 10:27:36 +0200
MIME-Version: 1.0
In-Reply-To: <cff917e0-f7e0-fd48-eda5-0cbe8173ae8a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-04-27 15:11, Janosch Frank wrote:
> On 4/24/20 12:45 PM, Pierre Morel wrote:
>> A second step when testing the channel subsystem is to prepare a channel
>> for use.
>> This includes:
>> - Get the current SubCHannel Information Block (SCHIB) using STSCH
>> - Update it in memory to set the ENABLE bit
>> - Tell the CSS that the SCHIB has been modified using MSCH
>> - Get the SCHIB from the CSS again to verify that the subchannel is
>>    enabled.
>>
>> This tests the MSCH instruction to enable a channel succesfuly.
> 
> successfully

Thx

> 
>> This is NOT a routine to really enable the channel, no retry is done,
>> in case of error, a report is made.
> 
> Would we expect needing retries for the pong device?

Yes it can be that we need to retry some instructions if we want them to 
succeed.
This is the case for example if we develop a driver for an operating system.
When working with firmware, sometime, things do not work at the first 
time. Mostly due to races in silicium, firmware or hypervisor or between 
them all.

Since our purpose is to detect such problems we do not retry 
instructions but report the error.

If we detect such problem we may in the future enhance the tests.

> 
>>


>> +
>> +	if (!test_device_sid) {
>> +		report_skip("No device");
>> +		return;
>> +	}
> 
> If these tests are layered on top of each other and need a device to
> work, we should abort or skip and exit the test if the enumeration
> doesn't bring up devices

OK, we can abort instead of skipping

>> +	report(1, "Tested");
> 
> s/Tested/Enabled/

OK

Thanks,
Regards,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
