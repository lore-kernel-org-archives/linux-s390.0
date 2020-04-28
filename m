Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgD1IRg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 04:17:36 -0400
Subject: Re: [kvm-unit-tests PATCH v6 06/10] s390x: css: stsch, enumeration
 test
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-7-git-send-email-pmorel@linux.ibm.com>
 <2f1e27a9-1cb2-79b2-b655-6f170431a14f@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <9eb8ac80-057f-0fb1-0f95-4a6ab91136b5@linux.ibm.com>
Date: Tue, 28 Apr 2020 10:17:29 +0200
MIME-Version: 1.0
In-Reply-To: <2f1e27a9-1cb2-79b2-b655-6f170431a14f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-04-27 15:06, Janosch Frank wrote:
> On 4/24/20 12:45 PM, Pierre Morel wrote:
>> First step for testing the channel subsystem is to enumerate the css and
>> retrieve the css devices.
>>
...snip...
>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>> index bab0dd5..9417541 100644
>> --- a/lib/s390x/css.h
>> +++ b/lib/s390x/css.h
>> @@ -82,6 +82,7 @@ struct pmcw {
>>   	uint8_t  chpid[8];
>>   	uint32_t flags2;
>>   };
>> +#define PMCW_CHANNEL_TYPE(pmcw) (pmcw->flags2 >> 21)
> 
> Why isn't this in the library patch?

OK


>> @@ -51,6 +52,7 @@ cflatobjs += lib/s390x/sclp-console.o
>>   cflatobjs += lib/s390x/interrupt.o
>>   cflatobjs += lib/s390x/mmu.o
>>   cflatobjs += lib/s390x/smp.o
>> +cflatobjs += lib/s390x/css_dump.o
> 
> Why isn't this in the library patch?

OK

> 
...snip...
>> +#define SID_ONE		0x00010000
> 
> Why isn't this in the library patch?

OK

> 
...snip...
>> +		if (!test_device_sid)
>> +			test_device_sid = scn|SID_ONE;
> 
> Give the pipe some space :)
> 
>> +		dev_found++;
> 
> Newlines would make this more readable.

OK and yes.

> 
>> +	}
>> +out:
> 
> We can report dev_found instead of 0/1 and a if/else
> 
> report(dev_found,
> 	"Tested subchannels: %d, I/O subchannels: %d, I/O devices: %d",
>                      scn, scn_found, dev_found);	

Yes, :)


Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
