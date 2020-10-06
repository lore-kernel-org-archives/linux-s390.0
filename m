Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgJFP2c (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Oct 2020 11:28:32 -0400
Date: Tue, 6 Oct 2020 17:27:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add entry for s390 vfio-pci
Message-ID: <20201006172718.121d2a26.cohuck@redhat.com>
In-Reply-To: <1601668844-5798-6-git-send-email-mjrosato@linux.ibm.com>
References: <1601668844-5798-1-git-send-email-mjrosato@linux.ibm.com>
        <1601668844-5798-6-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri,  2 Oct 2020 16:00:44 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Add myself to cover s390-specific items related to vfio-pci.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 190c7fa..389c4ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15162,6 +15162,14 @@ F:	Documentation/s390/vfio-ccw.rst
>  F:	drivers/s390/cio/vfio_ccw*
>  F:	include/uapi/linux/vfio_ccw.h
>  
> +S390 VFIO-PCI DRIVER
> +M:	Matthew Rosato <mjrosato@linux.ibm.com>
> +L:	linux-s390@vger.kernel.org
> +L:	kvm@vger.kernel.org
> +S:	Supported
> +F:	drivers/vfio/pci/vfio_pci_zdev.c
> +F:	include/uapi/linux/vfio_zdev.h
> +
>  S390 ZCRYPT DRIVER
>  M:	Harald Freudenberger <freude@linux.ibm.com>
>  L:	linux-s390@vger.kernel.org

Acked-by: Cornelia Huck <cohuck@redhat.com>
