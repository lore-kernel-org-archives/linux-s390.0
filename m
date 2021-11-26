Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937A1C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 26 Nov 2021 17:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347736AbhKZRRO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 Nov 2021 12:17:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54234 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235976AbhKZRPO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Nov 2021 12:15:14 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AQGlIkX002004;
        Fri, 26 Nov 2021 17:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ePFKLXgNRShWle4z9PyEy9mdkY2iMeuFnkZLePqu7oE=;
 b=Se//gY7XwQEP4+5LYlfZgbsx9RvsdTXbBEGPEHXM0OUE5SrAP5InsJO7Qe15SUeIy8IH
 iga9aTDZ8eJOGVDGEYAfMoSAPkme0InZw0jYh0lzTXhsJuJq+jBgsvk1OLMZ+4UJLLNx
 WjF5Y61YEC9G+iPc75dDY30fP26EvhZTrKhFkacFmCdfbpH70LdhLXL1Hzo6L1vNz8n7
 IJ7nJmHihx79Y+/yzEW8A6lo79FbVEG8NSQ/spoFsl7YnyZTZWmou79/9JhFNvtmszVS
 A6nYPgr5V3H55zBiLwAWq57BSqq8+snCt9JpxsAl5cBTL1QYFrlTS34ir+iMDMi//JGW gQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ck3dn8dhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 17:11:56 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AQH8dPS026493;
        Fri, 26 Nov 2021 17:11:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3cernak5wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 17:11:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AQHBqRh29884918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Nov 2021 17:11:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 162164C040;
        Fri, 26 Nov 2021 17:11:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B56614C04A;
        Fri, 26 Nov 2021 17:11:51 +0000 (GMT)
Received: from thinkpad (unknown [9.171.58.53])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 26 Nov 2021 17:11:51 +0000 (GMT)
Date:   Fri, 26 Nov 2021 18:11:49 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/1] mm/slub: fix endless "No data" printing for
 alloc/free_traces attribute
Message-ID: <20211126181149.230d6206@thinkpad>
In-Reply-To: <7c909b82-8e1c-a8ce-516d-e3aa9bc2fd81@suse.cz>
References: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
        <20211117193932.4049412-2-gerald.schaefer@linux.ibm.com>
        <9a4367c0-8141-f03c-e5a1-13483794d3e8@suse.cz>
        <20211119205943.1ee5da0d@thinkpad>
        <b513bbcf-f1ea-cfa6-763a-003a60e51da5@suse.cz>
        <20211122211400.41bf64cf@thinkpad>
        <20211122213330.66b7893e@thinkpad>
        <a081d544-41f0-29ab-6d46-1afa382af8be@suse.cz>
        <20211125171310.0fd27afa@thinkpad>
        <20211125211249.23a84729@thinkpad>
        <7c909b82-8e1c-a8ce-516d-e3aa9bc2fd81@suse.cz>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dhoLgd9Jyhbp8q4zQb74aDY1xHteuNRT
X-Proofpoint-ORIG-GUID: dhoLgd9Jyhbp8q4zQb74aDY1xHteuNRT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_04,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=836 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111260099
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 25 Nov 2021 23:00:47 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 11/25/21 21:12, Gerald Schaefer wrote:
> > On Thu, 25 Nov 2021 17:13:10 +0100
> > Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> > 
> >> On Tue, 23 Nov 2021 15:19:49 +0100
> >> Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >>> On 11/22/21 21:33, Gerald Schaefer wrote:
> >>>> On Mon, 22 Nov 2021 21:14:00 +0100
> >>>> Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> >>>>
> >>>> [...]
> >>>>>
> >>>>> Thanks. While testing this properly, yet another bug showed up. The idx
> >>>>> in op->show remains 0 in all iterations, so I always see the same line
> >>>>> printed t->count times (or infinitely, ATM). Not sure if this only shows
> >>>>> on s390 due to endianness, but the reason is this:
> >>>>>
> >>>>>   unsigned int idx = *(unsigned int *)v;
> >>>
> >>> Uh, good catch. I was actually looking suspiciously at how we cast signed to
> >>> unsigned, but didn't occur to me that shortening together with endiannes is
> >>> the problem.
> >>>
> >>>>>
> >>>>> IIUC, void *v is always the same as loff_t *ppos, and therefore idx also
> >>>>> should be *ppos. De-referencing the loff_t * with an unsigned int * only
> >>>>> gives the upper 32 bit half of the 64 bit value, which remains 0.
> >>>>>
> >>>>> This would be fixed e.g. with
> >>>>>
> >>>>>   unsigned int idx = (unsigned int) *(loff_t *) v;
> >>>
> >>> With all this experience I'm now inclined to rather follow more the example
> >>> in Documentation/filesystems/seq_file.rst and don't pass around the pointer
> >>> that we got as ppos in slab_debugfs_start(), and that seq_file.c points to
> >>> m->index.
> >>>
> >>> In that example an own value is kmalloced:
> >>>
> >>> loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
> >>>
> >>> while we could just make this a field of loc_track?
> >>
> >> Yes, following the example sounds good, and it would also make proper use
> >> of *v in op->next, which might make the code more readable. It also looks
> >> like it already does exactly what is needed here, i.e. have a simple
> >> iterator that just counts the lines.
> >>
> >> I don't think the iterator needs to be saved in loc_track. IIUC, it is
> >> already passed around like in the example, and can then be simply compared
> >> to t->count, similar to the existing code.
> 
> Saving it the loc_track doesn't preclude using the pointer that's being
> passed around. It however avoids the extra kmalloc and turns out it
> should also solve the return NULL from op->next() issue you describe below?

Yes, storing idx in loc_track seems straight-forward, and should also
improve code readability.

Patch will follow right here. I made idx a loff_t, as it seemed easier to
handle in op->start/next, then casted to unsigned long again in op->show.
Not sure if the unsigned int had any benefit. Given that loff_t is a signed
64 bit type, I guess both are wrong if it should ever turn negative (can it,
i.e. can ppos turn negative?). With unsigned long, chances are better that
it will at least turn into something big enough to not pass the
"idx < t->count" check.

> 
> >> This is what I'm currently testing, and it seems to work fine. Will send
> >> a new patch, if there are no objections:
> > 
> > Oh well, I have one objection, returning NULL from op->next will be
> > passed to op->stop, and then it will not free the allocated value.
> > 
> > The example is elegantly avoiding this, by not returning NULL anywhere,
> > and also not stopping. Sigh.
> > 
> > Maybe not return NULL in op->next, but only from op->start, and only
> > when no allocation was made or it was freed already? Or free it only/
> > already in op->next, when returning NULL?
> 
> From these two probably the "free in op->next". But still inclined to
> store it in loc_track.
> Why does the API need to be so awkward...

Maybe we are just holding it wrong :-)
