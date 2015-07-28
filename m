From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 28 Jul 2015 18:44:12 +0200
Message-ID: <55B7B15C.4010101@siemens.com>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
	<55B73A49.9050206@redhat.com>
	<1438078345.7562.133.camel@kernel.crashing.org>
	<55B7799C.3060908@redhat.com>
	<20150728160358-mutt-send-email-mst@redhat.com>
	<55B77F8C.7010804@siemens.com>
	<CALCETrVF1-=z60bCtsMBctbd14zjJgpUPNNo+EcJj_fXhww1og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrVF1-=z60bCtsMBctbd14zjJgpUPNNo+EcJj_fXhww1og@mail.gmail.com>
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
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, xen-devel <Xen-devel@lists.xen.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On 2015-07-28 18:11, Andy Lutomirski wrote:
> On Jul 28, 2015 6:11 AM, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>>
>> On 2015-07-28 15:06, Michael S. Tsirkin wrote:
>>> On Tue, Jul 28, 2015 at 02:46:20PM +0200, Paolo Bonzini wrote:
>>>>
>>>>
>>>> On 28/07/2015 12:12, Benjamin Herrenschmidt wrote:
>>>>>>> That is an experimental feature (it's x-iommu), so it can change.
>>>>>>>
>>>>>>> The plan was:
>>>>>>>
>>>>>>> - for PPC, virtio never honors IOMMU
>>>>>>>
>>>>>>> - for non-PPC, either have virtio always honor IOMMU, or enforce that
>>>>>>> virtio is not under IOMMU.
>>>>>>>
>>>>> I dislike having PPC special cased.
>>>>>
>>>>> In fact, today x86 guests also assume that virtio bypasses IOMMU I
>>>>> believe. In fact *all* guests do.
>>>>
>>>> This doesn't matter much, since the only guests that implement an IOMMU
>>>> in QEMU are (afaik) PPC and x86, and x86 does not yet promise any kind
>>>> of stability.
>>>
>>> Hmm I think Jan (cc) said it was already used out there.
>>
>> Yes, no known issues with vt-d emulation for almost a year now. Error
>> reporting could be improved, and interrupt remapping is still missing,
>> but those are minor issues in this context.
>>
>> In my testing setups, I also have virtio devices in use, passed through
>> to an L2 guest, but only in 1:1 mapping so that their broken IOMMU
>> support causes no practical problems.
>>
> 
> How are you getting 1:1 to work?  Is it something that L0 QEMU can
> advertise to L1?  If so, can we just do that unconditionally, which
> would make my patch work?

The guest hypervisor is Jailhouse and the guest is the root cell that
loaded the hypervisor, thus continues with identity mappings. You
usually don't have 1:1 mapping with other setups - maybe with some Xen
configuration? Dunno.

> 
> I have no objection to 1:1 devices in general.  It's only devices that
> the PCI code on the guest identifies as not 1:1 but that are
> nonetheless 1:1 that cause problems.

The ability to have virtio on systems with IOMMU in place makes testing
much more efficient for us. Ideally, we would have it in non-identity
mapping scenarios as well, e.g. to start secondary Linux instances in
the test VMs, giving them their own virtio devices. And we will
eventually have this need on ARM as well.

Virtio needs to be backward compatible, so the change to put these
devices under IOMMU control could be advertised during feature
negotiations and controlled on QEMU side via a device property. Newer
guest drivers would have to acknowledge that they support virtio via
IOMMUs. Older ones would refuse to work, and the admin could instead
spawn VMs with this feature disabled.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
