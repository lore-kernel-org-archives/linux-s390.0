Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40208 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgDHMXV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 08:23:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200408122318euoutp026002cbe86291540b4dd9b04fe5d9dbdc~D16UmSfZQ2570625706euoutp02M
        for <linux-s390@vger.kernel.org>; Wed,  8 Apr 2020 12:23:18 +0000 (GMT)
Subject: Re: [RFC PATCH 31/34] iommu/exynos: Create iommu_device in struct
 exynos_iommu_owner
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <449e7f16-e719-9617-ec92-63b82c0bc33f@samsung.com>
Date: Wed, 8 Apr 2020 14:23:16 +0200
MIME-Version: 1.0
In-Reply-To: <20200407183742.4344-32-joro@8bytes.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
References: <20200407183742.4344-1-joro@8bytes.org>
        <CGME20200407184501eucas1p25407bc96e4345df406cf6ba061ae6a82@eucas1p2.samsung.com>
        <20200407183742.4344-32-joro@8bytes.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

Hi Joerg,

On 07.04.2020 20:37, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> The 'struct exynos_iommu_owner' is an umbrella for multiple SYSMMU
> instances attached to one master. As such all these instances are
> handled the same, they are all configured with the same iommu_domain,
> for example.
>
> The IOMMU core code expects each device to have only one IOMMU
> attached, so create the IOMMU-device for the umbrella instead of each
> hardware SYSMMU.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/exynos-iommu.c | 96 +++++++++++++++++++++++++++---------
>   1 file changed, 73 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 186ff5cc975c..86ecccbf0438 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -235,6 +235,8 @@ struct exynos_iommu_owner {
>   	struct list_head controllers;	/* list of sysmmu_drvdata.owner_node */
>   	struct iommu_domain *domain;	/* domain this device is attached */
>   	struct mutex rpm_lock;		/* for runtime pm of all sysmmus */
> +
> +	struct iommu_device iommu;	/* IOMMU core handle */
>   };
>   
>   /*
> @@ -274,8 +276,6 @@ struct sysmmu_drvdata {
>   	struct list_head owner_node;	/* node for owner controllers list */
>   	phys_addr_t pgtable;		/* assigned page table structure */
>   	unsigned int version;		/* our version */
> -
> -	struct iommu_device iommu;	/* IOMMU core handle */
>   };
>   
>   static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> @@ -625,18 +625,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   	data->sysmmu = dev;
>   	spin_lock_init(&data->lock);
>   
> -	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
> -				     dev_name(data->sysmmu));
> -	if (ret)
> -		return ret;
> -
> -	iommu_device_set_ops(&data->iommu, &exynos_iommu_ops);
> -	iommu_device_set_fwnode(&data->iommu, &dev->of_node->fwnode);

The iommu_device_set_fwnode() call is lost during this conversion, what breaks driver operation. Most of the above IOMMU fw calls you have moved to xlate function. I've checked briefly but it looks that there is a chicken-egg problem here. The owner structure is allocated and initialized from of_xlate(), which won't be called without linking the problem iommu structure with the fwnode first, what might be done only in sysmmu_probe(). I will check how to handle this in a different way.

> -
> -	ret = iommu_device_register(&data->iommu);
> -	if (ret)
> -		return ret;
> -
>   	platform_set_drvdata(pdev, data);
>   
>   	__sysmmu_get_version(data);
> @@ -1261,6 +1249,8 @@ static int exynos_iommu_add_device(struct device *dev)
>   	}
>   	iommu_group_put(group);
>   
> +	iommu_device_link(&owner->iommu, dev);
> +
>   	return 0;
>   }
>   
> @@ -1282,18 +1272,82 @@ static void exynos_iommu_remove_device(struct device *dev)
>   			iommu_group_put(group);
>   		}
>   	}
> +	iommu_device_unlink(&owner->iommu, dev);
>   	iommu_group_remove_device(dev);
>   
>   	list_for_each_entry(data, &owner->controllers, owner_node)
>   		device_link_del(data->link);
>   }
>   
> +static int exynos_iommu_device_init(struct exynos_iommu_owner *owner)
> +{
> +	static u32 counter = 0;
> +	int ret;
> +
> +	/*
> +	 * Create a virtual IOMMU device. In reality it is an umbrella for a
> +	 * number of SYSMMU platform devices, but that also means that any
> +	 * master can have more than one real IOMMU device. This drivers handles
> +	 * all the real devices for one master synchronously, so they appear as
> +	 * one anyway.
> +	 */
> +	ret = iommu_device_sysfs_add(&owner->iommu, NULL, NULL,
> +				     "sysmmu-owner-%d", counter++);
> +	if (ret)
> +		return ret;
> +
> +	iommu_device_set_ops(&owner->iommu, &exynos_iommu_ops);
> +
> +	return 0;
> +}
> +
> +static void exynos_iommu_device_remove(struct exynos_iommu_owner *owner)
> +{
> +	iommu_device_set_ops(&owner->iommu, NULL);
> +	iommu_device_sysfs_remove(&owner->iommu);
> +}
> +
> +static int exynos_owner_init(struct device *dev)
> +{
> +	struct exynos_iommu_owner *owner = dev->archdata.iommu;
> +	int ret;
> +
> +	if (owner)
> +		return 0;
> +
> +	owner = kzalloc(sizeof(*owner), GFP_KERNEL);
> +	if (!owner)
> +		return -ENOMEM;
> +
> +	ret = exynos_iommu_device_init(owner);
> +	if (ret)
> +		goto out_free_owner;
> +
> +	ret = iommu_device_register(&owner->iommu);
> +	if (ret)
> +		goto out_remove_iommu_device;
> +
> +	INIT_LIST_HEAD(&owner->controllers);
> +	mutex_init(&owner->rpm_lock);
> +	dev->archdata.iommu = owner;
> +
> +	return 0;
> +
> +out_remove_iommu_device:
> +	exynos_iommu_device_remove(owner);
> +out_free_owner:
> +	kfree(owner);
> +
> +	return ret;
> +}
> +
>   static int exynos_iommu_of_xlate(struct device *dev,
>   				 struct of_phandle_args *spec)
>   {
> -	struct exynos_iommu_owner *owner = dev->archdata.iommu;
>   	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
>   	struct sysmmu_drvdata *data, *entry;
> +	struct exynos_iommu_owner *owner;
> +	int ret;
>   
>   	if (!sysmmu)
>   		return -ENODEV;
> @@ -1302,15 +1356,11 @@ static int exynos_iommu_of_xlate(struct device *dev,
>   	if (!data)
>   		return -ENODEV;
>   
> -	if (!owner) {
> -		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
> -		if (!owner)
> -			return -ENOMEM;
> +	ret = exynos_owner_init(dev);
> +	if (ret)
> +		return ret;
>   
> -		INIT_LIST_HEAD(&owner->controllers);
> -		mutex_init(&owner->rpm_lock);
> -		dev->archdata.iommu = owner;
> -	}
> +	owner = dev->archdata.iommu;
>   
>   	list_for_each_entry(entry, &owner->controllers, owner_node)
>   		if (entry == data)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
