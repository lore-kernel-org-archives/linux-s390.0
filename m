Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfLIQnC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 11:43:02 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9GMOwq036055
        for <linux-s390@vger.kernel.org>; Mon, 9 Dec 2019 11:43:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsm2d0rd0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 11:43:01 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 9 Dec 2019 16:42:59 -0000
Subject: Re: [kvm-unit-tests PATCH v3 6/9] s390x: css: stsch, enumeration test
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
 <1575649588-6127-7-git-send-email-pmorel@linux.ibm.com>
 <977b5622-4890-19b5-693a-ae0295fcb883@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 9 Dec 2019 17:42:54 +0100
MIME-Version: 1.0
In-Reply-To: <977b5622-4890-19b5-693a-ae0295fcb883@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5e76b341-1cb2-62bc-6fd7-260673d07bb9@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2019-12-09 12:52, Thomas Huth wrote:
> On 06/12/2019 17.26, Pierre Morel wrote:
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
>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>> index 6f19bb5..d37227b 100644
>> --- a/lib/s390x/css.h
>> +++ b/lib/s390x/css.h
>> @@ -82,6 +82,7 @@ struct pmcw {
>>   	uint8_t  chpid[8];
>>   	uint16_t flags2;
>>   };
>> +#define PMCW_CHANNEL_TYPE(pmcw) (pmcw->flags >> 21)
>>   
>>   struct schib {
>>   	struct pmcw pmcw;
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index 3744372..9ebbb84 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -16,6 +16,7 @@ tests += $(TEST_DIR)/diag288.elf
>>   tests += $(TEST_DIR)/stsi.elf
>>   tests += $(TEST_DIR)/skrf.elf
>>   tests += $(TEST_DIR)/smp.elf
>> +tests += $(TEST_DIR)/css.elf
>>   tests_binary = $(patsubst %.elf,%.bin,$(tests))
>>   
>>   all: directories test_cases test_cases_binary
>> @@ -50,6 +51,7 @@ cflatobjs += lib/s390x/sclp-console.o
>>   cflatobjs += lib/s390x/interrupt.o
>>   cflatobjs += lib/s390x/mmu.o
>>   cflatobjs += lib/s390x/smp.o
>> +cflatobjs += lib/s390x/css_dump.o
>>   
>>   OBJDIRS += lib/s390x
>>   
>> diff --git a/s390x/css.c b/s390x/css.c
>> new file mode 100644
>> index 0000000..3d4a986
>> --- /dev/null
>> +++ b/s390x/css.c
>> @@ -0,0 +1,82 @@
>> +/*
>> + * Channel Subsystem tests
>> + *
>> + * Copyright (c) 2019 IBM Corp
>> + *
>> + * Authors:
>> + *  Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2.
>> + */
>> +
>> +#include <libcflat.h>
>> +
>> +#include <css.h>
>> +
>> +#define SID_ONE		0x00010000
>> +
>> +static struct schib schib;
>> +
>> +static const char *Channel_type[4] = {
>> +	"I/O", "CHSC", "MSG", "EADM"
>> +};
>> +
>> +static int test_device_sid;
>> +
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
>> +			report_info("SID %04x Type %s PIM %x", scn,
>> +				     Channel_type[PMCW_CHANNEL_TYPE(pmcw)],
>> +				     pmcw->pim);
>> +			for (i = 0; i < 8; i++)  {
>> +				if ((pmcw->pim << i) & 0x80) {
>> +					report_info("CHPID[%d]: %02x", i,
>> +						    pmcw->chpid[i]);
>> +					break;
>> +				}
>> +			}
>> +			found++;
>> +		}
>> +		if (cc == 3) /* cc = 3 means no more channel in CSS */
>> +			break;
>> +		if (found && !test_device_sid)
>> +			test_device_sid = scn|SID_ONE;
>> +	}
>> +	if (!found) {
>> +		report("Tested %d devices, none found", 0, scn);
>> +		return;
>> +	}
>> +	report("Tested %d devices, %d found", 1, scn, found);
> 
> I'm sorry, but since last Friday, you now have to swap the first two
> parameters of the report() function. (that was unfortunately necessary
> to fix an issue with Clang)
> 
>   Thomas
> 

grrr.   :)

OK, will do.

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
