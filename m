Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229883AbhBBLxq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 06:53:46 -0500
Date: Tue, 2 Feb 2021 12:52:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v1 5/5] s390x: css: testing measurement
 block format 1
Message-ID: <20210202125209.4ef8b66c.cohuck@redhat.com>
In-Reply-To: <1611930869-25745-6-git-send-email-pmorel@linux.ibm.com>
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
        <1611930869-25745-6-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com

On Fri, 29 Jan 2021 15:34:29 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Measurement block format 1 is made available by the extended
> mesurement block facility and is indicated in the SCHIB by
> the bit in the PMCW.
> 
> The MBO is specified in the SCHIB of each channel and the MBO
> defined by the SCHM instruction is ignored.
> 
> The test of the MB format 1 is just skip if the feature is

s/skip/skipped/

> not available.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  s390x/css.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 

(...)

> @@ -208,6 +251,14 @@ static void test_schm(void)
>  	schm(mb0, SCHM_MBU);
>  	test_schm_fmt0(mb0);
>  
> +	mb1 = alloc_io_mem(sizeof(struct measurement_block_format1), 0);
> +	if (!mb1) {

I'm wondering whether you should move this into the format 1
invocation, so you won't try to allocate memory if format 1 is not even
supported.

> +		report(0, "mesurement_block_format0 allocation");

In any case, s/mesurement_block_format0/measurement_block_format1/ :)

> +		goto end_free;
> +	}
> +	test_schm_fmt1(mb1);
> +
> +	free_io_mem(mb1, sizeof(struct measurement_block_format1));
>  end_free:
>  	free_io_mem(mb0, sizeof(struct measurement_block_format0));
>  }
