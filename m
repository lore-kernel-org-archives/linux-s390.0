Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325702D879F;
	Thu, 13 Nov 2025 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036354; cv=none; b=fjge3Oo+PnJzelVE5liWVq+tOrFZ2VmyQKRsSWA8GlR+qpIbRq0XRkaBBLmKXNQcsq8Klp0zMlI/fnf9UNTiwBWjNY7GLr2DCraaYeQKRmRPA/TVaHZxzP8qUKpIyDmQGwF1qBq0MrjavbpmXoBCWCyu0vvu9woOzockCKL6eKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036354; c=relaxed/simple;
	bh=RWPnjwFsZcGt5ql56AV1Y9hJrP41/oHWGE2tNRfe5O8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qX4G1nL9zdlCOknUacFvn/7VnRVUKGnGVCH04oBdykWQJNtUt3VNq96GHwr9nwISBe4vpNJfDTlCteZ3FzbOqUbNIUOgff+hyv0rtrdnHeHriXF7gd8WqfoFAGWGMiTSYmQUyxk39/vUCrrHsnFGfnNv5y8iA11mI1aaQB72rmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pQXKTULF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pQXKTULF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD63Blh017447;
	Thu, 13 Nov 2025 12:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+3lefU
	O/2Li8Kzcwh4BrbzjDHZA4cn5mSREiQHi+9qc=; b=pQXKTULFZNJA+xuhcOW1ZO
	j7138ZMpAb9jbw+xik6FH6O3CMM76swmgO34rBrdt0O/oTYWpups2k+YFyoilLE3
	/r6+ClbGAyrTF6Hf5byb+WAHuvNqgwXDgzjJXpuj+0FJUcoQXQPhx62y/T/eNK18
	QV2V3qYOLJvDZ7CE7Fv3VIG3FJoljpKpfAnKf3ppHsIgPaJlKJ+ZFV2YjNOFifHJ
	THY8sSbxQxjkLyk3RnsY4jBwVb0WQEoTRBCsg1C7ndluEJr5RVYetPn3O1yoAW3U
	7GJZ4cE7fCbr8C0Qwtv3iqrwPFy+J2ZZarc2FfgS3lZsbghxtVzAih348EAshwWQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7fy8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 12:19:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8VfCG008702;
	Thu, 13 Nov 2025 12:19:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6n5pgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 12:19:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADCJ5R23998356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 12:19:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24FC158055;
	Thu, 13 Nov 2025 12:19:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D4FB58056;
	Thu, 13 Nov 2025 12:19:02 +0000 (GMT)
Received: from [9.111.38.118] (unknown [9.111.38.118])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 12:19:02 +0000 (GMT)
Message-ID: <5a87fee183963db08fd848f9d9ad7cf351d04f95.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
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
Date: Thu, 13 Nov 2025 13:19:01 +0100
In-Reply-To: <20251112-implement-msi-domain-v1-2-103dd123de14@linux.ibm.com>
References: <20251112-implement-msi-domain-v1-0-103dd123de14@linux.ibm.com>
	 <20251112-implement-msi-domain-v1-2-103dd123de14@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX31CvjPj95fYJ
 jHzLsuHNhMe5l7/k149Ff+XcXMlBJ5LG9LWj6IpK0/RTFWyYcKBKArxljRh2NXWwmS/jmEn8zly
 VRaX77E7+8RzlhNS/u5Au07Wulh/YNuCJS6/tYiHX62JtdzHVBaryNeWUrKEjkkX+hqyDH9ZCtG
 Px9ypZTQyd/elohxCEvGlkQb0ilFnAsc1PGFVOivLt1h3BGQUjTd3Yg78wAu1W0zrBMqS7fUQNz
 UnfkN7FZdp7iWfMUtXEHSnYNYNyhUcla3KZYkSLCuLtSTar1pp9po5b49nNcDO5nZm3/JmQHSzp
 JnMWtY5g11aPRwG4Wv8yAJCn45hb67BI+zPjCiETYd0Ud/RP5iywEHzzDCp3HdCdg6B7DmdXJPH
 baG3uyxdEejwnYUkB9ZPcn7V0KDzFA==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=6915ccbc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gJhNcgnLu8VJ-uDIRFQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5rRyD6qazfVihq9frlU6tW73yYDTINdK
