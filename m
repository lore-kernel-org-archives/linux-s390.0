Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729769AbgE0KJS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 May 2020 06:09:18 -0400
Date: Wed, 27 May 2020 12:09:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v7 11/12] s390x: css: ssch/tsch with
 sense and interrupt
Message-ID: <20200527120905.5fb20a4e.cohuck@redhat.com>
In-Reply-To: <1589818051-20549-12-git-send-email-pmorel@linux.ibm.com>
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
        <1589818051-20549-12-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Mon, 18 May 2020 18:07:30 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We add a new css_lib file to contain the I/O functions we may
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

It might make sense to extend this to be able to check for any expected
type (e.g. 0x3832, should my suggestion to split css tests and css-pong
tests make sense.)

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h     |  20 ++++++
>  lib/s390x/css_lib.c |  55 +++++++++++++++++
>  s390x/Makefile      |   1 +
>  s390x/css.c         | 145 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 221 insertions(+)
>  create mode 100644 lib/s390x/css_lib.c

(...)

> +int enable_subchannel(unsigned int sid)
> +{
> +	struct schib schib;
> +	struct pmcw *pmcw = &schib.pmcw;
> +	int try_count = 5;
> +	int cc;
> +
> +	if (!(sid & SID_ONE))
> +		return -1;

Hm... this error is indistinguishable for the caller from a cc 1 for
the msch. Use something else (as this is a coding error)?

> +
> +	cc = stsch(sid, &schib);
> +	if (cc)
> +		return -cc;
> +
> +	do {
> +		pmcw->flags |= PMCW_ENABLE;
> +
> +		cc = msch(sid, &schib);
> +		if (cc)
> +			return -cc;
> +
> +		cc = stsch(sid, &schib);
> +		if (cc)
> +			return -cc;
> +
> +	} while (!(pmcw->flags & PMCW_ENABLE) && --try_count);
> +
> +	return try_count;

How useful is that information for the caller? I don't see the code
below making use of it.

> +}
> +
> +int start_ccw1_chain(unsigned int sid, struct ccw1 *ccw)
> +{
> +	struct orb orb;
> +
> +	orb.intparm = sid;

Just an idea: If you use something else here (maybe the cpa), and set
the intparm to the sid in msch, you can test something else: Does msch
properly set the intparm, and is that intparm overwritten by a
successful ssch, until the next ssch or msch comes around?

> +	orb.ctrl = ORB_F_INIT_IRQ|ORB_F_FORMAT|ORB_F_LPM_DFLT;
> +	orb.cpa = (unsigned int) (unsigned long)ccw;

Use a struct initializer, so that unset fields are 0?

> +
> +	return ssch(sid, &orb);
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
> +	ret = start_subchannel(CCW_CMD_SENSE_ID, &senseid, sizeof(senseid),
> +			       CCW_F_SLI);

Clear senseid, before actually sending the program?

> +	if (!ret) {
> +		report(0, "ssch failed for SENSE ID on sch %08x",
> +		       test_device_sid);
> +		goto unreg_cb;
> +	}
> +
> +	wait_for_interrupt(PSW_MASK_IO);
> +
> +	if (lowcore->io_int_param != test_device_sid)
> +		goto unreg_cb;
> +
> +	report_info("reserved %02x cu_type %04x cu_model %02x dev_type %04x dev_model %02x",
> +		    senseid.reserved, senseid.cu_type, senseid.cu_model,
> +		    senseid.dev_type, senseid.dev_model);
> +

I'd also recommend checking that senseid.reserved is indeed 0xff -- in
combination with senseid clearing before the ssch, that ensures that
the senseid structure has actually been written to and is not pure
garbage. (It's also a cu type agnostic test :)

It also might make sense to check how much data you actually got, as
you set SLI.


> +	report((senseid.cu_type == PONG_CU),
> +	       "cu_type: expect 0x%04x got 0x%04x",
> +	       PONG_CU_TYPE, senseid.cu_type);
> +
> +unreg_cb:
> +	unregister_io_int_func(irq_io);
> +}
> +
>  static struct {
>  	const char *name;
>  	void (*func)(void);
>  } tests[] = {
>  	{ "enumerate (stsch)", test_enumerate },
>  	{ "enable (msch)", test_enable },
> +	{ "sense (ssch/tsch)", test_sense },
>  	{ NULL, NULL }
>  };
>  
> @@ -145,6 +289,7 @@ int main(int argc, char *argv[])
>  	int i;
>  
>  	report_prefix_push("Channel Subsystem");
> +	enable_io_isc();
>  	for (i = 0; tests[i].name; i++) {
>  		report_prefix_push(tests[i].name);
>  		tests[i].func();
