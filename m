Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727092AbgANRBn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Jan 2020 12:01:43 -0500
Subject: Re: [kvm-unit-tests PATCH 3/4] s390x: smp: Test all CRs on initial
 reset
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <20200114153054.77082-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bec10775-3713-4604-1b49-27d49682db43@redhat.com>
Date: Tue, 14 Jan 2020 18:01:32 +0100
MIME-Version: 1.0
In-Reply-To: <20200114153054.77082-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 14/01/2020 16.30, Janosch Frank wrote:
> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
> so we also need to test 1-13 and 15 for 0.
>=20
> And while we're at it, let's also set some values to cr 1, 7 and 13, so
> we can actually be sure that they will be zeroed.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 767d167..11ab425 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -175,16 +175,31 @@ static void test_emcall(void)
>  	report_prefix_pop();
>  }
> =20
> +static void test_func_initial(void)
> +{
> +	lctlg(1, 0x42000UL);
> +	lctlg(7, 0x43000UL);
> +	lctlg(13, 0x44000UL);
> +	testflag =3D 1;
> +	mb();
> +	cpu_loop();
> +}
> +
>  static void test_reset_initial(void)
>  {
>  	struct cpu_status *status =3D alloc_pages(0);
> +	uint8_t *nullp =3D alloc_pages(0);

Why not simply:

        uint64_t nullp[12];

?

>  	struct psw psw;
> =20
> +	memset(nullp, 0, PAGE_SIZE);
>  	psw.mask =3D extract_psw_mask();
> -	psw.addr =3D (unsigned long)test_func;
> +	psw.addr =3D (unsigned long)test_func_initial;
> =20
>  	report_prefix_push("reset initial");
> +	testflag =3D 0;
> +	mb();
>  	smp_cpu_start(1, psw);
> +	wait_for_flag();
> =20
>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
> @@ -195,6 +210,8 @@ static void test_reset_initial(void)
>  	report(!status->fpc, "fpc");
>  	report(!status->cputm, "cpu timer");
>  	report(!status->todpr, "todpr");
> +	report(!memcmp(&status->crs[1], nullp, sizeof(status->crs[1]) * 12), =
"cr1-13 =3D=3D 0");
> +	report(status->crs[15] =3D=3D 0, "cr15 =3D=3D 0");
>  	report_prefix_pop();
> =20
>  	report_prefix_push("initialized");
> @@ -204,6 +221,7 @@ static void test_reset_initial(void)
> =20
>  	report(smp_cpu_stopped(1), "cpu stopped");
>  	free_pages(status, PAGE_SIZE);
> +	free_pages(nullp, PAGE_SIZE);
>  	report_prefix_pop();
>  }
> =20
> @@ -219,6 +237,7 @@ static void test_reset(void)
> =20
>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>  	report(smp_cpu_stopped(1), "cpu stopped");
> +	smp_cpu_destroy(1);

Shouldn't that rather be part of patch 2/4 ? I'd maybe also move this to
the main() function instead since you've setup the cpu there...? Also is
it still ok to use smp_cpu_start() in test_reset_initial() after you've
destroyed the CPU here in test_reset()?

>  	report_prefix_pop();
>  }

 Thomas