X-Proofpoint-ORIG-GUID: 5rRyD6qazfVihq9frlU6tW73yYDTINdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

On Wed, 2025-11-12 at 16:40 +0100, Tobias Schumacher wrote:
> s390 is one of the last architectures using the legacy API for setup and
> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
> to the MSI parent domain API. For details, see:
>=20
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>=20
> In detail, create an MSI parent domain for zpci which is used by
> all PCI devices. When a PCI device sets up MSI or MSI-X IRQs, the
> library creates a per-device IRQ domain for this device, which is
> be used by the device for allocating and freeing IRQs.

Nit: superfluous word "be"

>=20
> The per-device domain delegates this allocation and freeing to the
> parent-domain. In the end, the corresponding callbacks of the parent
> domain are responsible for allocating and freeing the IRQs.
--- snip ---
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index df22b10d91415e1ed183cc8add9ad0ac4293c50e..739a9a9a86a277be1ba750cb2=
e98af0547df89fd 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -251,6 +251,7 @@ config S390
>  	select HOTPLUG_SMT
>  	select IOMMU_HELPER		if PCI
>  	select IOMMU_SUPPORT		if PCI
> +  select IRQ_MSI_LIB if PCI

The indentation is wrong here, instead of two spaces you want one tab
to match the context.

>  	select KASAN_VMALLOC if KASAN
>  	select LOCK_MM_AND_FIND_VMA
>  	select MMU_GATHER_MERGE_VMAS
--- snip ---
> +
> +static int zpci_msi_prepare(struct irq_domain *domain,
> +			    struct device *dev, int nvec,
> +			    msi_alloc_info_t *info)
> +{
--- snip ---
> -
> -		msg.data =3D hwirq - bit;
> +	zdev->msi_first_bit =3D bit;
> +	rc =3D zpci_set_irq(zdev);
> +	if (rc) {
> +		pr_err("Registering floating adapter interruptions for %s failed\n",
> +		       pci_name(pdev));

The error message is misleading as this could also happen for directed.
I'd just drop the "floating" in there. Also the wording is inconsistent
with the error message for allocation. I don't really have a preference
between "AIRQ" and "adapter interruptions" but from a Linux point of
view I think IRQ would be what I'd be grepping for which finds the
former.

>  		if (irq_delivery =3D=3D DIRECTED) {
> -			if (msi->affinity)
--- snip ---
>=20
> +static int __init zpci_create_parent_msi_domain(void)
> +{
> +	struct irq_domain_info info =3D {
> +		.fwnode		=3D irq_domain_alloc_named_fwnode("zpci_msi"),
> +		.ops		=3D &zpci_msi_domain_ops
> +	};

Nit: Missing empty line as the above is a variable definition

> +	if (!info.fwnode) {
> +		pr_err("Failed to allocate fwnode for MSI IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	zpci_msi_parent_domain =3D msi_create_parent_irq_domain(&info, &zpci_ms=
i_parent_ops);
> +	if (!zpci_msi_parent_domain) {
> +		irq_domain_free_fwnode(info.fwnode);
> +		pr_err("Failed to create MSI IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>=20
>=20
--- snip ---
> @@ -549,6 +625,7 @@ void __init zpci_irq_exit(void)
>  		}
>  	}
>  	kfree(zpci_ibv);
> +	irq_domain_remove(zpci_msi_parent_domain);
>  	if (zpci_sbv)
>  		airq_iv_release(zpci_sbv);
>  	unregister_adapter_interrupt(&zpci_airq);

Shouldn't zpci_irq_exit() also call irq_domain_free_fwnode() with
zpci_msi_parent_domain->fwnode? Otherwise I think a potential
subsequent zpci_irq_init() would fail because the fwnode already
exists. Not that we currently ever do that but still it should be all
undone.

Overall this looks great to me. I did run into an issue with my
experimental directed IRQ setup, we can work off list to solve this
before v2.

Thanks,
Niklas
