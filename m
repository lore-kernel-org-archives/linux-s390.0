Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727075AbgD0NLU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Apr 2020 09:11:20 -0400
Subject: Re: [kvm-unit-tests PATCH v6 07/10] s390x: css: msch, enable test
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-8-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <cff917e0-f7e0-fd48-eda5-0cbe8173ae8a@linux.ibm.com>
Date: Mon, 27 Apr 2020 15:11:13 +0200
MIME-Version: 1.0
In-Reply-To: <1587725152-25569-8-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M6t2jwwj6kk9C6cH5rp44fvZDvVCwbY5o"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M6t2jwwj6kk9C6cH5rp44fvZDvVCwbY5o
Content-Type: multipart/mixed; boundary="i8CKtsay0Xep4A2XszZHV3oCBMgaAuQCW"

--i8CKtsay0Xep4A2XszZHV3oCBMgaAuQCW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/24/20 12:45 PM, Pierre Morel wrote:
> A second step when testing the channel subsystem is to prepare a channe=
l
> for use.
> This includes:
> - Get the current SubCHannel Information Block (SCHIB) using STSCH
> - Update it in memory to set the ENABLE bit
> - Tell the CSS that the SCHIB has been modified using MSCH
> - Get the SCHIB from the CSS again to verify that the subchannel is
>   enabled.
>=20
> This tests the MSCH instruction to enable a channel succesfuly.

successfully

> This is NOT a routine to really enable the channel, no retry is done,
> in case of error, a report is made.

Would we expect needing retries for the pong device?

>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  s390x/css.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/s390x/css.c b/s390x/css.c
> index cc97e79..fa068bf 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -68,11 +68,59 @@ out:
>  	       scn, scn_found, dev_found);
>  }
> =20
> +static void test_enable(void)
> +{
> +	struct pmcw *pmcw =3D &schib.pmcw;
> +	int cc;
> +
> +	if (!test_device_sid) {
> +		report_skip("No device");
> +		return;
> +	}

If these tests are layered on top of each other and need a device to
work, we should abort or skip and exit the test if the enumeration
doesn't bring up devices

> +	/* Read the SCHIB for this subchannel */
> +	cc =3D stsch(test_device_sid, &schib);
> +	if (cc) {
> +		report(0, "stsch cc=3D%d", cc);
> +		return;
> +	}
> +
> +	/* Update the SCHIB to enable the channel */
> +	pmcw->flags |=3D PMCW_ENABLE;
> +
> +	/* Tell the CSS we want to modify the subchannel */
> +	cc =3D msch(test_device_sid, &schib);
> +	if (cc) {
> +		/*
> +		 * If the subchannel is status pending or
> +		 * if a function is in progress,
> +		 * we consider both cases as errors.
> +		 */
> +		report(0, "msch cc=3D%d", cc);
> +		return;
> +	}
> +
> +	/*
> +	 * Read the SCHIB again to verify the enablement
> +	 */
> +	cc =3D stsch(test_device_sid, &schib);
> +	if (cc) {
> +		report(0, "stsch cc=3D%d", cc);
> +		return;
> +	}
> +
> +	if (!(pmcw->flags & PMCW_ENABLE)) {
> +		report(0, "Enable failed. pmcw: %x", pmcw->flags);
> +		return;
> +	}
> +	report(1, "Tested");

s/Tested/Enabled/

> +}
> +
>  static struct {
>  	const char *name;
>  	void (*func)(void);
>  } tests[] =3D {
>  	{ "enumerate (stsch)", test_enumerate },
> +	{ "enable (msch)", test_enable },
>  	{ NULL, NULL }
>  };
> =20
>=20



--i8CKtsay0Xep4A2XszZHV3oCBMgaAuQCW--

--M6t2jwwj6kk9C6cH5rp44fvZDvVCwbY5o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6m2fEACgkQ41TmuOI4
ufir/hAAjOQd6TX8q3Z1I/S9JrAm4eILbV40voN1aAN4PYHzeKq9NisRo++yDuDF
++HiEVYkcBsMkr1QzX2NEf641/31d7c3K+Fm7ClbpoUwXnX17Y6qFU0/Cglsf7KA
268vyaJfczG3G/yWjsBkIWoJfYTd4zZkJlUnzaJB31l6UmsK2B2A2VIGGfb1uP69
DGq52A26MV2B/5butq0dGNEXx+CgTZ70XgIv657zOtd51cyXtO0IYHFLwHuOKiEy
5hu6cGNIit3UtdMBlucNcZQ035Xo7R4tMzgixDY5w8PfS9yXl9KrarfWf95uU73u
dgIoThvxB68hAFpVTJHaR24kzHQ2UVsgl7pmKOcEB8zEbDYCvTADM1+RRGP3a4vU
3TfC0GEs+H76TqChCiIYLdqu6qfarpE1nEQ8d2Nj5f9dAs/ZVVTFLpJQ/ADbrn3p
Lv65JR7iSYYKbRuCdkBwz2NJaFA9H97EwMvMpzmHkfbZC5qdATaZhN3kHetDLYYP
Yk7SJrZMWatky72+RRk2L+mxKtVvPapLWgt8sPolHo77wCk1F0MGG91pSi/78TgH
FxMM5CKD6dfjEkxuGvWECDKub5FMnogBnBo53h7nA/+VPB66C+lEwWh+9aMg5mzs
Pr7Mo+L7rmTub6EJvSZDbbfmGRxRAWG5Fv5eAfkLCO8I5Y6jGfU=
=J/1T
-----END PGP SIGNATURE-----

--M6t2jwwj6kk9C6cH5rp44fvZDvVCwbY5o--
