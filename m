Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48520 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726389AbgGUH20 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jul 2020 03:28:26 -0400
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: skrf: Add exception new skey
 test and add test to unittests.cfg
References: <20200717145813.62573-1-frankja@linux.ibm.com>
 <20200717145813.62573-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <78da93f7-118d-2c1d-582a-092232f36108@redhat.com>
Date: Tue, 21 Jul 2020 09:28:13 +0200
MIME-Version: 1.0
In-Reply-To: <20200717145813.62573-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

On 17/07/2020 16.58, Janosch Frank wrote:
> If a exception new psw mask contains a key a specification exception
> instead of a special operation exception is presented.

I have troubles parsing that sentence... could you write that differently?
(and: "s/a exception/an exception/")

> Let's test
> that.
> 
> Also let's add the test to unittests.cfg so it is run more often.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/skrf.c        | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  4 +++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/s390x/skrf.c b/s390x/skrf.c
> index 9cae589..9733412 100644
> --- a/s390x/skrf.c
> +++ b/s390x/skrf.c
> @@ -15,6 +15,8 @@
>  #include <asm/page.h>
>  #include <asm/facility.h>
>  #include <asm/mem.h>
> +#include <asm/sigp.h>
> +#include <smp.h>
>  
>  static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
>  
> @@ -106,6 +108,84 @@ static void test_tprot(void)
>  	report_prefix_pop();
>  }
>  
> +#include <asm-generic/barrier.h>

Can we keep the #includes at the top of the file, please?

> +static int testflag = 0;
> +
> +static void wait_for_flag(void)
> +{
> +	while (!testflag)
> +		mb();
> +}
> +
> +static void set_flag(int val)
> +{
> +	mb();
> +	testflag = val;
> +	mb();
> +}
> +
> +static void ecall_cleanup(void)
> +{
> +	struct lowcore *lc = (void *)0x0;
> +
> +	lc->ext_new_psw.mask = 0x0000000180000000UL;

Don't we have defines for the PSW values yet?

> +	lc->sw_int_crs[0] = 0x0000000000040000;
> +
> +	/*
> +	 * PGM old contains the ext new PSW, we need to clean it up,
> +	 * so we don't get a special oepration exception on the lpswe

operation

> +	 * of pgm old.
> +	 */
> +	lc->pgm_old_psw.mask = 0x0000000180000000UL;
> +	lc->pgm_old_psw.addr = (unsigned long)wait_for_flag;
> +
> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	set_flag(1);
> +}

 Thomas
