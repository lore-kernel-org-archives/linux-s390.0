Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbfLCI7D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Dec 2019 03:59:03 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB38v0NJ125898
        for <linux-s390@vger.kernel.org>; Tue, 3 Dec 2019 03:59:02 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wkrj5dfw7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 03 Dec 2019 03:59:01 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 3 Dec 2019 08:58:58 -0000
Subject: Re: [kvm-unit-tests PATCH v2 8/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-9-git-send-email-pmorel@linux.ibm.com>
 <20191202155510.410666a0.cohuck@redhat.com>
 <00d5235b-eaaa-172c-6aa0-09e45be43635@linux.ibm.com>
 <20191202205443.3711e682.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 3 Dec 2019 09:58:54 +0100
MIME-Version: 1.0
In-Reply-To: <20191202205443.3711e682.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2d071a4e-67e4-66ed-cb60-cf22d1c66b27@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-02 20:54, Cornelia Huck wrote:
> On Mon, 2 Dec 2019 19:18:20 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2019-12-02 15:55, Cornelia Huck wrote:
>>> On Thu, 28 Nov 2019 13:46:06 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>> +	ccw[0].code = code ;
>>>
>>> Extra ' ' before ';'
>>
>> yes, thanks
>>
>>>    
>>>> +	ccw[0].flags = CCW_F_PCI;
>>>
>>> Huh, what's that PCI for?
>>
>> Program Control Interruption
> 
> Yes; but why do you need it? Doesn't the QEMU device provide you with
> an interrupt for the final status? I don't think PCI makes sense unless
> you want a notification for the progress through a chain.

Right, but this is for a later test.
So I do not need it. Will remove it.

> 
>>
>> I will add a comment :)
> 
> Good idea; the PCI is bound to confuse people :)
> 
>>
>>>    
>>>> +	ccw[0].count = count;
>>>> +	ccw[0].data = (int)(unsigned long)data;
>>>
>>> Can you be sure that data is always below 2G?
>>
>> Currently yes, the program is loaded at 0x10000 and is quite small
>> also doing a test does not hurt for the case the function is used in
>> another test someday.
> 
> Nod.

Will do.

> 
>>
>>>    
>>>> +	orb_p->intparm = 0xcafec0ca;
>>>> +	orb_p->ctrl = ORB_F_INIT_IRQ|ORB_F_FORMAT|ORB_F_LPM_DFLT;
>>>> +	orb_p->cpa = (unsigned int) (unsigned long)&ccw[0];
>>>> +
>>>> +	report_prefix_push("Start Subchannel");
>>>> +	ret = ssch(test_device_sid, orb_p);
>>>> +	if (ret) {
>>>> +		report("ssch cc=%d", 0, ret);
>>>> +		report_prefix_pop();
>>>> +		return 0;
>>>> +	}
>>>> +	report_prefix_pop();
>>>> +	return 1;
>>>> +}
>>>> +
>>>> +static void test_sense(void)
>>>> +{
>>>> +	int success;
>>>> +
>>>> +	enable_io_irq();
>>>> +
>>>> +	success = start_subchannel(CCW_CMD_SENSE_ID, buffer, sizeof(senseid));
>>>> +	if (!success) {
>>>> +		report("start_subchannel failed", 0);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	senseid.cu_type = buffer[2] | (buffer[1] << 8);
>>>> +	delay(1000);
>>>> +
>>>> +	/* Sense ID is non packed cut_type is at offset +1 byte */
>>>> +	if (senseid.cu_type == PONG_CU)
>>>> +		report("cu_type: expect c0ca, got %04x", 1, senseid.cu_type);
>>>> +	else
>>>> +		report("cu_type: expect c0ca, got %04x", 0, senseid.cu_type);
>>>> +}
>>>
>>> I'm not really convinced by that logic here. This will fall apart if
>>> you don't have your pong device exactly in the right place, and it does
>>> not make it easy to extend this for more devices in the future.
>>
>> Wanted to keep things simple. PONG must be the first valid channel.
>> also, should be documented at least.
> 
> Yes, please :)
> 

Thanks.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
