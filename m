Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Apr 2020 17:43:03 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 17/28] mm: remove the prot argument from vm_map_ram
Message-ID: <20200408154303.GB28676@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408135240.6528-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408135240.6528-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 09:52:40PM +0800, Hillf Danton wrote:
> 
> On Wed,  8 Apr 2020 13:59:15 +0200 Christoph Hellwig wrote:
> > 
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -474,7 +474,7 @@ _xfs_buf_map_pages(
> >  		nofs_flag = memalloc_nofs_save();
> >  		do {
> >  			bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,
> > -						-1, PAGE_KERNEL);
> > +						-1);
> s/-1/NUMA_NO_NODE/

Not really relevant to this series, but otherwise agreed.
