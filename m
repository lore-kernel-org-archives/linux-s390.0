From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH RFC 1/2] drivers/base: export
 lock_device_hotplug/unlock_device_hotplug
Date: Fri, 17 Aug 2018 13:28:50 +0200
Message-ID: <20180817112850.GB3565@osiris>
References: <20180817075901.4608-1-david@redhat.com>
 <20180817075901.4608-2-david@redhat.com>
 <20180817084146.GB14725@kroah.com>
 <5a5d73e9-e4aa-ffed-a2e3-8aef64e61923@redhat.com>
 <CAJZ5v0gkYV8o2Eq+EcGT=OP1tQGPGVVe3n9VGD6z7KAVVqhv9w@mail.gmail.com>
 <42df9062-f647-3ad6-5a07-be2b99531119@redhat.com>
 <20180817100604.GA18164@kroah.com>
 <4ac624be-d2d6-5975-821f-b20a475781dc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ac624be-d2d6-5975-821f-b20a475781dc@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michal Hocko <mhocko@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Memory Management List <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, sthemmin@microsoft.com, Pavel Tatashin <pasha.tatashin@oracle.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, haiyangz@microsoft.com, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, osalvador@suse.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Martin
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 17, 2018 at 01:04:58PM +0200, David Hildenbrand wrote:
> >> If there are no objections, I'll go into that direction. But I'll wait
> >> for more comments regarding the general concept first.
> > 
> > It is the middle of the merge window, and maintainers are really busy
> > right now.  I doubt you will get many review comments just yet...
> > 
> 
> This has been broken since 2015, so I guess it can wait a bit :)

I hope you figured out what needs to be locked why. Your patch description
seems to be "only" about locking order ;)

I tried to figure out and document that partially with 55adc1d05dca ("mm:
add private lock to serialize memory hotplug operations"), and that wasn't
easy to figure out. I was especially concerned about sprinkling
lock/unlock_device_hotplug() calls, which has the potential to make it the
next BKL thing.
