Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44867 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726764AbgD3Pwu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:52:50 -0400
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce
 MHP_NO_FIRMWARE_MEMMAP
References: <20200430102908.10107-1-david@redhat.com>
 <20200430102908.10107-3-david@redhat.com>
 <87pnbp2dcz.fsf@x220.int.ebiederm.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
Date: Thu, 30 Apr 2020 17:52:35 +0200
MIME-Version: 1.0
In-Reply-To: <87pnbp2dcz.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>

On 30.04.20 17:38, Eric W. Biederman wrote:
> David Hildenbrand <david@redhat.com> writes:
>=20
>> Some devices/drivers that add memory via add_memory() and friends (e.g=
.,
>> dax/kmem, but also virtio-mem in the future) don't want to create entr=
ies
>> in /sys/firmware/memmap/ - primarily to hinder kexec from adding this
>> memory to the boot memmap of the kexec kernel.
>>
>> In fact, such memory is never exposed via the firmware memmap as Syste=
m
>> RAM (e.g., e820), so exposing this memory via /sys/firmware/memmap/ is
>> wrong:
>>  "kexec needs the raw firmware-provided memory map to setup the
>>   parameter segment of the kernel that should be booted with
>>   kexec. Also, the raw memory map is useful for debugging. For
>>   that reason, /sys/firmware/memmap is an interface that provides
>>   the raw memory map to userspace." [1]
>>
>> We don't have to worry about firmware_map_remove() on the removal path=
.
>> If there is no entry, it will simply return with -EINVAL.
>>
>> [1]
>> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmware-me=
mmap
>=20
>=20
> You know what this justification is rubbish, and I have previously
> explained why it is rubbish.

Actually, no, I don't think it is rubbish. See patch #3 and the cover
letter why this is the right thing to do *for special memory*, *not
ordinary DIMMs*.

And to be quite honest, I think your response is a little harsh. I don't
recall you replying to my virtio-mem-related comments.

>=20
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>=20
> This needs to be based on weather the added memory is ultimately normal
> ram or is something special.

Yes, that's what the caller are expected to decide, see patch #3.

kexec should try to be as closely as possible to a real reboot - IMHO.

>=20
> At least when we are talking memory resources.  Keeping it out of the
> firmware map that is fine.
>=20
> If the hotplugged memory is the result of plugging a stick of ram
> into the kernel and can and should used be like any other memory
> it should be treated like any normal memory.
>=20
> If the hotplugged memory is something special it should be treated as
> something special.

I am really sorry, I can't make sense of what you are trying to say here.

>=20
> Justifying behavior by documentation that does not consider memory
> hotplug is bad thinking.

Are you maybe confusing this patch series with the arm64 approach? This
is not about ordinary hotplugged DIMMs.

I'd love to get Dan's, Dave's and Michal's opinion.

--=20
Thanks,

David / dhildenb
