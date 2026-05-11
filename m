Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA393A3E68;
	Mon, 11 May 2026 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504175; cv=none; b=oEF52aJMoGCMYz2VLWrB/5JQjeWVe43NOlIQb7G8hyoxHJ+kiH0NF/2MIi5kFQKUecY7vy/tSAFKVIQpNcUh6Hjr83wTRh5jpVar8JhakxWivDvPvH5Fcw/mOMoOdvGgsiMp4PaB286IH4/SC0x9GoNNy52+6IRs5wfqews3MYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504175; c=relaxed/simple;
	bh=x5H6Qf2p21aEL4c52QEUPPf2We8WEhnVH4KmF1j5MOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PtsXMVjjmo7ZoHkVlz85USJYykYm2qJcx5mLLzf5lohEg9VS+E2B5FNDXoow5OqpVfAA2Oeik5om2jhs9nsa2dZAQB+wiyOUqFB/TzNTN4KXPdP4as148rXz9V9Y3cxOGiR2vC6ZewUSzjSiC+Usel58Xo3+lCK/ToAVAHN7Mgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nkox8fE3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nkox8fE3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B7P55T2514984;
	Mon, 11 May 2026 12:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x5H6Qf
	2p21aEL4c52QEUPPf2We8WEhnVH4KmF1j5MOc=; b=Nkox8fE3gi90iKGZTY5Xpo
	f/mgB833W0ozNYpcfGGksG/WXOXzQ3xYJsuXBRtVA11QonExf6AOdCAi4TGRgXFX
	iIK9wMaFNcdLYPGnfIldhKJHQbOUrQhefsFXebt6BEpgubODOIyr4sF14pjwq3zR
	hA/yRNbSdAcBCVST71WbtStQYYdN/MCdtfrPkah3mLLFIzDxPtecfiaAwEbWu0+L
	fwV9trpyn61QTmkGiQPvCADl+H0qwIPz2+RgG0GqWVbNY/+oKdsJYXP85Btaxmee
	fuBz1elC1xSAXdjhS2voNiMcpAu4XHmk8Xxyou1cy+sNMBPLYzVkSUuxuZjTHjQQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhqyyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 12:56:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BCsVOn003520;
	Mon, 11 May 2026 12:56:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2grh57b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 12:56:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BCu5v333817312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 12:56:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8DD058062;
	Mon, 11 May 2026 12:56:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62CF758059;
	Mon, 11 May 2026 12:56:04 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.111.34])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 12:56:04 +0000 (GMT)
Message-ID: <2b83784ccde25eeabce8f213ebf2ace727f688d2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] KVM: s390: Toggle operation exception for
 userspace
From: Eric Farman <farman@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger
	 <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand
	 <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Date: Mon, 11 May 2026 08:56:03 -0400
In-Reply-To: <c7655af3-9705-487c-add2-dd31d8bc6623@linux.ibm.com>
References: <20260507200836.3500368-1-farman@linux.ibm.com>
	 <20260507200836.3500368-2-farman@linux.ibm.com>
	 <c7655af3-9705-487c-add2-dd31d8bc6623@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a01d1e6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=PSjzCw7vbD8hFPKuc84A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 07f7fw-NgMVccG8vJ8670JkJOcgYHPi1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0MCBTYWx0ZWRfX5CuMEDHHO4Ud
 jXX+mAdvWNYFRf7lzWTcHprkwbXc31bddEFq3LtLj8r3D4CnjTPKya83ku0+g3/48FQSl4h1u47
 FRaNFBaB/Ty1a9eZuYVQ3Gq6BA3QexbkAuCkXscIiSDIl2rcvcSp4E9iSNTXgSGQyHx3MRF/NTQ
 1+UDJZqBFzxb29ob3E3xUporFLVyidu0/0AXtspi7SYT/UKyLiTpMvrVjvREjXo19WNYGTUarQg
 6hdoTb90onX7CCdJcApJstjpn4lKGsNssWsSeakqOafhsxa6pbIj5uT/zpzCtaUKZezEE5+DZ6N
 n2Gbjah/FKOjLbRQlGWN2IvTie4Yax4x2liEb1cutg5MCIlzhUf/dS34oFjCa8RUelTp4T5kB/w
 02zMEvp9qaQyWe9N+JaBTkVbVrIUQkHNbhMWSvvRUjig3zCT9ikSFI96AGI6ABUsBO5vwtae7Ba
 6+5rPzY3b/o83kfXkcQ==
X-Proofpoint-GUID: 07f7fw-NgMVccG8vJ8670JkJOcgYHPi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110140

On Mon, 2026-05-11 at 10:08 +0200, Janosch Frank wrote:
> On 5/7/26 22:08, Eric Farman wrote:
> > The KVM_CAP_S390_USER_OPEREXEC capability allows operation exceptions
> > to be forwarded to userspace. But the actual enablement at the hardware
> > level occurs in kvm_arch_vcpu_postcreate(), and only if STFLE.74 or
> > user_instr0 are enabled. The latter is associated with a separate
> > capability (KVM_CAP_S390_USER_INSTR0), so the only way this happens
> > for the USER_OPEREXEC capability is if STFLE.74 is enabled. KVM
> > unconditionally enables this bit in kvm_arch_init_vm(), but the guest
> > could disable it from the CPU model and thus ignore this capability.
> >=20
> > Add USER_OPEREXEC to the check in kvm_arch_vcpu_postcreate(), such that
> > either capability would enable this type of exception.
> >=20
>=20
> Naming wise shouldn't this be something like:
> KVM: s390: Fix S390_USER_OPEREXEC enablement without stfle 74
>=20
> ?

Yeah, that is clearer, and I would be fine with that edit.
