Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce
 MHP_NO_FIRMWARE_MEMMAP
References: <20200430102908.10107-1-david@redhat.com>
 <20200430102908.10107-3-david@redhat.com>
 <87pnbp2dcz.fsf@x220.int.ebiederm.org>
 <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
 <871ro52ary.fsf@x220.int.ebiederm.org>
 <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com>
 <875zdg26hp.fsf@x220.int.ebiederm.org>
 <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
 <20200430152403.e0d6da5eb1cad06411ac6d46@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5c908ec3-9495-531e-9291-cbab24f292d6@redhat.com>
Date: Fri, 1 May 2020 11:34:22 +0200
MIME-Version: 1.0
In-Reply-To: <20200430152403.e0d6da5eb1cad06411ac6d46@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>

On 01.05.20 00:24, Andrew Morton wrote:
> On Thu, 30 Apr 2020 20:43:39 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>>
>>> Why does the firmware map support hotplug entries?
>>
>> I assume:
>>
>> The firmware memmap was added primarily for x86-64 kexec (and still, is
>> mostly used on x86-64 only IIRC). There, we had ACPI hotplug. When DIMMs
>> get hotplugged on real HW, they get added to e820. Same applies to
>> memory added via HyperV balloon (unless memory is unplugged via
>> ballooning and you reboot ... the the e820 is changed as well). I assume
>> we wanted to be able to reflect that, to make kexec look like a real reboot.
>>
>> This worked for a while. Then came dax/kmem. Now comes virtio-mem.
>>
>>
>> But I assume only Andrew can enlighten us.
>>
>> @Andrew, any guidance here? Should we really add all memory to the
>> firmware memmap, even if this contradicts with the existing
>> documentation? (especially, if the actual firmware memmap will *not*
>> contain that memory after a reboot)
> 
> For some reason that patch is misattributed - it was authored by
> Shaohui Zheng <shaohui.zheng@intel.com>, who hasn't been heard from in
> a decade.  I looked through the email discussion from that time and I'm
> not seeing anything useful.  But I wasn't able to locate Dave Hansen's
> review comments.

Okay, thanks for checking. I think the documentation from 2008 is pretty
clear what has to be done here. I will add some of these details to the
patch description.

Also, now that I know that esp. kexec-tools already don't consider
dax/kmem memory properly (memory will not get dumped via kdump) and
won't really suffer from a name change in /proc/iomem, I will go back to
the MHP_DRIVER_MANAGED approach and
1. Don't create firmware memmap entries
2. Name the resource "System RAM (driver managed)"
3. Flag the resource via something like IORESOURCE_MEM_DRIVER_MANAGED.

This way, kernel users and user space can figure out that this memory
has different semantics and handle it accordingly - I think that was
what Eric was asking for.

Of course, open for suggestions.

-- 
Thanks,

David / dhildenb
