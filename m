Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FAF29D26C;
	Thu,  4 Dec 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842375; cv=none; b=VS8P9TR7cLHHbqj0U1dagAPamioVOaxtSWMa8+uQP4tJiQnEXY2+bdbDLt44dstoCaSwnSd+CDONw2PPAyV+1EZDp0N6v2yVe8eh8htcAsGxEl0qYam49UxUeJpMCphIwioLR3L6ajlIsDg36ISJHdKM4+oLn4oDCOqZ2rkSmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842375; c=relaxed/simple;
	bh=6m0gtTGntGnIUhZZ53YSHutZ4rGrIg0hWRpUx12dUyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nnaw89BYVt8ZSYZ7gE9AjCYozsmrQKBnydax4Oei7v62bxw6xTH4u9yK0Ym6wIuWkT7/g9mgGI2WN3HZOkXBm2uFdXfK4pwdqXBevT3IZLSYMT7Ii9YgdeZo2S0xdghq/60Q4FB1RKG9HwmVjXiXDJt5LzGHeGgDkpPbbkDEZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HvHwxzEo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HvHwxzEo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B479TLX017878;
	Thu, 4 Dec 2025 09:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DBPC3G
	itR7ALjd27A99Uiiyl0qBaTTGALrNx40gJrmA=; b=HvHwxzEoqZggA3f/Sn6W0O
	9T5OL/ltaxpFkVr5thImsMp3oMqHFKbSEAQ5OH/l6Ioef+QFMcIQtEUAqwz3Z3Hg
	CRn0NGdQcIChf8mQ8aXa35GCEr2z3QBo6pvuDy3WpDaWCKl8awxeT+Tc/u8+4GTF
	iEjTLCH7e/M2kQuzHWhlOPO5HJT62pygV8KsAiE2Ym9cwZ6VQzst05+8inH20oKf
	1fHTwYvTX7tP+YJSi4N+zWGFQ8LSH4v3GZATrCr8S1FGNYunLVEO15LdfP/EWvzO
	JiOKsWQs97RYdZGmoclGKgakSV6yM91ONGU3ZgE20eVIHliWdQohxZ4vePyehSpg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q7910-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 09:59:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B48u2iC029328;
	Thu, 4 Dec 2025 09:59:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1pt9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 09:59:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B49xP9449545532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 09:59:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC60A20049;
	Thu,  4 Dec 2025 09:59:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D19420040;
	Thu,  4 Dec 2025 09:59:25 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 09:59:25 +0000 (GMT)
