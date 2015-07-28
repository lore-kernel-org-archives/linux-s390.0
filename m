From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 28 Jul 2015 15:11:40 +0200
Message-ID: <55B77F8C.7010804@siemens.com>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
	<55B73A49.9050206@redhat.com>
	<1438078345.7562.133.camel@kernel.crashing.org>
	<55B7799C.3060908@redhat.com>
	<20150728160358-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150728160358-mutt-send-email-mst@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, xen-devel <Xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On 2015-07-28 15:06, Michael S. Tsirkin wrote:
> On Tue, Jul 28, 2015 at 02:46:20PM +0200, Paolo Bonzini wrote:
>>
>>
>> On 28/07/2015 12:12, Benjamin Herrenschmidt wrote:
>>>>> That is an experimental feature (it's x-iommu), so it can change.
>>>>>
>>>>> The plan was:
>>>>>
>>>>> - for PPC, virtio never honors IOMMU
>>>>>
>>>>> - for non-PPC, either have virtio always honor IOMMU, or enforce that
>>>>> virtio is not under IOMMU.
>>>>>
>>> I dislike having PPC special cased.
>>>
>>> In fact, today x86 guests also assume that virtio bypasses IOMMU I
>>> believe. In fact *all* guests do.
>>
>> This doesn't matter much, since the only guests that implement an IOMMU
>> in QEMU are (afaik) PPC and x86, and x86 does not yet promise any kind
>> of stability.
> 
> Hmm I think Jan (cc) said it was already used out there.

Yes, no known issues with vt-d emulation for almost a year now. Error
reporting could be improved, and interrupt remapping is still missing,
but those are minor issues in this context.

In my testing setups, I also have virtio devices in use, passed through
to an L2 guest, but only in 1:1 mapping so that their broken IOMMU
support causes no practical problems.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
