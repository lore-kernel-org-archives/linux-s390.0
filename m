Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4028DC433ED
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C56B61937
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 14:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbhEQORc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 17 May 2021 10:17:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32296 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234804AbhEQOPc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 May 2021 10:15:32 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HE4GJA066666;
        Mon, 17 May 2021 10:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ebyIfh4yS14SLNJP5JJjMQ4sEbw+CyRszK2yft5ksa0=;
 b=qikkEGYmYjQe0wBAS9SmirAqitGFfpLzSrFDzdVsWMX4OZhK2w9HdZfOTZfB62CsCp3H
 HFEUD7JMoYfk3fM5akD/GIDNqODHqtC2wR9AInRA/GrfnEVQ1dvGqtB4mJhwFPbGk4xI
 ljLSJ5KyT1zfC+UyhdrRfyJDHKQJacp2hka7/AGBfdhMUMIbsR7FUGb8/h51uVrmgRzb
 5cNt7sH74s8t4yiWY9pxpE19yEbR49d6p6BgjQ4d2vX7y0ce5+T8JNfmCi4wlhUcdAlT
 X8y9L6Bi3IAe6k5QxkHq+GWa+ct5OCnzBdhvCaXJegl+HPpkhiNvpHCT1hWmR0a8GrMo GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38kkmkv5k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 10:14:05 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14HE4VK0069688;
        Mon, 17 May 2021 10:14:05 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38kkmkv5hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 10:14:04 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14HDvuBV016372;
        Mon, 17 May 2021 14:14:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 38j5x80fg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 14:14:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14HEE0tW39911900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 14:14:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E84895204E;
        Mon, 17 May 2021 14:13:59 +0000 (GMT)
Received: from thinkpad (unknown [9.171.54.77])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 5B2EE52057;
        Mon, 17 May 2021 14:13:59 +0000 (GMT)
Date:   Mon, 17 May 2021 16:13:57 +0200
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
Message-ID: <20210517161358.49683f34@thinkpad>
In-Reply-To: <a4403be6-5b74-2c86-bc4c-42ae4f0764dc@arm.com>
References: <1620621345-29176-1-git-send-email-anshuman.khandual@arm.com>
        <a4403be6-5b74-2c86-bc4c-42ae4f0764dc@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L2wRBfDMFA8ii8uXT3uoCV9jTCk3AtQy
X-Proofpoint-ORIG-GUID: 0eDWjaTGdNJmIBb7dSGX-EcdESsB2Vwc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_05:2021-05-17,2021-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=530
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 mlxscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170100
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 17 May 2021 09:45:31 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> 
> 
> On 5/10/21 10:05 AM, Anshuman Khandual wrote:
> > ARCH_ENABLE_SPLIT_PMD_PTLOCK is irrelevant unless there are two page table
> > levels including PMD (also per Documentation/vm/split_page_table_lock.rst).
> > Make this dependency explicit on remaining platforms i.e x86 and s390 where
> > ARCH_ENABLE_SPLIT_PMD_PTLOCK is subscribed.

For s390, I don't think this makes a lot of sense. We always have 5 levels
defined for PGTABLE_LEVELS, and we would not even compile with any other
value, because of the "#error CONFIG_PGTABLE_LEVELS" in include/linux/pgtable.h.

Our pagetable folding also works a bit different than it does on other archs,
and we would actually have pmd level entries for 2-level pagetables, so it should
all work fine also with PGTABLE_LEVELS == 2 (if it was possible).

In fact, I do not really see why you would need "more than two levels" on any
arch, in order to use split PMD locks. Your description also just says
"irrelevant unless there are two page table levels", and not "more than two
levels", like in Documentation/vm/split_page_table_lock.rst.

Yet, your patch adds checks for "more than", so at least the description
seems a bit misleading. I assume that the "more than" has to do with folded
PMD on a 2-level system, but the way we fold on s390 I do not see why that
should be a problem. Could you please elaborate a bit?

We also have different levels of pagetables for kernel (CONFIG_PGTABLE_LEVELS)
and user processes on s390. The latter can have dynamic levels, currently
starting with 3, but previously we also had 2 levels for compat tasks e.g.
These dynamic levels for user processes are also independent from the
CONFIG_PGTABLE_LEVELS used for the kernel pagetable, while the split PMD lock
of course also affects user process pagetables, so that would be another
reason not to add such a dependency for ARCH_ENABLE_SPLIT_PMD_PTLOCK on s390.
