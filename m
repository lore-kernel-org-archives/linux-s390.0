Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59765 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726548AbgEBJ06 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 2 May 2020 05:26:58 -0400
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce
 MHP_NO_FIRMWARE_MEMMAP
References: <20200430102908.10107-1-david@redhat.com>
 <875zdg26hp.fsf@x220.int.ebiederm.org>
 <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
 <20200430152403.e0d6da5eb1cad06411ac6d46@linux-foundation.org>
 <5c908ec3-9495-531e-9291-cbab24f292d6@redhat.com>
 <CAPcyv4j=YKnr1HW4OhAmpzbuKjtfP7FdAn4-V7uA=b-Tcpfu+A@mail.gmail.com>
 <2d019c11-a478-9d70-abd5-4fd2ebf4bc1d@redhat.com>
 <CAPcyv4iOqS0Wbfa2KPfE1axQFGXoRB4mmPRP__Lmqpw6Qpr_ig@mail.gmail.com>
 <62dd4ce2-86cc-5b85-734f-ec8766528a1b@redhat.com>
 <0169e822-a6cc-1543-88ed-2a85d95ffb93@redhat.com>
 <CAPcyv4jGnR_fPtpKBC1rD2KRcT88bTkhqnTMmuwuc+f9Dwrz1g@mail.gmail.com>
 <9f3a813e-dc1d-b675-6e69-85beed3057a4@redhat.com>
 <CAPcyv4jjrxQ27rsfmz6wYPgmedevU=KG+wZ0GOm=qiE6tqa+VA@mail.gmail.com>
 <04242d48-5fa9-6da4-3e4a-991e401eb580@redhat.com>
 <CAPcyv4iXyOUDZgqhWH1KCObvATL=gP55xEr64rsRfUuJg5B+eQ@mail.gmail.com>
 <8242c0c5-2df2-fc0c-079a-3be62c113a11@redhat.com>
 <CAPcyv4h1nWjszkVJQgeXkUc=-nPv5=Me25BOGFQCpihUyFsD6w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <467ccba3-80ac-085c-3127-d5618d77d3e0@redhat.com>
Date: Sat, 2 May 2020 11:26:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h1nWjszkVJQgeXkUc=-nPv5=Me25BOGFQCpihUyFsD6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-hyperv@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Michal Hocko <mhocko@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>

>> Now, let's clarify what I want regarding virtio-mem:
>>
>> 1. kexec should not add virtio-mem memory to the initial firmware
>>    memmap. The driver has to be in charge as discussed.
>> 2. kexec should not place kexec images onto virtio-mem memory. That
>>    would end badly.
>> 3. kexec should still dump virtio-mem memory via kdump.
>=20
> Ok, but then seems to say to me that dax/kmem is a different type of
> (driver managed) than virtio-mem and it's confusing to try to apply
> the same meaning. Why not just call your type for the distinct type it
> is "System RAM (virtio-mem)" and let any other driver managed memory
> follow the same "System RAM ($driver)" format if it wants?

I had the same idea but discarded it because it seemed to uglify the
add_memory() interface (passing yet another parameter only relevant for
driver managed memory). Maybe we really want a new one, because I like
that idea:

/*
 * Add special, driver-managed memory to the system as system ram.
 * The resource_name is expected to have the name format "System RAM
 * ($DRIVER)", so user space (esp. kexec-tools)" can special-case it.
 *
 * For this memory, no entries in /sys/firmware/memmap are created,
 * as this memory won't be part of the raw firmware-provided memory map
 * e.g., after a reboot. Also, the created memory resource is flagged
 * with IORESOURCE_MEM_DRIVER_MANAGED, so in-kernel users can special-
 * case this memory (e.g., not place kexec images onto it).
 */
int add_memory_driver_managed(int nid, u64 start, u64 size,
			      const char *resource_name);


If we'd ever have to special case it even more in the kernel, we could
allow to specify further resource flags. While passing the driver name
instead of the resource_name would be an option, this way we don't have
to hand craft new resource strings for added memory resources.

Thoughts?

--=20
Thanks,

David / dhildenb
