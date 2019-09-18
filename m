Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39540 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728260AbfIRPKJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Sep 2019 11:10:09 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8IF2VWC104836
        for <linux-s390@vger.kernel.org>; Wed, 18 Sep 2019 11:10:07 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v39pexv7k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Sep 2019 11:10:06 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 18 Sep 2019 16:09:59 +0100
Subject: Re: [PATCH 1/2] scsi: core: fix missing .cleanup_rq for SCSI hosts
 without request batching
References: <20190807144948.28265-1-maier@linux.ibm.com>
 <20190807144948.28265-2-maier@linux.ibm.com>
 <CACVXFVM0tFj8CmcHON04_KjxR=QErCbUx0abJgG2W9OBb7akZA@mail.gmail.com>
 <yq136iccsbw.fsf@oracle.com>
From: Steffen Maier <maier@linux.ibm.com>
Date: Wed, 18 Sep 2019 17:09:50 +0200
MIME-Version: 1.0
In-Reply-To: <yq136iccsbw.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bec80a65-9a8c-54a9-fe70-876fcbe3d592@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Ming Lei <tom.leiming@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Brown <broonie@kernel.org>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, "open list:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>, "Ewan D . Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>

On 8/8/19 4:18 AM, Martin K. Petersen wrote:
> 
> Ming,
> 
>>> +       .cleanup_rq     = scsi_cleanup_rq,
>>>          .busy           = scsi_mq_lld_busy,
>>>          .map_queues     = scsi_map_queues,
>>>   };
>>
>> This one is a cross-tree thing, either scsi/5.4/scsi-queue needs to
>> pull for-5.4/block, or do it after both land linus tree.
> 
> I'll set up an amalgamated for-next branch tomorrow.

Martin, is it possible that you re-wrote your for-next and it now no longer 
contains a merged 5.4/scsi-postmerge with those fixes?
At least I cannot find the fix code in next-20190917 and it fails again for me.


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
