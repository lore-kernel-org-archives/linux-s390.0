Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632972C327A;
	Tue,  2 Dec 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699296; cv=none; b=VTsSgV/qNdkusH+fvErzVn4A6cJQ8a5g4O4m+4+6A8e6/U3OtCVhuXcAAgl+qH1BW9Ng1Pp0RDCgmNrTd4M7mmCu6zcRJtyGl/MP5Rqjq6Ikd3rhAh/w5mhuckWcmWk4c7m3XS+yxizQcIRu3X6gHEe6u5LIIN4k7uxZFplLf3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699296; c=relaxed/simple;
	bh=iKwBFR6dX4+uHjsv/uJ2h1d6PrMbnGcB8kM7dPjIWDQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VyXr5g9CeAM/PiqjHIKLS/S6EDP015aT4AmieUoodIE/rgRsIFEzuvXnIcDF99cgi0uN59aEsZMohxKylre6RDnxQG4OrxZ16art4LtjYJCGMHlvp+bky6VABEmoZ9Sg+gKoRxreYoJW1/PXzYohlnQlxHUcoUUNgcoWywDmTGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YdybvIJu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YdybvIJu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2CS79P009101;
	Tue, 2 Dec 2025 18:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RAhLSt
	fsE6TWDkvzGxH4u8xei1dO++AmMZUYPviAPvg=; b=YdybvIJus+qqtyu+RAO5fb
	hXYomj7tce+1sZbHJQDZGSsUE532AZPgwkWdwEtOVhfXrBqgIIBrE8mPPsPf1EY4
	kQNyFlKpgimLnNdFfoixt4lrCQpzpw+mevaGDEWa4gyfhiIE/wrd3d+ctuy1JYS8
	lQDtNd1GqjQhsOKj7TrPpaVsd3SmMKRSx68tGiToveiV/p2cfma0pRXm/vAqdZ9h
	CykkXtyYuucCb1WkdM5wX5fY9pmoYLtSylJJ6QFKAeBftjOXJJ1X00Z6T2vh8bof
	P+ot4dfrkcNPgsQ28m0nNMzQWoNlVAW21jy1i5SF7V+MgCls6O/yso+pIwoBufsg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8pxjxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 18:14:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2I1rLh029392;
	Tue, 2 Dec 2025 18:14:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1dpe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 18:14:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2IEkV545351186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 18:14:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 779B72004B;
	Tue,  2 Dec 2025 18:14:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEF1320040;
	Tue,  2 Dec 2025 18:14:45 +0000 (GMT)
Received: from [9.111.70.46] (unknown [9.111.70.46])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 18:14:45 +0000 (GMT)
Message-ID: <33d2feb221c2ca89a4d09876a00c40ed0a893118.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
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
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date: Tue, 02 Dec 2025 19:14:45 +0100
In-Reply-To: <20251127-implement-msi-domain-v7-2-86c9a4837e8c@linux.ibm.com>
References: <20251127-implement-msi-domain-v7-0-86c9a4837e8c@linux.ibm.com>
	 <20251127-implement-msi-domain-v7-2-86c9a4837e8c@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX0z39cZRiEKj3
 1mPNUM8deNrycdEVjFjjmcLxltuItiq6MvopKWly61I+5RMSALUt3r//5dFByWdUwBChzNj7KVa
 sw5sCKqy7axklAmj77jMMmaD9zbpZcE16BUvSSiQhTAAMxgWMflYOWj4E5XICx3erPyHeHB98T3
 aEiwQForEOdd50vy7VTA8kdSD/sh9FzZhWW2L4l4fzurjAa7TGOKHmOoRBFg178TmfOwuSKtLzp
 P6THByiS8zPzH3Jy0BPVxAqix7DuD71o6f2plOThsWhWdfeJhqZ/olfLKc1vsJZukxgezNw4fpa
 bXMQsk0OrbJGafuz3OuTrDClOIaY0x7qHOIoyGy2xv2YcV96oaad2HZeqTgWjCc+l4E+OrQ/Xpm
 IkzM41V74CY4zduhquJZuKgMtbvwyA==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692f2c9b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=erOAOvTrSR6KKPRzvjcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lFqppT5uqX7yGw9qhfIWJF6FIf1ULJdE
X-Proofpoint-GUID: lFqppT5uqX7yGw9qhfIWJF6FIf1ULJdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

