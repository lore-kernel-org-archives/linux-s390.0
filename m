Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729761AbgIHH5t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 03:57:49 -0400
Received: by mail-ed1-f70.google.com with SMTP id y15so4374467edq.4
        for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2020 00:57:38 -0700 (PDT)
Date: Tue, 8 Sep 2020 03:57:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v11 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200908035506-mutt-send-email-mst@kernel.org>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
 <20200908003951.233e47f3.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908003951.233e47f3.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, Sep 08, 2020 at 12:39:51AM +0200, Halil Pasic wrote:
> On Mon,  7 Sep 2020 11:39:05 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > Hi all,
> > 
> > The goal of the series is to give a chance to the architecture
> > to validate VIRTIO device features.
> 
> Michael, is this going in via your tree?

I guess so. Still not really happy about second-guessing
the hypervisor, but this got acks from others
so maybe I'm wrong in this instance. Won't be the first time.

-- 
MST
