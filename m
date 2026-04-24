Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E627603C;
	Fri, 24 Apr 2026 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061785; cv=none; b=dbLgIqWeRz/SfXIKjirqWpQU4Ol+SCPU4P6ULcPHDSOqLk4X/VDhiYLNIz+clRTtc3OiMzjX2rGzqYyQQBc0WOgmD/UWkGNUskJXHH9htMA+RSihpqB9dl42exC/iF92Tm3sWYUF7ynOGrc/OibwkZCZbsEpvnHZo4CZvgHI4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061785; c=relaxed/simple;
	bh=4Y6Oev7LIXS/Hkmz/YvmkBJHY3Mw1WWx/2ZpBIPezV4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Ld88ZuLuuzyBxzSauL4xAYyXYkaMbOJlBakif7t9MTP4bMEwqTsf87jx9Rm28mtsUH/XDr3wYZDkSRNigcP6nz22OaMtfgomFbL2l1v5BVKG0XkQXcodUc2FBy9zt7mCo8TVr80y9OGCf6aCWNhDIZiYWAeL0nZ6QNsnUyj9cm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sYWxC+D+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sYWxC+D+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OCFNSD3292262;
	Fri, 24 Apr 2026 20:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=683qgi
	lOGqVSu+v9RRyk7Hm5g8fZk3M96vYmxIo+HZM=; b=sYWxC+D+uCUsQNIWtwuM5d
	zyeKKOJOPWE5HZctjAwRYJVJjAZeCU0hJE8UZTNkZuVMfDs5ySBso0utiAxRJxoQ
	dz/HjIMiXexhjrQOOSPnokfUxSwglFx02ps+IeK3258Id4x983LEsnOlzZha5mnA
	7066txqy5kTkPOKQL7gnEopsNb+q+xjO/bbfHhrKlMcNJQ73xsqpUku76wfwJPvd
	uzYhZQlf2HQQJLEkqDFJnVPuf/ieLdPqG9rpp3TV5mDYv4rNSL8FCvV3MFk5uS6+
	qwpxr2dXqQwPHRqsFLtXlH0KQn1OU31SQ0J3IgcuYCvCFfir4XfZMzwjyACshucw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrq43r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 20:16:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OK5ONv005405;
	Fri, 24 Apr 2026 20:16:20 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky4bma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 20:16:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OKGIWo4588082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 20:16:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD93A5805C;
	Fri, 24 Apr 2026 20:16:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 368C258058;
	Fri, 24 Apr 2026 20:16:16 +0000 (GMT)
Received: from [9.87.143.165] (unknown [9.87.143.165])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 20:16:16 +0000 (GMT)
Message-ID: <1e6188579339a8cbae4ece744d7f981022188d9a.camel@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: pci: Fix aisb calculation
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1acdd73d-2b30-4d92-af83-1d5d1ec34c7d@linux.ibm.com>
References: <20260424193900.940816-1-mjrosato@linux.ibm.com>
	 <d0765cdf0f3832c3fd92af53d2a4060d2d018439.camel@linux.ibm.com>
	 <1acdd73d-2b30-4d92-af83-1d5d1ec34c7d@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 22:15:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8qceCoK2VaboZhd8BntOTOpaS63JLB7o
X-Proofpoint-ORIG-GUID: 8qceCoK2VaboZhd8BntOTOpaS63JLB7o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE5MyBTYWx0ZWRfX6Pa2ic1BGIsv
 sOMTR08Cbj0f+XFfHaF8BaL+buV4jajEkurzlT31LZDF+9lxUiMs+EuvLUtHNGsELbF27WgLu4L
 JTPXoV1ZC+kUz6MAJXb39SXI6zssHxSisvueEJh+YNpp5AeMjg0Emvy+H8aq0z1A9ZDuddFBEyr
 po+n55pyxPn5byZU8hD+5OX3WwioXhgD20Q+doiWH4aOi/Dev2o+WVGIPRcdWvX/ngot+cIZ4UG
 Ryn1+Tw8v/tPR1UFk3CZS6mjNbVuC4a7cCK+H6h1AKdK9wsGue1X3lHca1Rfi9iRLSSzz0yv80f
 M5pvywIn7Tt2W7xWw19ZCOrDaaIyRVcDm2IcM65p0/9Q6Fb46ypGAFJTq4WsTWrq3wPBz3sLJJ1
 oqcJBCowLAZDJfyiVcLqzH3okR4xw/R1ffHa7U8v8QNLiq8UTvAJuIisgAZG6RHRmxuYulNKqJE
 84NvJljjbXwFbW2d3Yw==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69ebcf95 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=0Qad79VQDZkC-pr6aQwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240193

