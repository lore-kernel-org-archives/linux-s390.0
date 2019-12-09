Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53400 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726230AbfLIQtv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 11:49:51 -0500
Date: Mon, 9 Dec 2019 17:49:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 6/9] s390x: css: stsch, enumeration
 test
Message-ID: <20191209174938.7df1ffa2.cohuck@redhat.com>
In-Reply-To: <1575649588-6127-7-git-send-email-pmorel@linux.ibm.com>
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
        <1575649588-6127-7-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Fri,  6 Dec 2019 17:26:25 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> First step for testing the channel subsystem is to enumerate the css and
> retrieve the css devices.
> 
> This tests the success of STSCH I/O instruction.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h     |  1 +
>  s390x/Makefile      |  2 ++
>  s390x/css.c         | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  4 +++
>  4 files changed, 89 insertions(+)
>  create mode 100644 s390x/css.c
> 

> +static void test_enumerate(void)
> +{
> +	struct pmcw *pmcw = &schib.pmcw;
> +	int scn;
> +	int cc, i;
> +	int found = 0;
> +
> +	for (scn = 0; scn < 0xffff; scn++) {
> +		cc = stsch(scn|SID_ONE, &schib);
> +		if (!cc && (pmcw->flags & PMCW_DNV)) {

Not sure when dnv is actually applicable... it is used for I/O
subchannels; chsc subchannels don't have a device; message subchannels
use a different bit IIRC; not sure about EADM subchannels.

[Not very relevant as long as we run under KVM, but should be
considered if you plan to run this test under z/VM or LPAR as well.]

> +			report_info("SID %04x Type %s PIM %x", scn,
> +				     Channel_type[PMCW_CHANNEL_TYPE(pmcw)],
> +				     pmcw->pim);
> +			for (i = 0; i < 8; i++)  {
> +				if ((pmcw->pim << i) & 0x80) {
> +					report_info("CHPID[%d]: %02x", i,
> +						    pmcw->chpid[i]);
> +					break;

That 'break;' seems odd -- won't you end up printing the first chpid in
the pim only?

Maybe modify this loop to print the chpid if the path is in the pim,
and 'n/a' or so if not?

> +				}
> +			}
> +			found++;
> +		}
> +		if (cc == 3) /* cc = 3 means no more channel in CSS */

s/channel/subchannels/

> +			break;
> +		if (found && !test_device_sid)
> +			test_device_sid = scn|SID_ONE;
> +	}
> +	if (!found) {
> +		report("Tested %d devices, none found", 0, scn);
> +		return;
> +	}
> +	report("Tested %d devices, %d found", 1, scn, found);
> +}
