Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5245D911;
	Wed,  7 Oct 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384399; cv=none; b=nowVTQ1DOTftGu8okxTJXSiizRWf03FbQeqQGzXq0mFZJjup5jqnvLxXfG5kzkRn73B1T1ZyaYqmkpjnfj1Aqw9ZbrRG6M1qKdKvvs0/jYwovd6yjdExvWYdzBqbXfw7Grxmfd5UNN+rn5Ww6x6FsUdJTYNIZaX+PKLdHMyMyaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384399; c=relaxed/simple;
	bh=Y2Ev2HiyMYwYoIMW4j0En0vbcmthH1wrfFA395620pU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKJ8Gx5OYGK93/frGQ716HmF01U3oFM08RCxJAtxUdIAHJcUZoJi3l2O3hJAyH2pixmwksp0Mux6iGD9/VqALNX26hCiuUHit+uIp/T2VBGJmxwWX/gYg+BU8KFKnWLeCEA/pMrXdQPj57kF9sTWyB+EFxF1XzsoTtC/YZnvIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AuAJetCy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AuAJetCy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZv1t597116;
	Wed, 7 Oct 2026 14:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jjNPSV
	mKr6c89WAa8C3C9erw+H/tJYWvkub40Ba8IYA=; b=AuAJetCynVE0iA9VcPw3eq
	6BfrfcE/HVKJXQXcJ9xL8bHRB6YH8oNl6GSpcIqK/Ixljf85q4RleTQpFgVezSeQ
	giEe4ed6nW3mcdZwJgG7MtQWk5zl18XMoeNWKv2795arM5qPac2caQ9wVExu6zEq
	7EJB8e3d+fap2oow12eHqveHiuzYlyjLRUcf485S3H3EI/ErSpYOXO3eHkUyh3hx
	RJzmQQ72QvmQ6j26YSUYlmL0VuLnoE+0gMayjYmEMIbg7jn+45vWoicn9h+jc1+c
	negKxZhkOLi7KfI0yHRXLI0DlrhXxYc74/c6iSitnGBu4QjcN/FPJ4QBe7cbOBkQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrp03e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 14:46:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BlYeX1808456;
	Wed, 7 Oct 2026 14:46:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvy3hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 14:46:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697EkNNH44892606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 14:46:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D594520043;
	Wed,  7 Oct 2026 14:46:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9825D20040;
	Wed,  7 Oct 2026 14:46:23 +0000 (GMT)
Received: from [9.224.92.241] (unknown [9.224.92.241])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 14:46:23 +0000 (GMT)
Message-ID: <8086f631ce7ce60f1763171c8f05b050ff6c73fd.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390/pci: Use 32-bit fh outside of inline asm
From: Gerd Bayer <gbayer@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev, Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik	
 <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Gerd Bayer
	 <gbayer@linux.ibm.com>
Date: Wed, 07 Oct 2026 16:46:23 +0200
In-Reply-To: <sashiko-outbox-162922@kernel.org>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
	 <20261007-rpcit_trcfh_upstream-v1-2-8a2718cfb90b@linux.ibm.com>
	 <sashiko-outbox-162922@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfX88t/axGTpOeP
 WekNQtOpQIB6OLkh3ujl/9zC7anGTX7YMNs5/JWm37C/Q3bJNYaVpHoGMU1bjkV90Frrm6qjE7k
 CJlMeqcKCEpUPkzMM7MOkyjPi6HP5R0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfX5T8QPesWOYlW
 FShx5TBUhXVsmKw6QVyG2FdLqNGR/N08EeZOSTYIOPZK/iDvug35QpKwYcnpHltJEg4OaOC64/a
 YPfnUpr3/F2wKjdy9H9s54O3Gkpz5JkiHaBwzRutA+ZomPpH/lrxsPCQCleg+Az9YgdaqKfPDBn
 e9MAofJctcO+1P6DL3y6Nua3LyKyUzgif7BQr7buJ6HVed2K32RIY/O0kNOFU8T7+3i0XkTfPJC
 OF1wWOicPCbCz1MNN7zW9myuRcnIYNLDVsZlMUO31asqeaHckohYHaZIDObslNkdsKvis0btlSA
 5tAyqy+mqxiR+1Zq7YPkhcmUhfRo+6CZNgW+nWg403aokj5zSV0pbKGI6gNg7aQ8p+fWKfYnCl4
 gdFEnUIJPfqIIvBZZTdsKaJJ9VJw/x/4lObH6u/u1ArdyCSEaxwME0eTG2teu0OErtg4Ia4BlSt
 uxd9Ku5AqsutaN8pKSQ==
