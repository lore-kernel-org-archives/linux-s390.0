Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0C28DF2D;
	Fri, 21 Nov 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736601; cv=none; b=D0N9YY9z9Di9QnACU3xTWmrIN8rRYXGFGu8nayKd8s9eGITRDl/KscN6zXdaqy/WWLx2VSUND8Ddm209UPE2yQL6NWmNSLAuBCy8+ZV2K0YDV0DV5sHJ+iD2Hod2p/+dSYcQF31LhH9Cr8o7RsIT5mHNbPZH+NSg/RZOxwxn4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736601; c=relaxed/simple;
	bh=pKemmz+hn9IInfUvGCr8kgYvfAKbfsVC604PRpRFTs8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=SP+szM506Wz7WBivSNw2eMhgA9GM2SdTnoBZen6XhBxfvJdQlc4hx6tFIXo5+cofnA/EUZL/3TqesFDRumAMT+ecWwV6mXvJPoC2vME24A8ThCvk19oojrIJShs/sXn3q4hyYRjMMmPbX8fw7NXtAgEn1CoFxzREQa5hMRMo/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QXiIKVj+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QXiIKVj+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEEiGX002761;
	Fri, 21 Nov 2025 14:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cno3+u
	2JOlSuZo1wYJT5AjXPcmrcQ/uzT35iy51t2rU=; b=QXiIKVj+fsePQfnowXBPgp
	rGMhwXNzxpNw/ZYLyKxT+Xs8lwyVhHJ2tOa3ChatXrmAGHyiop3l//4DvP1ndKPD
	N8/ikIEciApM30vVHZeROxxoZlojTECWgBR5usls57sGG4nRWjuIf96NwfcRTI+B
	wUQmuZpl8QkpNbY28L868PPrcc3zBTMq1O+eL6fgOUpNk1/qsT/M6c+38cmYKMR2
	E40U6iBUINZvvgaYfvKJoty0oPsJq1moZnDU/OdX7fqsUBj+mk+3kWpXBNeYUH+K
	kOStOXArKyGnlEIZoWG4sBZJHkL1cFlgRsAZYfa+hKy913Rww1J8UEH7JbizMflA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjuavu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:49:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALCj5xH006959;
	Fri, 21 Nov 2025 14:49:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af62jvg8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:49:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALEnoQP27853202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 14:49:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AB502004B;
	Fri, 21 Nov 2025 14:49:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67A3C20049;
	Fri, 21 Nov 2025 14:49:49 +0000 (GMT)
Received: from localhost (unknown [9.111.95.11])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 14:49:49 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Nov 2025 15:49:48 +0100
Message-Id: <DEEGFVBPI57E.1QW7C1D4B2ER4@linux.ibm.com>
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Tobias Schumacher"
 <ts@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik"
 <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle"
 <svens@linux.ibm.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Gerald
 Schaefer" <gerald.schaefer@linux.ibm.com>,
        "Halil Pasic"
 <pasic@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Thomas
 Gleixner" <tglx@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        "Farhan
 Ali" <alifm@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
X-Mailer: aerc 0.21.0
References: <20251121-implement-msi-domain-v5-0-d7e717dfd3f7@linux.ibm.com>
 <20251121-implement-msi-domain-v5-2-d7e717dfd3f7@linux.ibm.com>
 <626c1d010ff720c8c2beb7bdd36b0565850a6ab3.camel@linux.ibm.com>
In-Reply-To: <626c1d010ff720c8c2beb7bdd36b0565850a6ab3.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dwUcxL8lVoglVTSRGShDFmUVclavVBK0
X-Proofpoint-ORIG-GUID: dwUcxL8lVoglVTSRGShDFmUVclavVBK0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXwrbvJVVljgOI
 LpLf6cFpSqaRoGNJfvK67n/Bofd3R9Ld4v8X5V1Q5CK+NUFgOd/5lZLvLrm+svU30ihWE8DlPBr
 YsSxWsgOkcag8QQbwshyZfKcaqFeKS7F3NYNTFj1VxC5eNjb0XpCRwbquE4d0WjCus78tjJgp/Y
 /kXrXh17w6OOu+sLbp39mwwwNk6DicqewTQT7iNBT6Bpp7y4es+xSrzCDCnbC3j79cktm2jjoQR
 l2FyXqfxK8DW9H6uigaYmflHLfz0DR42IGkfbvaQENw+wN5Fm56C2QiztiKLczj6LUNFI/Vjat1
 Mbg+aqKtoU4QkMWGSzMyzf8AaYykn0X3Nf8tX9OQzGwBzMgsp2PDTJ07Itab5U285uaPOT1G0OU
 ap37K/YExxErCh9m0/+qPCPmGHtTGw==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=69207c12 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=O8nXZrIETkQSUyQ56joA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