On Thu, 2025-11-27 at 16:07 +0100, Tobias Schumacher wrote:
> s390 is one of the last architectures using the legacy API for setup and
> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
> to the MSI parent domain API. For details, see:
>=20
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>=20
> In detail, create an MSI parent domain for each PCI domain. When a PCI
> device sets up MSI or MSI-X IRQs, the library creates a per-device IRQ
> domain for this device, which is used by the device for allocating and
> freeing IRQs.
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
>   called once when all IRQs are freed before a device is removed.
>=20
> Since the parent domain in the end allocates the IRQs, the hwirq
> encoding must be unambiguous for all IRQs of all devices. This is
> achieved by encoding the hwirq using the devfn and the MSI index.
>=20
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  arch/s390/Kconfig           |   1 +
>  arch/s390/include/asm/pci.h |   5 +
>  arch/s390/pci/pci.c         |   6 +
>  arch/s390/pci/pci_bus.c     |  18 ++-
>  arch/s390/pci/pci_irq.c     | 310 ++++++++++++++++++++++++++++----------=
------
>  5 files changed, 224 insertions(+), 116 deletions(-)
>=20

  [ ... snip ... ]

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index e73be96ce5fe6473fc193d65b8f0ff635d6a98ba..2ac0fab605a83a2f06be6a0a6=
8718e528125ced6 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -290,146 +325,196 @@ static int __alloc_airq(struct zpci_dev *zdev, in=
t msi_vecs,
>  	return 0;
>  }
> =20
> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +bool arch_restore_msi_irqs(struct pci_dev *pdev)
>  {
> -	unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> -	struct msi_desc *msi;
> -	struct msi_msg msg;
> -	unsigned long bit;
> -	int cpu_addr;
> -	int rc, irq;
> =20
> +	zpci_set_irq(zdev);
> +	return true;
> +}
>=20

It's always a little tricky to distinguish which code handles both MSI
and MSI-X or just MSI proper when routines have _msi_ in their name.
But apparently, both __pci_restore_msi_state() and
__pci_restore_msix_state() inside pci_restore_msi_state() do call
arch_restore_msi_irqs() - so life is good!


  [ ... snip ... ]

> +static void zpci_msi_domain_free(struct irq_domain *domain, unsigned int=
 virq,
> +				 unsigned int nr_irqs)
> +{
> +	struct irq_data *d;
> +	int i;
> =20
> -	return (zdev->msi_nr_irqs =3D=3D nvec) ? 0 : zdev->msi_nr_irqs;
> +	for (i =3D 0; i < nr_irqs; i++) {
> +		d =3D irq_domain_get_irq_data(domain, virq + i);
> +		irq_domain_reset_irq_data(d);

Question: zpci_msi_alloc_domain() did modify airq data, can this be
left as is in zpci_msi_domain_free()?

> +	}
>  }
>=20

   [ ... snip ... ]


> +
> +int zpci_create_parent_msi_domain(struct zpci_bus *zbus)
> +{
> +	char fwnode_name[18];
> =20
> -	if (zdev->aisb !=3D -1UL) {
> -		zpci_ibv[zdev->aisb] =3D NULL;
> -		airq_iv_free_bit(zpci_sbv, zdev->aisb);
> -		zdev->aisb =3D -1UL;
> +	snprintf(fwnode_name, sizeof(fwnode_name), "ZPCI_MSI_DOM_%04x", zbus->d=
omain_nr);
> +	struct irq_domain_info info =3D {
> +		.fwnode		=3D irq_domain_alloc_named_fwnode(fwnode_name),
> +		.ops		=3D &zpci_msi_domain_ops,
> +	};
> +
> +	if (!info.fwnode) {
> +		pr_err("Failed to allocate fwnode for MSI IRQ domain\n");
> +		return -ENOMEM;
>  	}
> -	if (zdev->aibv) {
> -		airq_iv_release(zdev->aibv);
> -		zdev->aibv =3D NULL;
> +
> +	if (irq_delivery =3D=3D FLOATING)
> +		zpci_msi_parent_ops.required_flags |=3D MSI_FLAG_NO_AFFINITY;

Add empty line here, so the intent is clear that the following
assignment is executed unconditionally.

> +	zbus->msi_parent_domain =3D msi_create_parent_irq_domain(&info, &zpci_m=
si_parent_ops);
> +	if (!zbus->msi_parent_domain) {
> +		irq_domain_free_fwnode(info.fwnode);
> +		pr_err("Failed to create MSI IRQ domain\n");
> +		return -ENOMEM;
>  	}
> =20
> -	if ((irq_delivery =3D=3D DIRECTED) && zdev->msi_first_bit !=3D -1U)
> -		airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
> +	return 0;
>  }
>=20

   [ ... snip ... ]
=20
> @@ -466,6 +551,7 @@ static int __init zpci_directed_irq_init(void)
>  		 * is only done on the first vector.
>  		 */
>  		zpci_ibv[cpu] =3D airq_iv_create(cache_line_size() * BITS_PER_BYTE,
> +					       AIRQ_IV_PTR |
>  					       AIRQ_IV_DATA |
>  					       AIRQ_IV_CACHELINE |
>  					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);


This looks very good to me already. Unfortunately, I was unable to
relieve my MSI vs. MSI-X anxiety regarding arch_restore_msi_irqs() with
a test since the only MSI-using PCI function (ISM) is not supporting
PCI auto-recovery :(

But a mlx5 VF now recovers just fine!

Thanks,
Gerd
