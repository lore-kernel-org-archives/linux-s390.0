From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 29 Jul 2015 19:21:10 +1000
Message-ID: <1438161670.15927.9.camel@kernel.crashing.org>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
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
	<55B88C0E.9050104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55B88C0E.9050104@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, xen-devel <Xen-devel@lists.xen.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jan Kiszka <jan.kiszka@siemens.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Andy Lutomirski <luto@amacapital.net>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2015-07-29 at 10:17 +0200, Paolo Bonzini wrote:
> 
> On 29/07/2015 02:47, Andy Lutomirski wrote:
> > > > If new kernels ignore the IOMMU for devices that don't set the flag
> > > > and there are physical devices that already exist and don't set the
> > > > flag, then those devices won't work reliably on most modern
> > > > non-virtual platforms, PPC included.
> > >
> > > Are there many virtio physical devices out there ? We are talking about
> > > a virtio flag right ? Or have you been considering something else ?
> >
> > Yes, virtio flag.  I dislike having a virtio flag at all, but so far
> > no one has come up with any better ideas.  If there was a reliable,
> > cross-platform mechanism for per-device PCI bus properties, I'd be all
> > for using that instead.
> 
> No, a virtio flag doesn't make sense.

It wouldn't if we were creating virtio from scratch.

However we have to be realistic here, we are contending with existing
practices and implementation. The fact is qemu *does* bypass any iommu
and has been doing so for a long time, *and* the guest drivers are
written today *also* bypassing all DMA mapping mechanisms and just
passing everything accross.

So if it's a bug, it's a bug on both sides of the fence. We are no
longer in "bug fixing" territory here, it's a fundamental change of ABI.
The ABI might not be what was intended (but that's arguable, see below),
but it is that way.

Arguably it was even known and considered a *feature* by some (including
myself) at the time. It somewhat improved performances on archs where
otherwise every page would have to be mapped/unmapped in guest iommu. In
fact, it also makes vhost a lot easier.

So I disagree, it's de-facto a feature (even if unintended) of the
existing virtio implementations and changing that would be a major
interface change, and thus should be exposed as such.

> Blindly using system memory is a bug in QEMU; it has to be fixed to use
> the right address space, and then whatever the system provides to
> describe "the right address space" can be used (like the DMAR table on x86).

Except that it's not so easy.

For example, on PPC PAPR guests, there is no such thing as a "no IOMMU"
space, the concept doesn't exist. So we have at least three things to
deal with:

 - Existing guests, so we must preserve the existing behaviour for
backward compatibility.

 - vhost is made more complex because it now needs to be informed of the
guest iommu updates

 - New guests have the "new driver" that knows how to map and unmap
would have a performance loss unless some mechanism to create a "no
iommu" space exists which for us would need to be added. Either that or
we rely on DDW which is a way for a guest to create a permanent mapping
of its entire address space in an IOMMU but that incur a significant
waste of host kernel memory.

> On PPC I suppose you could use the host bridge's device tree?  If you
> need a hook, you can add a

No because we can mix and match virtio and other devices on the same
host bridge. Unless we put a property that only applies to virtio
children of the host bridge.

> 	bool virtio_should_bypass_iommu(void)
> 	{
> 		/* lookup something in the device tree?!? */
> 	}
> 	EXPORT_SYMBOL_GPL(virtio_should_bypass_iommu);
> 
> in some pseries.c file, and in the driver:
> 
> 	static bool virtio_bypass_iommu(void)
> 	{
> 		bool (*fn)(void);
> 	
> 		fn = symbol_get(virtio_should_bypass_iommu);
> 		return fn && fn();
> 	}
> 
> Awful, but that's what this thing is.

Ben.

> Paolo
