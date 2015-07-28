From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 28 Jul 2015 19:17:18 +0200
Message-ID: <55B7B91E.40200@siemens.com>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
	<55B73A49.9050206@redhat.com>
	<1438078345.7562.133.camel@kernel.crashing.org>
	<55B7799C.3060908@redhat.com>
	<20150728160358-mutt-send-email-mst@redhat.com>
	<55B77F8C.7010804@siemens.com>
	<CALCETrVF1-=z60bCtsMBctbd14zjJgpUPNNo+EcJj_fXhww1og@mail.gmail.com>
	<55B7B15C.4010101@siemens.com>
	<CALCETrW_7tmUg1zf3m1xYeSruW8njNYP9N4s8tBKJcTGJf_0QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrW_7tmUg1zf3m1xYeSruW8njNYP9N4s8tBKJcTGJf_0QA@mail.gmail.com>
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

On 2015-07-28 19:10, Andy Lutomirski wrote:
> On Tue, Jul 28, 2015 at 9:44 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> The ability to have virtio on systems with IOMMU in place makes testing
>> much more efficient for us. Ideally, we would have it in non-identity
>> mapping scenarios as well, e.g. to start secondary Linux instances in
>> the test VMs, giving them their own virtio devices. And we will
>> eventually have this need on ARM as well.
>>
>> Virtio needs to be backward compatible, so the change to put these
>> devices under IOMMU control could be advertised during feature
>> negotiations and controlled on QEMU side via a device property. Newer
>> guest drivers would have to acknowledge that they support virtio via
>> IOMMUs. Older ones would refuse to work, and the admin could instead
>> spawn VMs with this feature disabled.
>>
> 
> The trouble is that this is really a property of the bus and not of
> the device.  If you build a virtio device that physically plugs into a
> PCIe slot, the device has no concept of an IOMMU in the first place.

If one would build a real virtio device today, it would be broken
because every IOMMU would start to translate its requests. Already from
that POV, we really need to introduce a feature flag "I will be
IOMMU-translated" so that a potential physical implementation can carry
it unconditionally.

> Similarly, if you take an L0-provided IOMMU-supporting device and pass
> it through to L2 using current QEMU on L1 (with Q35 emulation and
> iommu enabled), then, from L2's perspective, the device is 1:1 no
> matter what the device thinks.
> 
> IOW, I think the original design was wrong and now we have to deal
> with it.  I think the best solution would be to teach QEMU to fix its
> ACPI tables so that 1:1 virtio devices are actually exposed as 1:1.

Only the current drivers are broken. And we can easily tell them apart
from newer ones via feature flags. Sorry, don't get the problem.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
