Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:38180 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfIRPXc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Sep 2019 11:23:32 -0400
Subject: Re: [PATCH 1/2] scsi: core: fix missing .cleanup_rq for SCSI hosts without request batching
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190807144948.28265-1-maier@linux.ibm.com>
        <20190807144948.28265-2-maier@linux.ibm.com>
        <CACVXFVM0tFj8CmcHON04_KjxR=QErCbUx0abJgG2W9OBb7akZA@mail.gmail.com>
        <yq136iccsbw.fsf@oracle.com>
        <bec80a65-9a8c-54a9-fe70-876fcbe3d592@linux.ibm.com>
Date: Wed, 18 Sep 2019 11:22:39 -0400
In-Reply-To: <bec80a65-9a8c-54a9-fe70-876fcbe3d592@linux.ibm.com> (Steffen
        Maier's message of "Wed, 18 Sep 2019 17:09:50 +0200")
Message-ID: <yq1lful8w8w.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Ming Lei <tom.leiming@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Brown <broonie@kernel.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, "open list:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>, "Ewan D . Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>


Steffen,

> Martin, is it possible that you re-wrote your for-next and it now no
> longer contains a merged 5.4/scsi-postmerge with those fixes?  At
> least I cannot find the fix code in next-20190917 and it fails again
> for me.

Yes, looks like you're right. Not sure how I managed to mess that up. I
must have inadvertently done a reset in the wrong worktree because my
for-next branch maintenance script only does merges.

In any case, since Linus has pulled the block tree dependencies, I'll
rebase the postmerge branch on top of current linus/master and create a
new for-next.

Thanks for the heads-up!

-- 
Martin K. Petersen	Oracle Linux Engineering
