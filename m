Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfFYBTk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Jun 2019 21:19:40 -0400
Date: Tue, 25 Jun 2019 09:19:03 +0800
From: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V5 10/16] s390: zfcp_fc: use sg helper to operate
 scatterlist
Message-ID: <20190625011902.GA23777@ming.t460p>
References: <20190618013757.22401-1-ming.lei@redhat.com>
 <20190618013757.22401-11-ming.lei@redhat.com>
 <95bfa1fb-d0eb-fc61-ecc0-001ae52a326f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95bfa1fb-d0eb-fc61-ecc0-001ae52a326f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>, Cathy Avery <cavery@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>, Brian King <brking@us.ibm.com>, James Smart <james.smart@broadcom.com>, "Juergen E . Fischer" <fischer@norbit.de>, Michael Schmitz <schmitzmic@gmail.com>, Finn Thain <fthain@telegraphics.com.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Block <bblock@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

On Mon, Jun 24, 2019 at 05:13:24PM +0200, Steffen Maier wrote:
> Hi Ming,
> 
> On 6/18/19 3:37 AM, Ming Lei wrote:
> > Use the scatterlist iterators and remove direct indexing of the
> > scatterlist array.
> > 
> > This way allows us to pre-allocate one small scatterlist, which can be
> > chained with one runtime allocated scatterlist if the pre-allocated one
> > isn't enough for the whole request.
> > 
> > Cc: Steffen Maier <maier@linux.ibm.com>
> > Cc: Benjamin Block <bblock@linux.ibm.com>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Acked-by: Benjamin Block <bblock@linux.ibm.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/s390/scsi/zfcp_fc.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> > index 33eddb02ee30..b018b61bd168 100644
> > --- a/drivers/s390/scsi/zfcp_fc.c
> > +++ b/drivers/s390/scsi/zfcp_fc.c
> > @@ -620,7 +620,7 @@ static void zfcp_fc_sg_free_table(struct scatterlist *sg, int count)
> >   {
> >   	int i;
> > -	for (i = 0; i < count; i++, sg++)
> > +	for (i = 0; i < count; i++, sg = sg_next(sg))
> >   		if (sg)
> >   			free_page((unsigned long) sg_virt(sg));
> >   		else
> > @@ -641,7 +641,7 @@ static int zfcp_fc_sg_setup_table(struct scatterlist *sg, int count)
> >   	int i;
> >   	sg_init_table(sg, count);
> > -	for (i = 0; i < count; i++, sg++) {
> > +	for (i = 0; i < count; i++, sg = sg_next(sg)) {
> >   		addr = (void *) get_zeroed_page(GFP_KERNEL);
> >   		if (!addr) {
> >   			zfcp_fc_sg_free_table(sg, i);
> > 
> 
> I'm still catching up with emails that came during my vacation, so I'm not
> fully up-to-date on the current state of this and how to bring in potential
> fixups on top.
> 
> I think, we also have two more (not so obvious) places in the corresponding
> response/completion code path, where we might need to introduce the proper
> iterator helper:
> 
> zfcp_fsf.c:
> 
> static int zfcp_fc_eval_gpn_ft(struct zfcp_fc_req *fc_req,
> 			       struct zfcp_adapter *adapter, int max_entries)
> {
> 	struct scatterlist *sg = &fc_req->sg_rsp;
> ...
> 	/* first entry is the header */
> 	for (x = 1; x < max_entries && !last; x++) {
> ...
> 		if (x % (ZFCP_FC_GPN_FT_ENT_PAGE + 1))
> ...
> 		else
> 			acc = sg_virt(++sg);
>                                       ^^^^
> 
> zfcp_dbf.c:
> 
> static u16 zfcp_dbf_san_res_cap_len_if_gpn_ft(char *tag,
> 					      struct zfcp_fsf_req *fsf,
> 					      u16 len)
> {
> 	struct scatterlist *resp_entry = ct_els->resp;
> ...
> 	/* the basic CT_IU preamble is the same size as one entry in the GPN_FT
> 	 * response, allowing us to skip special handling for it - just skip it
> 	 */
> 	for (x = 1; x < max_entries && !last; x++) {
> 		if (x % (ZFCP_FC_GPN_FT_ENT_PAGE + 1))
> ...
> 		else
> 			acc = sg_virt(++resp_entry);
>                                       ^^^^^^^^^^^^
> 
> 
> What do you think?

Yeah, looks this one is missed, so we need the following patch:

From c9c368308fefbf034d670984fe9746a4181fe514 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 25 Jun 2019 09:15:34 +0800
Subject: [PATCH] s390: scsi: use sg helper to iterate over scatterlist

Unlike the legacy I/O path, scsi-mq preallocates a large array to hold
the scatterlist for each request. This static allocation can consume
substantial amounts of memory on modern controllers which support a
large number of concurrently outstanding requests.

To facilitate a switch to a smaller static allocation combined with a
dynamic allocation for requests that need it, we need to make sure all
SCSI drivers handle chained scatterlists correctly.

Convert remaining drivers that directly dereference the scatterlist
array to using the iterator functions.

Cc: Steffen Maier <maier@linux.ibm.com>
Cc: Benjamin Block <bblock@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/s390/scsi/zfcp_dbf.c | 2 +-
 drivers/s390/scsi/zfcp_fc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index dccdb41bed8c..c7129f5234f0 100644
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -552,7 +552,7 @@ static u16 zfcp_dbf_san_res_cap_len_if_gpn_ft(char *tag,
 		if (x % (ZFCP_FC_GPN_FT_ENT_PAGE + 1))
 			acc++;
 		else
-			acc = sg_virt(++resp_entry);
+			acc = sg_virt(resp_entry = sg_next(resp_entry));
 
 		last = acc->fp_flags & FC_NS_FID_LAST;
 	}
diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index b018b61bd168..5048812ce660 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -742,7 +742,7 @@ static int zfcp_fc_eval_gpn_ft(struct zfcp_fc_req *fc_req,
 		if (x % (ZFCP_FC_GPN_FT_ENT_PAGE + 1))
 			acc++;
 		else
-			acc = sg_virt(++sg);
+			acc = sg_virt(sg = sg_next(sg));
 
 		last = acc->fp_flags & FC_NS_FID_LAST;
 		d_id = ntoh24(acc->fp_fid);
-- 
2.20.1


Thanks,
Ming
