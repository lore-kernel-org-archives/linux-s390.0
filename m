Return-Path: <bpf-owner@vger.kernel.org>
Date: Thu, 9 Apr 2020 08:09:11 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 25/28] mm: remove vmalloc_user_node_flags
Message-ID: <20200409060911.GA30101@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200409040645.14400-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409040645.14400-1-hdanton@sina.com>
Sender: bpf-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 12:06:45PM +0800, Hillf Danton wrote:
> > -	const gfp_t flags = __GFP_NOWARN | __GFP_ZERO;
> > +	const gfp_t gfp = __GFP_NOWARN | __GFP_ZERO;

> > +
> > +	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
> > +			gfp | GFP_KERNEL | __GFP_RETRY_MAYFAIL, PAGE_KERNEL,
> 
> Dunno if __GFP_ZERO needs to be added to match the current 
> vmalloc_user_node_flags().

__GFP_ZERO is already included in "gfp".
