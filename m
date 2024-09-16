Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C9158DB9;
	Mon, 16 Sep 2024 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502064; cv=none; b=LHQ5mOmokaDcvJnu414XVzamXd5GqZW4HpBGP25JRIzfUkIfw6EzoeVZ3ZVcIn9mJV6TLVvcxUsCq1KkIcMcl+ECcvEVwGALdRBp9JJwMUXoUt5QZbfpblJwHKiRL6OGJZaNwvawCmqJo2m+zUNMD2djYEeP1cz75zzzN87HAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502064; c=relaxed/simple;
	bh=pj4nO8M9/zqKQUo6iwmUIIeCcIS6vn38pTu+H8zW/Rw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVrHjmyQ5Xw0ej0PKg/TERCjaFlluBbJNwSGRYQWPFB9OYsKF6i6FVXkt7sB7UAC7VNZ602RGs3NJM4rNcpDux1EV9Xa01CbfnKOXfMQ3DAn0mcpA3jhIn8erUkyKtmhxU4Krb/cO4XyNNlR6Bu8ePtPveQfCOc7e5jlRUggL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WQPalHz2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WQPalHz2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCbcKK008931;
	Mon, 16 Sep 2024 15:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	+1/iU5JB0W3zG/2RHRZyL77/sORNzhX3vUAlVJXyzbU=; b=WQPalHz2EtZoFDM2
	yNqkZ0zwbKW7HssVBBKGW0EbmWtF9Ez9iRS3D2ANLTw8NPUF3oR1Z4xiLa3381Hh
	oAHttnMAx0lVq2zJDs4osCYojvL69vJpqCnmxDjqTyq1gsn0KuUgRA1LTMXwf/fj
	iUDLWQSFciSy1yoshyr0dgmKclAYrhx0/E+xHAlS1yAiBGWUOj/2Tu4hYkArDE8m
	QaXOHvT/K3x53a0MmkKOvn72gIoqRpSl0qqEkOt9500ccFe9FZFMgX2TtZs2kLqt
	IydqUVtRLDSGpTmYgRasX/57OkHZasXb6kxIfvdb+/Jv15GtcbQCU7bzWh5AJhPN
	iav1FQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vnjq0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 15:54:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48GEus98030642;
	Mon, 16 Sep 2024 15:54:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41npan0698-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 15:54:02 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48GFs0rb12059202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 15:54:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 906EA58059;
	Mon, 16 Sep 2024 15:54:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEEFD58053;
	Mon, 16 Sep 2024 15:53:57 +0000 (GMT)
Received: from oc-fedora.boeblingen.de.ibm.com (unknown [9.152.212.119])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Sep 2024 15:53:57 +0000 (GMT)
Message-ID: <27ba11cf6cb60c7a0056a00e71f22a3ea1e61714.camel@linux.ibm.com>
Subject: Re: [PATCH v4] iommu/s390: Implement blocking domain
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, gerald.schaefer@linux.ibm.com
Cc: jgg@ziepe.ca, baolu.lu@linux.intel.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        jroedel@suse.de, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Date: Mon, 16 Sep 2024 17:53:57 +0200
In-Reply-To: <20240910211516.137933-1-mjrosato@linux.ibm.com>
References: <20240910211516.137933-1-mjrosato@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 21Qtgwd_VkHn9EwJ_lHjyEdWhNV8cl1I
X-Proofpoint-GUID: 21Qtgwd_VkHn9EwJ_lHjyEdWhNV8cl1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_12,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160103

On Tue, 2024-09-10 at 17:15 -0400, Matthew Rosato wrote:
> This fixes a crash when surprise hot-unplugging a PCI device. This crash
> happens because during hot-unplug __iommu_group_set_domain_nofail()
> attaching the default domain fails when the platform no longer
> recognizes the device as it has already been removed and we end up with

Just to clarify my original wording here based on Jason's comments. The
device is already removed from the point of view of the platform
hypervisor not from the point of view of Linux that's why I phrased it
as the platform no longer recognizing it.

