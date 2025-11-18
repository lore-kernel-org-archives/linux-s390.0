Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688173702EE;
	Tue, 18 Nov 2025 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502560; cv=none; b=NC7I7dOiGPgwgwYfIUocXAXPHOQPKrepHwvLdB99b/dTahnw9N/eLjKYEIqUcQB3gTg1CtOe5HjBqYQxHGM/x3UrZ6JDDp2VbbkqZb1GGVvI0olDwBfXIr4H7Qj80edzCNbbaBP/YTM5cVD05x8FoVjhy3OPCL5wXgwdfITb+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502560; c=relaxed/simple;
	bh=sFjCZMCr6cypKt6hP6rTlxN2dKEta0TZFzH6izJKsaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGP2qNpNJ+D6W2YrmTxXE3v8SvnrC6mbKtDNCBbJ/Gs5P/C1gpQe3OfaNE9EbejOLT0ZY+btaesk6EEqVxGt7Z8wpmHEj+3yiwnVVl9wfPbP0X4vBONjgD63XJ4lsjibvi6aO4gsmysWcbMgMsDPp2Py3nVUG0esX9C6zZjqZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PuoHsD7q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PuoHsD7q"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIBvr7e011829;
	Tue, 18 Nov 2025 21:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9RwfM+
	YFsh9J9zZrPBhh57ES0vhurjdj4MJOTqFMNcg=; b=PuoHsD7qR0Jab0e6ltKGrG
	f5CajaR0/9V0fmGscn1adf7YQmJmfgIeWU1Yckp21FFC6pUkzpDhJqmAUaStQLHV
	70oh3SV/oiYprFzqCsjc78Xe7BBDWKgwVBnNXTTK+CLbzlDgyxzefH83SkbWksC1
	UskuA1CyCY0qaAzt7NOLVRdDKRJ1/KW/byKjtxA0Kpv5k7sZ6p19JqWupf8cRZVJ
	W7HW3FMREM4k3tEWD1e8cgGJlu9H38Wyii0iwmCHl4n2+cLkesXPAKIubszGIwVe
	BymztWaCdbEDDtd/VmnYttCv9GvaX7lOUDkXxuEJtjHuiziVd4BeNU2RuXWRJmgg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1dby5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 21:49:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIILj7J010448;
	Tue, 18 Nov 2025 21:49:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3us5hmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 21:49:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AILnBpb31916636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 21:49:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 999D75805D;
	Tue, 18 Nov 2025 21:49:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2AFC58056;
	Tue, 18 Nov 2025 21:49:10 +0000 (GMT)
Received: from [9.61.249.209] (unknown [9.61.249.209])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 21:49:10 +0000 (GMT)
Message-ID: <d16adbc5-600e-4260-abad-4a3e380dac6c@linux.ibm.com>
Date: Tue, 18 Nov 2025 13:49:09 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
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
References: <20251118-implement-msi-domain-v3-0-6fe8feb2a93f@linux.ibm.com>
 <20251118-implement-msi-domain-v3-2-6fe8feb2a93f@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251118-implement-msi-domain-v3-2-6fe8feb2a93f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691ce9d9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=0zg0yaFc_Ux_XDiXdBgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9B264ERfEpnowoLW_iYWamYMcKLIuD1L
X-Proofpoint-ORIG-GUID: 9B264ERfEpnowoLW_iYWamYMcKLIuD1L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX5HBbvQyu3p26
 KTfKg6+5s9HVefcFticsoYqBDd03LO7SouUL4ROjJUzpzTQaZHdbV00X+q43hds9K667l7lGpft
 eGUI7bYr3WSy8UfokPV5b1BRsBnXKmJeXqXZAc6I2qM6K3Zf+mk25i+gzvTj/BcGWQbvf71odBD
 sZFSL8zTr8PZjbxViXUKGz4P+Jc1+ESn1wc+J8C1LkfrVEbyZfeX6kw76/qU/gR7x96YWV64aPZ
 Y1qj3tlnnQ51MEevh5R1iJSzTw8HabI7ax7SSD8QijXMwb859+4uu8zz12mQdLMrUGd1PGxOYAr
 klQ+gkQ5ohRPND1IOwSGsLkUApmDmp+CMh/ZplmeAtkou9heID/c2qWxoped9hsUUPbS4+gj+b6
 fvFCaPcbQ5mdCTwFiVWK322vKrR3pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032


