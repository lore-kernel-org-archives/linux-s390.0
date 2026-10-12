Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF64A49A3;
	Mon, 12 Oct 2026 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821482; cv=none; b=oDpze+pcNOFzr01g+hqR2zIU6iXCXlbCoeYMIpOesq2nQeLMSZqYa2EVtUouxyzDS32fEMWvURj2xXNwsG0FZxqrqr7eRqBdgXLz2c1fqMTnBzGaPUKM/JZ44r4BtfhPpy7ZS/7w+lwPPqn6/euhf1Wse75htWDKmeyzqli4Faw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821482; c=relaxed/simple;
	bh=rOEAXF3BQzK906VvVGNARu+kIxU5Lq+9e563AwOngnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/hES+dQSs5PE46onjXhwBsOHurJc0RFCr0FSSRAHofE66edTT7hhYBRnjq2KAlR63C/73ljClW4N6rRg+mrx7hq72DpLxHARE3ljLkn5CpIUO5+jcxy9uU5kjBEUnz6+qL3q3AMo4wA4wMWhDSA6VOVmE0+ARKnS9oEC7j/LIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=co4p3bmr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="co4p3bmr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFidkm3645459;
	Mon, 12 Oct 2026 16:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=31eHh1
	bv4GcUP4pOr40VRPORlIPH9Zlxl9dmfA5dLgE=; b=co4p3bmrobKsu68OYXZyiw
	6yHU2yzDOYceiKmcKYr1aC0wDVcAk8DSEPDi93CKa6A6f4i+dG3qM9PD+GTB9Jqf
	bOXpUjHG8wAnJV8ddxlDMiU9VdDwvDd0WBhBjyTFRpTb9kSbKvLnegU+ttlbEpbY
	q5y03DGvLoC+ZkwRWeph/hajR540YSSEF4ahBKmrcw8OpiwCMa8Orl2oLcrhPoOK
	85Wp25ZADpT9EYqj4d/ttBlwII2ZcMkBhc38lTyfPI49L+2PDQQoP9kNp2gqpOHS
	zEZ7xPRPPoz7u0P+x0O0qlzrZi/aN678YU8uxr581y2pq/FlrsHvOqI9fRpr8R2g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv09f93-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 16:11:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFo0bl1594698;
	Mon, 12 Oct 2026 16:11:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwuwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 16:10:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CGAtGv44106208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:10:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D905020040;
	Mon, 12 Oct 2026 16:10:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BF402004B;
	Mon, 12 Oct 2026 16:10:55 +0000 (GMT)
Received: from [9.224.92.241] (unknown [9.224.92.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 16:10:55 +0000 (GMT)
Message-ID: <126474a4cf510aacd256dca642eb013f7e10dda1.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] s390/pci: Updates to PCI insn tracing
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Benjamin Block	
 <bblock@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Matthew
 Rosato	 <mjrosato@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev	 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>,
        Farhan Ali	
 <alifm@linux.ibm.com>, Cam Miller <cam@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 12 Oct 2026 18:10:55 +0200
In-Reply-To: <20261012160049.19350J7a-hca@linux.ibm.com>
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
	 <20261012160049.19350J7a-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfXw1zEiqwu96KY
 xgfrizNKR+jfzXBHlp3I+sm+fhYg62Xqc0txEfBmwMn78RH1G6i7mgctNZPA/a3saUVVAg/0VGY
 W0yjiIgOEgY0z6sfH2jutBsndPNaY+vodNM5Bsw63+y1bn/V317ESyPXUmnWgNdYHi0ym0MFZVE
 SAPrPRV3xICMs8DT/8QI1jwFcDXSrThslkz4AGx0fkz+mEORqhTyvgtJK/UBX9oDm4YExV0Zx+K
 qJLrkuPd3XWtR4rmg4Q2yaHVxMmTSV8HTFfu+ch9zrTYBk3IV3zHqB+vK47Oxd92jnSBT42qiaE
 bBBvUxidgpf9TtStE4bXhIvvtpBQqckdDM4PHSyVOgpbeLjaZo/fODZnuB2qsEU2i0LYnejDQDg
 OrDaHn55vTWUfzB/OBF3T9oSSADRwmECK/QJ9m6sroJ0oLzv2+2yssXgF/V4d9b+thUorBZXCHI
 BPsLrtc0TZvzY8ozeWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX25ylB/nGXg3v
 z3SmDruxbEo81SRi61hQ9QewIPjBX80yxWaTah4jjghUI1DjE2w1Ww/HMZwwHaUYZZEK9PCGxyL
 HyFfvip3kPaEMYzYKiaoZ4BU/W6IJjY=
X-Proofpoint-ORIG-GUID: DqazMTh9qk3ls8E9N84OmfuN0xEscDFi
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acd0694 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ElJ84iuNPfpE-5LpT_4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DqazMTh9qk3ls8E9N84OmfuN0xEscDFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120062

On Mon, 2026-10-12 at 18:00 +0200, Heiko Carstens wrote:
> On Mon, Oct 12, 2026 at 04:21:48PM +0200, Gerd Bayer wrote:
> > With this series applied (+ a test patch to trace RPCIT even in CC0
> > situations) an entry in /sys/kernel/debug/s390dbf/pci_error/hex_ascii
> > looks like the following (removed time-stamp and ASCII transcription,
> > replaced instruction address with "<IA>"):
>=20
> ...
>=20
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> > Changes in v2:
> > - 1/3 and 3/3: Replace unnamed bitfields with named dummy members for
> >   padding (address Sashiko findings)
> > - Link to v1: https://lore.kernel.org/r/20261007-rpcit_trcfh_upstream-v=
1-0-8a2718cfb90b@linux.ibm.com
> >=20
> > ---
> > Gerd Bayer (3):
> >       s390/pci: Adjust alignment in insn trace
> >       s390/pci: Use 32-bit fh outside of inline asm
> >       s390/pci: Add function handle to RPCIT insn trace
> >=20
> >  arch/s390/include/asm/pci_insn.h |  2 +-
> >  arch/s390/pci/pci_insn.c         | 42 ++++++++++++++++++++++++++++++++=
+-------
> >  drivers/iommu/s390-iommu.c       |  8 +++-----
> >  3 files changed, 39 insertions(+), 13 deletions(-)
>=20
> Even though this touches drivers/iommu/s390-iommu.c I assume this
> should go upstream via s390. Is this correct?

Hi Heiko,

that was my assumption, yes. I hope the iommu-maintainers agree, since
patch 2 touches s390 internals, exclusively.

Thanks,
Gerd
