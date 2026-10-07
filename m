Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331118E025;
	Wed,  7 Oct 2026 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378747; cv=none; b=GKL3545jo5tiKDZXAQfHUnk5mFxg568XiWus178Ux8SfAYhLNvznZyRkQ9kCfnrecjz00L+O/rYfaX6POWXiWJkG3KylNLNvBGPxPwJBfbS02isBZdqDDwrnB8p2dJfiP5FQVDPXF1DLJ+AYCjx/EsOi6wChTBEM6CUYKSiY2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378747; c=relaxed/simple;
	bh=sEw2n/TwzFT94Ck9/00k7WqWd6x+LeUOLfg1Bb3VDK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eMyxCWDX8WpjWI4VebmWy5y7r8zwuMl8bZeCytzAMtYc7/tvvH01rBDJHhoFPcPgQSklqVLkCiP8siYLKaKoALuaw/myHCfEedH2LVoo/C8AHbCqoqObRhpLRDYoE+kYPljhKygvam+Ok9qDE+l3c7c/MyfQbTM7QpQKxutmO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rME/AK40; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rME/AK40"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BaNIg597767;
	Wed, 7 Oct 2026 13:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j6NPSn
	eg8Dn+Yh87Op6YcB7n5pN307q+0xjOedrUjBM=; b=rME/AK40q0jT4QVmnV2uv0
	FIkS3Zen88YgkO198RqlU+wCHLJG2W977XCS9PdEKqYkZE62bYV0qzeLc2yJbsA3
	6e+QZs6jbeBU5Ksbo2SsZi5QdCafZRZ9nAOP/Cluv52+XNfxHq5dRLuiU+Xmez/9
	IH4m7P9C/vpickQUqLjweXfo93/pvM2uMIItcniPYlqNFUN/HRUMz4tpyLyaEKOl
	32HP2+azbqCM4s5XNQ1mW3g6DSPr63hpMEv0m9STGqh2oVZloFEZD7H8+wFQ5WS9
	I4tb3j2EZ/X/vvQ2AopMO85eCeJFz5DyIWGCFEF5ej8TDv9LJMXroPEDA1jC6MmA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrnhsh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:12:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWfLk1841543;
	Wed, 7 Oct 2026 13:12:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6djjtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:12:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697DCEKE50004424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 13:12:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E72E920043;
	Wed,  7 Oct 2026 13:12:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF9DD2004B;
	Wed,  7 Oct 2026 13:12:13 +0000 (GMT)
Received: from [9.224.92.241] (unknown [9.224.92.241])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 13:12:13 +0000 (GMT)
Message-ID: <d46130a7fa9b84dce30c8cf372be469cb615c7f7.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] s390/pci: Add function handle to RPCIT insn trace
From: Gerd Bayer <gbayer@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens
	 <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Gerd Bayer
	 <gbayer@linux.ibm.com>
Date: Wed, 07 Oct 2026 15:12:13 +0200
In-Reply-To: <sashiko-outbox-162921@kernel.org>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
	 <20261007-rpcit_trcfh_upstream-v1-3-8a2718cfb90b@linux.ibm.com>
	 <sashiko-outbox-162921@kernel.org>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1MiBTYWx0ZWRfX3e7vzGXNIf8M
 9+GJCfmt+TL63ToBHNbyJcyJcyN8WmCMwH/n5WAi1dXS3uKEgb1l6vw50dZvP6c8Ebz3e2u+ILp
 AJAY4uRxvuhco+hrDsoOEvRBpbnIYag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1MiBTYWx0ZWRfX54/izfAOE9AA
 In7bWZqwqxMOekaZYt4BpMsF++3y70UxUZWSg3RQI6hg7tY5BsHxdXTtM/v0K0U0qFEkkeX2E8O
 uMm+LSgOKQVJS35H7r6iNk4J2P3TwcSTBYcYpVkYsWgCN+CrIrnH7kTFc37cGXBz/ON9NtEMC+I
 yB1iXspwztcaNQYmo9Z3FCVsnWQtLyHTeMY/67YBZYHbepV0Hn2/PQKcMNKkP8xX3Qtiftw0RDw
 yuNh6Z9LpRFHAvBB1yCfnojsP83staGVkqJiMKcGx1YS0FsXZSlNgjiwxAKT2cXQx4/p6hguU87
 q1Fg3YT7YTGY/B4KgQfm43TWPM8RAnled48b6XZdA5gRxiRN4oAmQ2Zr0BqpdrVyldiQJMl9fiH
 zH42tphHBlV8QsKnPkNb/cHMIF1LB6vyo2ci0pzTqNMY0ZsSLa9bA7ghLnnxd7eQvrGUFuiiDnd
 65rYuxLBkkNG3bZPmDw==
