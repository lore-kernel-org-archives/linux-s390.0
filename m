Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730115AbgIIMAQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Sep 2020 08:00:16 -0400
Subject: Re: [PATCH v2 3/7] mm/memory_hotplug: prepare passing flags to
 add_memory() and friends
From: David Hildenbrand <david@redhat.com>
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-4-david@redhat.com> <20200909071759.GD435421@kroah.com>
 <3bc5b464-3229-d442-714a-ec33b5728ac6@redhat.com>
 <87eenbry5p.fsf@mpe.ellerman.id.au>
 <5145c5c4-d9c0-85a8-7e0b-ccfa03eb0427@redhat.com>
Message-ID: <4e83103c-14a0-6cc4-ae1b-438282edaea3@redhat.com>
Date: Wed, 9 Sep 2020 13:51:41 +0200
MIME-Version: 1.0
In-Reply-To: <5145c5c4-d9c0-85a8-7e0b-ccfa03eb0427@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oliver O'Halloran <oohall@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, Nathan Lynch <nathanl@linux.ibm.com>, Libor Pechacek <lpechacek@suse.cz>, Anton Blanchard <anton@ozlabs.org>, Leonardo Bras <leobras.c@gmail.com>, linuxppc-dev@lists.ozlabs.org

On 09.09.20 13:37, David Hildenbrand wrote:
> On 09.09.20 13:24, Michael Ellerman wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>> On 09.09.20 09:17, Greg Kroah-Hartman wrote:
>>>> On Tue, Sep 08, 2020 at 10:10:08PM +0200, David Hildenbrand wrote:
>>>>> We soon want to pass flags, e.g., to mark added System RAM resources.
>>>>> mergeable. Prepare for that.
>>>>
>>>> What are these random "flags", and how do we know what should be passed
>>>> to them?
>>>>
>>>> Why not make this an enumerated type so that we know it all works
>>>> properly, like the GPF_* flags are?  Passing around a random unsigned
>>>> long feels very odd/broken...
>>>
>>> Agreed, an enum (mhp_flags) seems to give a better hint what can
>>> actually be passed. Thanks!
>>
>> You probably know this but ...
>>
>> Just using a C enum doesn't get you any type safety.
>>
>> You can get some checking via sparse by using __bitwise, which is what
>> gfp_t does. You don't actually have to use an enum for that, it works
>> with #defines also.
> 
> Yeah, we seem to be using different approaches. And there is always a
> way to mess things up :)
> 
> gfp_t is one (extreme) example, enum memblock_flags is another example.
> I tend to prefer an enum in this particular case, because it's simple
> and at least tells the user which values are expected.
> 

Gave it another try, looks like mhp_t (like gfp_t) is actually nicer.

-- 
Thanks,

David / dhildenb
