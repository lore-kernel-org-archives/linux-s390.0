Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39638 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726280AbgFQItJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Jun 2020 04:49:09 -0400
Date: Wed, 17 Jun 2020 10:48:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v9 10/12] s390x: css: stsch, enumeration
 test
Message-ID: <20200617104857.1bdab6a5.cohuck@redhat.com>
In-Reply-To: <1592213521-19390-11-git-send-email-pmorel@linux.ibm.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
        <1592213521-19390-11-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Mon, 15 Jun 2020 11:31:59 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> First step for testing the channel subsystem is to enumerate the css and
> retrieve the css devices.

Maybe worth adding a note:

"We currently don't enable multiple subchannel sets and therefore only
look in subchannel set 0."

> 
> This tests the success of STSCH I/O instruction, we do not test the
> reaction of the VM for an instruction with wrong parameters.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css_lib.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/Makefile      |  2 ++
>  s390x/css.c         | 55 +++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  4 +++
>  4 files changed, 131 insertions(+)
>  create mode 100644 lib/s390x/css_lib.c
>  create mode 100644 s390x/css.c
> 
> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
> new file mode 100644
> index 0000000..b0a0294
> --- /dev/null
> +++ b/lib/s390x/css_lib.c
> @@ -0,0 +1,70 @@
> +/*
> + * Channel Subsystem tests library
> + *
> + * Copyright (c) 2020 IBM Corp
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2.
> + */
> +#include <libcflat.h>
> +#include <alloc_phys.h>
> +#include <asm/page.h>
> +#include <string.h>
> +#include <interrupt.h>
> +#include <asm/arch_def.h>
> +
> +#include <css.h>
> +
> +static struct schib schib;
> +
> +/*
> + * css_enumerate:
> + * On success return the first subchannel ID found.
> + * On error return an invalid subchannel ID containing cc
> + */
> +int css_enumerate(void)
> +{
> +	struct pmcw *pmcw = &schib.pmcw;
> +	int scn_found = 0;
> +	int dev_found = 0;
> +	int schid = 0;
> +	int cc;
> +	int scn;
> +
> +	for (scn = 0; scn < 0xffff; scn++) {
> +		cc = stsch(scn | SCHID_ONE, &schib);
> +		switch (cc) {
> +		case 0:		/* 0 means SCHIB stored */
> +			break;
> +		case 3:		/* 3 means no more channels */
> +			goto out;
> +		default:	/* 1 or 2 should never happened for STSCH */

s/happened/happen/

> +			report_abort("Unexpected error %d on subchannel %08x",
> +				     cc, scn | SCHID_ONE);
> +			return cc;
> +		}
> +
> +		/* We currently only support type 0, a.k.a. I/O channels */
> +		if (PMCW_CHANNEL_TYPE(pmcw) != 0)
> +			continue;
> +
> +		/* We ignore I/O channels without valid devices */
> +		scn_found++;
> +		if (!(pmcw->flags & PMCW_DNV))
> +			continue;
> +
> +		/* We keep track of the first device as our test device */
> +		if (!schid)
> +			schid = scn | SCHID_ONE;
> +		report_info("Found subchannel %08x", scn | SCHID_ONE);
> +		dev_found++;
> +	}
> +
> +out:
> +	report_info("Tested subchannels: %d, I/O subchannels: %d, I/O devices: %d",
> +		    scn, scn_found, dev_found);
> +	return schid;
> +}

(...)

> diff --git a/s390x/css.c b/s390x/css.c
> new file mode 100644
> index 0000000..230adf5
> --- /dev/null
> +++ b/s390x/css.c
> @@ -0,0 +1,55 @@
> +/*
> + * Channel Subsystem tests
> + *
> + * Copyright (c) 2020 IBM Corp
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
> +
> +#include <css.h>
> +
> +static int test_device_sid;
> +
> +static void test_enumerate(void)
> +{
> +	test_device_sid = css_enumerate();
> +	if (test_device_sid & SCHID_ONE) {
> +		report(1, "First device schid: 0x%08x", test_device_sid);

Maybe "Schid of first I/O device" ?

> +		return;
> +	}
> +	report(0, "No I/O device found");
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
> +	report_prefix_push("Channel Subsystem");
> +	for (i = 0; tests[i].name; i++) {
> +		report_prefix_push(tests[i].name);
> +		tests[i].func();
> +		report_prefix_pop();
> +	}
> +	report_prefix_pop();
> +
> +	return report_summary();
> +}

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
