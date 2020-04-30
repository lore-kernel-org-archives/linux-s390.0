Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49034 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726543AbgD3IUg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 04:20:36 -0400
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: Introduce MHP_DRIVER_MANAGED
References: <20200429160803.109056-1-david@redhat.com>
 <20200429160803.109056-3-david@redhat.com>
 <a7305cd8-8b2f-1d8f-7654-ecf777c46df6@redhat.com>
 <CAPcyv4i04+QLxiOyz04_eef2DFetEFKBUmi2A4xxw9abQD8hNQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e32522cd-31bb-e129-47a6-9ec13b570506@redhat.com>
Date: Thu, 30 Apr 2020 10:20:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i04+QLxiOyz04_eef2DFetEFKBUmi2A4xxw9abQD8hNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-hyperv@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dave Hansen <dave.hansen@linux.intel.com>

On 30.04.20 10:11, Dan Williams wrote:
> On Thu, Apr 30, 2020 at 12:20 AM David Hildenbrand <david@redhat.com> w=
rote:
>>
>> On 29.04.20 18:08, David Hildenbrand wrote:
>>> Some paravirtualized devices that add memory via add_memory() and
>>> friends (esp. virtio-mem) don't want to create entries in
>>> /sys/firmware/memmap/ - primarily to hinder kexec from adding this
>>> memory to the boot memmap of the kexec kernel.
>>>
>>> In fact, such memory is never exposed via the firmware (e.g., e820), =
but
>>> only via the device, so exposing this memory via /sys/firmware/memmap=
/ is
>>> wrong:
>>>  "kexec needs the raw firmware-provided memory map to setup the
>>>   parameter segment of the kernel that should be booted with
>>>   kexec. Also, the raw memory map is useful for debugging. For
>>>   that reason, /sys/firmware/memmap is an interface that provides
>>>   the raw memory map to userspace." [1]
>>>
>>> We want to let user space know that memory which is always detected,
>>> added, and managed via a (device) driver - like memory managed by
>>> virtio-mem - is special. It cannot be used for placing kexec segments
>>> and the (device) driver is responsible for re-adding memory that
>>> (eventually shrunk/grown/defragmented) memory after a reboot/kexec. I=
t
>>> should e.g., not be added to a fixed up firmware memmap. However, it =
should
>>> be dumped by kdump.
>>>
>>> Also, such memory could behave differently than an ordinary DIMM - e.=
g.,
>>> memory managed by virtio-mem can have holes inside added memory resou=
rce,
>>> which should not be touched, especially for writing.
>>>
>>> Let's expose that memory as "System RAM (driver managed)" e.g., via
>>> /pro/iomem.
>>>
>>> We don't have to worry about firmware_map_remove() on the removal pat=
h.
>>> If there is no entry, it will simply return with -EINVAL.
>>>
>>> [1] https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmwa=
re-memmap
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>> Cc: Wei Yang <richard.weiyang@gmail.com>
>>> Cc: Baoquan He <bhe@redhat.com>
>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  include/linux/memory_hotplug.h |  8 ++++++++
>>>  mm/memory_hotplug.c            | 20 ++++++++++++++++----
>>>  2 files changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_ho=
tplug.h
>>> index bf0e3edb8688..cc538584b39e 100644
>>> --- a/include/linux/memory_hotplug.h
>>> +++ b/include/linux/memory_hotplug.h
>>> @@ -68,6 +68,14 @@ struct mhp_params {
>>>       pgprot_t pgprot;
>>>  };
>>>
>>> +/* Flags used for add_memory() and friends. */
>>> +
>>> +/*
>>> + * Don't create entries in /sys/firmware/memmap/ and expose memory a=
s
>>> + * "System RAM (driver managed)" in e.g., /proc/iomem
>>> + */
>>> +#define MHP_DRIVER_MANAGED           1
>>> +
>>>  /*
>>>   * Zone resizing functions
>>>   *
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index ebdf6541d074..cfa0721280aa 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -98,11 +98,11 @@ void mem_hotplug_done(void)
>>>  u64 max_mem_size =3D U64_MAX;
>>>
>>>  /* add this memory to iomem resource */
>>> -static struct resource *register_memory_resource(u64 start, u64 size=
)
>>> +static struct resource *register_memory_resource(u64 start, u64 size=
,
>>> +                                              const char *resource_n=
ame)
>>>  {
>>>       struct resource *res;
>>>       unsigned long flags =3D  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUS=
Y;
>>> -     char *resource_name =3D "System RAM";
>>>
>>>       /*
>>>        * Make sure value parsed from 'mem=3D' only restricts memory a=
dding
>>> @@ -1058,7 +1058,8 @@ int __ref add_memory_resource(int nid, struct r=
esource *res,
>>>       BUG_ON(ret);
>>>
>>>       /* create new memmap entry */
>>> -     firmware_map_add_hotplug(start, start + size, "System RAM");
>>> +     if (!(flags & MHP_DRIVER_MANAGED))
>>> +             firmware_map_add_hotplug(start, start + size, "System R=
AM");
>>>
>>>       /* device_online() will take the lock when calling online_pages=
() */
>>>       mem_hotplug_done();
>>> @@ -1081,10 +1082,21 @@ int __ref add_memory_resource(int nid, struct=
 resource *res,
>>>  /* requires device_hotplug_lock, see add_memory_resource() */
>>>  int __ref __add_memory(int nid, u64 start, u64 size, unsigned long f=
lags)
>>>  {
>>> +     const char *resource_name =3D "System RAM";
>>>       struct resource *res;
>>>       int ret;
>>>
>>> -     res =3D register_memory_resource(start, size);
>>> +     /*
>>> +      * Indicate that memory managed by a driver is special. It's al=
ways
>>> +      * detected and added via a driver, should not be given to the =
kexec
>>> +      * kernel for booting when manually crafting the firmware memma=
p, and
>>> +      * no kexec segments should be placed on it. However, kdump sho=
uld
>>> +      * dump this memory.
>>> +      */
>>> +     if (flags & MHP_DRIVER_MANAGED)
>>> +             resource_name =3D "System RAM (driver managed)";
>>> +
>>> +     res =3D register_memory_resource(start, size, resource_name);
>>>       if (IS_ERR(res))
>>>               return PTR_ERR(res);
>>>
>>>
>>
>> BTW, I was wondering if this is actually also something that
>> drivers/dax/kmem.c wants to use for adding memory.
>>
>> Just because we decided to use some DAX memory in the current kernel a=
s
>> system ram, doesn't mean we should make that decision for the kexec
>> kernel (e.g., using it as initial memory, placing kexec binaries onto
>> it, etc.). This is also not what we would observe during a real reboot=
.
>=20
> Agree.
>=20
>> I can see that the "System RAM" resource will show up as child resourc=
e
>> under the device e.g., in /proc/iomem.
>>
>> However, entries in /sys/firmware/memmap/ are created as "System RAM".
>=20
> True. Do you think this rename should just be limited to what type
> /sys/firmware/memmap/ emits? I have the concern, but no proof

We could split this patch into

MHP_NO_FIRMWARE_MEMMAP (create firmware memmap entries)

and

MHP_DRIVER_MANAGED (name of the resource)

See below, the latter might not be needed.

> currently, that there are /proc/iomem walkers that explicitly look for
> "System RAM", but might be thrown off by "System RAM (driver
> managed)". I was not aware of /sys/firmware/memmap until about 5
> minutes ago.

The only two users of /proc/iomem I am aware of are kexec-tools and some
s390x tools.

kexec-tools on x86-64 uses /sys/firmware/memmap to craft the initial
memmap, but uses /proc/iomem to
a) Find places for kexec images
b) Detect memory regions to dump via kdump

I am not yet sure if we really need the "System RAM (driver managed)"
part. If we can teach kexec-tools to
a) Don't place kexec images on "System RAM" that has a parent resource
(most likely requires kexec-tools changes)
b) Consider for kdump "System RAM" that has a parent resource
we might be able to avoid renaming that. (I assume that's already done)

E.g., regarding virtio-mem (patch #3) I am currently also looking into
creating a parent resource instead, like dax/kmem to avoid the rename:

:/# cat /proc/iomem
00000000-00000fff : Reserved
[...]
100000000-13fffffff : System RAM
140000000-33fffffff : virtio0
  140000000-147ffffff : System RAM
  148000000-14fffffff : System RAM
  150000000-157ffffff : System RAM
340000000-303fffffff : virtio1
  340000000-347ffffff : System RAM
3280000000-32ffffffff : PCI Bus 0000:00



--=20
Thanks,

David / dhildenb
