Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B21C433B4
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 11:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CD96101E
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 11:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbhESLJG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 May 2021 07:09:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32990 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240482AbhESLJF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 07:09:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JB4McU175859;
        Wed, 19 May 2021 07:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=mgQP3Ox1zUzhqI+jTSjnWTXTwOY6N8NMVBkqvt6iJi4=;
 b=Ek/Cjvwltmcjr7sM4AGleRPxOaWP17xfCHOt/9R/Xta3oZjAyjxuYRye5uonQ/7F+MwD
 yFSQRmeklkFuy6gB9CRxCbbxAU5WTITKQ6+kyajSSvZBQiToOM0MRsz+wN40VZXx9vKw
 Q9XR9duZCdNGqq8plva7mEQbJXqYlF9E+77jIDe8Z7nCuyOPQAL/UpoR08yAfPpj6Sn/
 ntQmxn1c4fjzjLx1W+ao+J+GgrfP7FdskWJBnlsZECtQ6vD7UCfyrYe7t1sRNa01xtsG
 DRCgbBMaZy4/J5ciD6qOKHKvN9nTay0UzUCiK3tF5CngarC2nSi7z/EhWwJKuHFmYODT 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38n182gewj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 07:07:30 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14JB4lZJ183041;
        Wed, 19 May 2021 07:07:29 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38n182gevx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 07:07:29 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JAnVTT008925;
        Wed, 19 May 2021 11:07:28 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 38mceh8c0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 11:07:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JB7Ond29295018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 11:07:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B00CEA4059;
        Wed, 19 May 2021 11:07:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C109A4040;
        Wed, 19 May 2021 11:07:24 +0000 (GMT)
Received: from thinkpad (unknown [9.171.46.43])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 19 May 2021 11:07:24 +0000 (GMT)
Date:   Wed, 19 May 2021 13:07:22 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: Make ARCH_ENABLE_SPLIT_PMD_PTLOCK dependent on
 PGTABLE_LEVELS > 2
Message-ID: <20210519130722.7d255b7f@thinkpad>
In-Reply-To: <20210517161358.49683f34@thinkpad>
References: <1620621345-29176-1-git-send-email-anshuman.khandual@arm.com>
        <a4403be6-5b74-2c86-bc4c-42ae4f0764dc@arm.com>
        <20210517161358.49683f34@thinkpad>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WWrK9mQA_VGxztucBjuP4reC0yVbWybH
X-Proofpoint-ORIG-GUID: 8Di_qBcH4nJ6RmCX8ShVo6LLQY9FAAW_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_04:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190074
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 17 May 2021 16:13:57 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Mon, 17 May 2021 09:45:31 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
> > 
> > 
> > On 5/10/21 10:05 AM, Anshuman Khandual wrote:  
> > > ARCH_ENABLE_SPLIT_PMD_PTLOCK is irrelevant unless there are two page table
> > > levels including PMD (also per Documentation/vm/split_page_table_lock.rst).
> > > Make this dependency explicit on remaining platforms i.e x86 and s390 where
> > > ARCH_ENABLE_SPLIT_PMD_PTLOCK is subscribed.  
> 
> For s390, I don't think this makes a lot of sense. We always have 5 levels
> defined for PGTABLE_LEVELS, and we would not even compile with any other
> value, because of the "#error CONFIG_PGTABLE_LEVELS" in include/linux/pgtable.h.
> 
> Our pagetable folding also works a bit different than it does on other archs,
> and we would actually have pmd level entries for 2-level pagetables, so it should
> all work fine also with PGTABLE_LEVELS == 2 (if it was possible).
> 
> In fact, I do not really see why you would need "more than two levels" on any
> arch, in order to use split PMD locks. Your description also just says
> "irrelevant unless there are two page table levels", and not "more than two
> levels", like in Documentation/vm/split_page_table_lock.rst.
> 
> Yet, your patch adds checks for "more than", so at least the description
> seems a bit misleading. I assume that the "more than" has to do with folded
> PMD on a 2-level system, but the way we fold on s390 I do not see why that
> should be a problem. Could you please elaborate a bit?
> 
> We also have different levels of pagetables for kernel (CONFIG_PGTABLE_LEVELS)
> and user processes on s390. The latter can have dynamic levels, currently
> starting with 3, but previously we also had 2 levels for compat tasks e.g.
> These dynamic levels for user processes are also independent from the
> CONFIG_PGTABLE_LEVELS used for the kernel pagetable, while the split PMD lock
> of course also affects user process pagetables, so that would be another
> reason not to add such a dependency for ARCH_ENABLE_SPLIT_PMD_PTLOCK on s390.

Ouch, I guess I was a bit confused here. I thought the split PMD lock
was part of the struct page for the 4 KB page where the PMD entry is located,
and therefore, with more than one page, it still would make (a little) sense
to use it also for 2 pagetable levels.

However, pmd_to_page() always returns the struct page of the first page,
so there is only one split PMD lock for the whole thing (4 pages for s390).
Of course that means that with 2 pagetable levels, and only one PMD directory,
the split PMD lock would be equivalent to the global pagetable lock, and
therefore not make any sense.

Maybe you could change the description to also mention "more than two"
levels?

I still do not see a real benefit of the patch, e.g. it does not really
fix any possible misconfiguration, at least on s390. But it certainly is not
wrong, and at least it had the benefit of making me aware again of how split
PMD locks work, so I'll happily add this

Acked-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com> # s390
