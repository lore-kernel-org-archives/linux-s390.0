Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD028642B;
	Wed,  1 Apr 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050296; cv=none; b=oonCTIS1GwUChjCV/+Yr8Z/rBzUqj6vSLiJssG1qach+Qy6UQwYJqO97YnaE/scUrI57pHLe3E6fQfsE676rXM2o8L5vyZKItnToF8cl395dQMmcUQIWiOKlqSQn6bo/KJtTowD0sxdi+KVw0FYHuYXFa7w6T/ZHX6kSEa63CEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050296; c=relaxed/simple;
	bh=jsg0AbCyeu4+JCr0aIiJsl8IyRUzTxE/nmQGH7MTGo4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOHQS6aDLlT9CaAyLBLzdSn9T2lhuiAwhDSagRcQRVzb+aiE7TAun1iD80ZigkezA1+XRiBIV3hQvre05QQovitDj7Hv/UIvn9m7JrqXGN8Bko+HSo5ocSCHXtrkzuDwffS+lbxQBwfrtRTZp5GgAn1ooyQcWclGPsv6UAdC3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KJclgWsE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KJclgWsE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631BC6sH560642;
	Wed, 1 Apr 2026 13:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EY+LZf
	4mXkXrOeKrbYUq67zhItYQZ7joDVeTeEXXuyA=; b=KJclgWsEuOvWL2JAAGus+y
	QV0CyQtpSmFlKLFk2Pqkjjps7PthlQ0EPQNjO211jnZdfLBJc52UMSdinhsWnvi0
	/p8MssSGIXVyp6i7eKs73Tce+sHVbke38fgMf2IUbmCzssqvdV+I7b+SQ4g46VAX
	XCAermq5yQUr4ez+vMgW+7q07tLwXDy1GeLuOe5+zv89NLA1cqI/d6sXol/7sAZt
	GsTgHkqUHbmoxF8vRKstZyU1SSkCoxgxdLcf/doVdAl49PDrSI2acxdbr9rh6VVZ
	I5ziz1VZH0GRq89RL4TiaIEvV5FgdOgxfSz4PQFJOzjjSyTGzEbvgy9xV+a0VGvg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g20b6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:31:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631BVlc2022271;
	Wed, 1 Apr 2026 13:31:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan5pwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:31:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631DVQRC35914312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 13:31:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FA4C5805D;
	Wed,  1 Apr 2026 13:31:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC92A58056;
	Wed,  1 Apr 2026 13:31:25 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.97.105])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 13:31:25 +0000 (GMT)
Message-ID: <a643b4d04601e1ba0c72e54e95baee9af4a3e3b5.camel@linux.ibm.com>
Subject: Re: [PATCH v1 1/4] KVM: s390: vsie: Allow non-zarch guests
From: Eric Farman <farman@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand
 <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Date: Wed, 01 Apr 2026 09:31:25 -0400
In-Reply-To: <7aed180b-65ad-42fe-8785-d6ee0c112815@linux.ibm.com>
References: <20260401020915.1339228-1-farman@linux.ibm.com>
	 <20260401020915.1339228-2-farman@linux.ibm.com>
	 <7aed180b-65ad-42fe-8785-d6ee0c112815@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cd1e31 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=38KsxSFTJFVvFiXhMoMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sHEfhWkJVfhp_B0UKODCPQuFlnCtcRt1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEyMyBTYWx0ZWRfXwi4jyeO44E0r
 3oAVX3+TwUkKm3STG3FO1lGuTKpqnjKVr/Yr4mCnIeWnAK4//TkcQBdjd0clrNoZ2jHu0SKWg/c
 uWBmBrtHAFOrXwPxY9X79fRlPXWHhI46IdpGT1LjOnspfbkk7x4t78mjwvnpsGePJeRminpRG2Q
 EiSreTP8W3agr19KGVs/XYCfAzjL4YFhSRiBK8zbDKn5uxwqh/kNmP8ljzS2SYtpK04Njw/zJFU
 GKfgQmR/HglZ2rL+Mw2dkrdgn2pVtH+lQ9niqp6dEerMkT1HBd2xPxoAQNGF45v8S6tKGkKf9UE
 OIE5SdaXvwmOYUEv3053LmB87XZmKfyYaX804FCKjFXs4gjnCLKo4IIeX+qQdipAndoFVqfojhg
 /NFTceI/hQAjnKtez2Yzmz6XzN03lJ+nFncqbhgbFhgAQV1+ax34reRGVR2pxYciVPxMJoWcHvR
 eowxtfPb7MsKHctEaUw==
