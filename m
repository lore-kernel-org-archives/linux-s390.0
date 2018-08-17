From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC 1/2] drivers/base: export
 lock_device_hotplug/unlock_device_hotplug
Date: Fri, 17 Aug 2018 10:41:46 +0200
Message-ID: <20180817084146.GB14725@kroah.com>
References: <20180817075901.4608-1-david@redhat.com>
 <20180817075901.4608-2-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20180817075901.4608-2-david@redhat.com>
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
Cc: Michal Hocko <mhocko@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, devel@linuxdriverproject.org, Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 17, 2018 at 09:59:00AM +0200, David Hildenbrand wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Well require to call add_memory()/add_memory_resource() with
> device_hotplug_lock held, to avoid a lock inversion. Allow external modules
> (e.g. hv_balloon) that make use of add_memory()/add_memory_resource() to
> lock device hotplug.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> [modify patch description]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 04bbcd779e11..9010b9e942b5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -700,11 +700,13 @@ void lock_device_hotplug(void)
>  {
>  	mutex_lock(&device_hotplug_lock);
>  }
> +EXPORT_SYMBOL_GPL(lock_device_hotplug);
>  
>  void unlock_device_hotplug(void)
>  {
>  	mutex_unlock(&device_hotplug_lock);
>  }
> +EXPORT_SYMBOL_GPL(unlock_device_hotplug);

If these are going to be "global" symbols, let's properly name them.
device_hotplug_lock/unlock would be better.  But I am _really_ nervous
about letting stuff outside of the driver core mess with this, as people
better know what they are doing.

Can't we just "lock" the memory stuff instead?  Why does the entirety of
the driver core need to be messed with here?

thanks,

greg k-h
