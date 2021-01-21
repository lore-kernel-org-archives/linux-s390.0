Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728657AbhAUJ6q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 04:58:46 -0500
Subject: Re: [kvm-unit-tests PATCH v4 3/3] s390x: css: pv: css test adaptation
 for PV
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <b9d65d43-6a72-802f-127d-6b66d7ccc32c@linux.ibm.com>
Date: Thu, 21 Jan 2021 10:57:56 +0100
MIME-Version: 1.0
In-Reply-To: <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Fg7Bt0xb2NnXSQb8NmRtNpFG20HQ5DzJG"
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fg7Bt0xb2NnXSQb8NmRtNpFG20HQ5DzJG
Content-Type: multipart/mixed; boundary="Fw7QJi5b2lbnk6kWiFpfZVUNejTC8zvud";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com,
 pbonzini@redhat.com
Message-ID: <b9d65d43-6a72-802f-127d-6b66d7ccc32c@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v4 3/3] s390x: css: pv: css test adaptation
 for PV
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>

--Fw7QJi5b2lbnk6kWiFpfZVUNejTC8zvud
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/21/21 10:13 AM, Pierre Morel wrote:
> We want the tests to automatically work with or without protected
> virtualisation.
> To do this we need to share the I/O memory with the host.
>=20
> Let's replace all static allocations with dynamic allocations
> to clearly separate shared and private memory.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

Acked-by: Janosch Frank <frankja@de.ibm.com>