On Fri, 2026-04-24 at 16:09 -0400, Matthew Rosato wrote:
> On 4/24/26 3:55 PM, Niklas Schnelle wrote:
> > On Fri, 2026-04-24 at 15:39 -0400, Matthew Rosato wrote:
> > > The current implementation of aisb calculation will erroneously index
> > > via an unsigned long * as well as multiply by 8B for every 64-bits in
> > > the offset; only one or the other is required.  This throws off aisb
> > > calculations once the number of devices exceeds 64, and can result
> > > in out-of-bounds access as well as failure to indicate summary bits
> > > associated with those devices in guests.
> > >=20
> > > Fix this by converting to a physical address before applying the
> > > offset, as is already done in arch/s390/pci/pci_irq.c.
> > >=20
> > > Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/d=
isabling interrupt forwarding")
> > > Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > > ---
> > >  arch/s390/kvm/pci.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> > > index 86d93e8dddae..338171f9371b 100644
> > > --- a/arch/s390/kvm/pci.c
> > > +++ b/arch/s390/kvm/pci.c
> > > @@ -166,7 +166,7 @@ static int kvm_zpci_set_airq(struct zpci_dev *zde=
v)
> > >  	fib.fmt0.noi =3D airq_iv_end(zdev->aibv);
> > >  	fib.fmt0.aibv =3D virt_to_phys(zdev->aibv->vector);
> > >  	fib.fmt0.aibvo =3D 0;
> > > -	fib.fmt0.aisb =3D virt_to_phys(aift->sbv->vector + (zdev->aisb / 64=
) * 8);
> > > +	fib.fmt0.aisb =3D virt_to_phys(aift->sbv->vector) + (zdev->aisb / 6=
4) * 8;
> >=20
> > As you state, one or the other would work, wouldn't it be easy to read
> > like below:
> >=20
> >          fib.fmt0.aisb =3D virt_to_phys(aift->sbv->vector + (zdev->aisb=
 / 64));
>=20
> My rationale was to match exactly what zpci_set_airq() in
> arch/s390/pci/pci_irq.c is doing (I tested that code at the same time to
> ensure it produced the expected result as a comparison to the code
> changed by this patch).
>=20
> I'd rather all 3 places stay the same unless you have a strong opinion
> on it.  I think the reason they ended up different in the first place is
> because this code and the pci_irq.c code were updated independently for
> V!=3DR.

No strong feelings and I do agree about doing the calculation the same
as in zpci_set_airq(). Your variant also is understood without knowing
that aift->sbv->vector is an unsigned long*. So it's kind of a wash to
me.

>=20
> >=20
> > >  	fib.fmt0.aisbo =3D zdev->aisb & 63;
> > >  	fib.gd =3D zdev->gisa;
> > > =20
> > > @@ -309,7 +309,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_de=
v *zdev, struct zpci_fib *fib,
> > > =20
> > >  	/* Update guest FIB for re-issue */
> > >  	fib->fmt0.aisbo =3D zdev->aisb & 63;
> > > -	fib->fmt0.aisb =3D virt_to_phys(aift->sbv->vector + (zdev->aisb / 6=
4) * 8);
> > > +	fib->fmt0.aisb =3D virt_to_phys(aift->sbv->vector) + (zdev->aisb / =
64) * 8;
> >=20
> > Same argument as above.
> >=20
> > >  	fib->fmt0.isc =3D gisc;
> > > =20
> > >  	/* Save some guest fib values in the host for later use */
> >=20
> > Ouch, good catch! Was this kind of a follow up to the issue someone
> > found upstream with a wrong calculation in the gait? Or did you just
> > notice things break with more than 64 devices?
>=20
> A follow-up of sorts.  Sashiko gave various outputs to that gait patch
> that were unrelated to it; I'm looking into those things and it led me
> to at least this issue which I did verify is a real bug.
>=20
> Thanks,
> Matt

Makes sense and great work! Feel free to add mu:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas
