Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbgEOHhf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 03:37:35 -0400
Subject: Re: [kvm-unit-tests PATCH v6 09/10] s390x: css: ssch/tsch with sense
 and interrupt
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-10-git-send-email-pmorel@linux.ibm.com>
 <20200514142411.6e369fe4.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <7453c812-dd30-44bc-c64a-35c4a3c929ee@linux.ibm.com>
Date: Fri, 15 May 2020 09:37:25 +0200
MIME-Version: 1.0
In-Reply-To: <20200514142411.6e369fe4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-05-14 14:24, Cornelia Huck wrote:
> On Fri, 24 Apr 2020 12:45:51 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We add a new css_lib file to contain the I/O function we may
> 
> s/function/functions/

Yes, thanks.


>> +	report_prefix_push("tsch");
>> +	sid = lowcore->subsys_id_word;
>> +	ret = tsch(sid, &irb);
>> +	switch (ret) {
>> +	case 1:
>> +		dump_irb(&irb);
>> +		flags = dump_scsw_flags(irb.scsw.ctrl);
>> +		report(0,
>> +		       "I/O interrupt, but sch not status pending: %s", flags);
> 
> "...but tsch reporting sch as not status pending" ?

Yes, better, Thx

> 
> A buggy implementation might give the wrong cc for tsch, but still
> indicate status pending in the control block.

OK, I will write the status for other error cases too.
> 
>> +		break;
>> +	case 2:
>> +		report(0, "TSCH returns unexpected CC 2");

will also s/TSCH/tsch/ here

>> +		break;
>> +	case 3:
>> +		report(0, "Subchannel %08x not operational", sid);
> 
> "tsch reporting subchannel %08x as not operational" ?

Yes, better.
and I will standardize these three reports.

> 
>> +		break;
>> +	case 0:
>> +		/* Stay humble on success */
>> +		break;
>> +	}
>> +pop:
>> +	report_prefix_pop();
>> +	lowcore->io_old_psw.mask &= ~PSW_MASK_WAIT;
>> +}
> 
...snip...

>> +	lowcore->io_int_param = 0;
>> +
>> +	ret = start_subchannel(CCW_CMD_SENSE_ID, &senseid, sizeof(senseid));
> 
> You're always send the full (extended) sense id block. What if the the
> machine you're running on doesn't support extended sense id? Would the
> SLI ccw flag help?

Yes, you are right, since I only use senseid for recognition of the PONG 
subchannel, I can accept non extended senseid

> 
>> +	if (!ret) {
>> +		report(0, "start_senseid failed");
> 
> "ssch failed for SENSE ID on sch <sch>" ?

Better. Thx

> 
>> +		goto unreg_cb;
>> +	}
>> +
>> +	wfi(PSW_MASK_IO);
>> +
>> +	if (lowcore->io_int_param != test_device_sid) {
>> +		report(0,
>> +		       "No interrupts. io_int_param: expect 0x%08x, got 0x%08x",
>> +		       test_device_sid, lowcore->io_int_param);
> 
> Doesn't irq_io() already moan here?

Yes, right, I kept this from last version with delays.
It has no sense here:
- We are the only user of the CSS
- If the interrupt did not fire we are stuck in wfi()

Thanks.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
