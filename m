Return-Path: <linux-kernel-owner+w=401wt.eu-S1753489AbXJWFQv@vger.kernel.org>
Date: Tue, 23 Oct 2007 07:16:40 +0200
From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 02/10] [SG] Update block layer to use sg helpers
Message-ID: <20071023051640.GL16425@kernel.dk>
References: <1193076664-13652-1-git-send-email-jens.axboe@oracle.com> <1193076664-13652-3-git-send-email-jens.axboe@oracle.com> <20071023051316.GB10055@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071023051316.GB10055@osiris.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, mingo@elte.hu, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 23 2007, Heiko Carstens wrote:
> On Mon, Oct 22, 2007 at 08:10:56PM +0200, Jens Axboe wrote:
> > Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> > ---
> >  block/ll_rw_blk.c |    8 ++++++--
> >  1 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
> > index 8025d64..61c2e39 100644
> > --- a/block/ll_rw_blk.c
> > +++ b/block/ll_rw_blk.c
> > @@ -1354,8 +1354,9 @@ new_segment:
> >  			else
> >  				sg = sg_next(sg);
> > 
> > -			memset(sg, 0, sizeof(*sg));
> > -			sg->page = bvec->bv_page;
> > +			sg_dma_len(sg) = 0;
> > +			sg_dma_address(sg) = 0;
> > +			sg_set_page(sg, bvec->bv_page);
> >  			sg->length = nbytes;
> >  			sg->offset = bvec->bv_offset;
> >  			nsegs++;
> > @@ -1363,6 +1364,9 @@ new_segment:
> >  		bvprv = bvec;
> >  	} /* segments in rq */
> > 
> > +	if (sg)
> > +		__sg_mark_end(sg);
> > +
> >  	return nsegs;
> >  }
> 
> Hmm.... this breaks s390:
> 
>   CC      block/ll_rw_blk.o
> block/ll_rw_blk.c: In function 'blk_rq_map_sg':
> block/ll_rw_blk.c:1357: error: implicit declaration of function 'sg_dma_len'
> block/ll_rw_blk.c:1357: error: lvalue required as left operand of assignment
> block/ll_rw_blk.c:1358: error: implicit declaration of function 'sg_dma_address'
> block/ll_rw_blk.c:1358: error: lvalue required as left operand of assignment
> make[1]: *** [block/ll_rw_blk.o] Error 1
> 
> Missing macros and no appropriate members in struct scatterlist since we
> don't have DMA. How to fix?

Just remove the two lines here, there are actually not required.

-- 
Jens Axboe
