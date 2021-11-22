Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA86C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 22 Nov 2021 20:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhKVURa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:17:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19870 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240426AbhKVURW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Nov 2021 15:17:22 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMJqf5w002097;
        Mon, 22 Nov 2021 20:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=DPK6OLI4Kh0a+DATlgi8QTIRNh0LOiCs+k/tnqWDSMg=;
 b=FEvk1+P5cUD1SQb8QIjpuDxBH8bY6SJLdZQwMoqEiffv2SZr9ZlxA4JTUknouxfvdZ/I
 zpe/0R70LRiGTociUxLh9CXk1ilwnTuG7n06WDNmVNGeHRpQQjlLjwPPoXumjvWXxAQw
 Yja+25S5VwmmFOUP60+dkE9/mgpqN2tghXjGOee69S40UvjZiNfCRdNu8qEnNBuIigHG
 d3q8jH+E0pEl8rsW0wBQnecT3tTbaZWXBeDN+bPyKj8gvKhkQQ8ISIFFNJjvpwhXFd6s
 cGavBdnq8Mgp+gznmYaKOSSvEgwm8hJ8iqHL/B3jZ7PTmEipMvINV/klQppMqWjhP4Dl Ug== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cghre0dcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 20:14:06 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMK4GEP023869;
        Mon, 22 Nov 2021 20:14:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3cern9gvgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 20:14:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMK6tso63832388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 20:06:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95F5A52051;
        Mon, 22 Nov 2021 20:14:02 +0000 (GMT)
Received: from thinkpad (unknown [9.171.26.122])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 3E4405204F;
        Mon, 22 Nov 2021 20:14:02 +0000 (GMT)
Date:   Mon, 22 Nov 2021 21:14:00 +0100
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
Message-ID: <20211122211400.41bf64cf@thinkpad>
In-Reply-To: <b513bbcf-f1ea-cfa6-763a-003a60e51da5@suse.cz>
References: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
        <20211117193932.4049412-2-gerald.schaefer@linux.ibm.com>
        <9a4367c0-8141-f03c-e5a1-13483794d3e8@suse.cz>
        <20211119205943.1ee5da0d@thinkpad>
        <b513bbcf-f1ea-cfa6-763a-003a60e51da5@suse.cz>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GBAUk7c2W7Dkf33V0NjpjJqApXNtvYIn
X-Proofpoint-GUID: GBAUk7c2W7Dkf33V0NjpjJqApXNtvYIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220100
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 22 Nov 2021 16:02:28 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 11/19/21 20:59, Gerald Schaefer wrote:
> > On Fri, 19 Nov 2021 11:41:38 +0100
> > Vlastimil Babka <vbabka@suse.cz> wrote:
> > 
> >> On 11/17/21 20:39, Gerald Schaefer wrote:
> >> > Reading from alloc/free_traces attribute in /sys/kernel/debug/slab/ results
> >> > in an endless sequence of "No data". This is because slab_debugfs_start()
> >> > does not check for a "past end of file" condition and return NULL.
> >> 
> >> I still have no idea how that endless sequence happens.
> >> To get it, we would have to call slab_debugfs_show() repeatedly with such v
> >> that *v == 0. Which should only happen with slab_debugfs_start() with *ppos
> >> == 0. Which your patch won't change because you add a '*ppos > t->count'
> >> condition, so *ppos has to be at least 1 to trigger this.
> > 
> > Yes, very strange. After a closer look to fs/seq_file.c, especially
> > seq_read_iter(), it seems that op->next will only be called when m->count == 0,
> > at least in the first while(1) loop. Printing "No data\n" sets m->count
> > to 8, so it will continue after Fill:, then call op->next, which returns NULL
> > and breaks the second while(1) loop, and also calls op->stop. Then it returns
> > from seq_read_iter(), only to be called again, and again, ...
> > 
> > Only when op->start returns NULL it will end it for good, probably
> > because seq_read_iter() will then return 0 instead of 8.
> 
> Ah, thanks for investigating.
> 
> > Not sure if
> > there is a better way to fix this than by adding a second "return NULL"
> > to op->start, which feels a bit awkward and makes you wonder why the
> > "return NULL" from op->next is not enough.
> 
> I think it's fine to require op->start to return NULL, even if it didn't
> cause this infinite loop.

Yes, this all seems to work as designed, and it is slowly beginning to
make some sense. The only other way to stop it would be to return from
op->show, w/o printing anything, like it would be done for t->count > 0,
when idx becomes >= t->count. In theory at least, see below.

> 
> >> 
> >> But yeah, AFAIK we should detect this in slab_debugfs_start() anyway.
> >> But I think the condition should be something like below, because we are
> >> past end of file already with *ppos == t->count. But if both are 0, we want
> >> to proceed for the "No data" output.
> > 
> > Ah ok, I wasn't sure about the "t->count > 0" case, i.e. if the check for
> > "*ppos > t->count" would still be correct there. So apparently it wouldn't,
> > and we need two checks, like you suggested
> > 
> >> 
> >> // to show the No data
> >> if (!*ppos && !t->count)
> >> 	return ppos;
> >> 
> >> if (*ppos >= t->count)
> >> 	return ppos;
> > 
> > That should be return NULL here, right?
> 
> Doh, right.
> 
> >> 
> >> return ppos;
> >> 
> > 
> > Will send a new patch, unless I find a better way after investigating the
> > endless seq_read_iter() calls mentioned above.
> > Is there an easy way to test the "t->count > 0" case, i.e. what would need
> > to be done to get some other reply than "No data"?
> 
> Hm the debugfs files alloc_tracess/free_traces for any cache with non-zero
> objects (see /proc/slabinfo for that) should have t->count > 0. If the files
> are created for a cache, it means the related SLAB_STORE_USER debugging was
> enabled both during config and boot-time. If you see only a few caches with
> alloc_tracess/free_traces (because they are from e.g. some test module that
> adds SLAB_STORE_USER explicitly) and all happen to have 0 objects, boot with
> slub_debug=U parameter and then all caches will have this enabled and many
> will have >0 objects.

Thanks. While testing this properly, yet another bug showed up. The idx
in op->show remains 0 in all iterations, so I always see the same line
printed t->count times (or infinitely, ATM). Not sure if this only shows
on s390 due to endianness, but the reason is this:

  unsigned int idx = *(unsigned int *)v;

IIUC, void *v is always the same as loff_t *ppos, and therefore idx also
should be *ppos. De-referencing the loff_t * with an unsigned int * only
gives the upper 32 bit half of the 64 bit value, which remains 0.

This would be fixed e.g. with

  unsigned int idx = (unsigned int) *(loff_t *) v;

With this fixed, my original patch actually also works for t->count > 0,
because then op->show would return w/o printing anything when idx reaches
t->count. For t->count > 0, it would even work w/o any extra checks in
op->start because of that, only "No data" would be printed infinitely.

It probably still makes sense to make this explicit in op->start, by
checking separately for !*ppos && !t->count, and returning NULL for
*ppos >= t->count, as you suggested.

I think I will also make idx an unsigned long again, like it was before
commit 64dd68497be7, and similar to t->count. Not sure if it needs to
be, and with proper casting unsigned int is also possible, but why
change it?
