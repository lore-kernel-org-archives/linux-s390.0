Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726507AbgIVOCn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Sep 2020 10:02:43 -0400
Subject: Re: [PATCH 4/4] vfio-pci/zdev: use a device region to retrieve zPCI
 information
References: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
 <1600529318-8996-5-git-send-email-mjrosato@linux.ibm.com>
 <20200922132239.4be1e749.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <4c339a61-8013-f380-e608-1d81ebdfc0d0@linux.ibm.com>
Date: Tue, 22 Sep 2020 10:02:36 -0400
MIME-Version: 1.0
In-Reply-To: <20200922132239.4be1e749.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On 9/22/20 7:22 AM, Cornelia Huck wrote:
> On Sat, 19 Sep 2020 11:28:38 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> Define a new configuration entry VFIO_PCI_ZDEV for VFIO/PCI.
>>
>> When this s390-only feature is configured we initialize a new device
>> region, VFIO_REGION_SUBTYPE_IBM_ZPCI_CLP, to hold information provided
>> by the underlying hardware.
>>
>> This patch is based on work previously done by Pierre Morel.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   drivers/vfio/pci/Kconfig            |  13 ++
>>   drivers/vfio/pci/Makefile           |   1 +
>>   drivers/vfio/pci/vfio_pci.c         |   8 ++
>>   drivers/vfio/pci/vfio_pci_private.h |  10 ++
>>   drivers/vfio/pci/vfio_pci_zdev.c    | 242 ++++++++++++++++++++++++++++++++++++
> 
> Maybe you want to add yourself to MAINTAINERS for the zdev-specific
> files? You're probably better suited to review changes to the
> zpci-specific code :)

Of course, will do.  Looking at how we split vfio-ap and vfio-ccw, I'll 
add an S390 VFIO-PCI DRIVER category and point to the new .h and .c file 
for now.

> 
>>   5 files changed, 274 insertions(+)
>>   create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c
> 
> (...)
> 
>> +int vfio_pci_zdev_init(struct vfio_pci_device *vdev)
>> +{
>> +	struct vfio_region_zpci_info *region;
>> +	struct zpci_dev *zdev;
>> +	size_t clp_offset;
>> +	int size;
>> +	int ret;
>> +
>> +	if (!vdev->pdev->bus)
>> +		return -ENODEV;
>> +
>> +	zdev = to_zpci(vdev->pdev);
>> +	if (!zdev)
>> +		return -ENODEV;
>> +
>> +	/* Calculate size needed for all supported CLP features  */
>> +	size = sizeof(*region) +
>> +	       sizeof(struct vfio_region_zpci_info_qpci) +
>> +	       sizeof(struct vfio_region_zpci_info_qpcifg) +
>> +	       (sizeof(struct vfio_region_zpci_info_util) + CLP_UTIL_STR_LEN) +
>> +	       (sizeof(struct vfio_region_zpci_info_pfip) +
>> +		CLP_PFIP_NR_SEGMENTS);
>> +
>> +	region = kmalloc(size, GFP_KERNEL);
>> +	if (!region)
>> +		return -ENOMEM;
>> +
>> +	/* Fill in header */
>> +	region->argsz = size;
>> +	clp_offset = region->offset = sizeof(struct vfio_region_zpci_info);
>> +
>> +	/* Fill the supported CLP features */
>> +	clp_offset = vfio_pci_zdev_add_qpci(zdev, region, clp_offset);
>> +	clp_offset = vfio_pci_zdev_add_qpcifg(zdev, region, clp_offset);
>> +	clp_offset = vfio_pci_zdev_add_util(zdev, region, clp_offset);
>> +	clp_offset = vfio_pci_zdev_add_pfip(zdev, region, clp_offset);
> 
> So, the regions are populated once. Can any of the values in the
> hardware structures be modified by a guest? Or changed from the
> hardware side?
> 

The region is created read-only (vfio_pci_zdev_rw returns -EINVAL on 
writes), so no guest modification.  The expectation is the guest can 
read the region and take what it wants / ignore what it doesn't.

The CLPs covered by this region are not intended to change once the 
device is up.

If we end up needing either of the above for a different CLP, I would 
think an additional/different region would be appropriate.


>> +
>> +	ret = vfio_pci_register_dev_region(vdev,
>> +		PCI_VENDOR_ID_IBM | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
>> +		VFIO_REGION_SUBTYPE_IBM_ZPCI_CLP, &vfio_pci_zdev_regops,
>> +		size, VFIO_REGION_INFO_FLAG_READ, region);
>> +	if (ret)
>> +		kfree(region);
>> +
>> +	return ret;
>> +}
> 
