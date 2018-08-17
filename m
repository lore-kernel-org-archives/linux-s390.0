From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC 1/2] drivers/base: export lock_device_hotplug/unlock_device_hotplug
Date: Fri, 17 Aug 2018 10:57:25 +0200
Message-ID: <CAJZ5v0ja2wrwQ_X=8WW0Lvio+jE7nyqM_WSy1C+tzuKj6RsMdA@mail.gmail.com>
References: <20180817075901.4608-1-david@redhat.com> <20180817075901.4608-2-david@redhat.com>
 <20180817084146.GB14725@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817084146.GB14725@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Hildenbrand <david@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@linuxdriverproject.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, osalvador@suse.de, Vitaly Kuznetsov <vkuznets@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, Benjamin
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 17, 2018 at 10:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 17, 2018 at 09:59:00AM +0200, David Hildenbrand wrote:
> > From: Vitaly Kuznetsov <vkuznets@redhat.com>
> >
> > Well require to call add_memory()/add_memory_resource() with
> > device_hotplug_lock held, to avoid a lock inversion. Allow external modules
> > (e.g. hv_balloon) that make use of add_memory()/add_memory_resource() to
> > lock device hotplug.
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > [modify patch description]
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  drivers/base/core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 04bbcd779e11..9010b9e942b5 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -700,11 +700,13 @@ void lock_device_hotplug(void)
> >  {
> >       mutex_lock(&device_hotplug_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(lock_device_hotplug);
> >
> >  void unlock_device_hotplug(void)
> >  {
> >       mutex_unlock(&device_hotplug_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(unlock_device_hotplug);
>
> If these are going to be "global" symbols, let's properly name them.
> device_hotplug_lock/unlock would be better.

Well, device_hotplug_lock is the name of the lock itself. :-)

> But I am _really_ nervous about letting stuff outside of the driver core mess
> with this, as people better know what they are doing.
>
> Can't we just "lock" the memory stuff instead?  Why does the entirety of
> the driver core need to be messed with here?

Because, in general, memory hotplug and hotplug of devices are not
independent.  CPUs and memory may only be possible to take away
together and that may be the case for other devices too (say, it
wouldn't be a good idea to access a memory block that has just gone
away from a device, for DMA and the like).  That's why
device_hotplug_lock was introduced in the first place.

That said I agree that exporting this to drivers doesn't feel particularly safe.
