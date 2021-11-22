Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B545C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 22 Nov 2021 20:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbhKVUhA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:37:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239537AbhKVUgv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Nov 2021 15:36:51 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMJNAX3017631;
        Mon, 22 Nov 2021 20:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=pWXoERF+5c2HEobel7JaA89vYIzROWWFNszhOY05vZY=;
 b=PK0KK7oj4Keor4DDEjdNJVZ2v3o1x80EeJVGalHs1mqYwL4VXbSoVRe1Jt5Ri7rims+t
 adlTbbSxLtloM9DSRHWHpq7dd6m/DyXB74enQgdDOL6tFwUytsIvDKgBAENhqRxvWViG
 fGCej5hJar/obI//2dpdLXSyIOE9rPtihznX6S3lqJCq/MAEjp6Xe+V9b4nCgQwnz+xH
 eBsfTaqv2r4ZrhRA8yihpkOSqzVZjj78Q5XiohgxDP99rw+aEjVvg+Oz+eYuyM5XbxBU
 4lUGwxRuY96is3fhbo+pWWlCUHg1BCfgbpPjGCOat+uysto3YT0qv8+TcJM5Hm7sdtpL JA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cghad1ax6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 20:33:37 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMKIUr6016744;
        Mon, 22 Nov 2021 20:33:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3cern98w25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 20:33:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMKQPq164225630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 20:26:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94D8F42045;
        Mon, 22 Nov 2021 20:33:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B2A24203F;
        Mon, 22 Nov 2021 20:33:32 +0000 (GMT)
Received: from thinkpad (unknown [9.171.26.122])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 22 Nov 2021 20:33:32 +0000 (GMT)
Date:   Mon, 22 Nov 2021 21:33:30 +0100
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
Message-ID: <20211122213330.66b7893e@thinkpad>
In-Reply-To: <20211122211400.41bf64cf@thinkpad>
References: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
        <20211117193932.4049412-2-gerald.schaefer@linux.ibm.com>
        <9a4367c0-8141-f03c-e5a1-13483794d3e8@suse.cz>
        <20211119205943.1ee5da0d@thinkpad>
        <b513bbcf-f1ea-cfa6-763a-003a60e51da5@suse.cz>
        <20211122211400.41bf64cf@thinkpad>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ACB8K8P-yJGMHCz3zqACIjhP6yr_oHIa
X-Proofpoint-GUID: ACB8K8P-yJGMHCz3zqACIjhP6yr_oHIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=784
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220102
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 22 Nov 2021 21:14:00 +0100
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

[...]
> 
> Thanks. While testing this properly, yet another bug showed up. The idx
> in op->show remains 0 in all iterations, so I always see the same line
> printed t->count times (or infinitely, ATM). Not sure if this only shows
> on s390 due to endianness, but the reason is this:
> 
>   unsigned int idx = *(unsigned int *)v;
> 
> IIUC, void *v is always the same as loff_t *ppos, and therefore idx also
> should be *ppos. De-referencing the loff_t * with an unsigned int * only
> gives the upper 32 bit half of the 64 bit value, which remains 0.
> 
> This would be fixed e.g. with
> 
>   unsigned int idx = (unsigned int) *(loff_t *) v;
> 
> With this fixed, my original patch actually also works for t->count > 0,
> because then op->show would return w/o printing anything when idx reaches
> t->count. For t->count > 0, it would even work w/o any extra checks in
> op->start because of that, only "No data" would be printed infinitely.

Oh, no, that would actually also fix the "No data" part, as op->show
will then also return w/o printing in the next iteration, so that op->next
would correctly end it all.

This could also explain why it might all have worked fine on x86 (haven't
verified), and really only showed on big-endian s390.

Hmm, now I'm not so sure anymore if we really want the additional
checks and return NULL in op->start, just to make it "double safe".

> 
> It probably still makes sense to make this explicit in op->start, by
> checking separately for !*ppos && !t->count, and returning NULL for
> *ppos >= t->count, as you suggested.
> 
> I think I will also make idx an unsigned long again, like it was before
> commit 64dd68497be7, and similar to t->count. Not sure if it needs to
> be, and with proper casting unsigned int is also possible, but why
> change it?

