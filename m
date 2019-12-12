Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52421 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728536AbfLLKSj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Dec 2019 05:18:39 -0500
Date: Thu, 12 Dec 2019 11:18:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 6/9] s390x: css: stsch, enumeration
 test
Message-ID: <20191212111827.21f64fa3.cohuck@redhat.com>
In-Reply-To: <1576079170-7244-7-git-send-email-pmorel@linux.ibm.com>
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
        <1576079170-7244-7-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Wed, 11 Dec 2019 16:46:07 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> First step for testing the channel subsystem is to enumerate the css and
> retrieve the css devices.
> 
> This tests the success of STSCH I/O instruction, we do not test the
> reaction of the VM for an instruction with wrong parameters.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h     |  1 +
>  s390x/Makefile      |  2 ++
>  s390x/css.c         | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  4 +++
>  4 files changed, 95 insertions(+)
>  create mode 100644 s390x/css.c

> diff --git a/s390x/css.c b/s390x/css.c
> new file mode 100644
> index 0000000..dfab35f
> --- /dev/null
> +++ b/s390x/css.c
> @@ -0,0 +1,88 @@
> +/*
> + * Channel Subsystem tests
> + *
> + * Copyright (c) 2019 IBM Corp
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2.
> + */
> +
> +#include <libcflat.h>
> +#include <alloc_phys.h>
> +#include <asm/page.h>
> +#include <string.h>
> +#include <interrupt.h>
> +#include <asm/arch_def.h>
> +#include <asm/time.h>
> +
> +#include <css.h>
> +
> +#define SID_ONE		0x00010000
> +
> +static struct schib schib;
> +static int test_device_sid;
> +
> +static void test_enumerate(void)
> +{
> +	struct pmcw *pmcw = &schib.pmcw;
> +	int cc;
> +	int scn;
> +	int scn_found = 0;
> +
> +	for (scn = 0; scn < 0xffff; scn++) {
> +		cc = stsch(scn|SID_ONE, &schib);
> +		switch (cc) {
> +		case 0:		/* 0 means SCHIB stored */
> +			break;
> +		case 3:		/* 3 means no more channels */
> +			goto out;
> +		default:	/* 1 or 2 should never happened for STSCH */
> +			report(0, "Unexpected cc=%d on scn 0x%x", cc, scn);

Spell out "subchannel number"?

> +			return;
> +		}
> +		if (cc)
> +			break;

Isn't that redundant?

> +		/* We silently only support type 0, a.k.a. I/O channels */

s/silently/currently/ ?

> +		if (PMCW_CHANNEL_TYPE(pmcw) != 0)
> +			continue;
> +		/* We ignore I/O channels without valid devices */
> +		if (!(pmcw->flags & PMCW_DNV))
> +			continue;
> +		/* We keep track of the first device as our test device */
> +		if (!test_device_sid)
> +			test_device_sid = scn|SID_ONE;
> +		scn_found++;
> +	}
> +out:
> +	if (!scn_found) {
> +		report(0, "Devices, Tested: %d, no I/O type found", scn);

It's no I/O _devices_ found, isn't it? There might have been I/O
subchannels, but none with a valid device...

> +		return;
> +	}
> +	report(1, "Devices, tested: %d, I/O type: %d", scn, scn_found);

As you're testing this anyway: what about tracking _all_ numbers here?
I.e., advance a counter for I/O subchannels as well, even if !dnv, and
have an output like

"Tested subchannels: 20, I/O subchannels: 18, I/O devices: 10"

or so?

> +}
> +
> +static struct {
> +	const char *name;
> +	void (*func)(void);
> +} tests[] = {
> +	{ "enumerate (stsch)", test_enumerate },
> +	{ NULL, NULL }
> +};
> +
> +int main(int argc, char *argv[])
> +{
> +	int i;
> +
> +	report_prefix_push("Channel Sub-System");

s/Channel Sub-System/Channel Subsystem/ ?

> +	for (i = 0; tests[i].name; i++) {
> +		report_prefix_push(tests[i].name);
> +		tests[i].func();
> +		report_prefix_pop();
> +	}
> +	report_prefix_pop();
> +
> +	return report_summary();
> +}

This basically looks sane to me now.

Just some additional considerations (we can do that on top, no need to
do surgery here right now):

I currently have the (not sure how sensible) idea to add some optional
testing for vfio-ccw, and this would obviously need some I/O routines as
well. So, in the long run, it would be good if something like this
stsch-loop could be factored out to a kind of library function. Just
some thoughts for now :)
