Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbgFQLOX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 07:14:23 -0400
Subject: Re: [kvm-unit-tests PATCH v9 10/12] s390x: css: stsch, enumeration
 test
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-11-git-send-email-pmorel@linux.ibm.com>
 <20200617104857.1bdab6a5.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <20d6e17c-a396-1a99-938a-7e55656d518c@linux.ibm.com>
Date: Wed, 17 Jun 2020 13:14:15 +0200
MIME-Version: 1.0
In-Reply-To: <20200617104857.1bdab6a5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-06-17 10:48, Cornelia Huck wrote:
> On Mon, 15 Jun 2020 11:31:59 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> First step for testing the channel subsystem is to enumerate the css and
>> retrieve the css devices.
> 
> Maybe worth adding a note:
> 
> "We currently don't enable multiple subchannel sets and therefore only
> look in subchannel set 0."

right, thanks

> 
>>
>> This tests the success of STSCH I/O instruction, we do not test the
>> reaction of the VM for an instruction with wrong parameters.

...snip...

>> +	for (scn = 0; scn < 0xffff; scn++) {
>> +		cc = stsch(scn | SCHID_ONE, &schib);
>> +		switch (cc) {
>> +		case 0:		/* 0 means SCHIB stored */
>> +			break;
>> +		case 3:		/* 3 means no more channels */
>> +			goto out;
>> +		default:	/* 1 or 2 should never happened for STSCH */
> 
> s/happened/happen/

yes

...snip...


>> diff --git a/s390x/css.c b/s390x/css.c
...
>> +static void test_enumerate(void)
>> +{
>> +	test_device_sid = css_enumerate();
>> +	if (test_device_sid & SCHID_ONE) {
>> +		report(1, "First device schid: 0x%08x", test_device_sid);
> 
> Maybe "Schid of first I/O device" ?

yes, better.

> 
...snip...
>> +}
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
