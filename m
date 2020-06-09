Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbgFIMUm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 08:20:42 -0400
Subject: Re: [kvm-unit-tests PATCH v8 10/12] s390x: css: stsch, enumeration
 test
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-11-git-send-email-pmorel@linux.ibm.com>
 <af39687e-4512-d147-5011-11d03b68e1bf@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <a9a44f1d-2179-5d95-f45f-172000f7a3c1@linux.ibm.com>
Date: Tue, 9 Jun 2020 14:20:35 +0200
MIME-Version: 1.0
In-Reply-To: <af39687e-4512-d147-5011-11d03b68e1bf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-09 09:39, Thomas Huth wrote:
> On 08/06/2020 10.12, Pierre Morel wrote:

...snip...

>> +int css_enumerate(void)
>> +{
>> +	struct pmcw *pmcw = &schib.pmcw;
>> +	int scn_found = 0;
>> +	int dev_found = 0;
>> +	int schid = 0;
>> +	int cc;
>> +	int scn;
>> +
>> +	for (scn = 0; scn < 0xffff; scn++) {
>> +		cc = stsch(scn | SCHID_ONE, &schib);
>> +		switch (cc) {
>> +		case 0:		/* 0 means SCHIB stored */
>> +			break;
>> +		case 3:		/* 3 means no more channels */
>> +			goto out;
>> +		default:	/* 1 or 2 should never happened for STSCH */
>> +			report_info("Unexpected error %d on subchannel %08x",
>> +				    cc, scn | SCHID_ONE);
> 
> Should this maybe even be a report_abort() instead? Or leave the error
> reporting to the caller...

report_abort() should be fine as if this happens something is really broken.

> 
>> +			return cc;
>> +		}

...snip...

>> +static void test_enumerate(void)
>> +{
>> +	test_device_sid = css_enumerate();
>> +	if (test_device_sid & SCHID_ONE) {
>> +		report(1, "First device schid: 0x%08x", test_device_sid);
>> +		return;
>> +	}
>> +
>> +	switch (test_device_sid) {
>> +	case 0:
>> +		report (0, "No I/O device found");
>> +		break;
>> +	default:	/* 1 or 2 should never happened for STSCH */
>> +		report(0, "Unexpected cc=%d during enumeration",
>> +		       test_device_sid);
>> +			return;
>> +	}
> 
> Ok, so here is now the test failure for the cc=1 or 2 that should never
> happen. That means currently you print out the CC for this error twice.
> One time should be enough, either here, or use an report_abort() in the
> css_enumerate(), I'd say.
> 
> Anyway, can you please replace this switch statement with a "if
> (!test_device_sid)" instead? Or do you plan to add more "case"
> statements later?

I will use the repor_abort() in the css_enumerate() so there
is only two case, I find a channel or not, so I don't even need the 
second if :) .

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
