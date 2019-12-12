Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729392AbfLLOKY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 09:10:24 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCE8Hlt130499
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 09:10:23 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wu4t78qbx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 09:10:23 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 12 Dec 2019 14:10:18 -0000
Subject: Re: [kvm-unit-tests PATCH v4 8/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-9-git-send-email-pmorel@linux.ibm.com>
 <20191212132634.3a16a389.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 12 Dec 2019 15:10:15 +0100
MIME-Version: 1.0
In-Reply-To: <20191212132634.3a16a389.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1ea58644-9f24-f547-92d5-a99dcb041502@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-12 13:26, Cornelia Huck wrote:
> On Wed, 11 Dec 2019 16:46:09 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> When a channel is enabled we can start a SENSE command using the SSCH
> 
> s/SENSE/SENSE ID/
> 
> SENSE is for getting sense data after a unit check :)

Yes, thanks.

> 
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
>>   s390x/css.c     | 175 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 188 insertions(+)
> 
>> +static void irq_io(void)
>> +{
>> +	int ret = 0;
>> +	char *flags;
>> +	int sid;
>> +
>> +	report_prefix_push("Interrupt");
>> +	if (lowcore->io_int_param != CSS_TEST_INT_PARAM) {
>> +		report(0, "Bad io_int_param: %x", lowcore->io_int_param);
>> +		report_prefix_pop();
>> +		return;
>> +	}
>> +	report_prefix_pop();
>> +
>> +	report_prefix_push("tsch");
>> +	sid = lowcore->subsys_id_word;
>> +	ret = tsch(sid, &irb);
>> +	switch (ret) {
>> +	case 1:
>> +		dump_irb(&irb);
>> +		flags = dump_scsw_flags(irb.scsw.ctrl);
>> +		report(0, "IRB scsw flags: %s", flags);
> 
> I guess that should only happen if the I/O interrupt was for another
> subchannel, and we only enable one subchannel, right?
> 
> Maybe log "I/O interrupt, but sch not status pending: <flags>"? (No
> idea how log the logged messages can be for kvm unit tests.)

Yes, the log message I had was not very useful at first sight.

> 
>> +		goto pop;
>> +	case 2:
>> +		report(0, "TSCH return unexpected CC 2");
> 
> s/return/returns/
> 
>> +		goto pop;
>> +	case 3:
>> +		report(0, "Subchannel %08x not operational", sid);
>> +		goto pop;
>> +	case 0:
>> +		/* Stay humble on success */
> 
> :)
> 
>> +		break;
>> +	}
>> +pop:
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
>> +	if ((unsigned long)data >= 0x80000000UL) {
>> +		report(0, "Data above 2G! %p", data);
>> +		return 0;
>> +	}
>> +
>> +	/* Verify that the subchannel has been enabled */
>> +	ret = stsch(test_device_sid, &schib);
>> +	if (ret) {
>> +		report(0, "Err %d on stsch on sid %08x", ret, test_device_sid);
>> +		return 0;
>> +	}
>> +	if (!(p->flags & PMCW_ENABLE)) {
>> +		report_skip("Device (sid %08x) not enabled", test_device_sid);
>> +		return 0;
>> +	}
>> +
>> +	report_prefix_push("ssch");
>> +	/* Build the CCW chain with a single CCW */
>> +	ccw[0].code = code;
>> +	ccw[0].flags = 0; /* No flags need to be set */
>> +	ccw[0].count = count;
>> +	ccw[0].data_address = (int)(unsigned long)data;
>> +	orb_p->intparm = CSS_TEST_INT_PARAM;
>> +	orb_p->ctrl = ORB_F_INIT_IRQ|ORB_F_FORMAT|ORB_F_LPM_DFLT;
>> +	if ((unsigned long)&ccw[0] >= 0x80000000UL) {
>> +		report(0, "CCW above 2G! %016lx", (unsigned long)&ccw[0]);
> 
> Maybe check before filling out the ccw?

Yes. Also I wonder if we should not make sure the all kvm-test-text and 
data are under 2G by construct, because I am quite sure that this sort 
of tests will repeat all over the kvm-unit-test code.

Will provide a separate patch for this, in between just do as you said, 
it is the logical thing to do here.

> 
>> +		report_prefix_pop();
>> +		return 0;
>> +	}
>> +	orb_p->cpa = (unsigned int) (unsigned long)&ccw[0];
>> +
>> +	ret = ssch(test_device_sid, orb_p);
>> +	if (ret) {
>> +		report(0, "ssch cc=%d", ret);
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
>> + * - We need the QEMU PONG device as the first recognized
>> + * - device by the enumeration.
>> + * - ./s390x-run s390x/css.elf -device ccw-pong,cu_type=0xc0ca
>> + */
>> +static void test_sense(void)
>> +{
>> +	int ret;
>> +
>> +	ret = register_io_int_func(irq_io);
>> +	if (ret) {
>> +		report(0, "Could not register IRQ handler");
>> +		goto unreg_cb;
>> +	}
>> +
>> +	enable_io_irq();
>> +	lowcore->io_int_param = 0;
>> +
>> +	ret = start_subchannel(CCW_CMD_SENSE_ID, buffer, sizeof(senseid));
>> +	if (!ret) {
>> +		report(0, "start_subchannel failed");
>> +		goto unreg_cb;
>> +	}
>> +
>> +	delay(100);
>> +	if (lowcore->io_int_param != CSS_TEST_INT_PARAM) {
>> +		report(0, "cu_type: expect 0x%08x, got 0x%08x",
>> +		       CSS_TEST_INT_PARAM, lowcore->io_int_param);
>> +		goto unreg_cb;
>> +	}
> 
> This still looks like that odd "delay and hope an interrupt has arrived
> in the mean time" pattern.

yes.

> 
> Also, doesn't the interrupt handler check for the intparm already?

Yes, if the interrupt fires.

> 
>> +
>> +	senseid.cu_type = buffer[2] | (buffer[1] << 8);
> 
> This still looks odd; why not have the ccw fill out the senseid
> structure directly?

Oh sorry, you already said and I forgot to modify this.
thanks

> 
>> +
>> +	/* Sense ID is non packed cut_type is at offset +1 byte */
> 
> I have trouble parsing this sentence...
> 
>> +	if (senseid.cu_type == PONG_CU)
>> +		report(1, "cu_type: expect 0x%04x got 0x%04x",
>> +		       PONG_CU_TYPE, senseid.cu_type);
>> +	else
>> +		report(0, "cu_type: expect 0x%04x got 0x%04x",
>> +		       PONG_CU_TYPE, senseid.cu_type);
> 
> Didn't you want to check for ff in the reserved field as well?

It was not intended as a check for SENSE_ID but for STSCH/READ.
But, while at this... why not.

Thanks for the review.
Regards,

Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
