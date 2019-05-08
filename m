Return-Path: <SRS0=OmxZ=TI=kvack.org=owner-linux-mm@kernel.org>
MIME-Version: 1.0
References: <20190507183804.5512-1-david@redhat.com> <20190507183804.5512-8-david@redhat.com>
 <CAPcyv4h2PgzQZrD0UU=4Qz_yH2C_hiYQyqV9U7CCkjpmHZ5xjQ@mail.gmail.com> <1d369ae4-7183-b455-646a-65bbbe697281@redhat.com>
In-Reply-To: <1d369ae4-7183-b455-646a-65bbbe697281@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 8 May 2019 06:50:25 -0700
Message-ID: <CAPcyv4jtS6G_ZqLCdO4gOjS9K2cuX=ywFHemhSb46aQvS8pa8A@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] mm/memory_hotplug: Make unregister_memory_block_under_nodes()
 never fail
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: David Hildenbrand <david@redhat.com>
Cc: Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>, Oscar Salvador <osalvador@suse.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 8, 2019 at 12:22 AM David Hildenbrand <david@redhat.com> wrote:
>
>
> >>  drivers/base/node.c  | 18 +++++-------------
> >>  include/linux/node.h |  5 ++---
> >>  2 files changed, 7 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/base/node.c b/drivers/base/node.c
> >> index 04fdfa99b8bc..9be88fd05147 100644
> >> --- a/drivers/base/node.c
> >> +++ b/drivers/base/node.c
> >> @@ -803,20 +803,14 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
> >>
> >>  /*
> >>   * Unregister memory block device under all nodes that it spans.
> >> + * Has to be called with mem_sysfs_mutex held (due to unlinked_nodes).
> >
> > Given this comment can bitrot relative to the implementation lets
> > instead add an explicit:
> >
> >     lockdep_assert_held(&mem_sysfs_mutex);
>
> That would require to make the mutex non-static. Is that what you
> suggest, or any other alternative?

If the concern is other code paths taking the lock when they shouldn't
then you could make a public "lockdep_assert_mem_sysfs_held()" to do
the same, but I otherwise think the benefit of inline lock validation
is worth the price of adding a new non-static symbol.