X-Proofpoint-GUID: mvqaW27xrX4pBT3kB4kVvc8Hvkss7Wi_
X-Proofpoint-ORIG-GUID: mvqaW27xrX4pBT3kB4kVvc8Hvkss7Wi_
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac64532 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iAi7jWXkQSgZ8sHU6mwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070052

On Wed, 2026-10-07 at 11:17 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] s390/pci: info leak of uninitialized struct padding in zpci_er=
r_insn_rpcit
> --
>=20
> commit 9deafec98847a2a1de20826fbaa6431e1e3c973f
> Author: Gerd Bayer <gbayer@linux.ibm.com>
>=20
> s390/pci: Add function handle to RPCIT insn trace
>=20
> In certain debug situations it would be helpful, if the insn trace for a
> failing RPCIT would reveal the PCI function on which this was attempted.
>=20
> Introduce a variant of zpci_err_insn_req() called zpci_err_insn_rpcit()
> that accepts an IO virtual address and a range parameter together with
> the req conveying the function handle. Switch zpci_refresh_trans() to
> use that new error trace.
>=20
> > diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
> > index 053afb3e7a990..ae9ed4aa2ec9c 100644
> > --- a/arch/s390/pci/pci_insn.c
> > +++ b/arch/s390/pci/pci_insn.c
>=20
> [ ... ]
>=20
> > @@ -29,18 +29,40 @@ struct zpci_err_insn_data {
> >  	union {
> >  		struct {
> >  			u64 req;
> > -			u64 offset;
> > +			union {
> > +				/* PCILG/PCISTG/MPCIFC */
> > +				struct {
> > +					u64 offset;
> > +					u64: 64;
> > +				};
> > +				/* RPCIT */
> > +				struct {
> > +					u64 iova;
> > +					u64 range;
> > +				};
> > +			};
> >  		};
> > +		/* PCILGI/PCISTGI */
> >  		struct {
> >  			u64 addr;
> >  			u64 len;
> > +			u64: 64;
> >  		};
> >  	};
> > -	u64: 64;
> >  };
> > =20
> >  static_assert(sizeof(struct zpci_err_insn_data) <=3D ZPCI_ERR_INSN_DAT=
A_SIZE);
> > =20
> > +static inline void zpci_err_insn_rpcit(int lvl, u8 insn, u8 cc, u8 sta=
tus,
> > +				       u64 req, u64 iova, u64 range)
> > +{
> > +	struct zpci_err_insn_data data =3D {
> > +		.insn =3D insn, .cc =3D cc, .status =3D status,
> > +		.req =3D req, .iova =3D iova, .range =3D range};
> > +
> > +	zpci_err_hex_level(lvl, &data, sizeof(data));
> > +}
>=20
> [Severity: Medium]
> Does this code leak uninitialized stack memory to the s390dbf debug trace
> buffer?
>=20
> According to the C standard, unnamed bit-fields do not participate in
> designated initialization. The struct zpci_err_insn_data starts with:
>=20
> struct zpci_err_insn_data {
> 	u8 insn;
> 	u8 cc;
> 	u8 status;
> 	u8: 8;
> 	u32: 32;
>     ...
>=20
> Because the unnamed bit-fields are skipped by the designated initializer =
here,
> up to 5 bytes of uninitialized kernel stack memory are left in the paddin=
g
> of "data".
>=20
> Since sizeof(data) (which is 32 bytes) is then passed to zpci_err_hex_lev=
el(),
> could these indeterminate stack bytes be copied into the trace buffer on =
every
> invocation of zpci_err_insn_rpcit()?

This is basically the same concern as with patch 1/3 - I'll replace the
unnamed bit-fields with dummy members of appropriate size in a v2.
