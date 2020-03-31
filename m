Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730286AbgCaQNa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Mar 2020 12:13:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VG4NrW088142
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2020 12:13:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 301yffwdr3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2020 12:13:29 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Tue, 31 Mar 2020 17:13:25 +0100
Date: Tue, 31 Mar 2020 18:13:21 +0200
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [RFC PATCH v1 27/50] drivers/s390/scsi/zcsp_fc.c: Use
 prandom_u32_max() for backoff
References: <202003281643.02SGhHN7015213@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202003281643.02SGhHN7015213@sdf.org>
Message-Id: <20200331161321.GB17507@t480-pf1aa2c2>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: George Spelvin <lkml@sdf.org>, Steffen Maier <maier@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org

On Fri, Nov 29, 2019 at 03:39:41PM -0500, George Spelvin wrote:
> We don't need crypto-grade random numbers for randomized backoffs.
>=20
> (We could skip the if() if we wanted to rely on the undocumented fact
> that prandom_u32_max(0) always returns 0.  That would be a net time
> saving it port_scan_backoff =3D=3D 0 is rare; if it's common, the if()
> is false often enough to pay for itself. Not sure which applies here.)
>=20
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/s390/scsi/zfcp_fc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hello George,

it would be nice, if you could address the mails to the
driver-maintainers (`scripts/get_maintainer.pl drivers/s390/scsi/zfcp_fc.c`
will tell you that this is me and Steffen); I'd certainly have noticed
it earlier then :-).

>=20
> diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> index b018b61bd168e..d24cafe02708f 100644
> --- a/drivers/s390/scsi/zfcp_fc.c
> +++ b/drivers/s390/scsi/zfcp_fc.c
> @@ -48,7 +48,7 @@ unsigned int zfcp_fc_port_scan_backoff(void)
>  {
>  	if (!port_scan_backoff)
>  		return 0;
> -	return get_random_int() % port_scan_backoff;
> +	return prandom_u32_max(port_scan_backoff);

I think the change is fine. You are right, we don't need a crypto nonce
here.

I think I'd let the zero-check stand as is, because the internal
behaviour of prandom_u32_max() is, as you say, undocumented. This is not
a performance critical code-path for us anyway.

>  }
> =20
>  static void zfcp_fc_port_scan_time(struct zfcp_adapter *adapter)
> --=20
> 2.26.0
>=20

Steffen, do you have any objections? Otherwise I can queue this up -
minus the somewhat mangled subject - for when we send something next time.

--=20
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Sys=
tems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/pri=
vacy
Vorsitz. AufsR.: Gregor Pillen         /        Gesch=EF=BF=BDftsf=EF=BF=BD=
hrung: Dirk Wittkopp
Sitz der Gesellschaft: B=EF=BF=BDblingen / Registergericht: AmtsG Stuttgart=
, HRB 243294
