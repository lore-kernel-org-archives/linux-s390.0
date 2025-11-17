Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6A2F39AB;
	Mon, 17 Nov 2025 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419592; cv=none; b=BLaNAertN/CyNj0lYH8t5tcXDF+vox8bqk+bljK6rRs4hvrE8T+/ZAHujRGOkgsiI4tFzKKbeMaxNPSuggen1CwIeoZONYbXKjRE/9f56R4F2Zun3fiK9nG1tpYMGGW6jZMbrwuGtk+xPcf8wnfSOiAdKqAlav0TBl5FR4yjAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419592; c=relaxed/simple;
	bh=mK8rbG1GxV4qZK8Tj9Grz7fQ/XkmuQ0F5/XyHOplhlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyJMm7OFmPSol1NlHZfMuvPTabmu8dJfcVLlyMxeINMM80UqAxNbA8BRvxEEzx8coWkXPN4XHp0t/IIbzLb4XdDceOXsoclif5k7ij0mApRJaunrj52Tk8ffIT1bFHCZiWyqPqnkMtzxBLV2BsXOgZnfLJ8B/dWTvyrAGecv9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fqhf3WOO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fqhf3WOO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHDlMx4004165;
	Mon, 17 Nov 2025 22:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QOo0qo
	4vIt+PKf33wSBIWatQWYLnvZ00HUa7CV5VUdw=; b=Fqhf3WOOZv08WJRqDBBpBq
	hzauR+LQ0cdJ1Y5aUwZbrg385Gm1lHWT4NWba4ddnaOCiQwzWUViKBfuMPGI2/aK
	TWgn9DEPYg+HeYfx9gLaZMMVqMsRqa4RMlljDFPnnJGBBTpze6wnfHV+33q7nF4j
	6MM/XCVnaDb/taMNxtvcWVwlKbtTGKFgKLM3CcmE/VZ4LSjNCI3M2cW1qTF7OpU3
	lVS/qrkmWsN3sgSKB8fyeSlpnw9LPajgBc5WRGbPBztHbrRVh/DrWtH95krVvP+r
	Cl58tozbOe0kGD0NW3VPbJXJaATUUCiEh/8c/zBLmS8pC61IoPDdi/VVOz1X3SLQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw0ae3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 22:46:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHJ3VbV017317;
	Mon, 17 Nov 2025 22:46:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1fyfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 22:46:23 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHMkM5q8979066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 22:46:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF4935805D;
	Mon, 17 Nov 2025 22:46:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61ADC5805C;
	Mon, 17 Nov 2025 22:46:20 +0000 (GMT)
Received: from [9.61.241.175] (unknown [9.61.241.175])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 22:46:20 +0000 (GMT)
Message-ID: <933dea7a-4e5a-4d3c-8580-b94d0a9271c1@linux.ibm.com>
Date: Mon, 17 Nov 2025 14:46:20 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
To: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20251117-implement-msi-domain-v2-0-a110ea0721fe@linux.ibm.com>
 <20251117-implement-msi-domain-v2-2-a110ea0721fe@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251117-implement-msi-domain-v2-2-a110ea0721fe@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691ba5c0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=YkmI71CHjLlHVektNQEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX9ZfDkUPpDL5t
 wlq63KMPr6gisVy6AEiIFlkqmSSMM1/x5lL42wEGddnMJoiPqIOOl5zM6qXaRUHerMRlViGc4tV
 3JpBuRb85EZcA57D0drkpQ8YrLp8GGACMHxsIN6TRipLmc7+d3+QTQh36UKdwP56u1SenYq36ox
 000ydG46AE63YjpGfd4aoDYWd7xm1yXEx89B7BD0DnDEjt20oFz+jvU/yKew0zMW+B9GYm/e3Gr
 SV5RCy8N0djGGhxKvnWJoYABem42Dq/PKzBKKMsDeHH5nIDS0ekjPZXs0J7eam+NmQ0UMFw72jI
 MmprHdsIGg15UlWG5PlrB+xv4fCYvISwKszygHZEUGbFDT4Qr6FhZRthFoNMPy9kimqDvxFOUsM
 1LEfkVTISwAce6ADXK0YZL5xJenFRg==
