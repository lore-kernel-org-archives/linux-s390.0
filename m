Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24951 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388070AbgE0IzP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 May 2020 04:55:15 -0400
Date: Wed, 27 May 2020 10:55:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v7 08/12] s390x: css: stsch, enumeration
 test
Message-ID: <20200527105501.53681762.cohuck@redhat.com>
In-Reply-To: <1589818051-20549-9-git-send-email-pmorel@linux.ibm.com>
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
        <1589818051-20549-9-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Mon, 18 May 2020 18:07:27 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> First step for testing the channel subsystem is to enumerate the css and
> retrieve the css devices.
> 
> This tests the success of STSCH I/O instruction, we do not test the
> reaction of the VM for an instruction with wrong parameters.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  s390x/Makefile      |  1 +
>  s390x/css.c         | 89 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  4 ++
>  3 files changed, 94 insertions(+)
>  create mode 100644 s390x/css.c

(...)

> +static void test_enumerate(void)
> +{
> +	struct pmcw *pmcw = &schib.pmcw;
> +	int cc;
> +	int scn;
> +	int scn_found = 0;
> +	int dev_found = 0;
> +
> +	for (scn = 0; scn < 0xffff; scn++) {
> +		cc = stsch(scn|SID_ONE, &schib);
> +		switch (cc) {
> +		case 0:		/* 0 means SCHIB stored */
> +			break;
> +		case 3:		/* 3 means no more channels */
> +			goto out;
> +		default:	/* 1 or 2 should never happened for STSCH */
> +			report(0, "Unexpected cc=%d on subchannel number 0x%x",
> +			       cc, scn);
> +			return;
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
> +		if (!test_device_sid)
> +			test_device_sid = scn | SID_ONE;
> +
> +		dev_found++;
> +	}
> +
> +out:
> +	report(dev_found,
> +	       "Tested subchannels: %d, I/O subchannels: %d, I/O devices: %d",
> +	       scn, scn_found, dev_found);

Just wondering: with the current invocation, you expect to find exactly
one subchannel with a valid device, right?

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
> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index 07013b2..a436ec0 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -83,3 +83,7 @@ extra_params = -m 1G
>  [sclp-3g]
>  file = sclp.elf
>  extra_params = -m 3G
> +
> +[css]
> +file = css.elf
> +extra_params =-device ccw-pong

Hm... you could test enumeration even with a QEMU that does not include
support for the pong device, right? Would it be worthwhile to split out
a set of css tests that use e.g. a virtio-net-ccw device, and have a
css-pong set of tests that require the pong device?
