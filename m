Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492E8C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 25 Nov 2021 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356904AbhKYUSR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 25 Nov 2021 15:18:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356918AbhKYUQQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Nov 2021 15:16:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1APIGThp003789;
        Thu, 25 Nov 2021 20:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=1jer6viQ0PIh7I6yEV6Pzc1F4T2k49KKRjl9+ShH404=;
 b=Guv5hO2GkZmdZJQQ1kWcXo+pwXt6HKmYZdzn/TTz/q7Wjm02BS3r46zoqh+wvma8R/Kk
 KgeiwvnAEdTu9pWKeh4JoCHPr/i/sbCRNzncMspp6sxROx0fePLXBBAgi2bqQSuzCKyA
 Q2IBsyeUuowyyY0BQm1gZhpKf0+aPm5pSOj7tQ3W18CB2NrKgmxELOoq7Bdg6CxIHwxf
 ALqcnOqY9wGzjlpmmx8RMz34qrGhmIrrZc1fzgUFBY5WLC9odQTvTPxASF3bTTUvsjB7
 tMgkEWiVNJFz2gWLFPDKc5oZ+EGJbO8MePQmqdxGM2ruJtJg6h4OPUevxy36yxWeewG5 aA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cjfmdsu0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 20:12:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1APK77g2028549;
        Thu, 25 Nov 2021 20:12:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3cernanuea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 20:12:53 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1APKCp3K30147032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 20:12:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A130BA405C;
        Thu, 25 Nov 2021 20:12:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4222CA4054;
        Thu, 25 Nov 2021 20:12:51 +0000 (GMT)
Received: from thinkpad (unknown [9.171.40.168])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 25 Nov 2021 20:12:51 +0000 (GMT)
Date:   Thu, 25 Nov 2021 21:12:49 +0100
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
Message-ID: <20211125211249.23a84729@thinkpad>
In-Reply-To: <20211125171310.0fd27afa@thinkpad>
References: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
        <20211117193932.4049412-2-gerald.schaefer@linux.ibm.com>
        <9a4367c0-8141-f03c-e5a1-13483794d3e8@suse.cz>
        <20211119205943.1ee5da0d@thinkpad>
        <b513bbcf-f1ea-cfa6-763a-003a60e51da5@suse.cz>
        <20211122211400.41bf64cf@thinkpad>
        <20211122213330.66b7893e@thinkpad>
        <a081d544-41f0-29ab-6d46-1afa382af8be@suse.cz>
        <20211125171310.0fd27afa@thinkpad>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FP8eDLUu6Fa5qFbgrBlY2m0gtcv_5pEy
X-Proofpoint-GUID: FP8eDLUu6Fa5qFbgrBlY2m0gtcv_5pEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-25_07,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=797 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111250111
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 25 Nov 2021 17:13:10 +0100
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Tue, 23 Nov 2021 15:19:49 +0100
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> > On 11/22/21 21:33, Gerald Schaefer wrote:
> > > On Mon, 22 Nov 2021 21:14:00 +0100
> > > Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> > > 
> > > [...]
> > >> 
> > >> Thanks. While testing this properly, yet another bug showed up. The idx
> > >> in op->show remains 0 in all iterations, so I always see the same line
> > >> printed t->count times (or infinitely, ATM). Not sure if this only shows
> > >> on s390 due to endianness, but the reason is this:
> > >> 
> > >>   unsigned int idx = *(unsigned int *)v;
> > 
> > Uh, good catch. I was actually looking suspiciously at how we cast signed to
> > unsigned, but didn't occur to me that shortening together with endiannes is
> > the problem.
> > 
> > >> 
> > >> IIUC, void *v is always the same as loff_t *ppos, and therefore idx also
> > >> should be *ppos. De-referencing the loff_t * with an unsigned int * only
> > >> gives the upper 32 bit half of the 64 bit value, which remains 0.
> > >> 
> > >> This would be fixed e.g. with
> > >> 
> > >>   unsigned int idx = (unsigned int) *(loff_t *) v;
> > 
> > With all this experience I'm now inclined to rather follow more the example
> > in Documentation/filesystems/seq_file.rst and don't pass around the pointer
> > that we got as ppos in slab_debugfs_start(), and that seq_file.c points to
> > m->index.
> > 
> > In that example an own value is kmalloced:
> > 
> > loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
> > 
> > while we could just make this a field of loc_track?
> 
> Yes, following the example sounds good, and it would also make proper use
> of *v in op->next, which might make the code more readable. It also looks
> like it already does exactly what is needed here, i.e. have a simple
> iterator that just counts the lines.
> 
> I don't think the iterator needs to be saved in loc_track. IIUC, it is
> already passed around like in the example, and can then be simply compared
> to t->count, similar to the existing code.
> 
> This is what I'm currently testing, and it seems to work fine. Will send
> a new patch, if there are no objections:

Oh well, I have one objection, returning NULL from op->next will be
passed to op->stop, and then it will not free the allocated value.

The example is elegantly avoiding this, by not returning NULL anywhere,
and also not stopping. Sigh.

Maybe not return NULL in op->next, but only from op->start, and only
when no allocation was made or it was freed already? Or free it only/
already in op->next, when returning NULL?
