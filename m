From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 29 Jul 2015 09:21:34 +1000
Message-ID: <1438125694.7562.177.camel@kernel.crashing.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrW+YynS13qgXnUR-Vw9uyve9Js3RQb2RV9NBHxwyft5=w@mail.gmail.com>
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

On Tue, 2015-07-28 at 15:43 -0700, Andy Lutomirski wrote:
> Let me try to summarize a proposal:
> 
> Add a feature flag that indicates IOMMU support.
> 
> New kernels acknowledge that flag on any device that advertises it.
> 
> New kernels always respect the IOMMU (except on PowerPC).

Why ? I disagree, the flag should be honored when set in any
architecture. PowerPC is no different than any other platform in that
regard.

>   New kernels
> optionally refuse to talk to devices that don't have that feature flag
> if the device appears to be behind an IOMMU.  (This presumably
> includes any device whatsoever on an x86 platform with an IOMMU,
> including Xen's fake IOMMU.)
> 
> New QEMU always respects the IOMMU, if any, except on PPC.

This is just a matter of what is the default of the flag, ie we
should have a machine flag that indicates what the default is for
new virtio devices, otherwise, it should be specified per device
as an attribute of the device instance.

I would argue that we should default to "bypass IOMMU" on *all*
architecture due to the performance impact, and to essentially
default to the same behaviour as today. With things like DDW even
powerpc might be able to mostly alleviate the performance impact
so we might to change in the long term, but I tend to prefer
more incremental approaches.

>   New QEMU
> always advertises this feature flag.  If iommu=on, QEMU's virtio
> devices refuse to work unless the driver acknowledges the flag.

This should be configurable.

> On PPC, new QEMU will not respect the IOMMU and will not set the flag.
> New kernels will not talk to devices that set the flag.  If someone
> wants to fix that, then they get to figure out how.

I disagree with the kernel bit and I disagree with special casing PPC in
any shape or form in the code. The only difference should be a default
value for the iommu mode of virtio in qemu set per machine.

You can then feel free to change that default (in a separate patch for
bisectability) on x86 for the sake of Xen.

Ben.

> This results in:
> 
> New kernels work fine with old QEMU unless iommu=on.
> 
> New kernels work with new devices (QEMU and physical devices that set
> the flag) under all circumstances, except on PPC where physical
> devices are and remain broken.
> 
> Xen works work new QEMU and cleanly refuses to interoperate with old
> QEMU.  (This is worse than with just my patches, but it's better than
> the status quo in which the Xen guest corrupts itself and possibly
> corrupts the Xen hypervisor.)
> 
> New kernels with old QEMU with iommu=on optionally refuses to interoperate.
> 
> Old kernels are oblivious.  They work exactly the same as they do
> today except that they fail cleanly with new QEMU with iommu=on.  Old
> kernels continue to fail with physical virtio devices if they're
> behind an iommu.
> 
> Old physical virtio devices that don't advertise the flag fail cleanly
> if the host uses an iommu.  The driver could optionally whitelist such
> devices.
> 
> PPC works as well as it currently does.
> 
> I'm unsure about the arm64 situation.
> 
> 
> Did I get this right?
> 
> --Andy
