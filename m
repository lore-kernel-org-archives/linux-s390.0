Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgJEQBY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Oct 2020 12:01:24 -0400
Date: Mon, 5 Oct 2020 18:01:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 3/5] vfio-pci/zdev: define the vfio_zdev header
Message-ID: <20201005180107.5d027441.cohuck@redhat.com>
In-Reply-To: <8a71af3b-f8fc-48b2-45c6-51222fd2455b@linux.ibm.com>
References: <1601668844-5798-1-git-send-email-mjrosato@linux.ibm.com>
        <1601668844-5798-4-git-send-email-mjrosato@linux.ibm.com>
        <20201002154417.20c2a7ef@x1.home>
        <8a71af3b-f8fc-48b2-45c6-51222fd2455b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 09:52:25 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 10/2/20 5:44 PM, Alex Williamson wrote:

> > Can you discuss why a region with embedded capability chain is a better
> > solution than extending the VFIO_DEVICE_GET_INFO ioctl to support a
> > capability chain and providing this info there?  This all appears to be
> > read-only info, so what's the benefit of duplicating yet another  
> 
> It is indeed read-only info, and the device region was defined as such.
> 
> I would not necessarily be opposed to extending VFIO_DEVICE_GET_INFO 
> with these defined as capabilities; I'd say a primary motivating factor 
> to putting these in their own region was to avoid stuffing a bunch of 
> s390-specific capabilities into a general-purpose ioctl response.

Can't you make the zdev code register the capabilities? That would put
them nicely into their own configurable part.

> 
> But if you're OK with that notion, I can give that a crack in v3.
> 
> > capability chain in a region?  It would also be possible to define four
> > separate device specific regions, one for each of these capabilities
> > rather than creating this chain.  It just seems like a strange approach  
> 
> I'm not sure if creating separate regions would be the right approach 
> though; these are just the first 4.  There will definitely be additional 
> capabilities in support of new zPCI features moving forward, I'm not 
> sure how many regions we really want to end up with.  Some might be as 
> small as a single field, which seems more in-line with capabilities vs 
> an entire region.

If we are expecting more of these in the future, going with GET_INFO
capabilities when adding new ones seems like the best approach.