On Fri Nov 21, 2025 at 2:27 PM CET, Gerd Bayer wrote:
> Hi Tobias,
>
> sorry for being late with my comments...
>
> On Fri, 2025-11-21 at 06:32 +0100, Tobias Schumacher wrote:
>> s390 is one of the last architectures using the legacy API for setup and
>> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
>> to the MSI parent domain API. For details, see:
>>=20
>> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>>=20
>> In detail, create an MSI parent domain for each PCI domain. When a PCI
>> device sets up MSI or MSI-X IRQs, the library creates a per-device IRQ
>> domain for this device, which is used by the device for allocating and
>> freeing IRQs.
>>=20
>> The per-device domain delegates this allocation and freeing to the
>> parent-domain. In the end, the corresponding callbacks of the parent
>> domain are responsible for allocating and freeing the IRQs.
>>=20
>> The allocation is split into two parts:
>> - zpci_msi_prepare() is called once for each device and allocates the
>>   required resources. On s390, each PCI function has its own airq
>>   vector and a summary bit, which must be configured once per function.
>>   This is done in prepare().
>> - zpci_msi_alloc() can be called multiple times for allocating one or
>>   more MSI/MSI-X IRQs. This creates a mapping between the virtual IRQ
>>   number in the kernel and the hardware IRQ number.
>>=20
>> Freeing is split into two counterparts:
>> - zpci_msi_free() reverts the effects of zpci_msi_alloc() and
>> - zpci_msi_teardown() reverts the effects of zpci_msi_prepare(). This is
>>   called once when all IRQs are freed before a device is removed.
>>=20
>> Since the parent domain in the end allocates the IRQs, the hwirq
>> encoding must be unambiguous for all IRQs of all devices. This is
>> achieved by=20
>>=20
>> encoding the hwirq using the PCI function id and the MSI
>> index.
>
> This is no longer true with the per-PCI-domain irq domains! But you
> encode the hwirq with the devfn within the PCI domain, instead.

Correct, will fix that.

>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
>> ---
>>  arch/s390/Kconfig           |   1 +
>>  arch/s390/include/asm/pci.h |   4 +
>>  arch/s390/pci/pci_bus.c     |  21 ++-
>>  arch/s390/pci/pci_irq.c     | 333 +++++++++++++++++++++++++++----------=
-------
>>  4 files changed, 227 insertions(+), 132 deletions(-)
>>=20
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index 778ce20d34046cad84dd4ef57cab5a662e5796d9..46ab67d607f0db7f5f108106=
172699a5eebfc8c8 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -251,6 +251,7 @@ config S390
>>  	select HOTPLUG_SMT
>>  	select IOMMU_HELPER		if PCI
>>  	select IOMMU_SUPPORT		if PCI
>> +	select IRQ_MSI_LIB if PCI
>
> Nit: There's precedence for both versions (above and below!) but I
> personally would prefer to indent the pre-condition "if PCI" so it
> stands out. Maybe that's a generic clean-up task for this arch-specific
> file...

Since at least the 'if PCI' preconditions are indented in this file,
I'll also do it for this line.=20