X-Proofpoint-GUID: RcR-FhS3LHBfM8Mb8vEQ-R-IoUbCZqgl
X-Proofpoint-ORIG-GUID: RcR-FhS3LHBfM8Mb8vEQ-R-IoUbCZqgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032


On 11/17/2025 12:59 AM, Tobias Schumacher wrote:
> s390 is one of the last architectures using the legacy API for setup and
> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
> to the MSI parent domain API. For details, see:
>
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>
> In detail, create an MSI parent domain for zpci which is used by
> all PCI devices. When a PCI device sets up MSI or MSI-X IRQs, the
> library creates a per-device IRQ domain for this device, which is
> used by the device for allocating and freeing IRQs.
>
> The per-device domain delegates this allocation and freeing to the
> parent-domain. In the end, the corresponding callbacks of the parent
> domain are responsible for allocating and freeing the IRQs.
>
> The allocation is split into two parts:
> - zpci_msi_prepare() is called once for each device and allocates the
>    required resources. On s390, each PCI function has its own airq
>    vector and a summary bit, which must be configured once per function.
>    This is done in prepare().
> - zpci_msi_alloc() can be called multiple times for allocating one or
>    more MSI/MSI-X IRQs. This creates a mapping between the virtual IRQ
>    number in the kernel and the hardware IRQ number.
>
> Freeing is split into two counterparts:
> - zpci_msi_free() reverts the effects of zpci_msi_alloc() and
> - zpci_msi_teardown() reverts the effects of zpci_msi_prepare(). This is
>    callend once when all IRQs are freed before a device is removed.
>
> Since the parent domain in the end allocates the IRQs, the hwirq
> encoding must be unambiguous for all IRQs of all devices. This is
> achieved by encoding the hwirq using the PCI function id and the MSI
> index.
>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>   arch/s390/Kconfig           |   1 +
>   arch/s390/include/asm/pci.h |   1 +
>   arch/s390/pci/pci_bus.c     |   1 +
>   arch/s390/pci/pci_irq.c     | 335 +++++++++++++++++++++++++++-----------------
>   4 files changed, 208 insertions(+), 130 deletions(-)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index df22b10d91415e1ed183cc8add9ad0ac4293c50e..48cd6a12bd04dfe4dd61ecc79d3401ba685c51bb 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -251,6 +251,7 @@ config S390
>   	select HOTPLUG_SMT
>   	select IOMMU_HELPER		if PCI
>   	select IOMMU_SUPPORT		if PCI
> +	select IRQ_MSI_LIB if PCI
>   	select KASAN_VMALLOC if KASAN
>   	select LOCK_MM_AND_FIND_VMA
>   	select MMU_GATHER_MERGE_VMAS
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index a32f465ecf73a5cc3408a312d94ec888d62848cc..462e87bdb7acdfa4e7df0f9ca8e82c269e1f98aa 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -310,6 +310,7 @@ int zpci_dma_exit_device(struct zpci_dev *zdev);
>   /* IRQ */
>   int __init zpci_irq_init(void);
>   void __init zpci_irq_exit(void);
> +void zpci_set_msi_parent_domain(struct zpci_bus *zbus);
>   
>   /* FMB */
>   int zpci_fmb_enable_device(struct zpci_dev *);
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index be8c697fea0cc755cfdb4fb0a9e3b95183bec0dc..2be33cfb8970409db4fcb75ea73543f49b583a5c 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -210,6 +210,7 @@ static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, s
>   	}
>   
>   	zbus->bus = bus;
> +	zpci_set_msi_parent_domain(zbus);

Why are we setting the zpci_set_msi_parent_domain per root device 
instead of per zpci device?


