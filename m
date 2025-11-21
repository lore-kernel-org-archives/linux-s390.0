Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67611F09B3;
	Fri, 21 Nov 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731726; cv=none; b=BpJIdtqhgMS0ai4McVZ0F3PWOUusQXV/Os23XGBT4BOR1Wx173EaHAcfFhmOrh74CoSwwDJwvalpFYG2evVwk//eXG/WkPcQ4doBSyfyjL7fs04ArlQdpzbSJmbMolFgjqbyJ1M2z0FKLGr2OsaPehA7WcR13vJMv7Cv9+E7Q4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731726; c=relaxed/simple;
	bh=u51ep0SyM99SSPCInasKw2bQEnYrGe0oskN7txLQF1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T9hVZHQt9WUw5rUPS5+bnfYYngvpKiQnD00RWKKFEJPVFcHowG3CVIlXsjf18JMWg2VZYrYXsfiHjeIRZoPyivPl253aIGmacULakDGpKLlH2zTKVJtOlg+uB49LJKSI54o4UhivclhY4EIt48Tp8buoRv1OTf6lMm/YuO3VWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ET8/HygR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ET8/HygR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL0O4P6029069;
	Fri, 21 Nov 2025 13:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UTiHDZ
	4BuMR5USfRF8L4+qx6Kr4Ef9fA75g7cNyAoH8=; b=ET8/HygRbyh9U+L+fAhM4l
	1jKaM1aGoevr1upRPC1DJI4tw7M9zPi/uHG9UBV9myoYk2PhJUVwhEaqO++ZcBed
	4GEdw69FJXNvJN2VSJYkUG7VUP8tkTjL5Ts8AKVZ8J3IRvzZ1+iHZKFpiYxM6RdM
	SO4+4hck7Fs5R/K6Nkx12FGZndwzlJxlRuOU36uoZgitKQviykrTHaMBbYCp1dOQ
	FZ7OZh2l9DZbNduTfl++Us4sBl/x7oAygVLfLVVOTs76atqvfYyI6WOSiEKWQFb0
	6hwmLButw2CjRX6RHxPgeWqq26o7MEloFAYVbrZi0+ON6Ksv9LsCM5QiCVt2E/lw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1v5t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 13:27:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALC3Qkp010506;
	Fri, 21 Nov 2025 13:27:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3usmhm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 13:27:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALDRdEc45613478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 13:27:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6653B2004D;
	Fri, 21 Nov 2025 13:27:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F39B720040;
	Fri, 21 Nov 2025 13:27:38 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 13:27:38 +0000 (GMT)
Message-ID: <626c1d010ff720c8c2beb7bdd36b0565850a6ab3.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
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
Date: Fri, 21 Nov 2025 14:27:38 +0100
In-Reply-To: <20251121-implement-msi-domain-v5-2-d7e717dfd3f7@linux.ibm.com>
References: <20251121-implement-msi-domain-v5-0-d7e717dfd3f7@linux.ibm.com>
	 <20251121-implement-msi-domain-v5-2-d7e717dfd3f7@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=692068cf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=xoWgm32L-zh2MFM3n8EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 25m0ceSMlUqQrbAxBftPTXltOC80_QIE
X-Proofpoint-ORIG-GUID: 25m0ceSMlUqQrbAxBftPTXltOC80_QIE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX6M18adFYzl2n
 iZ1j0kjWH2wqliVdwNBIBf+/aBkUtk6VaMhhmWxHmcQ1e2mL3P1w/xOtvQBDM/0APBfVx63WjJi
 O3bsI2KzS7GiXC3vPWR4c2Lmg64HnH5k6KzQlp/jLLTZSG9U0yhSajxn9X+Br5gumiNYNRqZxVd
 3k8tnQA6SwNCB5T/JbKjIUPpPQmt5yA23VV05BWCPv1Bn8uXJeKYJ8O5JhWMFlGgDsOnjbkb7uy
 DmpXvvAStdE6werZF92dOTrgK+rbG7zIftiDvyL7PXAjVtWlu96s18QyTpd1qYDW/KSOzH/Ju8s
 EnfHcQTDTaCa3FVrqFvKXyEklrCFcQvQSV6UY/pii7II3EZ5+zZqup/aU09A6OywictuBxJk+ZQ
 ZaDptN8riqjprgiGuiGO6LkSMxBMNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

Hi Tobias,

sorry for being late with my comments...

On Fri, 2025-11-21 at 06:32 +0100, Tobias Schumacher wrote:
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
> achieved by=20
>=20
> encoding the hwirq using the PCI function id and the MSI
> index.

This is no longer true with the per-PCI-domain irq domains! But you
encode the hwirq with the devfn within the PCI domain, instead.


> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  arch/s390/Kconfig           |   1 +
>  arch/s390/include/asm/pci.h |   4 +
>  arch/s390/pci/pci_bus.c     |  21 ++-
>  arch/s390/pci/pci_irq.c     | 333 +++++++++++++++++++++++++++-----------=
------
>  4 files changed, 227 insertions(+), 132 deletions(-)
>=20
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 778ce20d34046cad84dd4ef57cab5a662e5796d9..46ab67d607f0db7f5f1081061=
72699a5eebfc8c8 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -251,6 +251,7 @@ config S390
>  	select HOTPLUG_SMT
>  	select IOMMU_HELPER		if PCI
>  	select IOMMU_SUPPORT		if PCI
> +	select IRQ_MSI_LIB if PCI

Nit: There's precedence for both versions (above and below!) but I
personally would prefer to indent the pre-condition "if PCI" so it
stands out. Maybe that's a generic clean-up task for this arch-specific
file...

>  	select KASAN_VMALLOC if KASAN
>  	select LOCK_MM_AND_FIND_VMA
>  	select MMU_GATHER_MERGE_VMAS
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index a32f465ecf73a5cc3408a312d94ec888d62848cc..60abc84cf14fe6fb1ee149df6=
88eea94f0983ed0 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -5,6 +5,7 @@
>  #include <linux/pci.h>
>  #include <linux/mutex.h>
>  #include <linux/iommu.h>
> +#include <linux/irqdomain.h>
>  #include <linux/pci_hotplug.h>
>  #include <asm/pci_clp.h>
>  #include <asm/pci_debug.h>
> @@ -109,6 +110,7 @@ struct zpci_bus {
>  	struct list_head	resources;
>  	struct list_head	bus_next;
>  	struct resource		bus_resource;
> +	struct irq_domain       *msi_parent_domain;
>  	int			topo;		/* TID if topo_is_tid, PCHID otherwise */
>  	int			domain_nr;
>  	u8			multifunction	: 1;
> @@ -310,6 +312,8 @@ int zpci_dma_exit_device(struct zpci_dev *zdev);
>  /* IRQ */
>  int __init zpci_irq_init(void);
>  void __init zpci_irq_exit(void);
> +int zpci_create_parent_msi_domain(struct zpci_bus *zbus);
> +void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
> =20
>  /* FMB */
>  int zpci_fmb_enable_device(struct zpci_dev *);
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index be8c697fea0cc755cfdb4fb0a9e3b95183bec0dc..9da261b600df805ef76f33319=
75ac8fce6178908 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -15,6 +15,7 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/seq_file.h>
> +#include <linux/irqdomain.h>
>  #include <linux/jump_label.h>
>  #include <linux/pci.h>
>  #include <linux/printk.h>
> @@ -189,7 +190,7 @@ static bool zpci_bus_is_multifunction_root(struct zpc=
i_dev *zdev)
>  static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_de=
v *fr, struct pci_ops *ops)
>  {
>  	struct pci_bus *bus;
> -	int domain;
> +	int domain, rc;
> =20
>  	domain =3D zpci_alloc_domain((u16)fr->uid);
>  	if (domain < 0)
> @@ -199,19 +200,28 @@ static int zpci_bus_create_pci_bus(struct zpci_bus =
*zbus, struct zpci_dev *fr, s
>  	zbus->multifunction =3D zpci_bus_is_multifunction_root(fr);
>  	zbus->max_bus_speed =3D fr->max_bus_speed;
> =20
> +	rc =3D zpci_create_parent_msi_domain(zbus);
> +	if (rc)
> +		goto out_free_domain;
> +

If you shortened this to use the call to
zpci_create_parent_msi_domain() as predicate for "if" you could do
without the additional rc.

>=20
>  	/*
>  	 * Note that the zbus->resources are taken over and zbus->resources
>  	 * is empty after a successful call
>  	 */
>  	bus =3D pci_create_root_bus(NULL, ZPCI_BUS_NR, ops, zbus, &zbus->resour=
ces);
> -	if (!bus) {
> -		zpci_free_domain(zbus->domain_nr);
> -		return -EFAULT;
> -	}
> +	if (!bus)
> +		goto out_remove_msi_domain;

Or do you want to set rc to -EFAULT here, and return the "original" rc
in the error exits?

> =20
>  	zbus->bus =3D bus;
> +	dev_set_msi_domain(&zbus->bus->dev, zbus->msi_parent_domain);
> =20
>  	return 0;
> +
> +out_remove_msi_domain:
> +	zpci_remove_parent_msi_domain(zbus);
> +out_free_domain:
> +	zpci_free_domain(zbus->domain_nr);
> +	return -EFAULT;
>  }
> =20
>  static void zpci_bus_release(struct kref *kref)
> @@ -232,6 +242,7 @@ static void zpci_bus_release(struct kref *kref)
>  	mutex_lock(&zbus_list_lock);
>  	list_del(&zbus->bus_next);
>  	mutex_unlock(&zbus_list_lock);
> +	zpci_remove_parent_msi_domain(zbus);
>  	kfree(zbus);
>  }
> =20
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index e73be96ce5fe6473fc193d65b8f0ff635d6a98ba..b0be21ab56995e81f54339fc7=
7167f5930182542 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -7,6 +7,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/pci.h>
>  #include <linux/msi.h>
> +#include <linux/irqchip/irq-msi-lib.h>
>  #include <linux/smp.h>
> =20
>  #include <asm/isc.h>
> @@ -110,43 +111,41 @@ static int zpci_set_irq(struct zpci_dev *zdev)
>  	return rc;
>  }
> =20
> -/* Clear adapter interruptions */
> -static int zpci_clear_irq(struct zpci_dev *zdev)


