Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28162 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbgEOHFQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 03:05:16 -0400
Subject: Re: [kvm-unit-tests PATCH v6 06/10] s390x: css: stsch, enumeration
 test
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-7-git-send-email-pmorel@linux.ibm.com>
 <20200514140552.107abbde.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <f6143792-3f35-529e-6eea-b59fa8393c72@linux.ibm.com>
Date: Fri, 15 May 2020 09:05:10 +0200
MIME-Version: 1.0
In-Reply-To: <20200514140552.107abbde.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-05-14 14:05, Cornelia Huck wrote:
> On Fri, 24 Apr 2020 12:45:48 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> First step for testing the channel subsystem is to enumerate the css and
>> retrieve the css devices.
>>
>> This tests the success of STSCH I/O instruction, we do not test the
> 
> s/of/of the/

Yes, zhanks.

> 
>> reaction of the VM for an instruction with wrong parameters.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h     |  1 +
>>   s390x/Makefile      |  2 +
>>   s390x/css.c         | 92 +++++++++++++++++++++++++++++++++++++++++++++
>>   s390x/unittests.cfg |  4 ++
>>   4 files changed, 99 insertions(+)
>>   create mode 100644 s390x/css.c
>>
> 
> (...)
> 
>> +static void test_enumerate(void)
>> +{
>> +	struct pmcw *pmcw = &schib.pmcw;
...snip...
			goto out;
>> +		default:	/* 1 or 2 should never happened for STSCH */
> 
> s/happened/happen/

Yes, thanks.

> 
>> +			report(0, "Unexpected cc=%d on subchannel number 0x%x",
>> +			       cc, scn);
>> +			return;
>> +		}
> 

Thanks,

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