X-Proofpoint-GUID: sHEfhWkJVfhp_B0UKODCPQuFlnCtcRt1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010123

On Wed, 2026-04-01 at 13:25 +0200, Janosch Frank wrote:
> On 4/1/26 04:09, Eric Farman wrote:
> > Linux/KVM runs in z/Architecture-only mode. Although z/Architecture
> > is built upon a long history of hardware refinements, any other
> > CPU mode is not permitted.
> >=20
> > Allow a userspace to explicitly enable the use of ESA mode for
> > nested guests, otherwise usage will be rejected.
> >=20
> > Signed-off-by: Eric Farman <farman@linux.ibm.com>
> > ---
> >   arch/s390/include/asm/kvm_host.h | 1 +
> >   arch/s390/kvm/vsie.c             | 8 +++++---
> >   2 files changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/k=
vm_host.h
> > index 3039c88daa63..8a4f4a39f7a2 100644
> > --- a/arch/s390/include/asm/kvm_host.h
> > +++ b/arch/s390/include/asm/kvm_host.h
> > @@ -656,6 +656,7 @@ struct kvm_arch {
> >   	int user_stsi;
> >   	int user_instr0;
> >   	int user_operexec;
> > +	int allow_vsie_esamode;
> >   	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
> >   	wait_queue_head_t ipte_wq;
> >   	int ipte_lock_count;
> > diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> > index 72895dddc39a..888370a02ef7 100644
> > --- a/arch/s390/kvm/vsie.c
> > +++ b/arch/s390/kvm/vsie.c
> > @@ -125,8 +125,9 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, =
struct vsie_page *vsie_page)
> >   	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
> >   	int newflags, cpuflags =3D atomic_read(&scb_o->cpuflags);
> >  =20
> > -	/* we don't allow ESA/390 guests */
> > -	if (!(cpuflags & CPUSTAT_ZARCH))
> > +	newflags =3D 0;
>=20
> Not sure why you have that here but removed setting newflags below.

Yeah, I don't have any good reason for it here.

>=20
> > +	/* we don't allow ESA/390 guests unless explicitly enabled */
> > +	if (!(cpuflags & CPUSTAT_ZARCH) && !vcpu->kvm->arch.allow_vsie_esamod=
e)
> >   		return set_validity_icpt(scb_s, 0x0001U);
> >  =20
> >   	if (cpuflags & (CPUSTAT_RRF | CPUSTAT_MCDS))
> > @@ -135,7 +136,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, =
struct vsie_page *vsie_page)
> >   		return set_validity_icpt(scb_s, 0x0007U);
> >  =20
> >   	/* intervention requests will be set later */
> > -	newflags =3D CPUSTAT_ZARCH;
>=20
> I'd leave this but set it to 0.
>=20
> > +	if (cpuflags & CPUSTAT_ZARCH)
> > +		newflags =3D CPUSTAT_ZARCH;
> >   	if (cpuflags & CPUSTAT_GED && test_kvm_facility(vcpu->kvm, 8))
> >   		newflags |=3D CPUSTAT_GED;
> >   	if (cpuflags & CPUSTAT_GED2 && test_kvm_facility(vcpu->kvm, 78)) {
>=20
> I can fix that up if you want.

This makes more sense. And if you don't mind, that would be wonderful!

>=20
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Thank you!
