Return-Path: <owner-linux-mm@kvack.org>
Date: Wed, 26 Jul 2017 13:48:12 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] mm: take memory hotplug lock within
 numa_zonelist_order_handler()
References: <20170726111738.38768-1-heiko.carstens@de.ibm.com>
 <20170726113112.GJ2981@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726113112.GJ2981@dhcp22.suse.cz>
Message-Id: <20170726114812.GH3218@osiris>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Andre Wild <wild@linux.vnet.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 26, 2017 at 01:31:12PM +0200, Michal Hocko wrote:
> On Wed 26-07-17 13:17:38, Heiko Carstens wrote:
> [...]
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 6d30e914afb6..fc32aa81f359 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4891,9 +4891,11 @@ int numa_zonelist_order_handler(struct ctl_table *table, int write,
> >  				NUMA_ZONELIST_ORDER_LEN);
> >  			user_zonelist_order = oldval;
> >  		} else if (oldval != user_zonelist_order) {
> > +			mem_hotplug_begin();
> >  			mutex_lock(&zonelists_mutex);
> >  			build_all_zonelists(NULL, NULL);
> >  			mutex_unlock(&zonelists_mutex);
> > +			mem_hotplug_done();
> >  		}
> >  	}
> >  out:
> 
> Please note that this code has been removed by
> http://lkml.kernel.org/r/20170721143915.14161-2-mhocko@kernel.org. It
> will get to linux-next as soon as Andrew releases a new version mmotm
> tree.

We still would need something for 4.13, no?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
