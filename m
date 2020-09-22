Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17216 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbgIVMPf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Sep 2020 08:15:35 -0400
Subject: Re: [PATCH v12 0/2] s390: virtio: let arch validate VIRTIO features
References: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <de191c4d-cfe3-1414-53b8-e7a09cc15e32@de.ibm.com>
Date: Tue, 22 Sep 2020 14:15:17 +0200
MIME-Version: 1.0
In-Reply-To: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org, mst@redhat.com
Cc: pasic@linux.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

Michael,

are you going to pick this series?


On 10.09.20 10:53, Pierre Morel wrote:
> Hi all,
> 
> The goal of the series is to give a chance to the architecture
> to validate VIRTIO device features.
> 
> I changed VIRTIO_F_IOMMU_PLATFORM to VIRTIO_F_ACCESS_PLATFORM
> I forgot in drivers/virtio/Kconfig, and put back the inclusion
> of virtio_config.h for the definition of the callback in
> arch/s390/mm/init.c I wrongly removed in the last series.
> 
> Regards,
> Pierre
> 
> 
> Pierre Morel (2):
>   virtio: let arch advertise guest's memory access restrictions
>   s390: virtio: PV needs VIRTIO I/O device protection
> 
>  arch/s390/Kconfig             |  1 +
>  arch/s390/mm/init.c           | 11 +++++++++++
>  drivers/virtio/Kconfig        |  6 ++++++
>  drivers/virtio/virtio.c       | 15 +++++++++++++++
>  include/linux/virtio_config.h | 10 ++++++++++
>  5 files changed, 43 insertions(+)
> 
