From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 0/2] mm: online/offline_pages called w.o. mem_hotplug_lock
Date: Fri, 17 Aug 2018 09:58:59 +0200
Message-ID: <20180817075901.4608-1-david@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, devel@linuxdriverproject.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Oscar Salvador <osalvador@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Hildenbrand <david@redhat.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>Paul Mackerras <p>
List-ID: <linux-s390.vger.kernel.org>

Reading through the code and studying how mem_hotplug_lock is to be used,
I noticed that there are two places where we can end up calling
device_online()/device_offline() - online_pages()/offline_pages() without
the mem_hotplug_lock. And there are other places where we call
device_online()/device_offline() without the device_hotplug_lock.

While e.g.
	echo "online" > /sys/devices/system/memory/memory9/state
is fine, e.g.
	echo 1 > /sys/devices/system/memory/memory9/online
Will not take the mem_hotplug_lock. However the device_lock() and
device_hotplug_lock.

E.g. via memory_probe_store(), we can end up calling
add_memory()->online_pages() without the device_hotplug_lock. So we can
have concurrent callers in online_pages(). We e.g. touch in online_pages()
basically unprotected zone->present_pages then.

Looks like there is a longer history to that (see Patch #2 for details),
and fixing it to work the way it was intended is not really possible. We
would e.g. have to take the mem_hotplug_lock in device/base/core.c, which
sounds wrong.

Summary: We had a lock inversion on mem_hotplug_lock and device_lock(),
and the approach to fix it fixed one inversion, but dropped the
mem_hotplug_lock on another instance (.online).

As far as I understand from the code and from b93e0f329e24 ("mm,
memory_hotplug: get rid of zonelists_mutex"), mem_hotplug_lock is required
because we assume that
	"both memory online and offline are fully serialized."
and this is not the case if we only hold the device_lock().

I propose the general rules:

1. add_memory/add_memory_resource() must only be called with
   device_hotplug_lock. For now only done in ACPI code.
2. remove_memory() must only be called with device_hotplug_lock. This is
   already documented and true in ACPI code.
3. device_online()/device_offline() must only be called with
   device_hotplug_lock. This is already documented and true for now in core
   code. Other callers (related to memory hotplug) have to be fixed up.
4. mem_hotplug_lock is taken inside of add_memory/remove_memory/
   online_pages/offline_pages. For now this is only true for the first two
   instances.

To me, this looks way cleaner than what we have right now (and easier to
verify). And looking at the documentation of remove_memory, using
lock_device_hotplug also for add_memory() feels natural. Second patch could
maybe split up.

But let's first hear if this is actually a problem and if there migh be
alternatives (or cleanups). Only tested with DIMM-based hotplug.

David Hildenbrand (1):
  mm/memory_hotplug: fix online/offline_pages called w.o.
    mem_hotplug_lock

Vitaly Kuznetsov (1):
  drivers/base: export lock_device_hotplug/unlock_device_hotplug

 arch/powerpc/platforms/powernv/memtrace.c |  3 ++
 drivers/acpi/acpi_memhotplug.c            |  1 +
 drivers/base/core.c                       |  2 ++
 drivers/base/memory.c                     | 18 +++++-----
 drivers/hv/hv_balloon.c                   |  4 +++
 drivers/s390/char/sclp_cmd.c              |  3 ++
 drivers/xen/balloon.c                     |  3 ++
 mm/memory_hotplug.c                       | 42 ++++++++++++++++++-----
 8 files changed, 57 insertions(+), 19 deletions(-)

-- 
2.17.1
