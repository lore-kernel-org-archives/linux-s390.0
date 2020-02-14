Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44594 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728775AbgBNS2m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 13:28:42 -0500
Subject: Re: [PATCH 07/35] KVM: s390: add new variants of UV CALL
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-8-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b9988313-74d1-6e68-efef-d012aae30d6d@redhat.com>
Date: Fri, 14 Feb 2020 19:28:32 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-8-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 07.02.20 12:39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
>=20
> This add 2 new variants of the UV CALL.
>=20
> The first variant handles UV CALLs that might have longer busy
> conditions or just need longer when doing partial completion. We should
> schedule when necessary.
>=20
> The second variant handles UV CALLs that only need the handle but have
> no payload (e.g. destroying a VM). We can provide a simple wrapper for
> those.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 59 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>=20
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 1b97230a57ba..e1cef772fde1 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/bug.h>
> +#include <linux/sched.h>
>  #include <asm/page.h>
>  #include <asm/gmap.h>
> =20
> @@ -91,6 +92,19 @@ struct uv_cb_cfs {
>  	u64 paddr;
>  } __packed __aligned(8);
> =20
> +/*
> + * A common UV call struct for calls that take no payload
> + * Examples:
> + * Destroy cpu/config
> + * Verify
> + */
> +struct uv_cb_nodata {
> +	struct uv_cb_header header;
> +	u64 reserved08[2];
> +	u64 handle;
> +	u64 reserved20[4];
> +} __packed __aligned(8);
> +
>  struct uv_cb_share {
>  	struct uv_cb_header header;
>  	u64 reserved08[3];
> @@ -98,6 +112,31 @@ struct uv_cb_share {
>  	u64 reserved28;
>  } __packed __aligned(8);
> =20
> +/*
> + * Low level uv_call that takes r1 and r2 as parameter and avoids
> + * stalls for long running busy conditions by doing schedule
> + */
> +static inline int uv_call_sched(unsigned long r1, unsigned long r2)
> +{
> +	int cc;
> +
> +	do {
> +		asm volatile(
> +			"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"

label not necessary

> +			"		ipm	%[cc]\n"
> +			"		srl	%[cc],28\n"
> +			: [cc] "=3Dd" (cc)
> +			: [r1] "d" (r1), [r2] "d" (r2)
> +			: "memory", "cc");

I was wondering if we could reuse uv_call() - something like

static inline int __uv_call(unsigned long r1, unsigned long r2)
{
	int cc;

	asm volatile(
		"	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
		"		ipm	%[cc]\n"
		"		srl	%[cc],28\n"
		: [cc] "=3Dd" (cc)
		: [r1] "a" (r1), [r2] "a" (r2)
		: "memory", "cc");
	return cc;
}

static inline int uv_call(unsigned long r1, unsigned long r2)
{
	int rc;

	do {
		cc =3D __uv_call(unsigned long r1, unsigned long r2);
	} while (cc > 1)
	return rc;
}

static inline int uv_call_sched(unsigned long r1, unsigned long r2)
{
	int rc;

	do {
		cc =3D __uv_call(unsigned long r1, unsigned long r2);
		cond_resched();
	} while (rc > 1)
	return rc;
}

> +		if (need_resched())
> +			schedule();

cond_resched();

> +	} while (cc > 1);
> +	return cc;
> +}
> +
> +/*
> + * Low level uv_call that takes r1 and r2 as parameter
> + */

This "r1 and r2" does not sound like relevant news. Same for the other
variant above.

>  static inline int uv_call(unsigned long r1, unsigned long r2)
>  {
>  	int cc;
> @@ -113,6 +152,26 @@ static inline int uv_call(unsigned long r1, unsign=
ed long r2)
>  	return cc;
>  }
> =20
> +/*
> + * special variant of uv_call that only transports the cpu or guest
> + * handle and the command, like destroy or verify.
> + */
> +static inline int uv_cmd_nodata(u64 handle, u16 cmd, u32 *ret)

uv_call_sched_simple() ?

> +{
> +	int rc;
> +	struct uv_cb_nodata uvcb =3D {
> +		.header.cmd =3D cmd,
> +		.header.len =3D sizeof(uvcb),
> +		.handle =3D handle,
> +	};
> +
> +	WARN(!handle, "No handle provided to Ultravisor call cmd %x\n", cmd);
> +	rc =3D uv_call_sched(0, (u64)&uvcb);
> +	if (ret)
> +		*ret =3D *(u32 *)&uvcb.header.rc;
> +	return rc ? -EINVAL : 0;
> +}
> +
>  struct uv_info {
>  	unsigned long inst_calls_list[4];
>  	unsigned long uv_base_stor_len;
>=20


--=20
Thanks,

David / dhildenb
