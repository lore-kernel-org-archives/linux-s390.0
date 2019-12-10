Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726890AbfLJJBy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Dec 2019 04:01:54 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBA9125f004375
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2019 04:01:53 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wrt120jjv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2019 04:01:52 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 10 Dec 2019 09:01:51 -0000
Subject: Re: [kvm-unit-tests PATCH v3 7/9] s390x: css: msch, enable test
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
 <1575649588-6127-8-git-send-email-pmorel@linux.ibm.com>
 <20191209175430.5381b328.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 10 Dec 2019 10:01:46 +0100
MIME-Version: 1.0
In-Reply-To: <20191209175430.5381b328.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a19d7e91-4048-3eaa-a819-51e95dd922de@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-09 17:54, Cornelia Huck wrote:
> On Fri,  6 Dec 2019 17:26:26 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> A second step when testing the channel subsystem is to prepare a channel
>> for use.
>> This includes:
>> - Get the current SubCHannel Information Block (SCHIB) using STSCH
>> - Update it in memory to set the ENABLE bit
>> - Tell the CSS that the SCHIB has been modified using MSCH
>> - Get the SCHIB from the CSS again to verify that the subchannel is
>>    enabled.
>>
>> This tests the success of the MSCH instruction by enabling a channel.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   s390x/css.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/s390x/css.c b/s390x/css.c
>> index 3d4a986..4c0031c 100644
>> --- a/s390x/css.c
>> +++ b/s390x/css.c
>> @@ -58,11 +58,50 @@ static void test_enumerate(void)
>>   	report("Tested %d devices, %d found", 1, scn, found);
>>   }
>>   
>> +static void test_enable(void)
>> +{
>> +	struct pmcw *pmcw = &schib.pmcw;
>> +	int cc;
>> +
>> +	if (!test_device_sid) {
>> +		report_skip("No device");
>> +		return;
>> +	}
>> +	/* Read the SCIB for this subchannel */
> 
> s/SCIB/SCHIB/

yes

> 
>> +	cc = stsch(test_device_sid, &schib);
>> +	if (cc) {
>> +		report("stsch cc=%d", 0, cc);
>> +		return;
>> +	}
>> +	/* Update the SCHIB to enable the channel */
>> +	pmcw->flags |= PMCW_ENABLE;
>> +
>> +	/* Tell the CSS we want to modify the subchannel */
>> +	cc = msch(test_device_sid, &schib);
>> +	if (cc) {
>> +		report("msch cc=%d", 0, cc);
> 
> So you expect the subchannel to be idle? Probably true, especially as
> QEMU has no reason to post an unsolicited interrupt for a test device.
> 
>> +		return;
>> +	}
>> +
>> +	/* Read the SCHIB again to verify the enablement */
>> +	cc = stsch(test_device_sid, &schib);
>> +	if (cc) {
>> +		report("stsch cc=%d", 0, cc);
>> +		return;
>> +	}
>> +	if (!(pmcw->flags & PMCW_ENABLE)) {
>> +		report("Enable failed. pmcw: %x", 0, pmcw->flags);
> 
> This check is fine when running under KVM. If this test is modified to
> run under z/VM in the future, you probably should retry here: I've seen
> the enable bit 'stick' only after the second msch() there.

Oh. Thanks, may be I can loop with a delay and count.
If I need to do this may be I need to create dedicated sub-functions to 
include the sanity tests.

> 
>> +		return;
>> +	}
>> +	report("Tested", 1);
>> +}
>> +
>>   static struct {
>>   	const char *name;
>>   	void (*func)(void);
>>   } tests[] = {
>>   	{ "enumerate (stsch)", test_enumerate },
>> +	{ "enable (msch)", test_enable },
>>   	{ NULL, NULL }
>>   };
>>   
> 

-- 
Pierre Morel
IBM Lab Boeblingen
