Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30837 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENMGE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 May 2020 08:06:04 -0400
Date: Thu, 14 May 2020 14:05:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v6 06/10] s390x: css: stsch, enumeration
 test
Message-ID: <20200514140552.107abbde.cohuck@redhat.com>
In-Reply-To: <1587725152-25569-7-git-send-email-pmorel@linux.ibm.com>
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
        <1587725152-25569-7-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Fri, 24 Apr 2020 12:45:48 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> First step for testing the channel subsystem is to enumerate the css and
> retrieve the css devices.
> 
> This tests the success of STSCH I/O instruction, we do not test the

s/of/of the/

> reaction of the VM for an instruction with wrong parameters.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h     |  1 +
>  s390x/Makefile      |  2 +
>  s390x/css.c         | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  4 ++
>  4 files changed, 99 insertions(+)
>  create mode 100644 s390x/css.c
> 

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

s/happened/happen/

> +			report(0, "Unexpected cc=%d on subchannel number 0x%x",
> +			       cc, scn);
> +			return;
> +		}
