Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfH1MCr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Aug 2019 08:02:47 -0400
Subject: Re: [kvm-unit-tests PATCH v2 4/4] s390x: Add storage key removal
 facility
References: <20190828113615.4769-1-frankja@linux.ibm.com>
 <20190828113615.4769-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3ea4cb74-4fe4-d2bd-7fe4-550df9c355e6@redhat.com>
Date: Wed, 28 Aug 2019 14:02:43 +0200
MIME-Version: 1.0
In-Reply-To: <20190828113615.4769-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 28/08/2019 13.36, Janosch Frank wrote:
> The storage key removal facility (stfle bit 169) makes all key related
> instructions result in a special operation exception if they handle a
> key.
> 
> Let's make sure that the skey and pfmf tests only run non key code
> (pfmf) or not at all (skey).
> 
> Also let's test this new facility. As lots of instructions are
> affected by this, only some of them are tested for now.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/Makefile |   1 +
>  s390x/pfmf.c   |  10 ++++
>  s390x/skey.c   |   5 ++
>  s390x/skrf.c   | 128 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 144 insertions(+)
>  create mode 100644 s390x/skrf.c
[...]
> +static void test_mvcos(void)
> +{
> +	uint64_t r3 = 64;
> +	uint8_t *src = pagebuf;
> +	uint8_t *dst = pagebuf + PAGE_SIZE;
> +	/* K bit set, as well as keys */
> +	register unsigned long oac asm("0") = 0xf002f002;
> +
> +	report_prefix_push("mvcos");
> +	expect_pgm_int();
> +	asm volatile("mvcos	%[dst],%[src],%[len]"
> +		     : [dst] "+Q" (*(dst))
> +		     : [src] "Q" (*(src)), [len] "d" (r3), "d" (oac)

Just a nit: I think you could write "*dst" instead of "*(dst)" and
"*src" instead of "*(src)".

> +		     : "cc", "memory");
> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
> +	report_prefix_pop();
> +}
> +
> +static void test_spka(void)
> +{
> +	report_prefix_push("spka");
> +	expect_pgm_int();
> +	asm volatile("spka	0xf0(0)\n");
> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
> +	report_prefix_pop();
> +}
> +
> +static void test_tprot(void)
> +{
> +	report_prefix_push("tprot");
> +	expect_pgm_int();
> +	asm volatile("tprot	%[addr],0xf0(0)\n"
> +		     : : [addr] "a" (pagebuf) : );
> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
> +	report_prefix_pop();
> +}
> +
> +int main(void)
> +{
> +	report_prefix_push("skrf");
> +	if (!test_facility(169)) {
> +		report_skip("storage key removal facility not available\n");
> +		goto done;
> +	}
> +
> +	test_facilities();
> +	test_skey();
> +	test_pfmf();
> +	test_psw_key();
> +	test_mvcos();
> +	test_spka();
> +	test_tprot();
> +
> +done:
> +	report_prefix_pop();
> +	return report_summary();
> +}

I can't say much about the technical details here (since I don't have
the doc for that "removal facility"), but apart from that, the patch
looks fine to me now.

Acked-by: Thomas Huth <thuth@redhat.com>

(and I'll wait one or two more days for additional reviews before
queuing the patches)
