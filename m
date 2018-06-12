From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
Date: Tue, 12 Jun 2018 17:25:48 +0200
Message-ID: <20180612172548.43ab4143.cohuck@redhat.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
        <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
        <20180515181006.0cb1dfc2.cohuck@redhat.com>
        <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
        <20180522145208.310143ea.cohuck@redhat.com>
        <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
        <20180605151449.22aafbfc.cohuck@redhat.com>
        <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
        <20180606142131.74ea2eb7.cohuck@redhat.com>
        <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
        <20180607115442.6a779ed9.cohuck@redhat.com>
        <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
        <20180608142022.7dd6a658.cohuck@redhat.com>
        <d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
        <20180608164514.2e8248f4.cohuck@redhat.com>
        <99ca65a2-ee33-6353-b6b7-aa4c07a34e2a@linux.ibm.com>
        <20180612115900.4aa319d1.cohuck@redhat.com>
        <d5416c61-252a-5bb8-aebe-46d883e5822e@linux.ibm.com>
        <e4fc9a67-f3df-c040-8188-37eb3091db1a@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e4fc9a67-f3df-c040-8188-37eb3091db1a@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: pmorel@linux.ibm.com, Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 12 Jun 2018 16:08:42 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 06/12/2018 03:56 PM, Pierre Morel wrote:
> >> So, what are you proposing? Being more specific and stating that the
> >> scsw is not necessarily a real scsw, but merely a vehicle for sending a
> >> command? Or keeping it as it is now for ssch, and adding a second
> >> interface for hsch/csch (and maybe rsch, msch, ...)?
> >>  
> > 
> > 
> > I said no radical surgery, but after thinking more about it...
> > I am not sure.
> > 
> > Let's explain this:
> > 
> > I see 2 ways to proceed but my favorite is definitively to introduce versioning.
> > 
> > 
> > Way 1)
> > 
> > This was the way I first thought about.
> > We keep the existing IO Regionand structures, and are more
> > specific by stating that the io_region is a command region during write
> > entry and a status region during interrupt handling:
> > This allow us to use the 3 bits of the FCTL field of the SCSW to pass
> > commands to the kernel and stay backward compatible.  
> > The FCTL field has 3 bits => we can have 8 commands.  
> > 
> > PRO: small change
> > 
> > CONTRA: This is still confusing, we do not really solve this
> >          unclarity problem since QEMU view / documentation and
> >          Linux view / documentation differ or we update QEMU.
> >          Moreover this does not allow for long term extensions
> >          and/or re-design.
> > 
> >   
> 
> I'm not really in favor of way 1. Conie's point with RSCH is a good one.
> And IMHO it speaks for a new interface for commands. Squeezing the RSCH
> command into the SCSW does not seem to be a good idea. Considering your
> proposal with the 3 bits, we could do something like: if in FCTL the
> start and the clear and the halt bits are set then we postulate that is
> request for a resume. But that would be quite confusing, and we would end
> up re-defining the semantic of the scsw_area -- in respect to what is
> documented Documentation/s390/vfio-ccw.txt, and also what is intuitive
> based on the uapi header.

Agreed. Making scsw_area something like an scsw but still different is
bound to be confusing, even if documented, and I'm not sure it covers
all our bases anyway. Just using the halt/clear bits might have been
feasible, but as that does not cover rsch, we need something different
anyway.

> 
> > 
> > Way 2)
> > 
> > We use the device VFIO versioning using the capability chain to advertise
> > a new interface.
> > 
> > This the preferred way, it is sane, allows for the userland backward
> > compatibility and allows to have a new command interface, extensible
> > for future use.
> > 
> > In this case we can extend the interface to be any kind we want
> > in a next version, pwrite with new io_region, mmap on new
> > IO regions, status region...
> > 
> > PRO: Extensible and also goes in the VFIO INFO extension direction
> >       proposed by Alex
> >   
> 
> 
> Sounds much better. I imagine the coexistence of old and new like this.
> Both the old and the new QEMU would supply the the SCSW area with the old
> documented semantics -- the SCSW of the virtual subchannel. But with the
> new version an explicit command would be supplied via the command region
> (also for  SSCH). Maybe the SCSW can still end up being useful for
> something in the kernel module too (maybe there are some  optimization
> that can be done based on the QEMU SCSW).

We need to keep the old interface anyway. But yes, I think capabilities
are the way to go.

> 
> 
> > CONTRA: I see none outer more work to do (but is it a problem?)
> > 
> >   
> The problem I see is that designing a good interface usually hard.

I fear that this is always the case :)

> I could help with review, but I don't have the resources to commit
> to more than that.

I'm looking into the halt/clear thing anyway. But review is appreciated.

> 
> > ====================
> > 
> > Extra argumentation for versioning support
> > 
> > 
> > Suppose a future implementation with 4 mapped regions like
> > the following:
> > 
> > - A Status region (RO updated as result of command and IRQ)

scsw/pmcw/anything else? Would also accommodate the path handling
stuff, I think.

> > 
> > - A command region (WO where the user send its commands)
> >    userland write here to trigger IO (quite as currently)
> > 
> > - A CCW program region (RW where the CCW chain is handled)
> >    most handling done from userspace, last translations in kernel,
> >    double buffering...

I'm not sure about that. But in any case, we can add this later on. We
need to keep the orb as it is now, and that should already cover our
current use cases.

> > 
> > - A performance / measurement / statistics region (RO)
> >    This is updated asynchronously by hardware and/or driver

For channel measurements, for example? Makes sense. (I recall that
there's also a measurement infrastructure triggered via CHSC, but I
don't have the documentation.)

> > 
> > This is purely theoretical and we do not need to do all at once
> > but if we want to extend the implementation without problems
> > and continue backward compatibility the versioning and capability
> > handling is a must.  
> 
> I'm not sure about this.

We can think about this later, the capabilities infrastructure enables
us to do so.
