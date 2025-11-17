Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15532C21DE;
	Mon, 17 Nov 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400023; cv=none; b=G9Ih7aLmgXIXkp/08sO00x9K0fNOmCCwxewvSxdTanukWGF/5u9SVC0xYVYYhW5vEFiuoJPiV+XVv0tvFAOBWRSwUpQ9pAh9P6Y4kQ74YXYsrPa4Cm0iMZEV04UfoHt9KZ5g1o54Wp5hJkobid7Rf8TGhH88dg3uWHgF9HtUnxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400023; c=relaxed/simple;
	bh=j1SVhdAZCZczpXTh2ZYzWEd+ruuEkLfGiDKSg1wTes4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2s3nTLHxeKXFmAYo5J94YL/sKqYzSuH+vKGBUeXwS4DWpPE87QwGZJuLu4CbImCKNyeAgywze7zEhQQPGTvYrlxcmOIrx0iaw5ato/4q6OvXpySBgkeJw+b/ndXOPjdLSOdKzUPOCxzM2c/DnytkxiMS/k/+6yqBJ1cRknkky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dUwRpkib; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dUwRpkib"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHDChT3005943;
	Mon, 17 Nov 2025 17:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+qjaKu
	fo+RY8JT+NXOyVssJ5UOh4wYfouHalfFQmxJQ=; b=dUwRpkibqgxE28u5V8bp/Z
	hfOdP+RnLQ2Xqm9LOcf32DIQ4HhGDzW8TAjjeC4iUB6/Nh5iEdZlyAMNGfJVEHsr
	cvR0j6Do621pN0Hv4CR/90s9gn9KCOE0ePU1yigzSn6bKehOyeHkgMeUcY1VLHS0
	lbKmsQpmEQQNbeTQqcqG3Laim7IwXzKQuP6uldvZxyvmg1fJO2mfIQzkH5OIyiz9
	/XGHOQ6pUJPCr95W4gYKvV15bZTp+R5sUBGAuTxyLsO/bzPkAXbccw6FS+zAvtUT
	qAMNG3WzKRNufBiZegCdh8KUDKL1RbIWWAaBGE2adPKK7lXrJ/ekLi5ben5+6lsw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk9q9n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 17:20:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHESHZX030813;
	Mon, 17 Nov 2025 17:20:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47xq64c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 17:20:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHHK5mb19137276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 17:20:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B9DE58054;
	Mon, 17 Nov 2025 17:20:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BAB95803F;
	Mon, 17 Nov 2025 17:20:02 +0000 (GMT)
Received: from [9.111.83.102] (unknown [9.111.83.102])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 17:20:02 +0000 (GMT)
Message-ID: <713144a7a6e833366665c6132c12ba820d3db51a.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer
 <gbayer@linux.ibm.com>, Halil Pasic	 <pasic@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Thomas Gleixner	 <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date: Mon, 17 Nov 2025 18:20:01 +0100
In-Reply-To: <20251117-implement-msi-domain-v2-2-a110ea0721fe@linux.ibm.com>
References: <20251117-implement-msi-domain-v2-0-a110ea0721fe@linux.ibm.com>
	 <20251117-implement-msi-domain-v2-2-a110ea0721fe@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m5c3LHFqw4UZTS6oec9GjMcaYQTIkssK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXzaPgzdQJkuo4
 AUz+rey8+6FIl38RvjUqZ/Q26+akesndNfyT8XB+CIwuyIYoTSn2/iuffvZ0mF37wo9P/rFJCnW
 Vhh1zoPFzUaxpr9ykvhP2gcSOeqYi4l3CWsmISzXvTKcyVOFZJddmBCRB9guGPnQZPsdQPit98G
 LdHKl30y7McR/Ifd6K2V1sxvKLspVTnYdzN3tu0NYEXYs4tXfBzL1J+cBNKWCQfhIz7/b9aSCl6
 saMFkZAx8EB4PqXpU8/0UlIen/NS1u7by0J/Y1+yDD9KKzyFtHiRLPkaA2TwtonQ0wn4JZWmTgA
 gP2gUEfffPmFUvE1sMp50JfQQIr4N0ciYSkG1aRS1sdMf6Ojcd+HYmB2Q2K2EpYaDOgf+WT9k6N
 0ZRe6OEqLWRxbgbSgDe2IMmIBWDBrA==
