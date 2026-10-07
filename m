Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45548C8CB;
	Wed,  7 Oct 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378632; cv=none; b=cYlTKLX8RG/23SjR979FhZhX50t+3xhAtMWwUgxd6Nm4nRK8utFu/YfqavI14lkIrXOaNvulgROyoJT8udIJsCJUkY2l8gsd7YOBCu1F1JOy5uTZevSLhbEuULFw4WulBIyUK82T0Ydtt4wvw2FzgxtnuGhGQpphhPuHzfkTUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378632; c=relaxed/simple;
	bh=FqMBlkqkvscznVm6S0tvLMgj04NHKFVjaV79NLpWMR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpuM1WTFXeNfE5jtqsDYoDi4yBBbp9WZRr21cLMqF7SbzbDQNLW1g8kn0DEfB7cQZtKkrq1wzT+IekfcJaUsfte0NOJx6fvfezG+tKgwK98ciWCf8pa/pOBAopRAG4ZkSlyIp4g7NpQC44AUec7Jq0ceaPBmMFGrqjqZaQ9zjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BJsttQPp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BJsttQPp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BaSE42376944;
	Wed, 7 Oct 2026 13:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yKicT9
	dBJszrsXzKWTROq39yt+zMzEwDfOORIBxsY08=; b=BJsttQPpxWGXf7OnqpQI4R
	cFxK38pmaPaVLB87PDh1TuZGqzsnJNnKuYQ211jzbDxEe8E7ecY+/z3gfDdj2EAL
	yU4LX4JUdGEQLCWNOy2jIz0SLuGN+R3km4741l/UkVzo8eRD+IpP7VToJJTZtYhE
	Ya4M+UgtOUevFPRNxH9q089OMDbNVfnOJsGn8N8st5BY8pNznostLdmg5a4wBKAR
	Y3EZ196SqDwrJO6MKPOs5I57Nvud0xl6ZKjXJGJk0Y0I2rdnnY0vGP6+jjsfii2D
	SIUn0pi86oNWXbDfmnJhpeYADN3nkVscaM6nR1nFfJ/dVhiNGrKojilay5liB/Lg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5nh19-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:10:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWdEn1789937;
	Wed, 7 Oct 2026 13:10:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5jx6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:10:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697DAFkA29688422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 13:10:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D93A220040;
	Wed,  7 Oct 2026 13:10:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A182E2004E;
	Wed,  7 Oct 2026 13:10:15 +0000 (GMT)
Received: from [9.224.92.241] (unknown [9.224.92.241])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 13:10:15 +0000 (GMT)
Message-ID: <9d1fe490bc472cf9f77407afbbd7dae2c4cd7e6a.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] s390/pci: Adjust alignment in insn trace
From: Gerd Bayer <gbayer@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerd
 Bayer <gbayer@linux.ibm.com>
Date: Wed, 07 Oct 2026 15:10:15 +0200
In-Reply-To: <sashiko-outbox-162918@kernel.org>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
	 <20261007-rpcit_trcfh_upstream-v1-1-8a2718cfb90b@linux.ibm.com>
	 <sashiko-outbox-162918@kernel.org>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1MiBTYWx0ZWRfXzs9zvUGkp6MB
 sKGrCr8H1hsd57rnB863XCvfDV4cl1+V2Igl/JfT6vYYxPgxbY5XfEUqQqX9KorUXfamvOkmYxh
 Evry9tbhV9/2fRVjz8UR8giRHyO2ga4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1MiBTYWx0ZWRfX8do5v2Coy2Wu
 Zq/MlzkSINe6xF45sz1nvGQSX7NYqCy39A3pEDxayCtTB4sxJZq7DhVnSCvsL4EOIT2/kgsbnhr
 y02f7Z2YdVBA+ijUzP65HP8XA0eYrFCZZIYEf8lyAowvhVrOZLtW8JREaMK5BdzASH2NEI6kz+5
 jQ/1aWR18FbNf8q/+omPe4yoRNyNA05/VaEae2oh0TyZLwdVf86UaRm47jqHpc9igG5tJpfJjhZ
 yyeQhUuVovHSFY9Hv+RLPQddhjo1jA9qAKRzKhyufKWx4PDXPVKSsv5kWsSsGim003sONTSlVfe
 YA3XOSuumgBVqj6NBViCGEa1o9vAfPe2HG+7Ro2sLhVNa8CTXH0Tko5YCVHDYHhgRXyw46CHIO2
 m26RDYDZ+lqz046SiruwBZU5fF5gAW0LiWyBZdyAkBBQnuWhLCubGOSTUHyoPy4wwh6UGxUsXVG
 rw1iw6IczNeuaEbg1WQ==
