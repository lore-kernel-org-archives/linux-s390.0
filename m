Return-Path: <SRS0=rkwH=SM=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 10 Apr 2019 18:52:14 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 04/12] s390/cio: introduce cio DMA pool
In-Reply-To: <20190410180719.17c3469e.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-5-pasic@linux.ibm.com>
        <20190409124458.348d1ff5.cohuck@redhat.com>
        <20190409141114.7dcce94a@oc2783563651>
        <20190409191453.01444317.cohuck@redhat.com>
        <20190410173148.067555dc@oc2783563651>
        <20190410180719.17c3469e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410185214.7ac37c87@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 10 Apr 2019 18:07:19 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 10 Apr 2019 17:31:48 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Tue, 9 Apr 2019 19:14:53 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > [..]
> > 
> > > > > At this point, you're always going via the css0 device. I'm
> > > > > wondering whether you should pass in the cssid here and use
> > > > > css_by_id(cssid) to make this future proof. But then, I'm not
> > > > > quite clear from which context this will be called.      
> > > > 
> > > > As said before I don't see MCSS-E coming. Regarding the client code,
> > > > please check out the rest of the series. Especially patch 6. 
> > > > 
> > > > From my perspective it would be at this stage saner to make it more
> > > > obvious that only one css is supported (at the moment), than to
> > > > implement MCSS-E, or to make this (kind of) MCSS-E ready.    
> > > 
> > > I disagree. I think there's value in keeping the interfaces clean
> > > (within reasonable bounds, of course.) Even if there is no
> > > implementation of MCSS-E other than QEMU... it is probably a good idea
> > > to spend some brain cycles to make this conceptually clean.  
> > 
> > AFAIU Linux currently does not support MCSS-E. I don't have the
> > bandwidth to implement MCSS-E support in the kernel.
> > 
> > I fully agree for external interfaces should be MCSS-E conform, so
> > should we ever decide to implement we don't have to overcome self-made
> > obstacles.
> > 
> > Kernel internal stuff however, IMHO, should avoid carrying a ballast of
> > an 20%-30% implemented MCSS-E support. I see no benefit.
> > 
> > But I don't insist. If you have a good idea how to make this more MCSS-E
> > conform, you are welcome. In think something like this is best done on
> > top of a series that provides a basic working solution. Especially if the
> > conceptually clean thing is conceptually or code-wise more complex than
> > the basic solution. If you have something in mind that is simpler and
> > more lightweight than what I did here, I would be more than happy to make
> > that happen.
> 
> I haven't asked for adding complete support for MCSS-E, just to keep it
> in the back of our minds...

I will, I promise ;)!

> 
> Back to the issue at hand. You're currently hard-wiring this to the
> css0 device. My question is: Does it make sense to have a per-css area?

What do you mean by area?

> From my limited perspective, I think it does (more css images would
> mean more devices, and just adding smaller areas per-css is probably
> easier than adding one big area scaling with the number of css images).

Currently all devices are hooked up to css0. This is also hard-wired:

int css_register_subchannel(struct subchannel *sch)                             
{                                                                               
        int ret;                                                                
                                                                                
        /* Initialize the subchannel structure */                               
        sch->dev.parent = &channel_subsystems[0]->device;

I think the hard-wiring the DMA properties of the CSS to
channel_subsystems[0] is consistent with prior art.

> In that case, what about tacking the area to the actual css object,
> instead of having the global variable? Should be an easy change, and
> feels cleaner.
> 

I already got rid of the global variable. Instead we have an accessor
now.

My problem with a gen_pool per ccs approach is the airq aiv vectors.
Those vectors are currently shared between devices (at least for
virtio-ccw), and those vectors must be allocated as shared (DMA) memory.
Please take another look at patch #6. Would you like 
airq_iv_create(unsigned long bits, unsigned long flags) to take
a struct channel_subsystem argument?

Regards,
Halil
