Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D33B47D2;
	Tue,  6 Oct 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300000; cv=none; b=iOAARVXNv2BEsalYEx8Vld4w/yjbOuG6h2ekfp0ZZjf7QqcDt4P82gzEjXNtbcQgw8vEjITV1i69vhfeCQjkTAX0lbo8gti3QRTSSYn6rbTxZvR5b8GtCXXzCSJwDj5px+QkJiTWGZ0+9/cGJO4ZArDPv+FLCN6gU9Y7/UE72j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300000; c=relaxed/simple;
	bh=MVMr/5rFJ/DS7YdQdSF7tuz7J4tny4yE1nDMsH+1UAY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=MmEl+y7rVVhGvW99nLZ/jcqL4j5do/zi3ib/xuU8qsyXaav/HDpwOejQXZHM6oGXqtyBATHStWKVA5jB7ZNNHwC2lf31gy1qEpKIyxUcmwICqlP/dqjMZJ/czKg+0RI0Ht5DCZQQoCsqusNDU4M3IT0jrjOv56nfdVTp6E4MCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZK7MGuoY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZK7MGuoY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZg2e3994513;
	Tue, 6 Oct 2026 15:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6hgGFV
	BVphiJBdcSNPfQHR95xQxtzZ8IEzCx7rDcpNY=; b=ZK7MGuoYFiUPpmlhEjzU45
	GAleqSPYFZ5B4Drjf3V/KzFHXZuURpXrqQh8bT4NxZSlSTcLpWaZ/DyLjsxJarWn
	s+toAsqbX3RBD/Xdhlj8ABJHUr+/QKR+4M34d9goBJ6sWtERwYQ6ZEn8jjA/3coI
	9d3SUuBgqCQTMqIBVwLpYoctJMa2nkvT2e9TwegQi8oF6dVV2uYf9mrQ2NaAqFy+
	V9zbILxvrlNGfQsqWr3LVigc6a1+UkTDbIGI4KMCJgqy2lVoFLorQSVAiEy1Quij
	sFFVFn8qlATSEHCOi+9fhIabSLYnoKPg/no4DMB+/uEDz2DYj72EtJpzDHLLRpZQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv7rmv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:19:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHTId424953;
	Tue, 6 Oct 2026 15:19:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqya88k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:19:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696FJsMj13894374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 15:19:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB8E58076;
	Tue,  6 Oct 2026 15:19:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67CA858070;
	Tue,  6 Oct 2026 15:19:52 +0000 (GMT)
Received: from [9.87.140.229] (unknown [9.87.140.229])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 15:19:52 +0000 (GMT)
Message-ID: <9551e60c73649927fb80e20230883551fa03c5a2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] s390/pci: Fix use-after-free race in zpci
 floating interrupt cleanup
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>, Gerd Bayer
 <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Farhan Ali
 <alifm@linux.ibm.com>,
        Christian Borntraeger	 <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato	 <mjrosato@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-4-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
	 <20261005-s390_irq_domain_fixes-v2-4-d45b824874c0@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 17:18:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: in23hVUECOvoAqUTruKdTd4Q_gNC2Jbi
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac5119d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cyxBq0GAK1Es2yPSh4wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: in23hVUECOvoAqUTruKdTd4Q_gNC2Jbi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MCBTYWx0ZWRfXzD/zs0LMbEzj
 3rednjs/ijqPWVIc6X9tN6tiAV09NnSkZBdOEXTQZNGstgswjLJKT6fc23kHpgZyKl26gFPvm50
 CXPRly9PFSRv+yFMgdGvphlCQJ3RzGO0euRlA/OUCXvyYjRmV5GFTpfbwMbPMq7bAgY96HZ+QH0
 koCoCoVEG85DFtSqb1hU9tdpA9Pjsi1XBJh//1BJXN6SNPhVZqVOdnGI8VtwiH+D3f/n+Omn3CH
 2cgcu4B4JmXqS4kidAPiMFVPCkNlM38Ytft14wLRlvPotCGTMkpvqBXnFkGFbfTTHo/9IlwO8LE
 XyUefxTaDiiuZox7bqMUOcE2ulwacDofUjzijo91/VTVsfWRnERTvO8O7zox0eIm5hDEkoXuRWw
 R18P5EkQ27MmBMzlVZLiWRjyVRVOuxgGeSANXDu1iB/pawaBY9wcx+pDH3E/M/htrxRJRJC+BKR
 lWToWLjw6HCTpxT1c+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MCBTYWx0ZWRfXwNnXyqpcTxnY
 1qE0L2bJWvC1pkmYchwJ56HBZMCQfhJMsHFdQlpFmCIzBhsk67uwD9ICpKxeK7A7uM8GWKdIAWL
 pXtt98wpOLzEBHgu2ckhchEefyPJFFM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060060

