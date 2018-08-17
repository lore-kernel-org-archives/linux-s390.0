From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC 2/2] mm/memory_hotplug: fix online/offline_pages
 called w.o. mem_hotplug_lock
Date: Fri, 17 Aug 2018 10:20:43 +0200
Message-ID: <CAJZ5v0jpx_XOmkSkMiSxcECxNHGXPGZHtgqRy_Q7iKnf-C55pg@mail.gmail.com>
References: <20180817075901.4608-1-david@redhat.com>
 <20180817075901.4608-3-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180817075901.4608-3-david@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Memory Management List <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, sthemmin@microsoft.com, Pavel Tatashin <pasha.tatashin@oracle.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, haiyangz@microsoft.com, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, osalvador@suse.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, devel@linuxdriverproject.org, Vitaly Kuznetsov <vkuznets@redhat.co>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 17, 2018 at 9:59 AM David Hildenbrand <david@redhat.com> wrote:
>
> There seem to be some problems as result of 30467e0b3be ("mm, hotplug:
> fix concurrent memory hot-add deadlock"), which tried to fix a possible
> lock inversion reported and discussed in [1] due to the two locks
>         a) device_lock()
>         b) mem_hotplug_lock
>
> While add_memory() first takes b), followed by a) during
> bus_probe_device(), onlining of memory from user space first took b),
> followed by a), exposing a possible deadlock.
>
> In [1], and it was decided to not make use of device_hotplug_lock, but
> rather to enforce a locking order. Looking at 1., this order is not always
> satisfied when calling device_online() - essentially we simply don't take
> one of both locks anymore - and fixing this would require us to
> take the mem_hotplug_lock in core driver code (online_store()), which
> sounds wrong.
>
> The problems I spotted related to this:
>
> 1. Memory block device attributes: While .state first calls
>    mem_hotplug_begin() and the calls device_online() - which takes
>    device_lock() - .online does no longer call mem_hotplug_begin(), so
>    effectively calls online_pages() without mem_hotplug_lock. onlining/
>    offlining of pages is no longer serialised across different devices.
>
> 2. device_online() should be called under device_hotplug_lock, however
>    onlining memory during add_memory() does not take care of that. (I
>    didn't follow how strictly this is needed, but there seems to be a
>    reason because it is documented at device_online() and
>    device_offline()).
>
> In addition, I think there is also something wrong about the locking in
>
> 3. arch/powerpc/platforms/powernv/memtrace.c calls offline_pages()
>    (and device_online()) without locks. This was introduced after
>    30467e0b3be. And skimming over the code, I assume it could need some
>    more care in regards to locking.
>
> ACPI code already holds the device_hotplug_lock, and as we are
> effectively hotplugging memory block devices, requiring to hold that
> lock does not sound too wrong, although not chosen in [1], as
>         "I don't think resolving a locking dependency is appropriate by
>          just serializing them with another lock."
> I think this is the cleanest solution.
>
> Requiring add_memory()/add_memory_resource() to be called under
> device_hotplug_lock fixes 2., taking the mem_hotplug_lock in
> online_pages/offline_pages() fixes 1. and 3.
>
> Fixup all callers of add_memory/add_memory_resource to hold the lock if
> not already done.
>
> So this is essentially a revert of 30467e0b3be, implementation of what
> was suggested in [1] by Vitaly, applied to the current tree.
>
> [1] http://driverdev.linuxdriverproject.org/pipermail/ driverdev-devel/
>     2015-February/065324.html
>
> This patch is partly based on a patch by Vitaly Kuznetsov.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/powernv/memtrace.c |  3 ++
>  drivers/acpi/acpi_memhotplug.c            |  1 +
>  drivers/base/memory.c                     | 18 +++++-----
>  drivers/hv/hv_balloon.c                   |  4 +++
>  drivers/s390/char/sclp_cmd.c              |  3 ++
>  drivers/xen/balloon.c                     |  3 ++
>  mm/memory_hotplug.c                       | 42 ++++++++++++++++++-----
>  7 files changed, 55 insertions(+), 19 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index 51dc398ae3f7..4c2737a33020 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -206,6 +206,8 @@ static int memtrace_online(void)
>         int i, ret = 0;
>         struct memtrace_entry *ent;
>
> +       /* add_memory() requires device_hotplug_lock */
> +       lock_device_hotplug();
>         for (i = memtrace_array_nr - 1; i >= 0; i--) {
>                 ent = &memtrace_array[i];
>
> @@ -244,6 +246,7 @@ static int memtrace_online(void)
>                 pr_info("Added trace memory back to node %d\n", ent->nid);
>                 ent->size = ent->start = ent->nid = -1;
>         }
> +       unlock_device_hotplug();
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 6b0d3ef7309c..e7a4c7900967 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -228,6 +228,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>                 if (node < 0)
>                         node = memory_add_physaddr_to_nid(info->start_addr);
>
> +               /* we already hold the device_hotplug lock at this point */
>                 result = add_memory(node, info->start_addr, info->length);
>
>                 /*

A very minor nit here: I would say "device_hotplug_lock is already
held at this point" in the comment (I sort of don't like to say "we"
in code comments as it is not particularly clear what group of people
is represented by that and the lock is actually called
device_hotplug_lock).

Otherwise the approach is fine by me.

BTW, the reason why device_hotplug_lock is acquired by the ACPI memory
hotplug is because it generally needs to be synchronized with respect
CPU hot-remove and similar.  I believe that this may be the case in
non-ACPI setups as well.

Thanks,
Rafael