>   
>   	return 0;
>   }
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index e73be96ce5fe6473fc193d65b8f0ff635d6a98ba..f2c2fc23d5693e211bcbfd94e8f2fe25dc71a4e2 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -7,6 +7,7 @@
>   #include <linux/kernel_stat.h>
>   #include <linux/pci.h>
>   #include <linux/msi.h>
> +#include <linux/irqchip/irq-msi-lib.h>
>   #include <linux/smp.h>
>   
>   #include <asm/isc.h>
> @@ -29,6 +30,8 @@ static struct airq_iv *zpci_sbv;
>    */
>   static struct airq_iv **zpci_ibv;
>   
> +static struct irq_domain *zpci_msi_parent_domain;
> +
>   /* Modify PCI: Register floating adapter interruptions */
>   static int zpci_set_airq(struct zpci_dev *zdev)
>   {
> @@ -110,43 +113,42 @@ static int zpci_set_irq(struct zpci_dev *zdev)
>   	return rc;
>   }
>   
> -/* Clear adapter interruptions */
> -static int zpci_clear_irq(struct zpci_dev *zdev)
> +static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *dest,
> +				 bool force)
>   {
> -	int rc;
> -
> -	if (irq_delivery == DIRECTED)
> -		rc = zpci_clear_directed_irq(zdev);
> -	else
> -		rc = zpci_clear_airq(zdev);
> -
> -	return rc;
> +	irq_data_update_affinity(data, dest);
> +	return IRQ_SET_MASK_OK;
>   }
>   
> -static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *dest,
> -				 bool force)
> +static void zpci_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>   {
> -	struct msi_desc *entry = irq_data_get_msi_desc(data);
> -	struct msi_msg msg = entry->msg;
> -	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +	struct zpci_dev *zdev = to_zpci_dev(desc->dev);
>   
> -	msg.address_lo &= 0xff0000ff;
> -	msg.address_lo |= (cpu_addr << 8);
> -	pci_write_msi_msg(data->irq, &msg);
> +	if (irq_delivery == DIRECTED) {
> +		int cpu = cpumask_first(irq_data_get_affinity_mask(data));
>   
> -	return IRQ_SET_MASK_OK;
> +		msg->address_lo = zdev->msi_addr & 0xff0000ff;
> +		msg->address_lo |= (smp_cpu_get_cpu_address(cpu) << 8);
> +	} else {
> +		msg->address_lo = zdev->msi_addr & 0xffffffff;
> +	}
> +	msg->address_hi = zdev->msi_addr >> 32;
> +	msg->data = data->hwirq & 0xffffffff;
>   }
>   
>   static struct irq_chip zpci_irq_chip = {
>   	.name = "PCI-MSI",
>   	.irq_unmask = pci_msi_unmask_irq,
>   	.irq_mask = pci_msi_mask_irq,
> +	.irq_compose_msi_msg = zpci_compose_msi_msg
>   };
>   
>   static void zpci_handle_cpu_local_irq(bool rescan)
>   {
>   	struct airq_iv *dibv = zpci_ibv[smp_processor_id()];
>   	union zpci_sic_iib iib = {{0}};
> +	irq_hw_number_t hwirq;
>   	unsigned long bit;
>   	int irqs_on = 0;
>   
> @@ -164,7 +166,8 @@ static void zpci_handle_cpu_local_irq(bool rescan)
>   			continue;
>   		}
>   		inc_irq_stat(IRQIO_MSI);
> -		generic_handle_irq(airq_iv_get_data(dibv, bit));
> +		hwirq = airq_iv_get_ptr(dibv, bit);
> +		generic_handle_domain_irq(zpci_msi_parent_domain, hwirq);
>   	}
>   }
>   
> @@ -229,6 +232,7 @@ static void zpci_floating_irq_handler(struct airq_struct *airq,
>   				      struct tpi_info *tpi_info)
>   {
>   	union zpci_sic_iib iib = {{0}};
> +	irq_hw_number_t hwirq;
>   	unsigned long si, ai;
>   	struct airq_iv *aibv;
>   	int irqs_on = 0;
> @@ -256,7 +260,9 @@ static void zpci_floating_irq_handler(struct airq_struct *airq,
>   				break;
>   			inc_irq_stat(IRQIO_MSI);
>   			airq_iv_lock(aibv, ai);
> -			generic_handle_irq(airq_iv_get_data(aibv, ai));
> +
> +			hwirq = airq_iv_get_ptr(aibv, ai);
> +			generic_handle_domain_irq(zpci_msi_parent_domain, hwirq);
>   			airq_iv_unlock(aibv, ai);
>   		}
>   	}
> @@ -278,7 +284,7 @@ static int __alloc_airq(struct zpci_dev *zdev, int msi_vecs,
>   		zdev->aisb = *bit;
>   
>   		/* Create adapter interrupt vector */
> -		zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA | AIRQ_IV_BITLOCK, NULL);
> +		zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_PTR | AIRQ_IV_BITLOCK, NULL);
>   		if (!zdev->aibv)
>   			return -ENOMEM;
>   
> @@ -290,146 +296,203 @@ static int __alloc_airq(struct zpci_dev *zdev, int msi_vecs,
>   	return 0;
>   }
>   
> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +static struct airq_struct zpci_airq = {
> +	.handler = zpci_floating_irq_handler,
> +	.isc = PCI_ISC,
> +};
> +
> +/*
> + * Encode the hwirq number for the parent domain. The encoding must be unique
> + * for each IRQ of each device in the parent domain, so it uses the fid to
> + * identify the device and the msi_index to identify the IRQ within that device.
> + */
> +static inline irq_hw_number_t zpci_encode_hwirq(u32 fid, u16 msi_index)
>   {
> -	unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
> -	struct zpci_dev *zdev = to_zpci(pdev);
> -	struct msi_desc *msi;
> -	struct msi_msg msg;
> -	unsigned long bit;
> -	int cpu_addr;
> -	int rc, irq;
> +	return ((irq_hw_number_t)fid << 32) | msi_index;
> +}
>   
> -	zdev->aisb = -1UL;
> -	zdev->msi_first_bit = -1U;
> +static inline u16 zpci_decode_hwirq_msi_index(irq_hw_number_t irq)
> +{
> +	return irq & 0xFFFF;
> +}
> +
> +static int zpci_msi_prepare(struct irq_domain *domain,
> +			    struct device *dev, int nvec,
> +			    msi_alloc_info_t *info)
> +{
> +	struct zpci_dev *zdev = to_zpci_dev(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	unsigned long bit;
> +	int msi_vecs, rc;
>   
>   	msi_vecs = min_t(unsigned int, nvec, zdev->max_msi);
> -	if (msi_vecs < nvec) {
> -		pr_info("%s requested %d irqs, allocate system limit of %d",
> +	if (msi_vecs < nvec)
> +		pr_info("%s requested %d IRQs, allocate system limit of %d",
>   			pci_name(pdev), nvec, zdev->max_msi);
> -	}
>   
>   	rc = __alloc_airq(zdev, msi_vecs, &bit);
> -	if (rc < 0)
> +	if (rc) {
> +		pr_err("Allocating adapter IRQs for %s failed\n", pci_name(pdev));
>   		return rc;
> +	}
>   
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
> -	hwirq = bit;
> -	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
> -		if (hwirq - bit >= msi_vecs)
> -			break;
> -		irqs_per_msi = min_t(unsigned int, msi_vecs, msi->nvec_used);
> -		irq = __irq_alloc_descs(-1, 0, irqs_per_msi, 0, THIS_MODULE,
> -					(irq_delivery == DIRECTED) ?
> -					msi->affinity : NULL);
> -		if (irq < 0)
> -			return -ENOMEM;
> -
> -		for (i = 0; i < irqs_per_msi; i++) {
> -			rc = irq_set_msi_desc_off(irq, i, msi);
> -			if (rc)
> -				return rc;
> -			irq_set_chip_and_handler(irq + i, &zpci_irq_chip,
> -						 handle_percpu_irq);
> -		}
> -
> -		msg.data = hwirq - bit;
> +	zdev->msi_first_bit = bit;
> +	zdev->msi_nr_irqs = msi_vecs;
> +	rc = zpci_set_irq(zdev);
> +	if (rc) {
> +		pr_err("Registering adapter IRQs for %s failed\n",
> +		       pci_name(pdev));
>   		if (irq_delivery == DIRECTED) {
> -			if (msi->affinity)
> -				cpu = cpumask_first(&msi->affinity->mask);
> -			else
> -				cpu = 0;
> -			cpu_addr = smp_cpu_get_cpu_address(cpu);
> -
> -			msg.address_lo = zdev->msi_addr & 0xff0000ff;
> -			msg.address_lo |= (cpu_addr << 8);
> -
> -			for_each_possible_cpu(cpu) {
> -				for (i = 0; i < irqs_per_msi; i++)
> -					airq_iv_set_data(zpci_ibv[cpu],
> -							 hwirq + i, irq + i);
> -			}
> +			airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, msi_vecs);
>   		} else {
> -			msg.address_lo = zdev->msi_addr & 0xffffffff;
> -			for (i = 0; i < irqs_per_msi; i++)
> -				airq_iv_set_data(zdev->aibv, hwirq + i, irq + i);
> +			zpci_clear_airq(zdev);
> +			airq_iv_release(zdev->aibv);
> +			zdev->aibv = NULL;
> +			airq_iv_free_bit(zpci_sbv, zdev->aisb);
> +			zdev->aisb = -1UL;
>   		}
> -		msg.address_hi = zdev->msi_addr >> 32;
> -		pci_write_msi_msg(irq, &msg);
> -		hwirq += irqs_per_msi;
> +		zdev->msi_first_bit = -1U;
> +		return rc;
>   	}
>   
> -	zdev->msi_first_bit = bit;
> -	zdev->msi_nr_irqs = hwirq - bit;
> +	return 0;
> +}
>   
> -	rc = zpci_set_irq(zdev);
> -	if (rc)
> -		return rc;
> +static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
> +{
> +	zpci_clear_directed_irq(zdev);
> +	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->max_msi);
> +	zdev->msi_first_bit = -1U;
> +}
>   
> -	return (zdev->msi_nr_irqs == nvec) ? 0 : zdev->msi_nr_irqs;
> +static void zpci_msi_teardown_floating(struct zpci_dev *zdev)
> +{
> +	zpci_clear_airq(zdev);
> +	airq_iv_release(zdev->aibv);
> +	zdev->aibv = NULL;
> +	airq_iv_free_bit(zpci_sbv, zdev->aisb);
> +	zdev->aisb = -1UL;
> +	zdev->msi_first_bit = -1U;
>   }
>   
> -void arch_teardown_msi_irqs(struct pci_dev *pdev)
> +static void zpci_msi_teardown(struct irq_domain *domain, msi_alloc_info_t *arg)
>   {
> -	struct zpci_dev *zdev = to_zpci(pdev);
> -	struct msi_desc *msi;
> -	unsigned int i;
> -	int rc;
> +	struct zpci_dev *zdev = to_zpci_dev(domain->dev);
>   
> -	/* Disable interrupts */
> -	rc = zpci_clear_irq(zdev);
> -	if (rc)
> -		return;
> +	if (irq_delivery == DIRECTED)
> +		zpci_msi_teardown_directed(zdev);
> +	else
> +		zpci_msi_teardown_floating(zdev);
> +}
>   
> -	/* Release MSI interrupts */
> -	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
> -		for (i = 0; i < msi->nvec_used; i++) {
> -			irq_set_msi_desc(msi->irq + i, NULL);
> -			irq_free_desc(msi->irq + i);
> +static int zpci_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				 unsigned int nr_irqs, void *args)
> +{
> +	struct msi_desc *desc = ((msi_alloc_info_t *)args)->desc;
> +	struct zpci_dev *zdev = to_zpci_dev(desc->dev);
> +	irq_hw_number_t hwirq;
> +	unsigned long bit;
> +	unsigned int cpu;
> +	int i;
> +
> +	bit = zdev->msi_first_bit + desc->msi_index;
> +	hwirq = zpci_encode_hwirq(zdev->fid, desc->msi_index);
> +
> +	if (desc->msi_index + nr_irqs > zdev->max_msi)
> +		return -EINVAL;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &zpci_irq_chip, zdev,
> +				    handle_percpu_irq, NULL, NULL);
> +
> +		if (irq_delivery == DIRECTED) {
> +			for_each_possible_cpu(cpu) {
> +				airq_iv_set_ptr(zpci_ibv[cpu],
> +						bit + i, hwirq + i);
> +				}
> +
> +		} else {
> +			airq_iv_set_ptr(zdev->aibv, bit + i, hwirq + i);
>   		}
> -		msi->msg.address_lo = 0;
> -		msi->msg.address_hi = 0;
> -		msi->msg.data = 0;
> -		msi->irq = 0;
>   	}
>   
> -	if (zdev->aisb != -1UL) {
> -		zpci_ibv[zdev->aisb] = NULL;
> -		airq_iv_free_bit(zpci_sbv, zdev->aisb);
> -		zdev->aisb = -1UL;
> -	}
> -	if (zdev->aibv) {
> -		airq_iv_release(zdev->aibv);
> -		zdev->aibv = NULL;
> -	}
> +	return 0;
> +}
>   
> -	if ((irq_delivery == DIRECTED) && zdev->msi_first_bit != -1U)
> -		airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
> +static void zpci_msi_domain_free(struct irq_domain *domain, unsigned int virq,
> +				 unsigned int nr_irqs)
> +{
> +	irq_hw_number_t hwirq;
> +	struct irq_data *d;
> +	u16 msi_index;
> +	int i;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		d = irq_domain_get_irq_data(domain, virq + i);
> +		hwirq = d->hwirq;
> +		msi_index = zpci_decode_hwirq_msi_index(hwirq);
> +		irq_domain_reset_irq_data(d);
> +	}
>   }
>   
> -bool arch_restore_msi_irqs(struct pci_dev *pdev)