>> @@ -189,7 +190,7 @@ static bool zpci_bus_is_multifunction_root(struct zp=
ci_dev *zdev)
>>  static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_d=
ev *fr, struct pci_ops *ops)
>>  {
>>  	struct pci_bus *bus;
>> -	int domain;
>> +	int domain, rc;
>> =20
>>  	domain =3D zpci_alloc_domain((u16)fr->uid);
>>  	if (domain < 0)
>> @@ -199,19 +200,28 @@ static int zpci_bus_create_pci_bus(struct zpci_bus=
 *zbus, struct zpci_dev *fr, s
>>  	zbus->multifunction =3D zpci_bus_is_multifunction_root(fr);
>>  	zbus->max_bus_speed =3D fr->max_bus_speed;
>> =20
>> +	rc =3D zpci_create_parent_msi_domain(zbus);
>> +	if (rc)
>> +		goto out_free_domain;
>> +
>
> If you shortened this to use the call to
> zpci_create_parent_msi_domain() as predicate for "if" you could do
> without the additional rc.

Will do.

>>  	/*
>>  	 * Note that the zbus->resources are taken over and zbus->resources
>>  	 * is empty after a successful call
>>  	 */
>>  	bus =3D pci_create_root_bus(NULL, ZPCI_BUS_NR, ops, zbus, &zbus->resou=
rces);
>> -	if (!bus) {
>> -		zpci_free_domain(zbus->domain_nr);
>> -		return -EFAULT;
>> -	}
>> +	if (!bus)
>> +		goto out_remove_msi_domain;
>
> Or do you want to set rc to -EFAULT here, and return the "original" rc
> in the error exits?

As Heiko mentioned, -EFAULT shouldn't be returned anyways I'd change it
to -ENOMEM for all error cases.

--- snip ---

>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> index e73be96ce5fe6473fc193d65b8f0ff635d6a98ba..b0be21ab56995e81f54339fc=
77167f5930182542 100644
>> --- a/arch/s390/pci/pci_irq.c
>> +++ b/arch/s390/pci/pci_irq.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/kernel_stat.h>
>>  #include <linux/pci.h>
>>  #include <linux/msi.h>
>> +#include <linux/irqchip/irq-msi-lib.h>
>>  #include <linux/smp.h>
>> =20
>>  #include <asm/isc.h>
>> @@ -110,43 +111,41 @@ static int zpci_set_irq(struct zpci_dev *zdev)
>>  	return rc;
>>  }
>> =20
>> -/* Clear adapter interruptions */
>> -static int zpci_clear_irq(struct zpci_dev *zdev)
>
>
> Any specific reason, why you removed zpci_clear_irq() indirecting to
> airq vs. directed_irq - but kept zpci_set_irq()? Just saying this is
> imbalanced now.

I removed it because it was only required in zpci_msi_teardown(), which
already has the distinction between directed and floating IRQs. So
having a separate zpci_clear_irq() seemed redundant.=20

--- snip ---

>> +static inline u16 zpci_decode_hwirq_msi_index(irq_hw_number_t irq)
>> +{
>> +	return irq & GENMASK_U16(15, 0);
>
>
> Please don't use GENMASK_U16. It is harder to read than any explicit
> constant like 0x00FF, especially since its parameters contradict the
> architecture's endianess.
> But then, is this called anywhere?

Right, it's not used anymore, I'll remove it completely.

--- snip ---

>> +static int zpci_msi_prepare(struct irq_domain *domain,
>> +			    struct device *dev, int nvec,
>> +			    msi_alloc_info_t *info)
>> +{
>> +	struct zpci_dev *zdev =3D to_zpci_dev(dev);
>> +	struct pci_dev *pdev =3D to_pci_dev(dev);
>> +	unsigned long bit;
>> +	int msi_vecs, rc;
>> =20
>>  	msi_vecs =3D min_t(unsigned int, nvec, zdev->max_msi);
>> -	if (msi_vecs < nvec) {
>> -		pr_info("%s requested %d irqs, allocate system limit of %d",
>> +	if (msi_vecs < nvec)
>> +		pr_info("%s requested %d IRQs, allocate system limit of %d\n",
>>  			pci_name(pdev), nvec, zdev->max_msi);
>> -	}
>> =20
>>  	rc =3D __alloc_airq(zdev, msi_vecs, &bit);
>> -	if (rc < 0)
>> +	if (rc) {
>> +		pr_err("Allocating adapter IRQs for %s failed\n", pci_name(pdev));
>>  		return rc;
>> +	}
>> =20
>> -	/*
>> -	 * Request MSI interrupts:
>> -	 * When using MSI, nvec_used interrupt sources and their irq
>> -	 * descriptors are controlled through one msi descriptor.
>> -	 * Thus the outer loop over msi descriptors shall run only once,
>> -	 * while two inner loops iterate over the interrupt vectors.
>> -	 * When using MSI-X, each interrupt vector/irq descriptor
>> -	 * is bound to exactly one msi descriptor (nvec_used is one).
>> -	 * So the inner loops are executed once, while the outer iterates
>> -	 * over the MSI-X descriptors.
>> -	 */
>> -	hwirq =3D bit;
>> -	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
>> -		if (hwirq - bit >=3D msi_vecs)
>> -			break;
>> -		irqs_per_msi =3D min_t(unsigned int, msi_vecs, msi->nvec_used);
>> -		irq =3D __irq_alloc_descs(-1, 0, irqs_per_msi, 0, THIS_MODULE,
>> -					(irq_delivery =3D=3D DIRECTED) ?
>> -					msi->affinity : NULL);
>> -		if (irq < 0)
>> -			return -ENOMEM;
>> -
>> -		for (i =3D 0; i < irqs_per_msi; i++) {
>> -			rc =3D irq_set_msi_desc_off(irq, i, msi);
>> -			if (rc)
>> -				return rc;
>> -			irq_set_chip_and_handler(irq + i, &zpci_irq_chip,
>> -						 handle_percpu_irq);
>> +	zdev->msi_first_bit =3D bit;
>> +	zdev->msi_nr_irqs =3D msi_vecs;
>> +	rc =3D zpci_set_irq(zdev);
>> +	if (rc) {
>> +		pr_err("Registering adapter IRQs for %s failed\n",
>> +		       pci_name(pdev));
>> +		if (irq_delivery =3D=3D DIRECTED) {
>> +			airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, msi_vecs);
>> +		} else {
>> +			zpci_clear_airq(zdev);
>> +			airq_iv_release(zdev->aibv);
>> +			zdev->aibv =3D NULL;
>> +			airq_iv_free_bit(zpci_sbv, zdev->aisb);
>> +			zdev->aisb =3D -1UL;
>
> These two failure clean-ups look a lot like
> zpci_msi_teardown_directed/_floating() below. Could these be called
> instead of duplicating the code?

Yes they are similar, only that zpci_msi_teardown_directed/_floating()
also call zpci_clear_directed_irq()/zpci_clear_airq(), respectively.
Considering your other comment above, it might be cleaner to add
zpci_clear_irq() again, call this directly from zpci_msi_teardown() and
then use zpci_msi_teardown_directed/_floating() here as suggested.

Thanks,
Tobias
