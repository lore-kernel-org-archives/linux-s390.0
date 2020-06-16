Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24452 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728454AbgFPMU0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 08:20:26 -0400
Date: Tue, 16 Jun 2020 14:20:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200616142010.04b7ba19.cohuck@redhat.com>
In-Reply-To: <ef235cc9-9d4b-1247-c01a-9dd1c63f437c@linux.ibm.com>
References: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
        <1592224764-1258-2-git-send-email-pmorel@linux.ibm.com>
        <20200616115202.0285aa08.pasic@linux.ibm.com>
        <ef235cc9-9d4b-1247-c01a-9dd1c63f437c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, David Gibson <david@gibson.dropbear.id.au>, Ram Pai <linuxram@us.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Tue, 16 Jun 2020 12:52:50 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-06-16 11:52, Halil Pasic wrote:
> > On Mon, 15 Jun 2020 14:39:24 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:

> >> @@ -162,6 +163,11 @@ bool force_dma_unencrypted(struct device *dev)
> >>   	return is_prot_virt_guest();
> >>   }
> >>   
> >> +int arch_needs_iommu_platform(struct virtio_device *dev)  
> > 
> > Maybe prefixing the name with virtio_ would help provide the
> > proper context.  
> 
> The virtio_dev makes it obvious and from the virtio side it should be 
> obvious that the arch is responsible for this.
> 
> However if nobody has something against I change it.

arch_needs_virtio_iommu_platform()?

> 
> >   
> >> +{
> >> +	return is_prot_virt_guest();
> >> +}
> >> +
> >>   /* protected virtualization */
> >>   static void pv_init(void)
> >>   {
