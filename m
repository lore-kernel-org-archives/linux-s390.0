Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbgENMYX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 May 2020 08:24:23 -0400
Date: Thu, 14 May 2020 14:24:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v6 09/10] s390x: css: ssch/tsch with
 sense and interrupt
Message-ID: <20200514142411.6e369fe4.cohuck@redhat.com>
In-Reply-To: <1587725152-25569-10-git-send-email-pmorel@linux.ibm.com>
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
        <1587725152-25569-10-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Fri, 24 Apr 2020 12:45:51 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We add a new css_lib file to contain the I/O function we may

s/function/functions/

> share with different tests.
> First function is the subchannel_enable() function.
> 
> When a channel is enabled we can start a SENSE_ID command using
> the SSCH instruction to recognize the control unit and device.
> 
> This tests the success of SSCH, the I/O interruption and the TSCH
> instructions.
> 
> The test expects a device with a control unit type of 0xC0CA as the
> first subchannel of the CSS.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h |   1 +
>  lib/s390x/css.h          |  20 ++++++
>  lib/s390x/css_lib.c      |  55 +++++++++++++++
>  s390x/Makefile           |   1 +
>  s390x/css.c              | 149 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 226 insertions(+)
>  create mode 100644 lib/s390x/css_lib.c
> 

(...)

> +static void irq_io(void)
> +{
> +	int ret = 0;
> +	char *flags;
> +	int sid;
> +
> +	report_prefix_push("Interrupt");
> +	/* Lowlevel set the SID as interrupt parameter. */
> +	if (lowcore->io_int_param != test_device_sid) {
> +		report(0,
> +		       "Bad io_int_param: %x expected %x",
> +		       lowcore->io_int_param, test_device_sid);
> +		goto pop;
> +	}
> +	report_prefix_pop();
> +
> +	report_prefix_push("tsch");
> +	sid = lowcore->subsys_id_word;
> +	ret = tsch(sid, &irb);
> +	switch (ret) {
> +	case 1:
> +		dump_irb(&irb);
> +		flags = dump_scsw_flags(irb.scsw.ctrl);
> +		report(0,
> +		       "I/O interrupt, but sch not status pending: %s", flags);

"...but tsch reporting sch as not status pending" ?

A buggy implementation might give the wrong cc for tsch, but still
indicate status pending in the control block.

> +		break;
> +	case 2:
> +		report(0, "TSCH returns unexpected CC 2");
> +		break;
> +	case 3:
> +		report(0, "Subchannel %08x not operational", sid);

"tsch reporting subchannel %08x as not operational" ?

> +		break;
> +	case 0:
> +		/* Stay humble on success */
> +		break;
> +	}
> +pop:
> +	report_prefix_pop();
> +	lowcore->io_old_psw.mask &= ~PSW_MASK_WAIT;
> +}

(...)

> +/*
> + * test_sense
> + * Pre-requisits:
> + * - We need the QEMU PONG device as the first recognized
> + *   device by the enumeration.
> + * - ./s390x-run s390x/css.elf -device ccw-pong,cu_type=0xc0ca
> + */
> +static void test_sense(void)
> +{
> +	int ret;
> +
> +	if (!test_device_sid) {
> +		report_skip("No device");
> +		return;
> +	}
> +
> +	ret = enable_subchannel(test_device_sid);
> +	if (ret < 0) {
> +		report(0,
> +		       "Could not enable the subchannel: %08x",
> +		       test_device_sid);
> +		return;
> +	}
> +
> +	ret = register_io_int_func(irq_io);
> +	if (ret) {
> +		report(0, "Could not register IRQ handler");
> +		goto unreg_cb;
> +	}
> +
> +	lowcore->io_int_param = 0;
> +
> +	ret = start_subchannel(CCW_CMD_SENSE_ID, &senseid, sizeof(senseid));

You're always send the full (extended) sense id block. What if the the
machine you're running on doesn't support extended sense id? Would the
SLI ccw flag help?

> +	if (!ret) {
> +		report(0, "start_senseid failed");

"ssch failed for SENSE ID on sch <sch>" ?

> +		goto unreg_cb;
> +	}
> +
> +	wfi(PSW_MASK_IO);
> +
> +	if (lowcore->io_int_param != test_device_sid) {
> +		report(0,
> +		       "No interrupts. io_int_param: expect 0x%08x, got 0x%08x",
> +		       test_device_sid, lowcore->io_int_param);

Doesn't irq_io() already moan here?

> +		goto unreg_cb;
> +	}
> +
> +	report_info("reserved %02x cu_type %04x cu_model %02x dev_type %04x dev_model %02x",
> +		    senseid.reserved, senseid.cu_type, senseid.cu_model,
> +		    senseid.dev_type, senseid.dev_model);
> +
> +	if (senseid.cu_type == PONG_CU)
> +		report(1, "cu_type: expect 0x%04x got 0x%04x",
> +		       PONG_CU_TYPE, senseid.cu_type);
> +	else
> +		report(0, "cu_type: expect 0x%04x got 0x%04x",
> +		       PONG_CU_TYPE, senseid.cu_type);
> +
> +unreg_cb:
> +	unregister_io_int_func(irq_io);
> +}
> +
