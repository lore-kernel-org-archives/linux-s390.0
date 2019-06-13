Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731712AbfFMJQG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 05:16:06 -0400
Date: Thu, 13 Jun 2019 17:15:44 +0800
From: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2 09/15] s390: zfcp_fc: use sg helper to operate sgl
Message-ID: <20190613091543.GA8357@ming.t460p>
References: <20190613071335.5679-1-ming.lei@redhat.com>
 <20190613071335.5679-10-ming.lei@redhat.com>
 <20190613084135.GA18038@t480-pf1aa2c2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613084135.GA18038@t480-pf1aa2c2>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>, Cathy Avery <cavery@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>, Brian King <brking@us.ibm.com>, James Smart <james.smart@broadcom.com>, "Juergen E . Fischer" <fischer@norbit.de>, Michael Schmitz <schmitzmic@gmail.com>, Finn Thain <fthain@telegraphics.com.au>, Steffen Maier <maier@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

On Thu, Jun 13, 2019 at 10:41:35AM +0200, Benjamin Block wrote:
> On Thu, Jun 13, 2019 at 03:13:29PM +0800, Ming Lei wrote:
> > The current way isn't safe for chained sgl, so use sg helper to
> > operate sgl.
> > 
> > Cc: Steffen Maier <maier@linux.ibm.com>
> > Cc: Benjamin Block <bblock@linux.ibm.com>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/s390/scsi/zfcp_fc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> > index 33eddb02ee30..b018b61bd168 100644
> > --- a/drivers/s390/scsi/zfcp_fc.c
> > +++ b/drivers/s390/scsi/zfcp_fc.c
> > @@ -620,7 +620,7 @@ static void zfcp_fc_sg_free_table(struct scatterlist *sg, int count)
> >  {
> >  	int i;
> >  
> > -	for (i = 0; i < count; i++, sg++)
> > +	for (i = 0; i < count; i++, sg = sg_next(sg))
> >  		if (sg)
> >  			free_page((unsigned long) sg_virt(sg));
> >  		else
> > @@ -641,7 +641,7 @@ static int zfcp_fc_sg_setup_table(struct scatterlist *sg, int count)
> >  	int i;
> >  
> >  	sg_init_table(sg, count);
> > -	for (i = 0; i < count; i++, sg++) {
> > +	for (i = 0; i < count; i++, sg = sg_next(sg)) {
> >  		addr = (void *) get_zeroed_page(GFP_KERNEL);
> >  		if (!addr) {
> >  			zfcp_fc_sg_free_table(sg, i);
> 
> Color more confused. Where did the rest of this patch-set go? I don't
> see any other patches from this series of 15 on linux-scsi? Neither on
> my mail-account, nor on the archive https://marc.info/?l=linux-scsi
> 
> I was looking for a bit more context.

Yeah, I also can't find them on the archive, maybe there is issue
related with my email box.

I need to check it now.

Thanks,
Ming
