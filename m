From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 29 Jul 2015 10:54:10 +1000
Message-ID: <1438131250.7562.191.camel@kernel.crashing.org>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
	<55B73A49.9050206@redhat.com>
	<1438078345.7562.133.camel@kernel.crashing.org>
	<55B7799C.3060908@redhat.com>
	<20150728160358-mutt-send-email-mst@redhat.com>
	<55B77F8C.7010804@siemens.com>
	<CALCETrVF1-=z60bCtsMBctbd14zjJgpUPNNo+EcJj_fXhww1og@mail.gmail.com>
	<55B7B15C.4010101@siemens.com>
	<CALCETrW_7tmUg1zf3m1xYeSruW8njNYP9N4s8tBKJcTGJf_0QA@mail.gmail.com>
	<55B7B91E.40200@siemens.com>
	<CALCETrWUVQWQ=mydbdiSJnA0uLSFarVYCnWWKpcgYD0A8hpfXQ@mail.gmail.com>
	<55B7D2A9.6040700@siemens.com>
	<CALCETrVeT-M+qMxXwDUB50xnFW1B6yu+ofiX-ydvtjaGgRLUNA@mail.gmail.com>
	<55B7D8F5.1000902@siemens.com>
	<CALCETrWZM=1y_nwBW2RcMNqKcPPGa0uqqGS_fKijfJzYJL4L-Q@mail.gmail.com>
	<CALCETrW+YynS13qgXnUR-Vw9uyve9Js3RQb2RV9NBHxwyft5=w@mail.gmail.com>
	<1438125694.7562.177.camel@kernel.crashing.org>
	<CALCETrXFMXCfCWLTdE2nff=gibsu2_2XEwwOxC6T3vQZphGeBg@mail.gmail.com>
	<1438130185.7562.186.camel@kernel.crashing.org>
	<CALCETrWrLypYdF3Yhzj=ku9i=EmBJm4Ux5ouJ33MuXf7tEgJ0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrWrLypYdF3Yhzj=ku9i=EmBJm4Ux5ouJ33MuXf7tEgJ0w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, xen-devel <Xen-devel@lists.xen.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2015-07-28 at 17:47 -0700, Andy Lutomirski wrote:

> Yes, virtio flag.  I dislike having a virtio flag at all, but so far
> no one has come up with any better ideas.  If there was a reliable,
> cross-platform mechanism for per-device PCI bus properties, I'd be all
> for using that instead.

There isn't that I know of, so I think it's the best approach we have.

 .../...

> >  - The kernel should just honor what qemu says, ie, whether the qemu
> > device honors or bypasses the iommu.
> 
> Except for vfio, which maybe just needs a special case: vfio checks if
> the device claims to be virtio and doesn't set the flag, in which case
> vfio just refuses to bind the device.

Right but passing virtio through isn't the highest priority on the
radar, but yes, indeed, it should identify them and reject them.

> >  - Qemu default behaviour should be set via a machine attribute which
> > can be overriden both globally (the machine one) or per-device.
> >
> >> I think that, in an ideal world, there would be no feature flag and
> >> all virtio devices would always respect the IOMMU.  Unfortunately we
> >> have existing practice in the form of PPC and Q35 iommu=on that
> >> conflict with that.
> >
> > And possibly more as in this is how the qemu virtio devices are written
> > today, they do not use the proper DMA accessors, they always bypass,
> > whatever the platform is (so sparc would be in the same boat for
> > example).
> 
> Except that AFAIK Q35 is the only QEMU platform that supports a
> nontrivial IOMMU in the first place.  Are there pseries hosts that
> have a working IOMMU?  Maybe I've just misunderstood.

You may well be correct, I remember that we actually created the iommu
infrastructure to a large extent in qemu for ppc/pseries, then it got
extended when q35 came in.

> >> >>   New QEMU
> >> >> always advertises this feature flag.  If iommu=on, QEMU's virtio
> >> >> devices refuse to work unless the driver acknowledges the flag.
> >> >
> >> > This should be configurable.
> >>
> >> Would any non-PPC user ever configure it differently?  I suppose if
> >> you want to support old kernels on new QEMU, you'd flip the switch.
> >
> > Possibly, have we looked at what ia64, sparc, arm, ... do ? At least
> > sparc has iommus as well.
> 
> I think (I hope!) that ia64 is irrelevant, and last I checked ARM
> didn't have a QEMU-emulated IOMMU.  Maybe things have changed.

Not yet...

 .../...
> >
> > On new machine types, we shouldn't change the behaviour of an existing
> > machine type, and we should keep the default to 0 on ppc/pseries because
> > of backward compatibility issue. But that should be the only place that
> > is "ppc specific", ie, a default value in a machine def structure.
> 
> Fair enough, except I still think we should change the default to be
> "respect IOMMU" on machine types that don't have an IOMMU in the first
> place. 

Ok, but do it in a separate patch because it *is* a behaviour change to
some extent.

>  That way Xen works with old machine types, and I don't think
> we lose anything.
> 
> >
> >> That's the setting that will work in all cases on new guest + new
> >> host, and it's the setting that's safest.  vfio will probably always
> >> malfunction if given a device that looks like it's behind an IOMMU but
> >> doesn't respect it.  For people who need the last bit of performance,
> >> they should use bus-level controls where available (they should be
> >> available everywhere except PPC and maybe arm64) and, ideally, someone
> >> would teach PPC how to exclude devices from the IOMMU cleanly if
> >> possible.  If that can't be done, then there can be an option to
> >> bypass the IOMMU the way it's currently done and no one except PPC
> >> would do it.
> >>
> >> PPC really is different from everything except x86 Q35 iommu=on, and
> >> the latter is experimental.  AFAIK in all other cases, the IOMMU is
> >> respected by virtio, but there is no non-1:1 IOMMU.
> >
> > What about sparc ? I though it was pretty similar to PPC in that
> > regard...
> 
> No clue, honestly.  I could be wrong about the set of existing QEMU
> machine types.

Ok.

Cheers,
Ben.