> ---
>  lib/s390x/css.h     |  3 +--
>  lib/s390x/css_lib.c | 28 ++++++++--------------------
>  s390x/css.c         | 43 +++++++++++++++++++++++++++++++------------
>  3 files changed, 40 insertions(+), 34 deletions(-)
>=20
> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
> index 221b67c..e3dee9f 100644
> --- a/lib/s390x/css.h
> +++ b/lib/s390x/css.h
> @@ -283,8 +283,7 @@ int css_enable(int schid, int isc);
> =20
>  /* Library functions */
>  int start_ccw1_chain(unsigned int sid, struct ccw1 *ccw);
> -int start_single_ccw(unsigned int sid, int code, void *data, int count=
,
> -		     unsigned char flags);
> +struct ccw1 *ccw_alloc(int code, void *data, int count, unsigned char =
flags);
>  void css_irq_io(void);
>  int css_residual_count(unsigned int schid);
> =20
> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
> index 8e02371..f31098d 100644
> --- a/lib/s390x/css_lib.c
> +++ b/lib/s390x/css_lib.c
> @@ -18,6 +18,7 @@
>  #include <asm/time.h>
>  #include <asm/arch_def.h>
> =20
> +#include <malloc_io.h>
>  #include <css.h>
> =20
>  static struct schib schib;
> @@ -202,33 +203,20 @@ int start_ccw1_chain(unsigned int sid, struct ccw=
1 *ccw)
>  	return ssch(sid, &orb);
>  }
> =20
> -/*
> - * In the future, we want to implement support for CCW chains;
> - * for that, we will need to work with ccw1 pointers.
> - */
> -static struct ccw1 unique_ccw;
> -
> -int start_single_ccw(unsigned int sid, int code, void *data, int count=
,
> -		     unsigned char flags)
> +struct ccw1 *ccw_alloc(int code, void *data, int count, unsigned char =
flags)
>  {
> -	int cc;
> -	struct ccw1 *ccw =3D &unique_ccw;
> +	struct ccw1 *ccw;
> +
> +	ccw =3D alloc_io_pages(sizeof(*ccw), 0);
> +	if (!ccw)
> +		return NULL;
> =20
> -	report_prefix_push("start_subchannel");
> -	/* Build the CCW chain with a single CCW */
>  	ccw->code =3D code;
>  	ccw->flags =3D flags;
>  	ccw->count =3D count;
>  	ccw->data_address =3D (int)(unsigned long)data;
> =20
> -	cc =3D start_ccw1_chain(sid, ccw);
> -	if (cc) {
> -		report(0, "cc =3D %d", cc);
> -		report_prefix_pop();
> -		return cc;
> -	}
> -	report_prefix_pop();
> -	return 0;
> +	return ccw;
>  }
> =20
>  /* wait_and_check_io_completion:
> diff --git a/s390x/css.c b/s390x/css.c
> index ee3bc83..01378e5 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -17,13 +17,15 @@
>  #include <interrupt.h>
>  #include <asm/arch_def.h>
> =20
> +#include <malloc_io.h>
>  #include <css.h>
> +#include <asm/barrier.h>
> =20
>  #define DEFAULT_CU_TYPE		0x3832 /* virtio-ccw */
>  static unsigned long cu_type =3D DEFAULT_CU_TYPE;
> =20
>  static int test_device_sid;
> -static struct senseid senseid;
> +static struct senseid *senseid;
> =20
>  static void test_enumerate(void)
>  {
> @@ -57,6 +59,7 @@ static void test_enable(void)
>   */
>  static void test_sense(void)
>  {
> +	struct ccw1 *ccw;
>  	int ret;
>  	int len;
> =20
> @@ -80,11 +83,23 @@ static void test_sense(void)
> =20
>  	lowcore_ptr->io_int_param =3D 0;
> =20
> -	memset(&senseid, 0, sizeof(senseid));
> -	ret =3D start_single_ccw(test_device_sid, CCW_CMD_SENSE_ID,
> -			       &senseid, sizeof(senseid), CCW_F_SLI);
> -	if (ret)
> +	senseid =3D alloc_io_pages(sizeof(*senseid), 0);
> +	if (!senseid) {
> +		report(0, "Allocation of senseid");
> +		goto error_senseid;
> +	}
> +
> +	ccw =3D ccw_alloc(CCW_CMD_SENSE_ID, senseid, sizeof(*senseid), CCW_F_=
SLI);
> +	if (!ccw) {
> +		report(0, "Allocation of CCW");
> +		goto error_ccw;
> +	}
> +
> +	ret =3D start_ccw1_chain(test_device_sid, ccw);
> +	if (ret) {
> +		report(0, "Starting CCW chain");
>  		goto error;
> +	}
> =20
>  	if (wait_and_check_io_completion(test_device_sid) < 0)
>  		goto error;
> @@ -97,7 +112,7 @@ static void test_sense(void)
>  	if (ret < 0) {
>  		report_info("no valid residual count");
>  	} else if (ret !=3D 0) {
> -		len =3D sizeof(senseid) - ret;
> +		len =3D sizeof(*senseid) - ret;
>  		if (ret && len < CSS_SENSEID_COMMON_LEN) {
>  			report(0, "transferred a too short length: %d", ret);
>  			goto error;
> @@ -105,21 +120,25 @@ static void test_sense(void)
>  			report_info("transferred a shorter length: %d", len);
>  	}
> =20
> -	if (senseid.reserved !=3D 0xff) {
> -		report(0, "transferred garbage: 0x%02x", senseid.reserved);
> +	if (senseid->reserved !=3D 0xff) {
> +		report(0, "transferred garbage: 0x%02x", senseid->reserved);
>  		goto error;
>  	}
> =20
>  	report_prefix_pop();
> =20
>  	report_info("reserved 0x%02x cu_type 0x%04x cu_model 0x%02x dev_type =
0x%04x dev_model 0x%02x",
> -		    senseid.reserved, senseid.cu_type, senseid.cu_model,
> -		    senseid.dev_type, senseid.dev_model);
> +		    senseid->reserved, senseid->cu_type, senseid->cu_model,
> +		    senseid->dev_type, senseid->dev_model);
> =20
> -	report(senseid.cu_type =3D=3D cu_type, "cu_type expected 0x%04x got 0=
x%04x",
> -	       (uint16_t) cu_type, senseid.cu_type);
> +	report(senseid->cu_type =3D=3D cu_type, "cu_type expected 0x%04x got =
0x%04x",
> +	       (uint16_t)cu_type, senseid->cu_type);
> =20
>  error:
> +	free_io_pages(ccw, sizeof(*ccw));
> +error_ccw:
> +	free_io_pages(senseid, sizeof(*senseid));
> +error_senseid:
>  	unregister_io_int_func(css_irq_io);
>  }
> =20
>=20



--Fw7QJi5b2lbnk6kWiFpfZVUNejTC8zvud--

--Fg7Bt0xb2NnXSQb8NmRtNpFG20HQ5DzJG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAmAJUCQFAwAAAAAACgkQ41TmuOI4ufjO
yBAAirnMK1zugUgBWB4gC5ssiTUCUgZfSz5p4ssVVjW0zoMDGl/vDi+Bn6xFPl/6nUL5cO0nY3Dt
oyR4T/QBmFDZRSM30XA0zNTWDnxvLUHCKPdvKGnbVhpmU98PMda9PegAsLefOm8/ZmuVkAO3pdtS
KWZYtB0Af4ieNfbToLXpXvDfAUwBd9Muji82u4bQywaMpW9JckLvOTRhAPws3Kch7g/9c3+HYIpB
MgjiLun2MCwSkNeNoVkqTBiMa5RBdveEzOkujGI35WFxxoLXEwx4XtvssZv3+/oAj0J5PepzGvef
cn8cEKEAMcRzvvF7MfoEKAhKu+H4VwfT+V4rGzYgwiQjHXQm4EMgTu4oOsWu2fZ34Fu0T+l3CRqs
fR1NvvDuhSPKZgmN3pyM/UCepqg+Bk+eohFm/jbjh64kTQ1MYddjA+jDFji2OommycEzrjf9K/+F
0wHGmyqylSh499NfwEv5BfXNYhQtDsMEGxDLPkDluPu5M8yRbXiMtgtfmgNugvPmYw95SP0HdgV6
l2NTEilAteGStrgWrRKUgbSyCJuIvb4wylgNAEyLYrIC2zb36p3FZeXTMUQF01t6wxmf0LsLnY98
0HWKFwBBa3B8moHRSX/sBB8VyXKBpoSJilG2syFxqmoo1fudt35hy5vlm+bvy9zswQ0+A4KXwfqm
6vE=
=n8i9
-----END PGP SIGNATURE-----

--Fg7Bt0xb2NnXSQb8NmRtNpFG20HQ5DzJG--