X-Proofpoint-GUID: h5mqAY9fS4ZVArJifoZMFpz5szzvV8Nz
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac644bd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=uPZiAMpXAAAA:8
 a=Cc3N9xrbAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=j3wDQA8pIdAv3-B9_HoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: h5mqAY9fS4ZVArJifoZMFpz5szzvV8Nz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070052

On Wed, 2026-10-07 at 11:14 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] s390/pci: info leak of kernel stack memory in trace buffer due=
 to unnamed bit-fields
> --
>=20
> commit 9eddce7825c1b38a4a78855744726217e301528b
> Author: Gerd Bayer <gbayer@linux.ibm.com>
>=20
> s390/pci: Adjust alignment in insn trace
>=20
> This patch adjusts the alignment of fields in the pci_error instruction
> trace. It drops the packed attribute on struct zpci_err_insn_data and
> adds unnamed bit-fields to explicitly pad the structure to 32 bytes for
> easier human readability in hex dumps.
>=20
> > diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
> > index 35ceb1bea1c61..2ba787e2304b5 100644
> > --- a/arch/s390/pci/pci_insn.c
> > +++ b/arch/s390/pci/pci_insn.c
> > @@ -18,11 +18,14 @@
> >  #include <asm/asm.h>
> > =20
> >  #define ZPCI_INSN_BUSY_DELAY	1	/* 1 microsecond */
> > +#define ZPCI_ERR_INSN_DATA_SIZE 32
> > =20
> >  struct zpci_err_insn_data {
> >  	u8 insn;
> >  	u8 cc;
> >  	u8 status;
> > +	u8: 8;
> > +	u32: 32;
> >  	union {
> >  		struct {
> >  			u64 req;
> > @@ -33,7 +36,10 @@ struct zpci_err_insn_data {
> >  			u64 len;
> >  		};
> >  	};
> > -} __packed;
> > +	u64: 64;
> > +};
> > +
>=20
> [Severity: Medium]
> Does this change unintentionally leak kernel stack memory into the s390db=
f
> debug trace ring buffer?
>=20
> By using unnamed bit-fields for padding, these fields are explicitly
> excluded from zero-initialization when using a designated initializer.
>=20
> When zpci_err_insn_req() in arch/s390/pci/pci_insn.c initializes this
> structure on the stack without an explicit memset(), the unnamed padding
> bytes retain their uninitialized stack memory:
>=20
> static inline void zpci_err_insn_req(...)
> {
>         struct zpci_err_insn_data data =3D {
>                 .insn =3D insn, .cc =3D cc, .status =3D status,
>                 .req =3D req, .offset =3D offset};
>=20
>         zpci_err_hex_level(lvl, &data, sizeof(data));
> }
>=20
> The subsequent call to zpci_err_hex_level() will copy the entire 32-byte
> structure to the trace buffer, exposing 13 bytes of uninitialized stack
> data.
>=20
> Will this also defeat the goal of having clean traces for humans, since
> the hex dumps will contain random stack data instead of zeroes?


Alright, according to some research [1][2] unnamed bit-fields are not
guaranteed to be zero-initialized. I'll provide dummy-names for the
padding fields in the next iteration.

>=20
> > +static_assert(sizeof(struct zpci_err_insn_data) <=3D ZPCI_ERR_INSN_DAT=
A_SIZE);
> > =20
> >  static inline void zpci_err_insn_req(int lvl, u8 insn, u8 cc, u8 statu=
s,
> >  				     u64 req, u64 offset)

[1] - https://stackoverflow.com/questions/56216243/how-do-bit-fields-interp=
lay-with-bits-padding-in-c
[2] - https://news.ycombinator.com/item?id=3D43792948
