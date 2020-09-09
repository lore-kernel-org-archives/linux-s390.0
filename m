Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729935AbgIIH2g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Sep 2020 03:28:36 -0400
Subject: Re: [PATCH v2 2/7] kernel/resource: move and rename
 IORESOURCE_MEM_DRIVER_MANAGED
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-3-david@redhat.com> <20200909071646.GC435421@kroah.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <811d0506-5da0-c01f-6d5c-d902f12911c8@redhat.com>
Date: Wed, 9 Sep 2020 09:27:42 +0200
MIME-Version: 1.0
In-Reply-To: <20200909071646.GC435421@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, kexec@lists.infradead.org

On 09.09.20 09:16, Greg Kroah-Hartman wrote:
> On Tue, Sep 08, 2020 at 10:10:07PM +0200, David Hildenbrand wrote:
>> IORESOURCE_MEM_DRIVER_MANAGED currently uses an unused PnP bit, which is
>> always set to 0 by hardware. This is far from beautiful (and confusing),
>> and the bit only applies to SYSRAM. So let's move it out of the
>> bus-specific (PnP) defined bits.
>>
>> We'll add another SYSRAM specific bit soon. If we ever need more bits for
>> other purposes, we can steal some from "desc", or reshuffle/regroup what we
>> have.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: kexec@lists.infradead.org
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/linux/ioport.h | 4 +++-
>>  kernel/kexec_file.c    | 2 +-
>>  mm/memory_hotplug.c    | 4 ++--
>>  3 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index 52a91f5fa1a36..d7620d7c941a0 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -58,6 +58,9 @@ struct resource {
>>  #define IORESOURCE_EXT_TYPE_BITS 0x01000000	/* Resource extended types */
>>  #define IORESOURCE_SYSRAM	0x01000000	/* System RAM (modifier) */
>>  
>> +/* IORESOURCE_SYSRAM specific bits. */
>> +#define IORESOURCE_SYSRAM_DRIVER_MANAGED	0x02000000 /* Always detected via a driver. */
>> +
> 
> Can't you use BIT() here?

I could, but this will make it look different to all other IORESOURCE_*
definitions?

If so, we should change all existing definitions - however the ones
spanning multiple bits might turn out rather ugly, like

#define IORESOURCE_TYPE_BITS    0x00001f00

Thoughts? Thanks

> 
> thanks,
> 
> greg k-h
> 


-- 
Thanks,

David / dhildenb