On Mon, 2026-10-05 at 14:03 +0200, Tobias Schumacher wrote:
> zpci_clear_irq() stops the adapter from raising new interrupts for the
> function, but a zpci_floating_irq_handler() already running on another CP=
U
> can still be scanning zdev->aibv when zpci_msi_teardown_floating() releas=
es
> it.
>=20
> Clear the zpci_ibv[] entry so no further handler picks the vector up, the=
n
> wait for a grace period before releasing it. The handler runs inside the
> rcu_read_lock() section that do_airq_interrupt() holds across
> airq->handler(), so synchronize_rcu() drains any handler still in flight.
> Free the summary bit only after the grace period, so it cannot be handed =
to
> another device while a reader still holds the old pointer.
>=20
> zpci_ibv served both delivery modes, indexed by summary bit under

Nit: Maybe more precisely and matching the comment: "=E2=80=A6, indexed by
function under FLOATING and =E2=80=A6"?

> FLOATING and by cpu under DIRECTED. Only the floating vectors are
> published to and torn down under the interrupt handler, so split the
> directed vectors out into zpci_dibv and annotate zpci_ibv __rcu, which
> lets sparse check the accessors above.
>=20
> Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  arch/s390/pci/pci_irq.c | 60 +++++++++++++++++++++++++++----------------=
------
>  1 file changed, 33 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index d5763c5feb09..81a27bf756a3 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -22,12 +22,11 @@ static enum {FLOATING, DIRECTED} irq_delivery;
>   */
>  static struct airq_iv *zpci_sbv;
> =20
> -/*
> - * interrupt bit vectors
> - * FLOATING - interrupt bit vector per function
> - * DIRECTED - interrupt bit vector per cpu
> - */
> -static struct airq_iv **zpci_ibv;
> +/* FLOATING - interrupt bit vector per function */
> +static struct airq_iv __rcu **zpci_ibv;
> +
> +/* DIRECTED - interrupt bit vector per cpu */
> +static struct airq_iv **zpci_dibv;
--- snip ---
> =20
>  static void zpci_msi_teardown_floating(struct zpci_dev *zdev)
>  {
> +	rcu_assign_pointer(zpci_ibv[zdev->aisb], NULL);
> +	synchronize_rcu();
> +	airq_iv_free_bit(zpci_sbv, zdev->aisb);
> +
>  	airq_iv_release(zdev->aibv);
>  	zdev->aibv =3D NULL;
> -	airq_iv_free_bit(zpci_sbv, zdev->aisb);

Not sure why the aisb free moved to before the aibv release? The commit
message only explains why it is after the synchronize_rcu(). This way
it's also not in the opposite order of the allocation.

>  	zdev->aisb =3D -1UL;
>  	zdev->msi_first_bit =3D -1U;
>  	zdev->msi_nr_irqs =3D 0;
> @@ -428,9 +432,9 @@ static int zpci_msi_domain_alloc(struct irq_domain *d=
omain, unsigned int virq,
> =20
--- snip ---

Overall the change and the use of RCU looks good to me.

Thanks,
Niklas