> a NULL domain pointer and UAF. This is exactly the case referred to in
> the second comment in __iommu_device_set_domain() and just as stated
> there if we can instead attach the blocking domain the UAF is prevented
> as this can handle the already removed device. Implement the blocking
> domain to use this handling.  With this change, the crash is fixed but
> we still hit a warning attempting to change DMA ownership on a blocked
> device.
>=20
> Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
> Co-developed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> Changes for v4:
> - fix lockdep assert
> Changes for v3:
> - make blocking_domain type iommu_domain
> - change zdev->s390_domain to type iommu_domain and remove most uses
> - remove s390_iommu_detach_device, use blocking domain attach
> - add spinlock to serialize zdev->s390_domain change / access to counters
> ---
>  arch/s390/include/asm/pci.h |  4 +-
>  arch/s390/pci/pci.c         |  3 ++
>  arch/s390/pci/pci_debug.c   | 10 ++++-
>  drivers/iommu/s390-iommu.c  | 73 +++++++++++++++++++++++--------------
>  4 files changed, 59 insertions(+), 31 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 30820a649e6e..a60a291fbd58 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -96,7 +96,6 @@ struct zpci_bar_struct {
>  	u8		size;		/* order 2 exponent */
>  };
> =20
> -struct s390_domain;
>  struct kvm_zdev;
> =20
>  #define ZPCI_FUNCTIONS_PER_BUS 256
> @@ -181,9 +180,10 @@ struct zpci_dev {
>  	struct dentry	*debugfs_dev;
> =20
>  	/* IOMMU and passthrough */
> -	struct s390_domain *s390_domain; /* s390 IOMMU domain data */
> +	struct iommu_domain *s390_domain; /* attached IOMMU domain */
>  	struct kvm_zdev *kzdev;
>  	struct mutex kzdev_lock;
> +	spinlock_t dom_lock;		/* protect s390_domain change */
>  };
> =20
>=20
---8<---
> =20
> +static struct iommu_domain blocking_domain;
> +

I originally looked at using struct iommu_domain for the blocking
domain when I started on this as well but got scared away by having to
change it in more places. Turns out it's not actually that bad. And as
Jason said this better matches the other IOMMU drivers and overall
design.

>  static inline unsigned int calc_rtx(dma_addr_t ptr)
>  {
>  	return ((unsigned long)ptr >> ZPCI_RT_SHIFT) & ZPCI_INDEX_MASK;
> @@ -369,20 +371,36 @@ static void s390_domain_free(struct iommu_domain *d=
omain)
>  	call_rcu(&s390_domain->rcu, s390_iommu_rcu_free_domain);
>  }
> =20
> -static void s390_iommu_detach_device(struct iommu_domain *domain,
> -				     struct device *dev)
> +static void zdev_s390_domain_update(struct zpci_dev *zdev,
> +				    struct iommu_domain *domain)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&zdev->dom_lock, flags);
> +	zdev->s390_domain =3D domain;
> +	spin_unlock_irqrestore(&zdev->dom_lock, flags);
> +}
> +
> +static int blocking_domain_attach_device(struct iommu_domain *domain,
> +					 struct device *dev)
>  {
> -	struct s390_domain *s390_domain =3D to_s390_domain(domain);
>  	struct zpci_dev *zdev =3D to_zpci_dev(dev);
> +	struct s390_domain *s390_domain;
>  	unsigned long flags;
> =20
> +	if (zdev->s390_domain->type =3D=3D IOMMU_DOMAIN_BLOCKED)
> +		return 0;
> +
> +	s390_domain =3D to_s390_domain(zdev->s390_domain);
>  	spin_lock_irqsave(&s390_domain->list_lock, flags);
>  	list_del_rcu(&zdev->iommu_list);
>  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> =20
>  	zpci_unregister_ioat(zdev, 0);
> -	zdev->s390_domain =3D NULL;
>  	zdev->dma_table =3D NULL;
> +	zdev_s390_domain_update(zdev, domain);
> +
> +	return 0;
>  }

I like that we get rid of s390_iommu_detach_device() really makes it
simpler to think of the DMA as blocked rather than no IOMMU being
attached.

