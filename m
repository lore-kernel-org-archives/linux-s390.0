Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727183AbgC3JRR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 05:17:17 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02U95YZs175639
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 05:17:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30227uuk9d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 05:17:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 30 Mar 2020 10:17:02 +0100
Subject: Re: [kvm-unit-tests 1/2] s390x/smp: fix detection of "running"
References: <20200330084911.34248-1-borntraeger@de.ibm.com>
 <20200330084911.34248-2-borntraeger@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 30 Mar 2020 11:17:08 +0200
MIME-Version: 1.0
In-Reply-To: <20200330084911.34248-2-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7yQXseOxpMwqByGo7OSgstgdBoB0rvb4V"
Message-Id: <cffb6632-e4ba-c360-3b73-02581ccf855d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7yQXseOxpMwqByGo7OSgstgdBoB0rvb4V
Content-Type: multipart/mixed; boundary="il8DkvxJcCnRanV1fM5hZACTfvPmiZu9M"

--il8DkvxJcCnRanV1fM5hZACTfvPmiZu9M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/30/20 10:49 AM, Christian Borntraeger wrote:
> On s390x hosts with a single CPU, the smp test case hangs (loops).
> The check is our restart has finished is wrong.
> Sigp sense running status checks if the CPU is currently backed by a
> real CPU. This means that on single CPU hosts a sigp sense running
> will never claim that a target is running. We need to check for not
> being stopped instead.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>

> ---
>  lib/s390x/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index 2555bf4..5ed8b7b 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -128,7 +128,7 @@ static int smp_cpu_restart_nolock(uint16_t addr, st=
ruct psw *psw)
>  	 * The order has been accepted, but the actual restart may not
>  	 * have been performed yet, so wait until the cpu is running.
>  	 */
> -	while (!smp_cpu_running(addr))
> +	while (smp_cpu_stopped(addr))
>  		mb();
>  	cpu->active =3D true;
>  	return 0;
>=20



--il8DkvxJcCnRanV1fM5hZACTfvPmiZu9M--

--7yQXseOxpMwqByGo7OSgstgdBoB0rvb4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6BuRQACgkQ41TmuOI4
ufjqMw//SznSfvkqltgIe1i46hFe+7/F8mmlp7ma/JPr14GXypqFcX0/+B2YeTvT
97EHdWWOWoj/8Z6nsEw90sM9GezKNOhfJ/1MecUj0oDrpDiz4FkGYnXuK45oTRQc
rbf92CzHuVFHdrwlfT2FS3MDBXRWgBac0Bw4Hpt+sBVIhCJ/kQUTZVmHwdBjTfLJ
7iLLZ+N96Kb03rIAbk3ThwUrADlamP0h9+IfEd1colPjleIUZEk1n+QOsofdlW/t
NYE3FUGNelrNx7XX3rj1CMrTmGzPnsZiQV6yHR0MxIERTotD4IfpCTAP4uSvYqml
f0Wm8iYsvByPbFoB7bKYuVF/aoxzPM381M3inTfBekqDaTk8j1QGFmG34GVZ8c3G
PcGcj1PkCo4/9qV4wvkZSdCrTTaT9KlhqiVhga7XLAVbA9/QUzfgdWnJvveJQoOJ
bhuIvwIotk+S78qX9JSs3zLoWhpIFWdK3PEGmBg8uQI94XIHc8/mmQ70/aDQXl62
T/pNpOIosBFKLFPQocTQd1Dn/ynlN5lfRznuXauaTmWt97s9DGdw3OO8jPsltUMk
a5w7avphKp4s6PomgQeAf9pntS3uUuOG9gpghLlg9PPOuvZAAGg5/+30PjDULNky
PVB2K6pf7Mkd0NWvMlHPgWQeFdOkYOR7OfLhlN8AETyAr2isx+U=
=hyri
-----END PGP SIGNATURE-----

--7yQXseOxpMwqByGo7OSgstgdBoB0rvb4V--