X-Proofpoint-ORIG-GUID: m5c3LHFqw4UZTS6oec9GjMcaYQTIkssK
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=691b5947 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=oVuppWX2UIaEmmP2xxMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Mon, 2025-11-17 at 09:59 +0100, Tobias Schumacher wrote:
> s390 is one of the last architectures using the legacy API for setup and
> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
> to the MSI parent domain API. For details, see:
>=20
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>=20
> In detail, create an MSI parent domain for zpci which is used by
> all PCI devices. When a PCI device sets up MSI or MSI-X IRQs, the
> library creates a per-device IRQ domain for this device, which is
> used by the device for allocating and freeing IRQs.
>=20
> The per-device domain delegates this allocation and freeing to the
> parent-domain. In the end, the corresponding callbacks of the parent
> domain are responsible for allocating and freeing the IRQs.
>=20
> The allocation is split into two parts:
> - zpci_msi_prepare() is called once for each device and allocates the
>   required resources. On s390, each PCI function has its own airq
>   vector and a summary bit, which must be configured once per function.
>   This is done in prepare().
> - zpci_msi_alloc() can be called multiple times for allocating one or
>   more MSI/MSI-X IRQs. This creates a mapping between the virtual IRQ
>   number in the kernel and the hardware IRQ number.
>=20
> Freeing is split into two counterparts:
> - zpci_msi_free() reverts the effects of zpci_msi_alloc() and
> - zpci_msi_teardown() reverts the effects of zpci_msi_prepare(). This is
>   callend once when all IRQs are freed before a device is removed.
>=20
> Since the parent domain in the end allocates the IRQs, the hwirq
> encoding must be unambiguous for all IRQs of all devices. This is
> achieved by encoding the hwirq using the PCI function id and the MSI
> index.
>=20
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  arch/s390/Kconfig           |   1 +
>  arch/s390/include/asm/pci.h |   1 +
>  arch/s390/pci/pci_bus.c     |   1 +
>  arch/s390/pci/pci_irq.c     | 335 +++++++++++++++++++++++++++-----------=
------
>  4 files changed, 208 insertions(+), 130 deletions(-)
>=20
--- snip ---
> +
> +static int zpci_msi_prepare(struct irq_domain *domain,
> +			    struct device *dev, int nvec,
> +			    msi_alloc_info_t *info)
> +{
> +	struct zpci_dev *zdev =3D to_zpci_dev(dev);
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	unsigned long bit;
> +	int msi_vecs, rc;
> =20
>  	msi_vecs =3D min_t(unsigned int, nvec, zdev->max_msi);
> -	if (msi_vecs < nvec) {
> -		pr_info("%s requested %d irqs, allocate system limit of %d",
> +	if (msi_vecs < nvec)
> +		pr_info("%s requested %d IRQs, allocate system limit of %d",
>  			pci_name(pdev), nvec, zdev->max_msi);

This is already wrong in the existing code but the above pr_info()
misses a "\n" at the end.

> -	}
> =20
--- snip ---
> +static int zpci_msi_domain_alloc(struct irq_domain *domain, unsigned int=
 virq,
> +				 unsigned int nr_irqs, void *args)
> +{
> +	struct msi_desc *desc =3D ((msi_alloc_info_t *)args)->desc;
> +	struct zpci_dev *zdev =3D to_zpci_dev(desc->dev);
> +	irq_hw_number_t hwirq;
> +	unsigned long bit;
> +	unsigned int cpu;
> +	int i;
> +
> +	bit =3D zdev->msi_first_bit + desc->msi_index;
> +	hwirq =3D zpci_encode_hwirq(zdev->fid, desc->msi_index);
> +
> +	if (desc->msi_index + nr_irqs > zdev->max_msi)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < nr_irqs; i++) {
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &zpci_irq_chip, zdev,
> +				    handle_percpu_irq, NULL, NULL);
> +
> +		if (irq_delivery =3D=3D DIRECTED) {
> +			for_each_possible_cpu(cpu) {
> +				airq_iv_set_ptr(zpci_ibv[cpu],
> +						bit + i, hwirq + i);
> +				}
> +

The above closing brace seems to be indented wrong. I have no idea why
checkpatch.pl --strict doesn't catch this (I tried). It also doesn't
complain when I remove one tab so let's do that. While at it also drop
the empty line here.

> +		} else {
> +			airq_iv_set_ptr(zdev->aibv, bit + i, hwirq + i);
>  		}
> -		msi->msg.address_lo =3D 0;
> -		msi->msg.address_hi =3D 0;
> -		msi->msg.data =3D 0;
> -		msi->irq =3D 0;
>  	}
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
> +	return 0;
> +}
--- snip ---

Apart from the two style issues this now works well with directed IRQs
and overall is a nice cleanup. Thanks a lot!

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
