From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
Date: Tue, 15 Jan 2019 20:33:35 +0100
Message-ID: <20190115203335.111bfcdc@thinkpad>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
        <1547573850-9459-2-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547573850-9459-2-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: joro@8bytes.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com, walling@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 15 Jan 2019 18:37:30 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The s390 iommu can only allow DMA transactions between the zPCI device
> entries start_dma and end_dma.
> 
> Let's declare the regions before start_dma and after end_dma as
> reserved regions using the appropriate callback in iommu_ops.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 22d4db3..5ca91a1 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -363,6 +363,33 @@ void zpci_destroy_iommu(struct zpci_dev *zdev)
>  	iommu_device_sysfs_remove(&zdev->iommu_dev);
>  }
> 
> +static void s390_get_resv_regions(struct device *dev, struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
> +
> +	region = iommu_alloc_resv_region(0, zdev->start_dma,
> +					 0, IOMMU_RESV_RESERVED);
> +	if (!region)
> +		return;
> +	list_add_tail(&region->list, head);
> +
> +	region = iommu_alloc_resv_region(zdev->end_dma + 1,
> +					 ~0UL - zdev->end_dma,
> +					 0, IOMMU_RESV_RESERVED);

Can you guarantee that start_dma will never be 0 and end_dma never ~0UL,
even with future HW?

In any of these cases, your code would reserve strange ranges, and sysfs
would report broken reserved ranges.

Maybe add a check for start_dma > 0 and end_dma < ULONG_MAX?

> +	if (!region)
> +		return;
> +	list_add_tail(&region->list, head);
> +}
> +
> +static void s390_put_resv_regions(struct device *dev, struct list_head *head)
> +{
> +	struct iommu_resv_region *entry, *next;
> +
> +	list_for_each_entry_safe(entry, next, head, list)
> +		kfree(entry);
> +}

It looks very wrong that there is no matching list_del() for the previous
list_add_tail(). However, it seems to be done like this everywhere else,
and the calling functions (currently) only use temporary list_heads as
far as I can see, so I guess it should be OK (for now).

Still, a list_del() would be nice :-)

> +
>  static const struct iommu_ops s390_iommu_ops = {
>  	.capable = s390_iommu_capable,
>  	.domain_alloc = s390_domain_alloc,
> @@ -376,6 +403,8 @@ static const struct iommu_ops s390_iommu_ops = {
>  	.remove_device = s390_iommu_remove_device,
>  	.device_group = generic_device_group,
>  	.pgsize_bitmap = S390_IOMMU_PGSIZES,
> +	.get_resv_regions = s390_get_resv_regions,
> +	.put_resv_regions = s390_put_resv_regions,
>  };
> 
>  static int __init s390_iommu_init(void)

With the start/end_dma issue addressed (if necessary):
Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
