Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCP2k (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 3 Jul 2019 11:28:40 -0400
Date: Wed, 3 Jul 2019 17:28:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390/cio: introduce driver_override on the css bus
Message-ID: <20190703172834.31ed1848.cohuck@redhat.com>
In-Reply-To: <your-ad-here.call-01562166593-ext-0522@work.hours>
References: <20190613110815.17251-1-cohuck@redhat.com>
        <alpine.LFD.2.21.1906211817010.2388@schleppi>
        <20190624091740.1d9c6c1d.cohuck@redhat.com>
        <20190703165506.53d3911c.cohuck@redhat.com>
        <your-ad-here.call-01562166593-ext-0522@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 17:09:53 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Wed, Jul 03, 2019 at 04:55:06PM +0200, Cornelia Huck wrote:
> > On Mon, 24 Jun 2019 09:17:40 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > On Fri, 21 Jun 2019 18:19:36 +0200 (CEST)
> > > Sebastian Ott <sebott@linux.ibm.com> wrote:
> > >   
> > > > On Thu, 13 Jun 2019, Cornelia Huck wrote:    
> > > > > Sometimes, we want to control which of the matching drivers
> > > > > binds to a subchannel device (e.g. for subchannels we want to
> > > > > handle via vfio-ccw).
> > > > > 
> > > > > For pci devices, a mechanism to do so has been introduced in
> > > > > 782a985d7af2 ("PCI: Introduce new device binding path using
> > > > > pci_dev.driver_override"). It makes sense to introduce the
> > > > > driver_override attribute for subchannel devices as well, so
> > > > > that we can easily extend the 'driverctl' tool (which makes
> > > > > use of the driver_override attribute for pci).
> > > > > 
> > > > > Note that unlike pci we still require a driver override to
> > > > > match the subchannel type; matching more than one subchannel
> > > > > type is probably not useful anyway.
> > > > > 
> > > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>      
> > > > 
> > > > Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> > > > 
> > > > Should I take that via our git tree or do you have other patches depending 
> > > > on this one?
> > > >     
> > > 
> > > No, this patch is stand-alone; everything else is happening in user
> > > space, so taking it via your tree would be great. Thanks!  
> > 
> > Friendly ping (I don't see it on s390/features yet; or is this going
> > via some other path?)
> >   
> 
> It is there now. Just waited until latest ci results to push the branch.
> Sorry for delay.
> 

Awesome, thanks!
