Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BABC433F5
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 20:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B4561B1E
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 20:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhKSUDK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:03:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236712AbhKSUDC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Nov 2021 15:03:02 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJIlEg0021112;
        Fri, 19 Nov 2021 19:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ht4LbqGA9SMT5zj4CQQn1tDk0StTGoZ7phKyP5w1OuQ=;
 b=j3g03QDrjFelVYQsbh7rkocbtjC9UKz4k+JETe24hBj2HiDH8fq3YfZ+dft7cYv6pNvv
 sJR3Wo6eToUcNBCWbQm+wIDV6XCSj0N8njR4kNQzkrgOlBsQH59KE8JkMfHkuY9DUd/h
 gok55iB+9jQGmDtIdBWHW10pQSDuULiTo46QHASdU+R5Yu7chArkgIKM5N9kmUJ1T8MB
 7Wk0l5KuDKei58ZiG/saYM6xolMJ1YjhlBkbXELYVUCeyPGc96/bk6u2Kv+RGDtcd1cb
 +iwdSOtSLq2bXpkVZgvHgT2UYZnc64jJ8eFS+t4StKNJtGbZCPoHixw8TKH9VTcRzpmL yQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cehgv1a3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 19:59:50 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJJruI7027459;
        Fri, 19 Nov 2021 19:59:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3ca50asfdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 19:59:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJJxj1j2425550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 19:59:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D25D642047;
        Fri, 19 Nov 2021 19:59:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 705554203F;
        Fri, 19 Nov 2021 19:59:45 +0000 (GMT)
Received: from thinkpad (unknown [9.171.79.181])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 19 Nov 2021 19:59:45 +0000 (GMT)
Date:   Fri, 19 Nov 2021 20:59:43 +0100
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
Message-ID: <20211119205943.1ee5da0d@thinkpad>
In-Reply-To: <9a4367c0-8141-f03c-e5a1-13483794d3e8@suse.cz>
References: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
        <20211117193932.4049412-2-gerald.schaefer@linux.ibm.com>
        <9a4367c0-8141-f03c-e5a1-13483794d3e8@suse.cz>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: csvluHu51M-jqF8b8QrieElqCh7D_S44
X-Proofpoint-ORIG-GUID: csvluHu51M-jqF8b8QrieElqCh7D_S44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_15,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=890 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111190105
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 19 Nov 2021 11:41:38 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 11/17/21 20:39, Gerald Schaefer wrote:
> > Reading from alloc/free_traces attribute in /sys/kernel/debug/slab/ results
> > in an endless sequence of "No data". This is because slab_debugfs_start()
> > does not check for a "past end of file" condition and return NULL.
> 
> I still have no idea how that endless sequence happens.
> To get it, we would have to call slab_debugfs_show() repeatedly with such v
> that *v == 0. Which should only happen with slab_debugfs_start() with *ppos
> == 0. Which your patch won't change because you add a '*ppos > t->count'
> condition, so *ppos has to be at least 1 to trigger this.

Yes, very strange. After a closer look to fs/seq_file.c, especially
seq_read_iter(), it seems that op->next will only be called when m->count == 0,
at least in the first while(1) loop. Printing "No data\n" sets m->count
to 8, so it will continue after Fill:, then call op->next, which returns NULL
and breaks the second while(1) loop, and also calls op->stop. Then it returns
from seq_read_iter(), only to be called again, and again, ...

Only when op->start returns NULL it will end it for good, probably
because seq_read_iter() will then return 0 instead of 8. Not sure if
there is a better way to fix this than by adding a second "return NULL"
to op->start, which feels a bit awkward and makes you wonder why the
"return NULL" from op->next is not enough.

> 
> But yeah, AFAIK we should detect this in slab_debugfs_start() anyway.
> But I think the condition should be something like below, because we are
> past end of file already with *ppos == t->count. But if both are 0, we want
> to proceed for the "No data" output.

Ah ok, I wasn't sure about the "t->count > 0" case, i.e. if the check for
"*ppos > t->count" would still be correct there. So apparently it wouldn't,
and we need two checks, like you suggested

> 
> // to show the No data
> if (!*ppos && !t->count)
> 	return ppos;
> 
> if (*ppos >= t->count)
> 	return ppos;

That should be return NULL here, right?

> 
> return ppos;
> 

Will send a new patch, unless I find a better way after investigating the
endless seq_read_iter() calls mentioned above.
Is there an easy way to test the "t->count > 0" case, i.e. what would need
to be done to get some other reply than "No data"?
