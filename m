Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45277 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389135AbfHWK6E (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 06:58:04 -0400
Subject: Re: [kvm-unit-tests PATCH v2 4/4] s390x: STSI tests
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190821104736.1470-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3fffb16f-672e-bff1-03cc-475fd2739165@redhat.com>
Date: Fri, 23 Aug 2019 12:57:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190821104736.1470-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 8/21/19 12:47 PM, Janosch Frank wrote:
> For now let's concentrate on the error conditions.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/Makefile      |  1 +
>  s390x/stsi.c        | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  3 ++
>  3 files changed, 88 insertions(+)
>  create mode 100644 s390x/stsi.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 3453373..76db0bb 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -13,6 +13,7 @@ tests += $(TEST_DIR)/gs.elf
>  tests += $(TEST_DIR)/iep.elf
>  tests += $(TEST_DIR)/cpumodel.elf
>  tests += $(TEST_DIR)/diag288.elf
> +tests += $(TEST_DIR)/stsi.elf
>  tests_binary = $(patsubst %.elf,%.bin,$(tests))
>  
>  all: directories test_cases test_cases_binary
> diff --git a/s390x/stsi.c b/s390x/stsi.c
> new file mode 100644
> index 0000000..0f90c9a
> --- /dev/null
> +++ b/s390x/stsi.c
> @@ -0,0 +1,84 @@
[...]
> +static inline unsigned long stsi_get_fc(void *addr)
> +{
> +	register unsigned long r0 asm("0") = 0;
> +	register unsigned long r1 asm("1") = 0;
> +	int cc;
> +
> +	asm volatile("stsi	0(%2)\n"

Shouldn't that be %3 instead?

> +		     "ipm	%[cc]\n"
> +		     "srl	%[cc],28\n"
> +		     : "+d" (r0), [cc] "=d" (cc)
> +		     : "d" (r1), "a" (addr)
> +		     : "cc", "memory");
> +	assert(!cc);
> +	return r0 >> 28;
> +}
> +
> +static void test_fc(void)
> +{
> +	report("cc == 3",  stsi(pagebuf, 7, 0, 0) == 3);
> +	report("r0 == 3",  stsi_get_fc(pagebuf) >= 2);

I'd like to suggest to change the string to "r0 >= 2", too.

 Thomas
