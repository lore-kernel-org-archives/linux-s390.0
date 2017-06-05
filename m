Return-Path: <owner-linux-mm@kvack.org>
Date: Mon, 5 Jun 2017 14:38:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/6] mm: vmstat: move slab statistics from zone to node
 counters
Message-Id: <20170605143831.dac73f489bfe2644e103d2b3@linux-foundation.org>
In-Reply-To: <20170605183511.GA8915@cmpxchg.org>
References: <20170530181724.27197-1-hannes@cmpxchg.org>
	<20170530181724.27197-3-hannes@cmpxchg.org>
	<20170531091256.GA5914@osiris>
	<20170531113900.GB5914@osiris>
	<20170531171151.e4zh7ffzbl4w33gd@yury-thinkpad>
	<87mv9s2f8f.fsf@concordia.ellerman.id.au>
	<20170605183511.GA8915@cmpxchg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Yury Norov <ynorov@caviumnetworks.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Josef Bacik <josef@toxicpanda.com>, Michal Hocko <mhocko@suse.com>, Vladimir Davydov <vdavydov.dev@gmail.com>, Rik van Riel <riel@redhat.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 5 Jun 2017 14:35:11 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5107,6 +5107,7 @@ static void build_zonelists(pg_data_t *pgdat)
>   */
>  static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch);
>  static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
> +static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  static void setup_zone_pageset(struct zone *zone);

There's a few kb there.  It just sits evermore unused after boot?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