Message-ID: <5e1e50a004a7faf758872380db66876371b32631.camel@linux.ibm.com>
Subject: Re: [PATCH v9 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas
 Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Halil Pasic	 <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner	
 <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Farhan Ali
	 <alifm@linux.ibm.com>
Date: Thu, 04 Dec 2025 10:59:25 +0100
In-Reply-To: <20251204-implement-msi-domain-v9-2-d2152235701b@linux.ibm.com>
References: <20251204-implement-msi-domain-v9-0-d2152235701b@linux.ibm.com>
	 <20251204-implement-msi-domain-v9-2-d2152235701b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX2Vx/Wwtyw+pN
 48FAEnWXo6pnfhr66nknwZ/lgBB/qPVibcK7i2QYrWAZD6zUCCu+spWqtCJKrRePvVR/fa19/ZV
 Ml4CP+5X5qmm3CHaK30BrXRRWiWxmf9n0NudzGTtqXVpitPlesjstdXX9AN/4IRx6auz61/ZN+Z
 I2oyZXMNI+MI9mUzX7f+8vqUAJ0qmpOhaXFf4vunoRZuLRV9yb9fzs7CJDK6jm0ZZCuATfCHSfE
 kjyzv+MDbTIDM29DVtlnAKkgDGxJZGv/U3qXJYkl092teSzP085Q2X+pqnJzz/MZodPbHu1cZ2L
 z3e6tGmNKjYM6NZMpB/5C50JtAIHu/nhToFamjZ0vGXEpR9sveLwtEuAg7u3M62UUfHHdwutVp+
 QDWkV+YAoHmjYRNOJfJr7xRZvZJWWw==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=69315b82 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=aWfhc1sf7vF5DyUi4kUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DBlA_4IvlRQIUGN2mBFnTsOKQf54Xqxv
X-Proofpoint-GUID: DBlA_4IvlRQIUGN2mBFnTsOKQf54Xqxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

On Thu, 2025-12-04 at 06:05 +0100, Tobias Schumacher wrote:
> s390 is one of the last architectures using the legacy API for setup and
> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
> to the MSI parent domain API. For details, see:
>=20
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>=20

  [ ... snip ... ]
>=20
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  arch/s390/Kconfig           |   1 +
>  arch/s390/include/asm/pci.h |   5 +
>  arch/s390/pci/pci.c         |   6 +
>  arch/s390/pci/pci_bus.c     |  18 ++-
>  arch/s390/pci/pci_irq.c     | 332 +++++++++++++++++++++++++++++---------=
------
>  5 files changed, 247 insertions(+), 115 deletions(-)
>=20

  [ ... snip ... ]

> +static void zpci_msi_clear_airq(struct irq_data *d, int i)
>  {
> -	struct zpci_dev *zdev =3D to_zpci(pdev);
> -	struct msi_desc *msi;
> -	unsigned int i;
> -	int rc;
> +	struct msi_desc *desc =3D irq_data_get_msi_desc(d);
> +	struct zpci_dev *zdev =3D to_zpci_dev(desc->dev);
> +	unsigned long bit;
> +	unsigned int cpu;
> +	u16 msi_index;
> =20
> -	/* Disable interrupts */
> -	rc =3D zpci_clear_irq(zdev);
> -	if (rc)
> -		return;
> +	msi_index =3D zpci_decode_hwirq_msi_index(d->hwirq);
> +	bit =3D zdev->msi_first_bit + msi_index;
> =20
> -	/* Release MSI interrupts */
> -	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
> -		for (i =3D 0; i < msi->nvec_used; i++) {
> -			irq_set_msi_desc(msi->irq + i, NULL);
> -			irq_free_desc(msi->irq + i);
> +	if (irq_delivery =3D=3D DIRECTED) {
> +		for_each_possible_cpu(cpu) {
> +			airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
> +			airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
>  		}
> -		msi->msg.address_lo =3D 0;
> -		msi->msg.address_hi =3D 0;
> -		msi->msg.data =3D 0;
> -		msi->irq =3D 0;
> +	} else {
> +		airq_iv_set_ptr(zdev->aibv, bit + i, 0);
> +		airq_iv_set_data(zdev->aibv, bit + i, 0);
>  	}
> +}
> =20
> -	if (zdev->aisb !=3D -1UL) {
> -		zpci_ibv[zdev->aisb] =3D NULL;
> -		airq_iv_free_bit(zpci_sbv, zdev->aisb);
> -		zdev->aisb =3D -1UL;
> -	}
> -	if (zdev->aibv) {
> -		airq_iv_release(zdev->aibv);
> -		zdev->aibv =3D NULL;
> -	}
> +static void zpci_msi_domain_free(struct irq_domain *domain, unsigned int=
 virq,
> +				 unsigned int nr_irqs)
> +{
> +	struct irq_data *d;
> +	int i;
> =20
> -	if ((irq_delivery =3D=3D DIRECTED) && zdev->msi_first_bit !=3D -1U)
> -		airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
> +	for (i =3D 0; i < nr_irqs; i++) {
> +		d =3D irq_domain_get_irq_data(domain, virq + i);
> +		zpci_msi_clear_airq(d, i);
> +		irq_domain_reset_irq_data(d);
> +	}
>  }
>=20

Thanks for your great work and for addressing all my issues!

Feel free to add
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
