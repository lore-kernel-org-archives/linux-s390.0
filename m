Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfFZISR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 04:18:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8IDGE080774
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 04:18:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tc45habta-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 04:18:15 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 26 Jun 2019 09:17:41 +0100
Subject: Re: [PATCH V5 10/16] s390: zfcp_fc: use sg helper to operate
 scatterlist
References: <20190618013757.22401-1-ming.lei@redhat.com>
 <20190618013757.22401-11-ming.lei@redhat.com>
 <95bfa1fb-d0eb-fc61-ecc0-001ae52a326f@linux.ibm.com>
 <20190625011902.GA23777@ming.t460p>
 <93d3d89e-a9ae-691f-d1f8-0463f714957d@linux.ibm.com>
 <20190626030751.GA26340@ming.t460p>
From: Steffen Maier <maier@linux.ibm.com>
Date: Wed, 26 Jun 2019 10:17:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190626030751.GA26340@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1353d755-de62-d575-4c7b-d20d59d07f23@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>, Cathy Avery <cavery@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>, Brian King <brking@us.ibm.com>, James Smart <james.smart@broadcom.com>, "Juergen E . Fischer" <fischer@norbit.de>, Michael Schmitz <schmitzmic@gmail.com>, Finn Thain <fthain@telegraphics.com.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Block <bblock@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

Hi Ming,

On 6/26/19 5:07 AM, Ming Lei wrote:
> On Tue, Jun 25, 2019 at 12:51:04PM +0200, Steffen Maier wrote:
>> I don't mind doing this change for zfcp. However, I'm having doubts
>> regarding the rationale in the commit description.

> However, I still suggest to do it because it will make us to audit SCSI chained
> sg uses much easier. And the change shouldn't have performance effect.

>> If I was not mistaken above, the following could be more descriptive parts
>> of a patch/commit description, with hopefully less confusion for anyone
>> having to look at zfcp git history a few weeks/months/years from now:
>>
>> "While not required for this SCSI MQ change regarding scatterlist
>> allocation, change all other scatterlist iterators in zfcp to the safe
>> sg_next() even if not necessary as these changed zfcp-internal scatterlists
>> are linear and unchained. This may avoid confusion about a potential need
>> for conversions in the future."

Sure, let's change the code, but could you please update the description of 
your below new patch to something like I drafted above regarding rationale?

If you would like to send a V2, I'll be happy to give a Reviewed-by.

>>>   From c9c368308fefbf034d670984fe9746a4181fe514 Mon Sep 17 00:00:00 2001
>>> From: Ming Lei <ming.lei@redhat.com>
>>> Date: Tue, 25 Jun 2019 09:15:34 +0800
>>> Subject: [PATCH] s390: scsi: use sg helper to iterate over scatterlist

>>> Unlike the legacy I/O path, scsi-mq preallocates a large array to hold
>>> the scatterlist for each request. This static allocation can consume
>>> substantial amounts of memory on modern controllers which support a
>>> large number of concurrently outstanding requests.

>>> To facilitate a switch to a smaller static allocation combined with a
>>> dynamic allocation for requests that need it, we need to make sure all
>>> SCSI drivers handle chained scatterlists correctly.

>>> Convert remaining drivers that directly dereference the scatterlist
>>> array to using the iterator functions.

> OK, I still suggest to apply the patch for the mentioned reason if you
> are fine.



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
