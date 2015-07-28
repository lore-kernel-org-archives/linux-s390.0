From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 28 Jul 2015 09:05:29 +0200
Message-ID: <55B729B9.8050606@de.ibm.com>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
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
To: Andy Lutomirski <luto@amacapital.net>, Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, xen-devel <Xen-devel@lists.xen.org>
List-ID: <linux-s390.vger.kernel.org>

Am 28.07.2015 um 03:08 schrieb Andy Lutomirski:
> On Mon, Sep 1, 2014 at 10:39 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> This fixes virtio on Xen guests as well as on any other platform
>> that uses virtio_pci on which physical addresses don't match bus
>> addresses.
>>
>> This can be tested with:
>>
>>     virtme-run --xen xen --kimg arch/x86/boot/bzImage --console
>>
>> using virtme from here:
>>
>>     https://git.kernel.org/cgit/utils/kernel/virtme/virtme.git
>>
>> Without these patches, the guest hangs forever.  With these patches,
>> everything works.
>>
> 
> Dusting off an ancient thread.
> 
> Now that the dust has accumulated^Wsettled, is it worth pursuing this?
>  I think the situation is considerably worse than it was when I
> originally wrote these patches: I think that QEMU now supports a nasty
> mode in which the guest's PCI bus appears to be behind an IOMMU but
> the virtio devices on that bus punch straight through that IOMMU.
> 
> I have a half-hearted port to modern kernels here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=virtio_ring_xen
> 
> I didn't implement DMA API access for virtio_pci_modern, and I have no
> idea what to do about detecting whether a given virtio device honors
> its IOMMU or not.

I think its really tricky.

Looking at where virtio came from, the virtio ring was always native access without
IOMMU. This was true for the early lguest things and then the early s390 transport,
(which is quite close to the lguest interface). virtio-pci used the same scheme
 - ignoring all iommu considerations.

I understand that for PCI we  actually might want to follow iommu restrictions from
a correctness and security point of view and from the ccw point of view we do not.
No idea about virtio-mmio.

I think the proper way of handling this is to take this into the TC for virtio - dont
know what would be the right thing to do. A feature bit, always iommu for pci, something
else?

Michael, Conny, 

do you agree?

Christian
