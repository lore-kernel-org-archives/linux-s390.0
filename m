Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C7DC433FE
	for <linux-s390@archiver.kernel.org>; Thu, 25 Nov 2021 16:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhKYQSf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:18:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46866 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234339AbhKYQQe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Nov 2021 11:16:34 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1APF1AaS031305;
        Thu, 25 Nov 2021 16:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=cdKAV0f7xwqGAzQlwfnGcviBWxxPjXMrAZX1/EbOHeI=;
 b=UjiwJ1ZKPydVOmsBE3BeLu/PUNQUerWCtQXnv7nXFc9GkbqTmgqN3OafZOV9lGN9VYwr
 4eIrMqsI0m4l+VNiDHdsDAioK6fKJxgl2idtxLfoIyOVQMA/NdIS28nSsjp55+64+5CS
 JomT/1Qmcq9TDVv+chPFIqs6XIHHnl3Fguknze92ZMWADIV+XmWobDCL17gidfNVSv1y
 Lu54AwKrT89HZt0L3T9CN8DhoCSsWkAxY4+WU6pu/aGOQnvyx0MxMXIDiu9GA0riSzic
 qVMeYuTfCyO7MgUxYGZIkkIG0TEL2wIiv1+vitYFQlD7oL888vCUPdWjPSleZBIyhQr1 +A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cj7qf057b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 16:13:17 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1APG3GVg025884;
        Thu, 25 Nov 2021 16:13:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3cernatpje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 16:13:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1APGDClq34079000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 16:13:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86C5BAE051;
        Thu, 25 Nov 2021 16:13:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F534AE056;
        Thu, 25 Nov 2021 16:13:12 +0000 (GMT)
Received: from thinkpad (unknown [9.171.40.168])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 25 Nov 2021 16:13:12 +0000 (GMT)
Date:   Thu, 25 Nov 2021 17:13:10 +0100
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
Message-ID: <20211125171310.0fd27afa@thinkpad>
In-Reply-To: <a081d544-41f0-29ab-6d46-1afa382af8be@suse.cz>
References: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
        <20211117193932.4049412-2-gerald.schaefer@linux.ibm.com>
        <9a4367c0-8141-f03c-e5a1-13483794d3e8@suse.cz>
        <20211119205943.1ee5da0d@thinkpad>
        <b513bbcf-f1ea-cfa6-763a-003a60e51da5@suse.cz>
        <20211122211400.41bf64cf@thinkpad>
        <20211122213330.66b7893e@thinkpad>
        <a081d544-41f0-29ab-6d46-1afa382af8be@suse.cz>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: --l6ZNj_MkE0tNUneJECDjsMlInWDatD
X-Proofpoint-ORIG-GUID: --l6ZNj_MkE0tNUneJECDjsMlInWDatD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-25_06,2021-11-25_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250089
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 23 Nov 2021 15:19:49 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 11/22/21 21:33, Gerald Schaefer wrote:
> > On Mon, 22 Nov 2021 21:14:00 +0100
> > Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> > 
> > [...]
> >> 
> >> Thanks. While testing this properly, yet another bug showed up. The idx
> >> in op->show remains 0 in all iterations, so I always see the same line
> >> printed t->count times (or infinitely, ATM). Not sure if this only shows
> >> on s390 due to endianness, but the reason is this:
> >> 
> >>   unsigned int idx = *(unsigned int *)v;
> 
> Uh, good catch. I was actually looking suspiciously at how we cast signed to
> unsigned, but didn't occur to me that shortening together with endiannes is
> the problem.
> 
> >> 
> >> IIUC, void *v is always the same as loff_t *ppos, and therefore idx also
> >> should be *ppos. De-referencing the loff_t * with an unsigned int * only
> >> gives the upper 32 bit half of the 64 bit value, which remains 0.
> >> 
> >> This would be fixed e.g. with
> >> 
> >>   unsigned int idx = (unsigned int) *(loff_t *) v;
> 
> With all this experience I'm now inclined to rather follow more the example
> in Documentation/filesystems/seq_file.rst and don't pass around the pointer
> that we got as ppos in slab_debugfs_start(), and that seq_file.c points to
> m->index.
> 
> In that example an own value is kmalloced:
> 
> loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
> 
> while we could just make this a field of loc_track?

Yes, following the example sounds good, and it would also make proper use
of *v in op->next, which might make the code more readable. It also looks
like it already does exactly what is needed here, i.e. have a simple
iterator that just counts the lines.

I don't think the iterator needs to be saved in loc_track. IIUC, it is
already passed around like in the example, and can then be simply compared
to t->count, similar to the existing code.

This is what I'm currently testing, and it seems to work fine. Will send
a new patch, if there are no objections:

---
 mm/slub.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a8626825a829..effb7b8d8f88 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6052,10 +6052,9 @@ __initcall(slab_sysfs_init);
 #if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
 static int slab_debugfs_show(struct seq_file *seq, void *v)
 {
-
-	struct location *l;
-	unsigned int idx = *(unsigned int *)v;
 	struct loc_track *t = seq->private;
+	loff_t idx = *(loff_t *) v;
+	struct location *l;
 
 	if (idx < t->count) {
 		l = &t->loc[idx];
@@ -6099,23 +6098,29 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
 
 static void slab_debugfs_stop(struct seq_file *seq, void *v)
 {
+	kfree(v);
 }
 
 static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
 {
 	struct loc_track *t = seq->private;
+	loff_t *idxp = (loff_t *) v;
 
-	v = ppos;
-	++*ppos;
-	if (*ppos <= t->count)
-		return v;
+	*ppos = ++(*idxp);
+	if (*idxp <= t->count)
+		return idxp;
 
 	return NULL;
 }
 
 static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
 {
-	return ppos;
+	loff_t *idxp = kmalloc(sizeof(loff_t), GFP_KERNEL);
+
+	if (!idxp)
+		return NULL;
+	*idxp = *ppos;
+	return idxp;
 }
 
 static const struct seq_operations slab_debugfs_sops = {
-- 
2.32.0

