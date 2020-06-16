Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37560 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727804AbgFPMVY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Jun 2020 08:21:24 -0400
Date: Tue, 16 Jun 2020 14:21:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200616142112.2d08ff7d.cohuck@redhat.com>
In-Reply-To: <a93bf169-55ca-2a77-f9a5-b27bf18176e2@linux.ibm.com>
References: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
        <1592224764-1258-2-git-send-email-pmorel@linux.ibm.com>
        <74b6cf8a-d5a6-e0bf-f1c1-e453af133614@de.ibm.com>
        <a93bf169-55ca-2a77-f9a5-b27bf18176e2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, pasic@linux.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org

On Tue, 16 Jun 2020 09:35:19 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-06-16 08:55, Christian Borntraeger wrote:
> > 
> > 
> > On 15.06.20 14:39, Pierre Morel wrote:  
> >> An architecture protecting the guest memory against unauthorized host
> >> access may want to enforce VIRTIO I/O device protection through the
> >> use of VIRTIO_F_IOMMU_PLATFORM.
> >>
> >> Let's give a chance to the architecture to accept or not devices
> >> without VIRTIO_F_IOMMU_PLATFORM.
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>  
> > 
> > 
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>  
> 
> Thanks,
> 
> > 
> > Shouldnt we maybe add a pr_warn if that happens to help the admins to understand what is going on?
> > 
> >   
> 
> Yes, Connie asked for it too, good that you remind it to me, I add it.

Yes, please :)
