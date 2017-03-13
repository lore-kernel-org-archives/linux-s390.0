Return-Path: <owner-linux-mm@kvack.org>
Date: Mon, 13 Mar 2017 19:57:10 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] mm: add private lock to serialize memory hotplug
 operations
References: <20170309130616.51286-1-heiko.carstens@de.ibm.com>
 <3207330.x0D3JT6f2l@aspire.rjw.lan>
 <CAPcyv4g7_E1JTCGq1_gC7W2JtS2JXmWGPuiHW5CMNpjWs2DXpg@mail.gmail.com>
 <2552966.WcQWnf8t6b@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2552966.WcQWnf8t6b@aspire.rjw.lan>
Message-Id: <20170313185710.GA3422@osiris>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Vladimir Davydov <vdavydov.dev@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 09, 2017 at 11:34:44PM +0100, Rafael J. Wysocki wrote:
> > The memory described by devm_memremap_pages() is never "onlined" to
> > the core mm. We're only using arch_add_memory() to get a linear
> > mapping and page structures. The rest of memory hotplug is skipped,
> > and this ZONE_DEVICE memory is otherwise hidden from the core mm.
> 
> OK, that should be fine then.

So, does that mean that the patch is ok as it is? If so, it would be good
to get an Ack from both, you and Dan, please.

Thanks,
Heiko

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
