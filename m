Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH RFC 7/7] mm: better document PG_reserved
References: <20181205122851.5891-1-david@redhat.com>
 <20181205122851.5891-8-david@redhat.com>
 <20181205143510.GA17232@bombadil.infradead.org>
 <46d0e90f-f0bb-815e-7a5b-4429de1c502a@redhat.com>
 <20181205173201.GA11646@bombadil.infradead.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <35689ede-d86e-d692-adae-bc2f1adfb2ab@redhat.com>
Date: Wed, 5 Dec 2018 19:13:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181205173201.GA11646@bombadil.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>, yi.z.zhang@linux.intel.com, Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org, Miles Chen <miles.chen@mediatek.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On 05.12.18 18:32, Matthew Wilcox wrote:
> On Wed, Dec 05, 2018 at 04:05:12PM +0100, David Hildenbrand wrote:
>> On 05.12.18 15:35, Matthew Wilcox wrote:
>>> On Wed, Dec 05, 2018 at 01:28:51PM +0100, David Hildenbrand wrote:
>>>> I don't see a reason why we have to document "Some of them might not even
>>>> exist". If there is a user, we should document it. E.g. for balloon
>>>> drivers we now use PG_offline to indicate that a page might currently
>>>> not be backed by memory in the hypervisor. And that is independent from
>>>> PG_reserved.
>>>
>>> I think you're confused by the meaning of "some of them might not even
>>> exist".  What this means is that there might not be memory there; maybe
>>> writes to that memory will be discarded, or maybe they'll cause a machine
>>> check.  Maybe reads will return ~0, or 0, or cause a machine check.
>>> We just don't know what's there, and we shouldn't try touching the memory.
>>
>> If there are users, let's document it. And I need more details for that :)
>>
>> 1. machine check: if there is a HW error, we set PG_hwpoison (except
>> ia64 MCA, see the list)
>>
>> 2. Writes to that memory will be discarded
>>
>> Who is the user of that? When will we have such pages right now?
>>
>> 3. Reads will return ~0, / 0?
>>
>> I think this is a special case of e.g. x86? But where do we have that,
>> are there any user?
> 
> When there are gaps in the physical memory.  As in, if you put that
> physical address on the bus (or in a packet), no device will respond
> to it.  Look:
> 
> 00000000-00000fff : Reserved
> 00001000-00057fff : System RAM
> 00058000-00058fff : Reserved
> 00059000-0009dfff : System RAM
> 0009e000-000fffff : Reserved
> 
> Those examples I gave are examples of how various different architectures
> respond to "no device responded to this memory access".
> 

Okay, so for this memory we will have
a) vmmaps
b) Memory block devices
c) A sections that is online

So essentially "Gaps in physical memory" which is part of a online section.

This might be a candidate for PG_offline as well.

Thanks for the info, I'll try to find out how such things are handled.
In general I assume this memory has to be readable, because otherwise
kdump and friends would crash already when trying to dump?

-- 

Thanks,

David / dhildenb

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
