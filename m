Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52405 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726289AbgDXKDk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 06:03:40 -0400
Subject: Re: [PATCH v3] s390x: smp: Test all CRs on initial reset
References: <2ebdf5d6-74ac-d9e5-d329-29611a5f87cd@redhat.com>
 <20200424093356.11931-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a37706b5-9319-0a70-181f-5a6afbb79d64@redhat.com>
Date: Fri, 24 Apr 2020 12:03:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200424093356.11931-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 24.04.20 11:33, Janosch Frank wrote:
> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
> so we also need to test 1-13 and 15 for 0.
>=20
> And while we're at it, let's also set some values to cr 1, 7 and 13, so
> we can actually be sure that they will be zeroed.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  s390x/smp.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/s390x/smp.c b/s390x/smp.c
> index fa40753..7144c9b 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -182,16 +182,28 @@ static void test_emcall(void)
>  	report_prefix_pop();
>  }
> =20
> +/* Used to dirty registers of cpu #1 before it is reset */
> +static void test_func_initial(void)
> +{
> +	lctlg(1, 0x42000UL);
> +	lctlg(7, 0x43000UL);
> +	lctlg(13, 0x44000UL);
> +	set_flag(1);
> +}
> +
>  static void test_reset_initial(void)
>  {
>  	struct cpu_status *status =3D alloc_pages(0);
>  	struct psw psw;
> +	int i;
> =20
>  	psw.mask =3D extract_psw_mask();
> -	psw.addr =3D (unsigned long)test_func;
> +	psw.addr =3D (unsigned long)test_func_initial;
> =20
>  	report_prefix_push("reset initial");
> +	set_flag(0);
>  	smp_cpu_start(1, psw);
> +	wait_for_flag();
> =20
>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
> @@ -202,6 +214,10 @@ static void test_reset_initial(void)
>  	report(!status->fpc, "fpc");
>  	report(!status->cputm, "cpu timer");
>  	report(!status->todpr, "todpr");
> +	for (i =3D 1; i <=3D 13; i++) {
> +		report(status->crs[i] =3D=3D 0, "cr%d =3D=3D 0", i);
> +	}
> +	report(status->crs[15] =3D=3D 0, "cr15 =3D=3D 0");
>  	report_prefix_pop();
> =20
>  	report_prefix_push("initialized");
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

Queued to

https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next

thanks!

--=20
Thanks,

David / dhildenb
