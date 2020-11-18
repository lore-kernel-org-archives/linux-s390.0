Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727776AbgKRRuf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 12:50:35 -0500
Date: Wed, 18 Nov 2020 18:50:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 3/5] s390x: SCLP feature checking
Message-ID: <20201118185026.776c63dd.cohuck@redhat.com>
In-Reply-To: <20201117154215.45855-4-frankja@linux.ibm.com>
References: <20201117154215.45855-1-frankja@linux.ibm.com>
        <20201117154215.45855-4-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On Tue, 17 Nov 2020 10:42:13 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Availability of SIE is announced via a feature bit in a SCLP info CPU
> entry. Let's add a framework that allows us to easily check for such
> facilities.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/io.c   |  1 +
>  lib/s390x/sclp.c | 19 +++++++++++++++++++
>  lib/s390x/sclp.h | 15 +++++++++++++++
>  3 files changed, 35 insertions(+)

(...)

> +void sclp_facilities_setup(void)
> +{
> +	unsigned short cpu0_addr = stap();
> +	CPUEntry *cpu;
> +	int i;
> +
> +	assert(read_info);
> +
> +	cpu = (void *)read_info + read_info->offset_cpu;
> +	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
> +		if (cpu->address == cpu0_addr) {
> +			sclp_facilities.has_sief2 = test_bit_inv(SCLP_CPU_FEATURE_SIEF2_BIT, (void *)&cpu->address);

Can you wrap this? This line is really overlong.

(Also, just to understand: Is sief2 only indicated for cpu0, and not
for the other cpus?)

> +			break;
> +		}
> +	}
> +}
> +
>  /* Perform service call. Return 0 on success, non-zero otherwise. */
>  int sclp_service_call(unsigned int command, void *sccb)
>  {
