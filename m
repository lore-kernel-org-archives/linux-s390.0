Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgIIL2a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Sep 2020 07:28:30 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 3/7] mm/memory_hotplug: prepare passing flags to add_memory() and friends
In-Reply-To: <3bc5b464-3229-d442-714a-ec33b5728ac6@redhat.com>
References: <20200908201012.44168-1-david@redhat.com> <20200908201012.44168-4-david@redhat.com> <20200909071759.GD435421@kroah.com> <3bc5b464-3229-d442-714a-ec33b5728ac6@redhat.com>
Date: Wed, 09 Sep 2020 21:24:02 +1000
Message-ID: <87eenbry5p.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oliver O'Halloran <oohall@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, Nathan Lynch <nathanl@linux.ibm.com>, Libor Pechacek <lpechacek@suse.cz>, Anton Blanchard <anton@ozlabs.org>, Leonardo Bras <leobras.c@gmail.com>, linuxppc-dev@lists.ozlabs.org

David Hildenbrand <david@redhat.com> writes:
> On 09.09.20 09:17, Greg Kroah-Hartman wrote:
>> On Tue, Sep 08, 2020 at 10:10:08PM +0200, David Hildenbrand wrote:
>>> We soon want to pass flags, e.g., to mark added System RAM resources.
>>> mergeable. Prepare for that.
>> 
>> What are these random "flags", and how do we know what should be passed
>> to them?
>> 
>> Why not make this an enumerated type so that we know it all works
>> properly, like the GPF_* flags are?  Passing around a random unsigned
>> long feels very odd/broken...
>
> Agreed, an enum (mhp_flags) seems to give a better hint what can
> actually be passed. Thanks!

You probably know this but ...

Just using a C enum doesn't get you any type safety.

You can get some checking via sparse by using __bitwise, which is what
gfp_t does. You don't actually have to use an enum for that, it works
with #defines also.

Or you can wrap the flag in a struct, the way atomic_t does, and then
the compiler will prevent passing plain integers in place of your custom
type.

cheers
