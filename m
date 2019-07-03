Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 3 Jul 2019 17:09:53 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390/cio: introduce driver_override on the css bus
References: <20190613110815.17251-1-cohuck@redhat.com>
 <alpine.LFD.2.21.1906211817010.2388@schleppi>
 <20190624091740.1d9c6c1d.cohuck@redhat.com>
 <20190703165506.53d3911c.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190703165506.53d3911c.cohuck@redhat.com>
Message-Id: <your-ad-here.call-01562166593-ext-0522@work.hours>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 04:55:06PM +0200, Cornelia Huck wrote:
> On Mon, 24 Jun 2019 09:17:40 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri, 21 Jun 2019 18:19:36 +0200 (CEST)
> > Sebastian Ott <sebott@linux.ibm.com> wrote:
> > 
> > > On Thu, 13 Jun 2019, Cornelia Huck wrote:  
> > > > Sometimes, we want to control which of the matching drivers
> > > > binds to a subchannel device (e.g. for subchannels we want to
> > > > handle via vfio-ccw).
> > > > 
> > > > For pci devices, a mechanism to do so has been introduced in
> > > > 782a985d7af2 ("PCI: Introduce new device binding path using
> > > > pci_dev.driver_override"). It makes sense to introduce the
> > > > driver_override attribute for subchannel devices as well, so
> > > > that we can easily extend the 'driverctl' tool (which makes
> > > > use of the driver_override attribute for pci).
> > > > 
> > > > Note that unlike pci we still require a driver override to
> > > > match the subchannel type; matching more than one subchannel
> > > > type is probably not useful anyway.
> > > > 
> > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>    
> > > 
> > > Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> > > 
> > > Should I take that via our git tree or do you have other patches depending 
> > > on this one?
> > >   
> > 
> > No, this patch is stand-alone; everything else is happening in user
> > space, so taking it via your tree would be great. Thanks!
> 
> Friendly ping (I don't see it on s390/features yet; or is this going
> via some other path?)
> 

It is there now. Just waited until latest ci results to push the branch.
Sorry for delay.
