Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:50172 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgD3Pl0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:41:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200430102908.10107-1-david@redhat.com>
        <20200430102908.10107-3-david@redhat.com>
Date: Thu, 30 Apr 2020 10:38:04 -0500
In-Reply-To: <20200430102908.10107-3-david@redhat.com> (David Hildenbrand's
        message of "Thu, 30 Apr 2020 12:29:07 +0200")
Message-ID: <87pnbp2dcz.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce MHP_NO_FIRMWARE_MEMMAP
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>

David Hildenbrand <david@redhat.com> writes:

> Some devices/drivers that add memory via add_memory() and friends (e.g.,
> dax/kmem, but also virtio-mem in the future) don't want to create entries
> in /sys/firmware/memmap/ - primarily to hinder kexec from adding this
> memory to the boot memmap of the kexec kernel.
>
> In fact, such memory is never exposed via the firmware memmap as System
> RAM (e.g., e820), so exposing this memory via /sys/firmware/memmap/ is
> wrong:
>  "kexec needs the raw firmware-provided memory map to setup the
>   parameter segment of the kernel that should be booted with
>   kexec. Also, the raw memory map is useful for debugging. For
>   that reason, /sys/firmware/memmap is an interface that provides
>   the raw memory map to userspace." [1]
>
> We don't have to worry about firmware_map_remove() on the removal path.
> If there is no entry, it will simply return with -EINVAL.
>
> [1]
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmware-memmap


You know what this justification is rubbish, and I have previously
explained why it is rubbish.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

This needs to be based on weather the added memory is ultimately normal
ram or is something special.

At least when we are talking memory resources.  Keeping it out of the
firmware map that is fine.

If the hotplugged memory is the result of plugging a stick of ram
into the kernel and can and should used be like any other memory
it should be treated like any normal memory.

If the hotplugged memory is something special it should be treated as
something special.

Justifying behavior by documentation that does not consider memory
hotplug is bad thinking.








> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/memory_hotplug.h | 8 ++++++++
>  mm/memory_hotplug.c            | 3 ++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 0151fb935c09..4ca418a731eb 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -68,6 +68,14 @@ struct mhp_params {
>  	pgprot_t pgprot;
>  };
>  
> +/* Flags used for add_memory() and friends. */
> +
> +/*
> + * Don't create entries in /sys/firmware/memmap/. The memory is detected and
> + * added via a device driver, not via the initial (firmware) memmap.
> + */
> +#define MHP_NO_FIRMWARE_MEMMAP		1
> +
>  /*
>   * Zone resizing functions
>   *
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c01be92693e3..e94ede9cad00 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1062,7 +1062,8 @@ int __ref add_memory_resource(int nid, struct resource *res,
>  	BUG_ON(ret);
>  
>  	/* create new memmap entry */
> -	firmware_map_add_hotplug(start, start + size, "System RAM");
> +	if (!(flags & MHP_NO_FIRMWARE_MEMMAP))
> +		firmware_map_add_hotplug(start, start + size, "System RAM");
>  
>  	/* device_online() will take the lock when calling online_pages() */
>  	mem_hotplug_done();
