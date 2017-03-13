Return-Path: <owner-linux-mm@kvack.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] mm: add private lock to serialize memory hotplug operations
Date: Mon, 13 Mar 2017 22:15:46 +0100
Message-ID: <5904743.94GiNAKfGi@aspire.rjw.lan>
In-Reply-To: <CAPcyv4i1phF5rZL--g6ojguHScKetNA3gfsZRpHhVw3VbgqmFg@mail.gmail.com>
References: <20170309130616.51286-1-heiko.carstens@de.ibm.com> <20170313185710.GA3422@osiris> <CAPcyv4i1phF5rZL--g6ojguHScKetNA3gfsZRpHhVw3VbgqmFg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Dan Williams <dan.j.williams@intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Vladimir Davydov <vdavydov.dev@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Monday, March 13, 2017 12:44:25 PM Dan Williams wrote:
> On Mon, Mar 13, 2017 at 11:57 AM, Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> > On Thu, Mar 09, 2017 at 11:34:44PM +0100, Rafael J. Wysocki wrote:
> >> > The memory described by devm_memremap_pages() is never "onlined" to
> >> > the core mm. We're only using arch_add_memory() to get a linear
> >> > mapping and page structures. The rest of memory hotplug is skipped,
> >> > and this ZONE_DEVICE memory is otherwise hidden from the core mm.
> >>
> >> OK, that should be fine then.
> >
> > So, does that mean that the patch is ok as it is? If so, it would be good
> > to get an Ack from both, you and Dan, please.
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
