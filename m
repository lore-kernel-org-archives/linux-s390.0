Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726881AbfLJI4m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Dec 2019 03:56:42 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBA8q5lo019340
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2019 03:56:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsrdn8m02-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2019 03:56:41 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 10 Dec 2019 08:56:39 -0000
Subject: Re: [kvm-unit-tests PATCH v3 6/9] s390x: css: stsch, enumeration test
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
 <1575649588-6127-7-git-send-email-pmorel@linux.ibm.com>
 <20191209174938.7df1ffa2.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 10 Dec 2019 09:56:35 +0100
MIME-Version: 1.0
In-Reply-To: <20191209174938.7df1ffa2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e2d4611a-f702-36b9-9344-fdc4f4e771bf@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-09 17:49, Cornelia Huck wrote:
> On Fri,  6 Dec 2019 17:26:25 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> First step for testing the channel subsystem is to enumerate the css and
>> retrieve the css devices.
>>
>> This tests the success of STSCH I/O instruction.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h     |  1 +
>>   s390x/Makefile      |  2 ++
>>   s390x/css.c         | 82 +++++++++++++++++++++++++++++++++++++++++++++
>>   s390x/unittests.cfg |  4 +++
>>   4 files changed, 89 insertions(+)
>>   create mode 100644 s390x/css.c
>>
> 
>> +static void test_enumerate(void)
>> +{
>> +	struct pmcw *pmcw = &schib.pmcw;
>> +	int scn;
>> +	int cc, i;
>> +	int found = 0;
>> +
>> +	for (scn = 0; scn < 0xffff; scn++) {
>> +		cc = stsch(scn|SID_ONE, &schib);
>> +		if (!cc && (pmcw->flags & PMCW_DNV)) {
> 
> Not sure when dnv is actually applicable... it is used for I/O
> subchannels; chsc subchannels don't have a device; message subchannels
> use a different bit IIRC; not sure about EADM subchannels.
> 
> [Not very relevant as long as we run under KVM, but should be
> considered if you plan to run this test under z/VM or LPAR as well.]

Hum, interresting, I will check and modify accordingly.

> 
>> +			report_info("SID %04x Type %s PIM %x", scn,
>> +				     Channel_type[PMCW_CHANNEL_TYPE(pmcw)],
>> +				     pmcw->pim);
>> +			for (i = 0; i < 8; i++)  {
>> +				if ((pmcw->pim << i) & 0x80) {
>> +					report_info("CHPID[%d]: %02x", i,
>> +						    pmcw->chpid[i]);
>> +					break;
> 
> That 'break;' seems odd -- won't you end up printing the first chpid in
> the pim only?
yes
> 
> Maybe modify this loop to print the chpid if the path is in the pim,
> and 'n/a' or so if not?

OK

> 
>> +				}
>> +			}
>> +			found++;
>> +		}
>> +		if (cc == 3) /* cc = 3 means no more channel in CSS */
> 
> s/channel/subchannels/

thanks

> 
>> +			break;
>> +		if (found && !test_device_sid)
>> +			test_device_sid = scn|SID_ONE;
>> +	}
>> +	if (!found) {
>> +		report("Tested %d devices, none found", 0, scn);
>> +		return;
>> +	}
>> +	report("Tested %d devices, %d found", 1, scn, found);
>> +}
> 

Thanks for the reviewing,
Regards,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