Any specific reason, why you removed zpci_clear_irq() indirecting to
airq vs. directed_irq - but kept zpci_set_irq()? Just saying this is
imbalanced now.

> +static int zpci_set_irq_affinity(struct irq_data *data, const struct cpu=
mask *dest,
> +				 bool force)
>  {
> -	int rc;
> -
> -	if (irq_delivery =3D=3D DIRECTED)
> -		rc =3D zpci_clear_directed_irq(zdev);
> -	else
> -		rc =3D zpci_clear_airq(zdev);
> -
> -	return rc;
> +	irq_data_update_affinity(data, dest);
> +	return IRQ_SET_MASK_OK;
>  }
> =20
> -static int zpci_set_irq_affinity(struct irq_data *data, const struct cpu=
mask *dest,
> -				 bool force)
> +static void zpci_compose_msi_msg(struct irq_data *data, struct msi_msg *=
msg)
>  {
> -	struct msi_desc *entry =3D irq_data_get_msi_desc(data);
> -	struct msi_msg msg =3D entry->msg;
> -	int cpu_addr =3D smp_cpu_get_cpu_address(cpumask_first(dest));
> +	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
> +	struct zpci_dev *zdev =3D to_zpci_dev(desc->dev);
> =20
> -	msg.address_lo &=3D 0xff0000ff;
> -	msg.address_lo |=3D (cpu_addr << 8);
> -	pci_write_msi_msg(data->irq, &msg);
> +	if (irq_delivery =3D=3D DIRECTED) {
> +		int cpu =3D cpumask_first(irq_data_get_affinity_mask(data));
> =20
> -	return IRQ_SET_MASK_OK;
> +		msg->address_lo =3D zdev->msi_addr & 0xff0000ff;
> +		msg->address_lo |=3D (smp_cpu_get_cpu_address(cpu) << 8);
> +	} else {
> +		msg->address_lo =3D zdev->msi_addr & 0xffffffff;
> +	}
> +	msg->address_hi =3D zdev->msi_addr >> 32;
> +	msg->data =3D data->hwirq & 0xffffffff;
>  }
> =20
>  static struct irq_chip zpci_irq_chip =3D {
>  	.name =3D "PCI-MSI",
> -	.irq_unmask =3D pci_msi_unmask_irq,
> -	.irq_mask =3D pci_msi_mask_irq,
> +	.irq_compose_msi_msg =3D zpci_compose_msi_msg
>  };
> =20
>  static void zpci_handle_cpu_local_irq(bool rescan)
>  {
>  	struct airq_iv *dibv =3D zpci_ibv[smp_processor_id()];
>  	union zpci_sic_iib iib =3D {{0}};
> +	struct irq_domain *msi_domain;
> +	irq_hw_number_t hwirq;
>  	unsigned long bit;
>  	int irqs_on =3D 0;
> =20

[... snip ...]

>=20
> @@ -290,146 +297,217 @@ static int __alloc_airq(struct zpci_dev *zdev, in=
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
> -	zdev->aisb =3D -1UL;
> -	zdev->msi_first_bit =3D -1U;
> +	zpci_set_irq(zdev);
> +	return true;
> +}
> +
> +static struct airq_struct zpci_airq =3D {
> +	.handler =3D zpci_floating_irq_handler,
> +	.isc =3D PCI_ISC,
> +};
> +
> +/*
> + * Encode the hwirq number for the parent domain. The encoding must be u=
nique
> + * for each IRQ of each device in the parent domain, so it uses the devf=
n to
> + * identify the device and the msi_index to identify the IRQ within that=
 device.
> + */
> +static inline u32 zpci_encode_hwirq(u8 devfn, u16 msi_index)
> +{
> +	return (devfn << 16) | msi_index;
> +}
> +
> +static inline u16 zpci_decode_hwirq_msi_index(irq_hw_number_t irq)
> +{
> +	return irq & GENMASK_U16(15, 0);


Please don't use GENMASK_U16. It is harder to read than any explicit
constant like 0x00FF, especially since its parameters contradict the
architecture's endianess.
But then, is this called anywhere?

> +}
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
> +		pr_info("%s requested %d IRQs, allocate system limit of %d\n",
>  			pci_name(pdev), nvec, zdev->max_msi);
> -	}
> =20
>  	rc =3D __alloc_airq(zdev, msi_vecs, &bit);
> -	if (rc < 0)
> +	if (rc) {
> +		pr_err("Allocating adapter IRQs for %s failed\n", pci_name(pdev));
>  		return rc;
> +	}
> =20
> -	/*
> -	 * Request MSI interrupts:
> -	 * When using MSI, nvec_used interrupt sources and their irq
> -	 * descriptors are controlled through one msi descriptor.
> -	 * Thus the outer loop over msi descriptors shall run only once,
> -	 * while two inner loops iterate over the interrupt vectors.
> -	 * When using MSI-X, each interrupt vector/irq descriptor
> -	 * is bound to exactly one msi descriptor (nvec_used is one).
> -	 * So the inner loops are executed once, while the outer iterates
> -	 * over the MSI-X descriptors.
> -	 */
> -	hwirq =3D bit;
> -	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
> -		if (hwirq - bit >=3D msi_vecs)
> -			break;
> -		irqs_per_msi =3D min_t(unsigned int, msi_vecs, msi->nvec_used);
> -		irq =3D __irq_alloc_descs(-1, 0, irqs_per_msi, 0, THIS_MODULE,
> -					(irq_delivery =3D=3D DIRECTED) ?
> -					msi->affinity : NULL);
> -		if (irq < 0)
> -			return -ENOMEM;
> -
> -		for (i =3D 0; i < irqs_per_msi; i++) {
> -			rc =3D irq_set_msi_desc_off(irq, i, msi);
> -			if (rc)
> -				return rc;
> -			irq_set_chip_and_handler(irq + i, &zpci_irq_chip,
> -						 handle_percpu_irq);
> +	zdev->msi_first_bit =3D bit;
> +	zdev->msi_nr_irqs =3D msi_vecs;
> +	rc =3D zpci_set_irq(zdev);
> +	if (rc) {
> +		pr_err("Registering adapter IRQs for %s failed\n",
> +		       pci_name(pdev));
> +		if (irq_delivery =3D=3D DIRECTED) {
> +			airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, msi_vecs);
> +		} else {
> +			zpci_clear_airq(zdev);
> +			airq_iv_release(zdev->aibv);
> +			zdev->aibv =3D NULL;
> +			airq_iv_free_bit(zpci_sbv, zdev->aisb);
> +			zdev->aisb =3D -1UL;

These two failure clean-ups look a lot like
zpci_msi_teardown_directed/_floating() below. Could these be called
instead of duplicating the code?

>  		}
> +		zdev->msi_first_bit =3D -1U;
> +		return rc;
> +	}
> =20
> -		msg.data =3D hwirq - bit;
> -		if (irq_delivery =3D=3D DIRECTED) {
> -			if (msi->affinity)
> -				cpu =3D cpumask_first(&msi->affinity->mask);
> -			else
> -				cpu =3D 0;
> -			cpu_addr =3D smp_cpu_get_cpu_address(cpu);
> +	return 0;
> +}
> +
> +static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
> +{
> +	zpci_clear_directed_irq(zdev);
> +	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->max_msi);
> +	zdev->msi_first_bit =3D -1U;
> +}
> +
> +static void zpci_msi_teardown_floating(struct zpci_dev *zdev)
> +{
> +	zpci_clear_airq(zdev);
> +	airq_iv_release(zdev->aibv);
> +	zdev->aibv =3D NULL;
> +	airq_iv_free_bit(zpci_sbv, zdev->aisb);
> +	zdev->aisb =3D -1UL;
> +	zdev->msi_first_bit =3D -1U;
> +}
> =20
> -			msg.address_lo =3D zdev->msi_addr & 0xff0000ff;
> -			msg.address_lo |=3D (cpu_addr << 8);
> +static void zpci_msi_teardown(struct irq_domain *domain, msi_alloc_info_=
t *arg)
> +{
> +	struct zpci_dev *zdev =3D to_zpci_dev(domain->dev);
> =20
> +	if (irq_delivery =3D=3D DIRECTED)
> +		zpci_msi_teardown_directed(zdev);
> +	else
> +		zpci_msi_teardown_floating(zdev);
> +}
> +

[... snip ...]

No more findings at this point in time.
Thanks for your work!

Gerd