X-Proofpoint-GUID: XdEtSc4rshbH5GSEUTF4GqwY55HMGiUX
X-Proofpoint-ORIG-GUID: XdEtSc4rshbH5GSEUTF4GqwY55HMGiUX
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac65b45 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=C1r-qKCkr2Mr0rMjA-sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070058

On Wed, 2026-10-07 at 11:19 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] s390/pci: infinite loop in zpci_refresh_trans on CC=3D2
> --
>=20
> commit 1c8706bb963f0d551da7d8535f804ca9f9b4305a
> Author: Gerd Bayer <gbayer@linux.ibm.com>
>=20
> s390/pci: Use 32-bit fh outside of inline asm
>    =20
> zpci_refresh_trans() declared the PCI function handle as a u64 type just
> because the actual RPCIT machine instruction required that in a 64bit
> register, while the function handle is architected as a 32bit type and
> defined as such in the zpci_dev struct.
>=20
> > diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
> > index 2ba787e2304b5..053afb3e7a990 100644
> > --- a/arch/s390/pci/pci_insn.c
> > +++ b/arch/s390/pci/pci_insn.c
> > @@ -117,13 +117,14 @@ static inline u8 __rpcit(u64 fn, u64 addr, u64 ra=
nge, u8 *status)
> >  	return CC_TRANSFORM(cc);
> >  }
> > =20
> > -int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
> > +int zpci_refresh_trans(u32 fh, u64 addr, u64 range)
> >  {
> > +	u64 req =3D ZPCI_CREATE_REQ(fh, 0, 0);
> >  	bool retried =3D false;
> >  	u8 cc, status;
> > =20
> >  	do {
> > -		cc =3D __rpcit(fn, addr, range, &status);
> > +		cc =3D __rpcit(req, addr, range, &status);
> >  		if (cc =3D=3D 2) {
> >  			udelay(ZPCI_INSN_BUSY_DELAY);
>=20
> [Severity: High]
> Does this retry loop risk causing an infinite loop or CPU stall when hand=
ling
> large DMA spaces?
>=20
> When the s390x RPCIT instruction sets CC=3D2, it indicates that it cannot=
 complete
> the operation in the allotted time. It then updates the address and range
> registers to reflect the remaining uncompleted portion.

I've re-read the relevant ISA documentation a couple times now. I don't
find any mention of address and range being modified after RPCIT was
executed - regardless of condition code or status.

Maybe @Niklas or @Matt have an idea where this allegation of "CC=3D2
means partial completion and one should retry with an updated
iova/range" comes from?

> However, in __rpcit(), addr_range is passed using an input-only constrain=
t ("d"
> instead of "+d"), and the arguments are passed by value:
>=20
> arch/s390/pci/pci_insn.c:__rpcit() {
> 	union register_pair addr_range =3D {.even =3D addr, .odd =3D range};
> 	...
> 		: [addr_range] "d" (addr_range.pair)
> }
>=20
> Because the hardware's partial progress updates to addr and range are dis=
carded,
> this loop continually re-invokes __rpcit() with the unmodified original
> addr and range.
>=20
> If scanning the initial portion consistently exhausts the hardware time s=
lice
> (such as during IOMMU TLB flushes on devices with large DMA spaces in
> zpci_refresh_all()), will the operation fail to advance and loop infinite=
ly?

I see that all the PCI related instructions in this file may retry
indefinitely (with delay) on CC=3D2. However, the architecture guarantees
that at some point the instruction will end with any of the other
condition codes.

Net: I think this review finding is not valid. Feel free to convince me
otherwise.

Thanks,
Gerd
