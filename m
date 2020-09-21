Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbgIUPuG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 11:50:06 -0400
Date: Mon, 21 Sep 2020 17:49:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/4] s390/pci: stash version in the zpci_dev
Message-ID: <20200921174951.3b660003.cohuck@redhat.com>
In-Reply-To: <ea53b58a-74f0-2a10-3f08-dbcca512ef86@linux.ibm.com>
References: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
        <1600529318-8996-2-git-send-email-mjrosato@linux.ibm.com>
        <20200921170158.1080d872.cohuck@redhat.com>
        <ea53b58a-74f0-2a10-3f08-dbcca512ef86@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 11:44:20 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 9/21/20 11:01 AM, Cornelia Huck wrote:
> > On Sat, 19 Sep 2020 11:28:35 -0400
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> >> In preparation for passing the info on to vfio-pci devices, stash the
> >> supported PCI version for the target device in the zpci_dev.  
> > 
> > Hm, what kind of version is that? The version of the zPCI interface?
> > 
> > Inquiring minds want to know :)
> >   
> 
> Ha :) It's related to PCI-SIG spec versions and which one the zPCI 
> facility supports for this device.

Thanks for the info :)

> 
> >>
> >> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> >> ---
> >>   arch/s390/include/asm/pci.h | 1 +
> >>   arch/s390/pci/pci_clp.c     | 1 +
> >>   2 files changed, 2 insertions(+)  
> >   
> 

FWIW,

Acked-by: Cornelia Huck <cohuck@redhat.com>
