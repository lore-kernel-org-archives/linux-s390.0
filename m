Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59404 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgDHOXI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 10:23:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200408142306euoutp02fa089e30a2d0f4c3dc2f8e862ebe487a~D3i7mu-Jg0817408174euoutp02i
        for <linux-s390@vger.kernel.org>; Wed,  8 Apr 2020 14:23:06 +0000 (GMT)
Subject: Re: [RFC PATCH 31/34] iommu/exynos: Create iommu_device in struct
 exynos_iommu_owner
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f59b0bb3-8c08-9cc9-bb1a-e69b7b226f60@samsung.com>
Date: Wed, 8 Apr 2020 16:23:05 +0200
MIME-Version: 1.0
In-Reply-To: <449e7f16-e719-9617-ec92-63b82c0bc33f@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
References: <20200407183742.4344-1-joro@8bytes.org>
        <CGME20200407184501eucas1p25407bc96e4345df406cf6ba061ae6a82@eucas1p2.samsung.com>
        <20200407183742.4344-32-joro@8bytes.org>
        <449e7f16-e719-9617-ec92-63b82c0bc33f@samsung.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

Hi again,

On 08.04.2020 14:23, Marek Szyprowski wrote:
> Hi Joerg,
>
> On 07.04.2020 20:37, Joerg Roedel wrote:
>> From: Joerg Roedel <jroedel@suse.de>
>>
>> The 'struct exynos_iommu_owner' is an umbrella for multiple SYSMMU
>> instances attached to one master. As such all these instances are
>> handled the same, they are all configured with the same iommu_domain,
>> for example.
>>
>> The IOMMU core code expects each device to have only one IOMMU
>> attached, so create the IOMMU-device for the umbrella instead of each
>> hardware SYSMMU.
>>
>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>> ---
>>   drivers/iommu/exynos-iommu.c | 96 +++++++++++++++++++++++++++---------
>>   1 file changed, 73 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index 186ff5cc975c..86ecccbf0438 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -235,6 +235,8 @@ struct exynos_iommu_owner {
>>       struct list_head controllers;    /* list of 
>> sysmmu_drvdata.owner_node */
>>       struct iommu_domain *domain;    /* domain this device is 
>> attached */
>>       struct mutex rpm_lock;        /* for runtime pm of all sysmmus */
>> +
>> +    struct iommu_device iommu;    /* IOMMU core handle */
>>   };
>>     /*
>> @@ -274,8 +276,6 @@ struct sysmmu_drvdata {
>>       struct list_head owner_node;    /* node for owner controllers 
>> list */
>>       phys_addr_t pgtable;        /* assigned page table structure */
>>       unsigned int version;        /* our version */
>> -
>> -    struct iommu_device iommu;    /* IOMMU core handle */
>>   };
>>     static struct exynos_iommu_domain *to_exynos_domain(struct 
>> iommu_domain *dom)
>> @@ -625,18 +625,6 @@ static int exynos_sysmmu_probe(struct 
>> platform_device *pdev)
>>       data->sysmmu = dev;
>>       spin_lock_init(&data->lock);
>>   -    ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
>> -                     dev_name(data->sysmmu));
>> -    if (ret)
>> -        return ret;
>> -
>> -    iommu_device_set_ops(&data->iommu, &exynos_iommu_ops);
>> -    iommu_device_set_fwnode(&data->iommu, &dev->of_node->fwnode);
>
> The iommu_device_set_fwnode() call is lost during this conversion, 
> what breaks driver operation. Most of the above IOMMU fw calls you 
> have moved to xlate function. I've checked briefly but it looks that 
> there is a chicken-egg problem here. The owner structure is allocated 
> and initialized from of_xlate(), which won't be called without linking 
> the problem iommu structure with the fwnode first, what might be done 
> only in sysmmu_probe(). I will check how to handle this in a different 
> way.

I've played with this a bit and it looks that won't be easy to make it 
working on ARM 32bit.

I need a place to initialize properly all the structures for the given 
master (IOMMU client device, the one which performs DMA operations).

I tried to move all the initialization from xlate() to device_probe(), 
but such approach doesn't work.

On ARM32bit exynos_iommu_device_probe() is called by the device core and 
IOMMU framework very early, before the Exynos SYSMMU platform devices 
(controllers) are probed yet. Even iommu class is not yet initialized 
that time, so returning anything successful from it causes following 
NULL ptr dereference:

Unable to handle kernel NULL pointer dereference at virtual address 0000004c
...

(__iommu_probe_device) from [<c055b334>] (iommu_probe_device+0x18/0x114)
(iommu_probe_device) from [<c055b4ac>] (iommu_bus_notifier+0x7c/0x94)
(iommu_bus_notifier) from [<c014e8ec>] (notifier_call_chain+0x44/0x84)
(notifier_call_chain) from [<c014e9ec>] 
(__blocking_notifier_call_chain+0x48/0x60)
(__blocking_notifier_call_chain) from [<c014ea1c>] 
(blocking_notifier_call_chain+0x18/0x20)
(blocking_notifier_call_chain) from [<c05c8d1c>] (device_add+0x3e8/0x704)
(device_add) from [<c07bafc4>] (of_platform_device_create_pdata+0x90/0xc4)
(of_platform_device_create_pdata) from [<c07bb138>] 
(of_platform_bus_create+0x134/0x48c)
(of_platform_bus_create) from [<c07bb1a4>] 
(of_platform_bus_create+0x1a0/0x48c)
(of_platform_bus_create) from [<c07bb63c>] (of_platform_populate+0x84/0x114)
(of_platform_populate) from [<c1125e9c>] 
(of_platform_default_populate_init+0x90/0xac)
(of_platform_default_populate_init) from [<c010326c>] 
(do_one_initcall+0x80/0x42c)
(do_one_initcall) from [<c1101074>] (kernel_init_freeable+0x15c/0x208)
(kernel_init_freeable) from [<c0afdde0>] (kernel_init+0x8/0x118)
(kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)

I've tried returning ERR_PTR(-EPROBE_DEFER) from device_probe(), but I 
doesn't work there. Some more changes in the framework are needed...

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
