From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Tue, 10 Nov 2015 08:28:18 +0100
Message-ID: <56419C92.9050704@siemens.com>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
	<CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
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
To: Andy Lutomirski <luto@amacapital.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 2015-11-10 03:18, Andy Lutomirski wrote:
> On Mon, Nov 9, 2015 at 6:04 PM, Benjamin Herrenschmidt
>> I thus go back to my original statement, it's a LOT easier to handle if
>> the device itself is self describing, indicating whether it is set to
>> bypass a host iommu or not. For L1->L2, well, that wouldn't be the
>> first time qemu/VFIO plays tricks with the passed through device
>> configuration space...
> 
> Which leaves the special case of Xen, where even preexisting devices
> don't bypass the IOMMU.  Can we keep this specific to powerpc and
> sparc?  On x86, this problem is basically nonexistent, since the IOMMU
> is properly self-describing.
> 
> IOW, I think that on x86 we should assume that all virtio devices
> honor the IOMMU.

From the guest driver POV, that is OK because either there is no IOMMU
to program (the current situation with qemu), there can be one that
doesn't need it (the current situation with qemu and iommu=on) or there
is (Xen) or will be (future qemu) one that requires it.

> 
>>
>> Note that the above can be solved via some kind of compromise: The
>> device self describes the ability to honor the iommu, along with the
>> property (or ACPI table entry) that indicates whether or not it does.
>>
>> IE. We could use the revision or ProgIf field of the config space for
>> example. Or something in virtio config. If it's an "old" device, we
>> know it always bypass. If it's a new device, we know it only bypasses
>> if the corresponding property is in. I still would have to sort out the
>> openbios case for mac among others but it's at least a workable
>> direction.
>>
>> BTW. Don't you have a similar problem on x86 that today qemu claims
>> that everything honors the iommu in ACPI ?
> 
> Only on a single experimental configuration, and that can apparently
> just be fixed going forward without any real problems being caused.

BTW, I once tried to describe the current situation on QEMU x86 with
IOMMU enabled via ACPI. While you can easily add IOMMU device exceptions
to the static tables, the fun starts when considering device hotplug for
virtio. Unless I missed some trick, ACPI doesn't seem like being
designed for that level of flexibility.

You would have to reserve a complete PCI bus, declare that one as not
being IOMMU-governed, and then only add new virtio devices to that bus.
Possible, but a lot of restrictions that existing management software
would have to be aware of as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
