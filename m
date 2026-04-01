Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6C43CEC0;
	Wed,  1 Apr 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051173; cv=none; b=lzZihPouBSWa5lU87+qkhi9tbeBcaLYuCqZymnA0YUCESy9k92kpD9mb3aMTLBBsVGyH2mucKER/O/3NTrQeeeK4a/SwM32Ms6oTd02SzQDn61xJLei5U5ea+GJXeLMp1uVrF7LELBA1NbwW+COKq4HoK8L/6Ab48H+kDN1VDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051173; c=relaxed/simple;
	bh=j9D2tttLZSRm13yRspI7NkKXyBxrpLfnpiGrCO+2Y3c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rzlZa7hmA4Eey+s3mQjifWNCl5sn6UHHN+AKotXQorg0DLaF9Rx23JYY1TX5MMnlwHbJFV+EuVH7PEZ90iWj9kiEvuT95Uvve0bCihfzwoqX0nTeznDGXq7EjAGULYeqlzWKPQu0PoswCQJvxtsay0Lx4WhNgdA44jmSETpp74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=atH8g9A/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="atH8g9A/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631CLhCj4014126;
	Wed, 1 Apr 2026 13:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DKnbti
	TyGgCnmOyEGSpxddvmaOvk1+WMeObbZbMbLnE=; b=atH8g9A/PFjSW4rlEhjNlr
	9zPo9Udckv80vkoJmJxn/hzd5reyH1iLzxO0t5d8qXl4b9yfamku716ePn9Y0VDq
	CE892oKFKjIyLQXssWUsgXdWugendkWOVAKD6QESF1Y/YPtSkoUHLEc3qIaVG9wr
	bh6RciloBTBuNoKqwD9J8yqJeJmrbpzuWruA664IjVghFtKuEZNwsDyxGHqnjSUN
	cLDZWYLlAgQ6gFPyhJ8t4r52FZt1Khk5maB48lcHxdVjCnP9HXJ2wT8lrNqLk6CG
	NMGXgf5W9wYXII4M7XkJ4WeVEkUYhOmFHUnIonLrIJv6lo47QGpChorrLkSpLnYQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcfnxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:46:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631CooRt008751;
	Wed, 1 Apr 2026 13:46:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11nj62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:46:06 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631Dk4af19006092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 13:46:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B316958061;
	Wed,  1 Apr 2026 13:46:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 354A158059;
	Wed,  1 Apr 2026 13:46:03 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.97.105])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 13:46:03 +0000 (GMT)
Message-ID: <ca84cb51f1d4f6520012ef2e2df475a5d2a344f2.camel@linux.ibm.com>
Subject: Re: [PATCH v1 2/4] KVM: s390: vsie: Disable some bits when in ESA
 mode
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner
	 <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio
 Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Date: Wed, 01 Apr 2026 09:46:02 -0400
In-Reply-To: <91feaccb-9d28-4519-8e89-43f75e88b8bd@linux.ibm.com>
References: <20260401020915.1339228-1-farman@linux.ibm.com>
	 <20260401020915.1339228-3-farman@linux.ibm.com>
	 <91feaccb-9d28-4519-8e89-43f75e88b8bd@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cd219e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Ulf51bJkPhmArn7DDwoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EMKskH7-_TvfNGVD48n7V4FjYdLWQ9NJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEyMyBTYWx0ZWRfX5TjdoR5DJjYe
 Ms/UbD4bcnqESP3VyZ2wpz4w58bPoI59g9FXUoBWlObz1xKgsqI9GAYuBzCkutb++U/G8C12D4/
 OqYn+D7rtBwL//g4bRk6E7Go9du55zy3nsKxaIqka+rY5logdEX9/xZ0X5LdmdnoVnoLy3UrzBl
 JeGxvEAowO/eNp29HKilBgPFdbpFLIFLISA569LZHddoBu1AZKhMXJ6KPiuIzUFWPX38BHe3rGG
 AoSnqq2mc5IJwZs3xpy9RnGiYSVb8P/j6ezYqkLIC4l8poqiJPIgXPJwlNtHjj0FP+xpR6zIeUj
 JuhjoUrn5ngSZcmStPKvUrxXjdFSAl99QlZ+ZnheePUeU7w42cht4GaIKrJcNuaAAvhmYUnpqa7
 pb4ZDdy4yH+ues6SrYxw35Sqv8OFILYqbqig2ghsiIZyPZ3S4BPzJjYxOovUpjSefupz1qCtE/J
 pK59VfelTv8+WIlpEUg==
X-Proofpoint-ORIG-GUID: EMKskH7-_TvfNGVD48n7V4FjYdLWQ9NJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010123

On Wed, 2026-04-01 at 14:58 +0200, Christian Borntraeger wrote:
>=20
> Am 01.04.26 um 04:09 schrieb Eric Farman:
> > In the event that a nested guest is put in ESA mode,
> > ensure that some bits are scrubbed from the shadow SCB.
> >=20
> > Signed-off-by: Eric Farman <farman@linux.ibm.com>
>=20
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> apart from one thing below
>=20
> > ---
> >   arch/s390/kvm/vsie.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >=20
> > diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> > index 888370a02ef7..584fc7803632 100644
> > --- a/arch/s390/kvm/vsie.c
> > +++ b/arch/s390/kvm/vsie.c
> > @@ -387,6 +387,17 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, str=
uct vsie_page *vsie_page)
> >   	return 0;
> >   }
> >  =20
> > +static void shadow_esa(struct kvm_vcpu *vcpu, struct vsie_page *vsie_p=
age)
> > +{
> > +	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
> > +
> > +	/* Ensure these bits are indeed turned off */
> > +	scb_s->eca &=3D ~ECA_VX;
> > +	scb_s->ecb &=3D ~ECB_GS;
> > +	scb_s->ecb3 &=3D ~ECB3_RI;
> > +	scb_s->ecd &=3D ~ECD_HOSTREGMGMT;
>=20
> shouldnt we also remove the TE bit (transactional execution)?

Ahh, good point. Yeah, that should be removed.

@Janosch, I'll spin a quick v2 with this and the other nits, so you don't h=
ave to do the fixups.
Just want to doublecheck this one.

>=20
> > +}
> > +
> >   /* shadow (round up/down) the ibc to avoid validity icpt */
> >   static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie=
_page)
> >   {
> > @@ -590,6 +601,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
> >   	scb_s->hpid =3D HPID_VSIE;
> >   	scb_s->cpnc =3D scb_o->cpnc;
> >  =20
> > +	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_ZARCH))
> > +		shadow_esa(vcpu, vsie_page);
> > +
> >   	prepare_ibc(vcpu, vsie_page);
> >   	rc =3D shadow_crycb(vcpu, vsie_page);
> >   out:
