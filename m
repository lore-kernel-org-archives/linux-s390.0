From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 1/2] drivers/base: export
 lock_device_hotplug/unlock_device_hotplug
Date: Fri, 17 Aug 2018 10:56:36 +0200
Message-ID: <5a5d73e9-e4aa-ffed-a2e3-8aef64e61923@redhat.com>
References: <20180817075901.4608-1-david@redhat.com>
 <20180817075901.4608-2-david@redhat.com> <20180817084146.GB14725@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180817084146.GB14725@kroah.com>
Content-Language: en-US
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, devel@linuxdriverproject.org, Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On 17.08.2018 10:41, Greg Kroah-Hartman wrote:
> On Fri, Aug 17, 2018 at 09:59:00AM +0200, David Hildenbrand wrote:
>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>>
>> Well require to call add_memory()/add_memory_resource() with
>> device_hotplug_lock held, to avoid a lock inversion. Allow external modules
>> (e.g. hv_balloon) that make use of add_memory()/add_memory_resource() to
>> lock device hotplug.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> [modify patch description]
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/base/core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 04bbcd779e11..9010b9e942b5 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -700,11 +700,13 @@ void lock_device_hotplug(void)
>>  {
>>  	mutex_lock(&device_hotplug_lock);
>>  }
>> +EXPORT_SYMBOL_GPL(lock_device_hotplug);
>>  
>>  void unlock_device_hotplug(void)
>>  {
>>  	mutex_unlock(&device_hotplug_lock);
>>  }
>> +EXPORT_SYMBOL_GPL(unlock_device_hotplug);
> 
> If these are going to be "global" symbols, let's properly name them.
> device_hotplug_lock/unlock would be better.  But I am _really_ nervous
> about letting stuff outside of the driver core mess with this, as people
> better know what they are doing.

The only "problem" is that we have kernel modules (for paravirtualized
devices) that call add_memory(). This is Hyper-V right now, but we might
have other ones in the future. Without them we would not have to export
it. We might also get kernel modules that want to call remove_memory() -
which will require the device_hotplug_lock as of now.

What we could do is

a) add_memory() -> _add_memory() and don't export it
b) add_memory() takes the device_hotplug_lock and calls _add_memory() .
We export that one.
c) Use add_memory() in external modules only

Similar wrapper would be needed e.g. for remove_memory() later on.

> 
> Can't we just "lock" the memory stuff instead?  Why does the entirety of
> the driver core need to be messed with here?

The main problem is that add_memory() will first take the
mem_hotplug_lock, to later on create and attach the memory block devices
(to a bus without any drivers) via bus_probe_device(). Here, we will
take the device_lock() of these devices.

Setting a device online from user space (.online = true) will first take
the device_hotplug_lock, then the device_lock(), and _right now_ not the
mem_hotplug_lock (see cover letter/patch 2).

We have to take mem_hotplug_lock here, but doing it down in e.g.
online_pages() will right now create the possibility for a lock
inversion. So one alternative is to take the mem_hotplug_lock in core.c
before calling device_online()/device_offline(). But this feels very wrong.

Thanks!

> 
> thanks,
> 
> greg k-h
> 


-- 

Thanks,

David / dhildenb
