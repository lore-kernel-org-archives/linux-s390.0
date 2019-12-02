Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726673AbfLBR4F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 12:56:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2HlU71089002
        for <linux-s390@vger.kernel.org>; Mon, 2 Dec 2019 12:56:04 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6rqg6dm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Dec 2019 12:56:04 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 2 Dec 2019 17:56:02 -0000
Subject: Re: [kvm-unit-tests PATCH v2 7/9] s390x: css: msch, enable test
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-8-git-send-email-pmorel@linux.ibm.com>
 <20191202153016.382e3fa8.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 2 Dec 2019 18:55:57 +0100
MIME-Version: 1.0
In-Reply-To: <20191202153016.382e3fa8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <14ca95f4-f64c-6535-776a-639b45269cd2@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-02 15:30, Cornelia Huck wrote:
> On Thu, 28 Nov 2019 13:46:05 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> A second step when testing the channel subsystem is to prepare a channel
>> for use.
>>
>> This tests the success of the MSCH instruction by enabling a channel.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   s390x/css.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/s390x/css.c b/s390x/css.c
>> index 8186f55..e42dc2f 100644
>> --- a/s390x/css.c
>> +++ b/s390x/css.c
>> @@ -62,11 +62,38 @@ static void test_enumerate(void)
>>   	return;
>>   }
>>   
>> +static void set_schib(void)
>> +{
>> +	struct pmcw *p = &schib.pmcw;
>> +
>> +	p->intparm = 0xdeadbeef;
>> +	p->flags |= PMCW_ENABLE;
>> +}
>> +
>> +static void test_enable(void)
>> +{
>> +	int ret;
>> +
>> +	if (!test_device_sid) {
>> +		report_skip("No device");
>> +		return;
>> +	}
>> +	set_schib();
>> +	dump_schib(&schib);
>> +
>> +	ret = msch(test_device_sid, &schib);
>> +	if (ret)
>> +		report("msch cc=%d", 0, ret);
> 
> Maybe do a stsch and then check/dump the contents of the schib again?
> 
> Background: The architecture allows that msch returns success, but that
> the fields modified by the issuer remain unchanged at the subchannel
> regardless. That should not happen with QEMU; but I remember versions
> of z/VM where we sometimes had to call msch twice to make changes stick.

OK, thanks, good advice

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
