From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Fri, 20 Nov 2015 10:21:08 +0200
Message-ID: <20151120085658-mutt-send-email-mst@redhat.com>
References: <cover.1446014204.git.luto@kernel.org>
	<20151119153821-mutt-send-email-mst@redhat.com>
	<CALCETrXXsThXpbRMQ_CWTsq7_HiRFaK+dTeDYaz5cSm0QtoW_w@mail.gmail.com>
	<1447976286.145626.122.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1447976286.145626.122.camel@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.a@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 19, 2015 at 11:38:06PM +0000, David Woodhouse wrote:
> On Thu, 2015-11-19 at 13:59 -0800, Andy Lutomirski wrote:
> > =

> > >
> > > So thinking hard about it, I don't see any real drawbacks to making t=
his
> > > conditional on a new feature bit, that Xen can then set..
> > =

> > Can you elaborate?=A0 If I run QEMU, hosting Xen, hosting Linux, and the
> > virtio device is provided by QEMU, then how does Xen set the bit?
> > Similarly, how would Xen set the bit for a real physical device?
> =

> Right. This is *not* a fundamental characteristic of the device. This
> is all about how your *particular* hypervisor (in the set of turtles-
> all-the-way-down) happened to expose the thing to you.
> =

> This is why it lives in the DMAR table, in the Intel world, which
> *tells* you which devices are behind which IOMMU (and which are not).

David, there are two things a hypervisor needs to tell the guest.
1. The actual device is behind an IOMMU. This is what you
   are suggesting we use DMAR for.
2. Using IOMMU from kernel (as opposed to from userspace with VFIO)
   actually adds security. For exising virtio devices on KVM,
   the answer is no. And DMAR has no way to reflect that.

Question 2 only makes sense if you answer yes to question 1 and if user
wants protection from malicious devices with iommu=3Don, and
if you care about getting good performance from *other*
devices.  And what guest would do is use 1:1 for the
devices where answer 2 is "no".

Maybe for now I should just give up and say "don't use iommu=3Don within
VMs if you want any performance".  But the point is, if we just fix QEMU
to actually obey IOMMU mappings for assigned devices, then there's
already a kind of answer with virtio being trusted since it's part of
hypervisor, all this without guest changes. Seems kind of sad to let
performance regress.

So a (yet another) feature bit would be a possible solution there, but
we don't seem to be able to even agree on using a feature bit for a
quirk.


> And why I keep repeating myself that it has nothing to do with the
> actual device or the virtio drivers.
>
> I understand that POWER and other platforms don't currently have a
> clean way to indicate that certain device don't have translation. And I
> understand that we may end up with a *quirk* which ensures that the DMA
> API does the right thing (i.e. nothing) in certain cases.

So assuming we forget about 2 above for now, then yes, all we need
is a quirk, using some logic to detect these systems.

> But we should *NOT* be involving the virtio device drivers in that
> quirk, in any way. And putting a feature bit in the virtio device
> itself doesn't seem at all sane either.

Only if there's some other device that benefits from all this work.  If
virtio is the only one that benefits, then why do we want to
spread the quirk rules around so much? A feature bit gives us
a single, portable rule that the quirk can use on all platforms.

> Bear in mind that qemu-system-x86_64 currently has the *same* problem
> with assigned physical devices. It's claiming they're translated, and
> they're not.
> =

> -- =

> dwmw2
> =


Presumably people either don't assign
devices or don't have an iommu otherwise things won't work for them,
but if they do have an iommu and don't assign devices, then Andy's
patch will break them.

This is not QEMU specific unfortunately, we don't know who
might have implemented virtio.





-- =

MST
