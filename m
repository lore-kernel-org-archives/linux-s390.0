Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C883F1645;
	Wed,  6 May 2026 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075725; cv=none; b=SJPmwtO2y2aB8U6SQ4tI7y+rU6IXwpsvTtYXaK5CQn5b7E4fQx72nuZ93n0sd3MQDzk7EgTOZH9dnnlV0aszCyz4qGwqQMOwV37TIKqmGvEz8ue5dm5pD+MNW/hVlFLV5JLe3ZvWTwkaheKgSiwi9QPyO6BwXM/B64i/7ebD6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075725; c=relaxed/simple;
	bh=X7KKTp4eS62Kb7RbgA46G+mYGISlbx+Lnbg459zCqCo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dk8ldXrRKV/6S12fd5YjNWI9MouHiMqA+dGIFjThHZgHHRjinwwh7Krv/Xgrtca3N9FLwD2aI7ZTvgD6iWy576lnrYgkqC1z0+aC0ZnMdE6zx2wvhHp++kTKFI4f+CNw89U/b74stkOZv/GRJZa3g4rLP4Q52UTBFyImsRJgqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ek59/uKV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ek59/uKV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646Bsh5L3452190;
	Wed, 6 May 2026 13:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wyPTZP
	JGBXl92pvzlRytExwFC101737pHluhtMlqBfo=; b=ek59/uKVhtPiQbhd3BgV+i
	ExMHffzruHt3Ajz45Jj7PmFI0UIft4hNyXboiJfJaRhfiRvLTU4AA/e0RYrl1YZQ
	pTl18XQ49oGro1QTaY1GnvcBE1FZ056NVAYMaFfMn4Plbi3ZfsIZbVbujhvbRIpJ
	fNwsbEmBVxhGpYB8tM6RBB3vtB0j7mrRZLeW4VL48A649V+ZTj8i5QF9/j+9TdMC
	bn9sUDzpGZR3GkNe/yfDUO1hPJrC5HX2ls/3DiM+o4wHmeWYnoSilSZqCycTOMQn
	DR159xskusaKJ3XimGCxyO42tD2+BkFYvJLQi7rRndE+F/sfJo6nzrB4GRs+9geQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxr8sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 13:55:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646DsTpx016927;
	Wed, 6 May 2026 13:55:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw6j1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 13:55:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646DtJHu23003830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 13:55:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71C065805E;
	Wed,  6 May 2026 13:55:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 865E558052;
	Wed,  6 May 2026 13:55:18 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.44.93])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 13:55:18 +0000 (GMT)
Message-ID: <8f8f757b12f203db1afc00a122f67226beddc76b.camel@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: Toggle operation exception for userspace
From: Eric Farman <farman@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
	 <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Date: Wed, 06 May 2026 09:55:18 -0400
In-Reply-To: <20260506151909.60278083@p-imbrenda>
References: <20260505204521.1658704-1-farman@linux.ibm.com>
	 <20260506151909.60278083@p-imbrenda>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNCBTYWx0ZWRfXxJBd4D+FzYAb
 /Qyqwuu0PHVKknPDgRrr4d5qji7jl2h/wWzi0tQ6i/2cJ+V7KwtsX2arGk5uDNa0P8cWjwHEzzc
 HctJu9JU1NnyRMn0tX7mOJO1zO2G25Dz+Z3hPmrz0pfUbRBR0VWxkszJiyjtcEf/vtGzKBuF7bE
 e7a0Yxa6Qjgjn4F+GMYty6Cb6me3A1Zc5X7+pC2uk1g2eiAFXrMB/MnL57sX6C/PY8TzyahFMwZ
 gIS96J4oyNa9I4KzH0OcCwdBP8pFcdkHsiRv/psOiy0qEEh4njvWgUz1JOzc/p22wC6nDYoMX5+
 UFhQhjtj/WejILfuZLx+VSF7aqEoaJRszNpeAK5RpOPUfoqhmSP1wt/vHavU14NuzSxpjyIdZEg
 YUsQl9HIqnnaMM37jPNaMhZfkbO6zwlEbDp6GCTlwTg1dWo32/Ky9K+kzzfDwVbbRcW3QVAuSlr
 Gzv7BgJHzQhzWROxD8w==
X-Proofpoint-ORIG-GUID: 3rIqLs-vJ5OGfpNjDHvqHH1nKUWrOkvc
X-Proofpoint-GUID: 3rIqLs-vJ5OGfpNjDHvqHH1nKUWrOkvc
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fb4849 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=CuL7MAiMsHSykVvUlJYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060134

On Wed, 2026-05-06 at 15:19 +0200, Claudio Imbrenda wrote:
> On Tue,  5 May 2026 22:45:21 +0200
> Eric Farman <farman@linux.ibm.com> wrote:
>=20
> > The KVM_CAP_S390_USER_OPEREXEC capability allows operation exceptions
> > to be forwarded to userspace. But the actual enablement at the hardware
> > level occurs in kvm_arch_vcpu_postcreate(), and only if STFLE.74 or
> > user_instr0 are enabled. The latter is associated with a separate
> > capability (KVM_CAP_S390_USER_INSTR0), so the only way this happens
> > for the USER_OPEREXEC capability is if STFLE.74 is enabled. KVM
> > unconditionally enables this bit in kvm_arch_init_vm(), but the guest
> > could disable it from the CPU model and thus ignore this capability.
> >=20
> > Add USER_OPEREXEC to the check in kvm_arch_vcpu_postcreate(), such
> > that either capability would enable this type of exception.
> > KVM_CAP_S390_USER_INSTR0
> > Fixes: 8e8678e740ec ("KVM: s390: Add capability that forwards
> > operation exceptions") Signed-off-by: Eric Farman
> > <farman@linux.ibm.com>
>=20
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>=20
> can you also extend the existing selftest for KVM_CAP_S390_USER_OPEREXEC
> to also properly test with all combinations of
> STFLE.74 / KVM_CAP_S390_USER_OPEREXEC / KVM_CAP_S390_USER_INSTR0

Ah, of course. Will do.

>=20
> > ---
> >  arch/s390/kvm/kvm-s390.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index e09960c2e6ed..a91a42174302 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -3521,7 +3521,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vc=
pu)
> >  		vcpu->arch.gmap =3D vcpu->kvm->arch.gmap;
> >  		sca_add_vcpu(vcpu);
> >  	}
> > -	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0)
> > +	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 |=
|
> > +	    vcpu->kvm->arch.user_operexec)
> >  		vcpu->arch.sie_block->ictl |=3D ICTL_OPEREXC;
> >  }
> > =20
