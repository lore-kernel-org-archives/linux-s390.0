Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728798AbgJEQ2l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Oct 2020 12:28:41 -0400
Date: Mon, 5 Oct 2020 18:28:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 3/5] vfio-pci/zdev: define the vfio_zdev header
Message-ID: <20201005182811.6c17ed6b.cohuck@redhat.com>
In-Reply-To: <e0688173-8c5a-1797-8398-235c5e406bc1@linux.ibm.com>
References: <1601668844-5798-1-git-send-email-mjrosato@linux.ibm.com>
        <1601668844-5798-4-git-send-email-mjrosato@linux.ibm.com>
        <20201002154417.20c2a7ef@x1.home>
        <8a71af3b-f8fc-48b2-45c6-51222fd2455b@linux.ibm.com>
        <20201005180107.5d027441.cohuck@redhat.com>
        <e0688173-8c5a-1797-8398-235c5e406bc1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 12:16:10 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 10/5/20 12:01 PM, Cornelia Huck wrote:
> > On Mon, 5 Oct 2020 09:52:25 -0400
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> >> On 10/2/20 5:44 PM, Alex Williamson wrote:  
> >   
> >>> Can you discuss why a region with embedded capability chain is a better
> >>> solution than extending the VFIO_DEVICE_GET_INFO ioctl to support a
> >>> capability chain and providing this info there?  This all appears to be
> >>> read-only info, so what's the benefit of duplicating yet another  
> >>
> >> It is indeed read-only info, and the device region was defined as such.
> >>
> >> I would not necessarily be opposed to extending VFIO_DEVICE_GET_INFO
> >> with these defined as capabilities; I'd say a primary motivating factor
> >> to putting these in their own region was to avoid stuffing a bunch of
> >> s390-specific capabilities into a general-purpose ioctl response.  
> > 
> > Can't you make the zdev code register the capabilities? That would put
> > them nicely into their own configurable part.
> >   
> 
> I can still keep the code that adds these capabilities in the zdev .c 
> file, thus meaning they will only be added for s390 zpci devices -- but 
> the actual definition of them should probably instead be in vfio.h, no? 
> (maybe that's what you mean, but let's lay it out just in case)
> 
> The capability IDs would be shared with any other potential user of 
> VFIO_DEVICE_GET_INFO (I guess there is precedent for this already, 
> nvlink2 does this for vfio_region_info, see 
> VFIO_REGION_INFO_CAP_NVLINK2_SSATGT as an example).
> 
> Today, ZPCI would be the only users of VFIO_DEVICE_GET_INFO capability 
> chains.  Tomorrow, some other type might use them too.  Unless we want 
> to put a stake in the ground that says there will never be a case for a 
> capability that all devices share on VFIO_DEVICE_GET_INFO, I think we 
> should keep the IDs unique and define the capabilities in vfio.h but do 
> the corresponding add_capability() calls from a zdev-specific file.

Agreed. We should have enough space for multiple users, and I do not
consider reserving the IDs cluttering.