> =20
>  static int s390_iommu_attach_device(struct iommu_domain *domain,
> @@ -401,20 +419,15 @@ static int s390_iommu_attach_device(struct iommu_do=
main *domain,
>  		domain->geometry.aperture_end < zdev->start_dma))
>  		return -EINVAL;
> =20
> -	if (zdev->s390_domain)
> -		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
> +	blocking_domain_attach_device(&blocking_domain, dev);
> =20
> +	/* If we fail now DMA remains blocked via blocking domain */
>  	cc =3D zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
>  				virt_to_phys(s390_domain->dma_table), &status);
> -	/*
> -	 * If the device is undergoing error recovery the reset code
> -	 * will re-establish the new domain.
> -	 */
>  	if (cc && status !=3D ZPCI_PCI_ST_FUNC_NOT_AVAIL)
>  		return -EIO;
> -
>  	zdev->dma_table =3D s390_domain->dma_table;
> -	zdev->s390_domain =3D s390_domain;
> +	zdev_s390_domain_update(zdev, domain);
> =20
>  	spin_lock_irqsave(&s390_domain->list_lock, flags);
>  	list_add_rcu(&zdev->iommu_list, &s390_domain->devices);
> @@ -466,19 +479,11 @@ static struct iommu_device *s390_iommu_probe_device=
(struct device *dev)
>  	if (zdev->tlb_refresh)
>  		dev->iommu->shadow_on_flush =3D 1;
> =20
> -	return &zdev->iommu_dev;
> -}
> +	/* Start with DMA blocked */
> +	spin_lock_init(&zdev->dom_lock);
> +	zdev_s390_domain_update(zdev, &blocking_domain);

Thanks for incorporating this suggestion from Jason, makes sense to
start out as blocked especially since that matches the platform
behavior too.

> =20
> -static void s390_iommu_release_device(struct device *dev)
> -{
> -	struct zpci_dev *zdev =3D to_zpci_dev(dev);
> -
> -	/*
> -	 * release_device is expected to detach any domain currently attached
> -	 * to the device, but keep it attached to other devices in the group.
> -	 */
> -	if (zdev)
> -		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
> +	return &zdev->iommu_dev;
>  }
> =20
>  static int zpci_refresh_all(struct zpci_dev *zdev)
> @@ -697,9 +702,15 @@ static size_t s390_iommu_unmap_pages(struct iommu_do=
main *domain,
> =20
>  struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
>  {
> -	if (!zdev || !zdev->s390_domain)
> +	struct s390_domain *s390_domain;
> +
> +	lockdep_assert_held(&zdev->dom_lock);
> +
> +	if (zdev->s390_domain->type =3D=3D IOMMU_DOMAIN_BLOCKED)
>  		return NULL;
> -	return &zdev->s390_domain->ctrs;
> +
> +	s390_domain =3D to_s390_domain(zdev->s390_domain);
> +	return &s390_domain->ctrs;
>  }
> =20
>  int zpci_init_iommu(struct zpci_dev *zdev)
> @@ -776,11 +787,19 @@ static int __init s390_iommu_init(void)
>  }
>  subsys_initcall(s390_iommu_init);
> =20
> +static struct iommu_domain blocking_domain =3D {
> +	.type =3D IOMMU_DOMAIN_BLOCKED,
> +	.ops =3D &(const struct iommu_domain_ops) {
> +		.attach_dev	=3D blocking_domain_attach_device,
> +	}
> +};
> +
>  static const struct iommu_ops s390_iommu_ops =3D {
> +	.blocked_domain		=3D &blocking_domain,
> +	.release_domain		=3D &blocking_domain,
>  	.capable =3D s390_iommu_capable,
>  	.domain_alloc_paging =3D s390_domain_alloc_paging,
>  	.probe_device =3D s390_iommu_probe_device,
> -	.release_device =3D s390_iommu_release_device,
>  	.device_group =3D generic_device_group,
>  	.pgsize_bitmap =3D SZ_4K,
>  	.get_resv_regions =3D s390_iommu_get_resv_regions,

Thanks for taking care of the suggestions I agree these are all useful
improvements over my original patch.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