Why are we removing arch_restore_msi_irqs? This is called in the path 
for restoring the MSI/MSI-X state of the device 
(pci_restore_msi_state()). It looks like irqdomain infrastructure will 
not setup airq for the device in the restore path.


> +static const struct irq_domain_ops zpci_msi_domain_ops = {
> +	.alloc = zpci_msi_domain_alloc,
> +	.free  = zpci_msi_domain_free
> +};
> +
> +static bool zpci_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> +				   struct irq_domain *real_parent,
> +				   struct msi_domain_info *info)
>   {
> -	struct zpci_dev *zdev = to_zpci(pdev);
> +	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> +		return false;
> +
> +	info->ops->msi_prepare = zpci_msi_prepare;
> +	info->ops->msi_teardown = zpci_msi_teardown;
>   
> -	zpci_set_irq(zdev);
>   	return true;
>   }
>   
> -static struct airq_struct zpci_airq = {
> -	.handler = zpci_floating_irq_handler,
> -	.isc = PCI_ISC,
> +static struct msi_parent_ops zpci_msi_parent_ops = {
> +	.supported_flags   = MSI_GENERIC_FLAGS_MASK	|
> +			     MSI_FLAG_PCI_MSIX		|
> +			     MSI_FLAG_MULTI_PCI_MSI,
> +	.required_flags	   = MSI_FLAG_USE_DEF_DOM_OPS  |
> +			     MSI_FLAG_USE_DEF_CHIP_OPS |
> +			     MSI_FLAG_PCI_MSI_MASK_PARENT,
> +	.init_dev_msi_info = zpci_init_dev_msi_info
>   };
>   
> +static int __init zpci_create_parent_msi_domain(void)
> +{
> +	struct irq_domain_info info = {
> +		.fwnode		= irq_domain_alloc_named_fwnode("zpci_msi"),
> +		.ops		= &zpci_msi_domain_ops
> +	};
> +
> +	if (!info.fwnode) {
> +		pr_err("Failed to allocate fwnode for MSI IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (irq_delivery == FLOATING)
> +		zpci_msi_parent_ops.required_flags |= MSI_FLAG_NO_AFFINITY;
> +	zpci_msi_parent_domain = msi_create_parent_irq_domain(&info, &zpci_msi_parent_ops);
> +	if (!zpci_msi_parent_domain) {
> +		irq_domain_free_fwnode(info.fwnode);
> +		pr_err("Failed to create MSI IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +void zpci_set_msi_parent_domain(struct zpci_bus *zbus)
> +{
> +	dev_set_msi_domain(&zbus->bus->dev, zpci_msi_parent_domain);
> +}
> +
>   static void __init cpu_enable_directed_irq(void *unused)
>   {
>   	union zpci_sic_iib iib = {{0}};
> @@ -466,7 +529,7 @@ static int __init zpci_directed_irq_init(void)
>   		 * is only done on the first vector.
>   		 */
>   		zpci_ibv[cpu] = airq_iv_create(cache_line_size() * BITS_PER_BYTE,
> -					       AIRQ_IV_DATA |
> +					       AIRQ_IV_PTR |
>   					       AIRQ_IV_CACHELINE |
>   					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);
>   		if (!zpci_ibv[cpu])
> @@ -511,6 +574,11 @@ int __init zpci_irq_init(void)
>   	rc = register_adapter_interrupt(&zpci_airq);
>   	if (rc)
>   		goto out;
> +
> +	zpci_create_parent_msi_domain();
> +	if (!zpci_msi_parent_domain)
> +		goto out_airq;
> +
>   	/* Set summary to 1 to be called every time for the ISC. */
>   	*zpci_airq.lsi_ptr = 1;
>   
> @@ -524,7 +592,7 @@ int __init zpci_irq_init(void)
>   	}
>   
>   	if (rc)
> -		goto out_airq;
> +		goto out_msi_domain;
>   
>   	/*
>   	 * Enable floating IRQs (with suppression after one IRQ). When using
> @@ -533,6 +601,8 @@ int __init zpci_irq_init(void)
>   	zpci_set_irq_ctrl(SIC_IRQ_MODE_SINGLE, PCI_ISC, &iib);
>   
>   	return 0;
> +out_msi_domain:
> +	irq_domain_remove(zpci_msi_parent_domain);

Shouldn't this also do a irq_domain_free_fwnode?

Thanks

Farhan

>   out_airq:
>   	unregister_adapter_interrupt(&zpci_airq);
>   out:
> @@ -541,6 +611,7 @@ int __init zpci_irq_init(void)
>   
>   void __init zpci_irq_exit(void)
>   {
> +	struct fwnode_handle *fn;
>   	unsigned int cpu;
>   
>   	if (irq_delivery == DIRECTED) {
> @@ -549,6 +620,10 @@ void __init zpci_irq_exit(void)
>   		}
>   	}
>   	kfree(zpci_ibv);
> +	fn = zpci_msi_parent_domain->fwnode;
> +	irq_domain_remove(zpci_msi_parent_domain);
> +	irq_domain_free_fwnode(fn);
> +
>   	if (zpci_sbv)
>   		airq_iv_release(zpci_sbv);
>   	unregister_adapter_interrupt(&zpci_airq);
>
