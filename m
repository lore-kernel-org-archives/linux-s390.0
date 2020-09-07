Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35038 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726938AbgIGWWg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Sep 2020 18:22:36 -0400
Date: Tue, 8 Sep 2020 00:22:12 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 1/2] virtio: let arch advertise guest's memory
 access restrictions
Message-ID: <20200908002212.462303b4.pasic@linux.ibm.com>
In-Reply-To: <1599471547-28631-2-git-send-email-pmorel@linux.ibm.com>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
        <1599471547-28631-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Mon,  7 Sep 2020 11:39:06 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> An architecture may restrict host access to guest memory,
> e.g. IBM s390 Secure Execution or AMD SEV.
> 
> Provide a new Kconfig entry the architecture can select,
> CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, when it provides
> the arch_has_restricted_virtio_memory_access callback to advertise
> to VIRTIO common code when the architecture restricts memory access
> from the host.
> 
> The common code can then fail the probe for any device where
> VIRTIO_F_ACCESS_PLATFORM is required, but not set.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]
>  
> +config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +	bool
> +	help
> +	  This option is selected if the architecture may need to enforce
> +	  VIRTIO_F_IOMMU_PLATFORM.
> +

A small nit: you use F_ACCESS_PLATFORM everywhere but here.

Regards,
Halil
