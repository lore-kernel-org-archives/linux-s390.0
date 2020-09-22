Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgIVNwW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Sep 2020 09:52:22 -0400
Received: by mail-wr1-f72.google.com with SMTP id l17so7389437wrw.11
        for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2020 06:52:18 -0700 (PDT)
Date: Tue, 22 Sep 2020 09:52:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v12 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200922095158-mutt-send-email-mst@kernel.org>
References: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
 <de191c4d-cfe3-1414-53b8-e7a09cc15e32@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de191c4d-cfe3-1414-53b8-e7a09cc15e32@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org, pasic@linux.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

Will do for the next Linux.

On Tue, Sep 22, 2020 at 02:15:17PM +0200, Christian Borntraeger wrote:
> Michael,
> 
> are you going to pick this series?
> 
> 
> On 10.09.20 10:53, Pierre Morel wrote:
> > Hi all,
> > 
> > The goal of the series is to give a chance to the architecture
> > to validate VIRTIO device features.
> > 
> > I changed VIRTIO_F_IOMMU_PLATFORM to VIRTIO_F_ACCESS_PLATFORM
> > I forgot in drivers/virtio/Kconfig, and put back the inclusion
> > of virtio_config.h for the definition of the callback in
> > arch/s390/mm/init.c I wrongly removed in the last series.
> > 
> > Regards,
> > Pierre
> > 
> > 
> > Pierre Morel (2):
> >   virtio: let arch advertise guest's memory access restrictions
> >   s390: virtio: PV needs VIRTIO I/O device protection
> > 
> >  arch/s390/Kconfig             |  1 +
> >  arch/s390/mm/init.c           | 11 +++++++++++
> >  drivers/virtio/Kconfig        |  6 ++++++
> >  drivers/virtio/virtio.c       | 15 +++++++++++++++
> >  include/linux/virtio_config.h | 10 ++++++++++
> >  5 files changed, 43 insertions(+)
> > 
