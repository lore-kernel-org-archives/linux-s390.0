From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 29 Jul 2015 10:17:18 +0200
Message-ID: <55B88C0E.9050104@redhat.com>
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
To: Andy Lutomirski <luto@amacapital.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, xen-devel <Xen-devel@lists.xen.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>



On 29/07/2015 02:47, Andy Lutomirski wrote:
> > > If new kernels ignore the IOMMU for devices that don't set the flag
> > > and there are physical devices that already exist and don't set the
> > > flag, then those devices won't work reliably on most modern
> > > non-virtual platforms, PPC included.
> >
> > Are there many virtio physical devices out there ? We are talking about
> > a virtio flag right ? Or have you been considering something else ?
>
> Yes, virtio flag.  I dislike having a virtio flag at all, but so far
> no one has come up with any better ideas.  If there was a reliable,
> cross-platform mechanism for per-device PCI bus properties, I'd be all
> for using that instead.

No, a virtio flag doesn't make sense.

Blindly using system memory is a bug in QEMU; it has to be fixed to use
the right address space, and then whatever the system provides to
describe "the right address space" can be used (like the DMAR table on x86).

On PPC I suppose you could use the host bridge's device tree?  If you
need a hook, you can add a

	bool virtio_should_bypass_iommu(void)
	{
		/* lookup something in the device tree?!? */
	}
	EXPORT_SYMBOL_GPL(virtio_should_bypass_iommu);

in some pseries.c file, and in the driver:

	static bool virtio_bypass_iommu(void)
	{
		bool (*fn)(void);
	
		fn = symbol_get(virtio_should_bypass_iommu);
		return fn && fn();
	}

Awful, but that's what this thing is.

Paolo
