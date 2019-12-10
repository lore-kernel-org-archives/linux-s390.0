Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbfLJJMh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Dec 2019 04:12:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBA9CZtp017181
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2019 04:12:36 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsm2dvhsm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2019 04:12:35 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 10 Dec 2019 09:12:32 -0000
Subject: Re: [kvm-unit-tests PATCH v3 8/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
 <1575649588-6127-9-git-send-email-pmorel@linux.ibm.com>
 <20191209182213.69e14263.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 10 Dec 2019 10:12:29 +0100
MIME-Version: 1.0
In-Reply-To: <20191209182213.69e14263.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <502977b7-ad73-3468-92c9-7798cff6f754@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-09 18:22, Cornelia Huck wrote:
> On Fri,  6 Dec 2019 17:26:27 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> When a channel is enabled we can start a SENSE command using the SSCH
>> instruction to recognize the control unit and device.
>>
>> This tests the success of SSCH, the I/O interruption and the TSCH
>> instructions.
>>
>> The test expects a device with a control unit type of 0xC0CA as the
>> first subchannel of the CSS.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h |  13 ++++
>>   s390x/css.c     | 164 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 177 insertions(+)
>>
> 
>> +static void irq_io(void)
>> +{
>> +	int ret = 0;
>> +	char *flags;
>> +
>> +	report_prefix_push("Interrupt");
>> +	if (lowcore->io_int_param != 0xcafec0ca) {
>> +		report("Bad io_int_param: %x", 0, lowcore->io_int_param);
> 
> Use a #define for the intparm and print got vs. expected on mismatch?

OK

> 
>> +		report_prefix_pop();
>> +		return;
>> +	}
>> +	report("io_int_param: %x", 1, lowcore->io_int_param);
> 
> Well, at that moment you already know what the intparm is, don't you? :)

Yes, I can remove this, was for debug purpose.

> 
>> +	report_prefix_pop();
>> +
>> +	ret = tsch(lowcore->subsys_id_word, &irb);
>> +	dump_irb(&irb);
>> +	flags = dump_scsw_flags(irb.scsw.ctrl);
>> +
>> +	if (ret)
>> +		report("IRB scsw flags: %s", 0, flags);
> 
> I think you should also distinguish between cc 1 (not status pending)
> and cc 3 (not operational) here (or at least also print that info).

Yes, right, thanks.

> 
>> +	else
>> +		report("IRB scsw flags: %s", 1, flags);
>> +	report_prefix_pop();
>> +}
>> +
>> +static int start_subchannel(int code, char *data, int count)
>> +{
>> +	int ret;
>> +	struct pmcw *p = &schib.pmcw;
>> +	struct orb *orb_p = &orb[0];
>> +
>> +	/* Verify that a test subchannel has been set */
>> +	if (!test_device_sid) {
>> +		report_skip("No device");
>> +		return 0;
>> +	}
>> +
>> +	/* Verify that the subchannel has been enabled */
>> +	ret = stsch(test_device_sid, &schib);
>> +	if (ret) {
>> +		report("Err %d on stsch on sid %08x", 0, ret, test_device_sid);
>> +		return 0;
>> +	}
>> +	if (!(p->flags & PMCW_ENABLE)) {
>> +		report_skip("Device (sid %08x) not enabled", test_device_sid);
>> +		return 0;
>> +	}
>> +
>> +	report_prefix_push("Start Subchannel");
>> +	/* Build the CCW chain with a single CCW */
>> +	ccw[0].code = code;
>> +	ccw[0].flags = 0; /* No flags need to be set */
>> +	ccw[0].count = count;
>> +	ccw[0].data_address = (int)(unsigned long)data;
>> +	orb_p->intparm = 0xcafec0ca;
>> +	orb_p->ctrl = ORB_F_INIT_IRQ|ORB_F_FORMAT|ORB_F_LPM_DFLT;
>> +	if ((unsigned long)&ccw[0] >= 0x80000000UL) {
>> +		report("Data above 2G! %016lx", 0, (unsigned long)&ccw[0]);
> 
> Check for data under 2G before you set up data_address as well?

yes. Even more important since it is a parameter.

> 
>> +		report_prefix_pop();
>> +		return 0;
>> +	}
>> +	orb_p->cpa = (unsigned int) (unsigned long)&ccw[0];
>> +
>> +	ret = ssch(test_device_sid, orb_p);
>> +	if (ret) {
>> +		report("ssch cc=%d", 0, ret);
>> +		report_prefix_pop();
>> +		return 0;
>> +	}
>> +	report_prefix_pop();
>> +	return 1;
>> +}
>> +
>> +/*
>> + * test_sense
>> + * Pre-requisits:
>> + * 	We need the QEMU PONG device as the first recognized
>> + *	device by the enumeration.
>> + *	./s390x-run s390x/css.elf -device ccw-pong,cu_type=0xc0ca
>> + */
>> +static void test_sense(void)
>> +{
>> +	int ret;
>> +
>> +	ret = register_io_int_func(irq_io);
>> +	if (ret) {
>> +		report("Could not register IRQ handler", 0);
>> +		goto unreg_cb;
>> +	}
>> +
>> +	enable_io_irq();
>> +
>> +	ret = start_subchannel(CCW_CMD_SENSE_ID, buffer, sizeof(senseid));
>> +	if (!ret) {
>> +		report("start_subchannel failed", 0);
>> +		goto unreg_cb;
>> +	}
>> +
>> +	senseid.cu_type = buffer[2] | (buffer[1] << 8);
>> +	delay(100);
> 
> Hm... registering an interrupt handler and then doing a random delay
> seems a bit odd. I'd rather expect something like
> 
> (a) check for an indication that an interrupt has arrived (global
>      variable)
> (b) wait for a bit
> (c) if timeout has not yet been hit: goto (a)
> 
> Or do a tpi loop, if this can't be done fully asynchronous?

Currently the test is done on the io_int_parameter.
And you are right there is a problem, if no interrupt happen the test is 
silently skipped

> 
> Also, I don't understand what you are doing with the buffer and
> senseid: Can't you make senseid a pointer to buffer, so that it can
> simply access the fields after they have been filled by sense id?
> 
> Lastly, it might make sense if the reserved field of senseid has been
> filled with 0xff; that way you can easily distinguish 'device is not a
> pong device' from 'senseid has not been filled out correctly'.

yes, thanks.


Thanks for comemnts,
Regards

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
