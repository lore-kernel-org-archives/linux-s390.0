From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC patch 0/6] vfio based pci pass-through for
	qemu/KVM on s390
Date: Tue, 23 Sep 2014 10:33:27 +0200
Message-ID: <54213057.2040801@suse.de>
References: <20140919115429.557279920@de.ibm.com>	
	<1411418851.1199.137.camel@ul30vt.home> <54209DD8.50506@suse.de>
	<1411424936.1199.181.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1411424936.1199.181.camel@ul30vt.home>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-s390@vger.kernel.org, frank.blaschka@de.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>



On 23.09.14 00:28, Alex Williamson wrote:
> On Tue, 2014-09-23 at 00:08 +0200, Alexander Graf wrote:
>>
>> On 22.09.14 22:47, Alex Williamson wrote:
>>> On Fri, 2014-09-19 at 13:54 +0200, frank.blaschka@de.ibm.com wrote:
>>>> This set of patches implements a vfio based solution for pci
>>>> pass-through on the s390 platform. The kernel stuff is pretty
>>>> much straight forward, but qemu needs more work.
>>>>
>>>> Most interesting patch is:
>>>>   vfio: make vfio run on s390 platform
>>>>
>>>> I hope Alex & Alex can give me some guidance how to do the changes
>>>> in an appropriate way. After creating a separate iommmu address space
>>>> for each attached PCI device I can successfully run the vfio type1
>>>> iommu. So If we could extend type1 not registering all guest memory
>>>> (see patch) I think we do not need a special vfio iommu for s390
>>>> for the moment.
>>>>
>>>> The patches implement the base pass-through support. s390 specific
>>>> virtualization functions are currently not included. This would
>>>> be a second step after the base support is done.
>>>>
>>>> kernel patches apply to linux-kvm-next
>>>>
>>>> KVM: s390: Enable PCI instructions
>>>> iommu: add iommu for s390 platform
>>>> vfio: make vfio build on s390
>>>>
>>>> qemu patches apply to qemu-master
>>>>
>>>> s390: Add PCI bus support
>>>> s390: implement pci instruction
>>>> vfio: make vfio run on s390 platform
>>>>
>>>> Thx for feedback and review comments
>>>
>>> Sending patches as attachments makes it difficult to comment inline.
>>>
>>> 2/6
>>>  - careful of the namespace as you're changing functions from static and
>>> exporting them
>>>  - doesn't seem like functions need to be exported, just non-static to
>>> call from s390-iommu.c
>>>
>>> 6/6
>>>  - We shouldn't need to globally disable mmap, each VFIO region reports
>>> whether it supports mmap and vfio-pci on s390 should indicate mmap is
>>> not supported on the platform.
>>
>> Can we emulate MMIO on mmap'ed regions by routing every memory access
>> via the kernel? It'd be slow, but at least make existing VFIO code
>> compatible.
> 
> Isn't that effectively what we do when we use memory_region_init_io() vs
> memory_region_init_ram_ptr() or are you suggesting something that can
> handle the MMIO without bouncing out to QEMU?  VFIO is already
> compatible with regions that cannot be mmap'd, the kernel just needs to
> report it as such.  Thanks,

Ah, cool. I guess I missed that part :). Then all is well.


Alex