On 11/18/2025 8:13 AM, Tobias Schumacher wrote:
> s390 is one of the last architectures using the legacy API for setup and
> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
> to the MSI parent domain API. For details, see:
>
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>
> In detail, create an MSI parent domain for zpci which is used by
> all PCI devices.

I think this statement would need to be updated with the new approach of 
MSI parent domain per zpci domain?


> When a PCI device sets up MSI or MSI-X IRQs, the
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
>   arch/s390/include/asm/pci.h |   4 +
>   arch/s390/pci/pci_bus.c     |  11 ++
>   arch/s390/pci/pci_irq.c     | 334 +++++++++++++++++++++++++++-----------------
>   4 files changed, 225 insertions(+), 125 deletions(-)
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
> index a32f465ecf73a5cc3408a312d94ec888d62848cc..60abc84cf14fe6fb1ee149df688eea94f0983ed0 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -5,6 +5,7 @@
>   #include <linux/pci.h>
>   #include <linux/mutex.h>
>   #include <linux/iommu.h>
> +#include <linux/irqdomain.h>
>   #include <linux/pci_hotplug.h>
>   #include <asm/pci_clp.h>
>   #include <asm/pci_debug.h>
> @@ -109,6 +110,7 @@ struct zpci_bus {
>   	struct list_head	resources;
>   	struct list_head	bus_next;
>   	struct resource		bus_resource;
> +	struct irq_domain       *msi_parent_domain;
>   	int			topo;		/* TID if topo_is_tid, PCHID otherwise */
>   	int			domain_nr;
>   	u8			multifunction	: 1;
> @@ -310,6 +312,8 @@ int zpci_dma_exit_device(struct zpci_dev *zdev);
>   /* IRQ */
>   int __init zpci_irq_init(void);
>   void __init zpci_irq_exit(void);
> +int zpci_create_parent_msi_domain(struct zpci_bus *zbus);
> +void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
>   
>   /* FMB */
>   int zpci_fmb_enable_device(struct zpci_dev *);
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index be8c697fea0cc755cfdb4fb0a9e3b95183bec0dc..4849420d4f72c886edbe9c5e32cf0b1513d0b555 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -15,6 +15,7 @@
>   #include <linux/err.h>
>   #include <linux/delay.h>
>   #include <linux/seq_file.h>
> +#include <linux/irqdomain.h>
>   #include <linux/jump_label.h>
>   #include <linux/pci.h>
>   #include <linux/printk.h>
> @@ -190,6 +191,7 @@ static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, s
>   {
>   	struct pci_bus *bus;
>   	int domain;
> +	int rc;
>   
>   	domain = zpci_alloc_domain((u16)fr->uid);
>   	if (domain < 0)
> @@ -199,6 +201,12 @@ static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, s
>   	zbus->multifunction = zpci_bus_is_multifunction_root(fr);
>   	zbus->max_bus_speed = fr->max_bus_speed;
>   
> +	rc = zpci_create_parent_msi_domain(zbus);
> +	if (rc) {
> +		zpci_free_domain(zbus->domain_nr);
> +		return -EFAULT;
> +	}
> +
>   	/*
>   	 * Note that the zbus->resources are taken over and zbus->resources
>   	 * is empty after a successful call
> @@ -206,10 +214,12 @@ static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, s
>   	bus = pci_create_root_bus(NULL, ZPCI_BUS_NR, ops, zbus, &zbus->resources);
>   	if (!bus) {
>   		zpci_free_domain(zbus->domain_nr);
> +		zpci_remove_parent_msi_domain(zbus);
>   		return -EFAULT;
>   	}
>   

Nit: I wonder if it would be more readable if we used goto statements 
here and above.

<..snip..>

> +
> +/*
> + * Encode the hwirq number for the parent domain. The encoding must be unique
> + * for each IRQ of each device in the parent domain, so it uses the devfn to
> + * identify the device and the msi_index to identify the IRQ within that device.
> + */
> +static inline u32 zpci_encode_hwirq(u8 devfn, u16 msi_index)
> +{
> +	return (devfn << 16) | msi_index;

I see we have changed the encoding from using the fid to using the 
devfn, any reason for changing it? AFAIU the fid is unique for every 
function within the system.

Also thinking it out loud, is it this going to be unique if we have 
multiple IRQ (if nr_irqs in zpci_msi_domain_alloc() is > 1) per MSI 
descriptor, unless I missed something?

