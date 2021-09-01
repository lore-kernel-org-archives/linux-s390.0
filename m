Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5A2C432BE
	for <linux-s390@archiver.kernel.org>; Wed,  1 Sep 2021 18:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D092660E98
	for <linux-s390@archiver.kernel.org>; Wed,  1 Sep 2021 18:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344186AbhIASIx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 1 Sep 2021 14:08:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346742AbhIASIw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Sep 2021 14:08:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 181I3qek107666;
        Wed, 1 Sep 2021 14:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wkYjLWX8rXhdvLuWE8NESy6EQAHoacFiv3Ea4fPekEs=;
 b=FYfcFWnLbiqRtoym4DYsZfiQ5vIgw1t7zPfi0ve2ESNWQGnlC+9BX/4ObAaKDVFk8qQy
 GIBCgT3+bEbvrjKpTyB7IryNsCp6nzD63m5on25qFQNtnv63wDkb83SHfTrB2OSbbV2O
 EvqJnzxU18j28uosxA+WixgVK2npV22TDz039cMPIdY809ixlUK7lPdnY6tI97kkLbeT
 JZMDNIucejtBkUker5bsm6UD7oIcHLNClVQpVauOUP4i2QlKz+1OVyF5kGYWaIk0nlSy
 1wMK+jcSI6B+Ub7b6BdidWOWA/Rc0Qv/jCgMlnLY7oMNmKG5uWsFOm4t4e9g5dLYJGbV cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ateffr40f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 14:07:46 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 181I7jjR131768;
        Wed, 1 Sep 2021 14:07:45 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ateffr3yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 14:07:45 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 181I3gsm012145;
        Wed, 1 Sep 2021 18:07:43 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3atdxs8bf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 18:07:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 181I7di654919586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 18:07:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 000D0AE058;
        Wed,  1 Sep 2021 18:07:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 947A2AE051;
        Wed,  1 Sep 2021 18:07:38 +0000 (GMT)
Received: from osiris (unknown [9.145.33.173])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Sep 2021 18:07:38 +0000 (GMT)
Date:   Wed, 1 Sep 2021 20:07:37 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Marco Elver <elver@google.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH] s390/unwind: use current_frame_address() to unwind
 current task
Message-ID: <YS/BaQcbMkEji9Zg@osiris>
References: <your-ad-here.call-01630505035-ext-2999@work.hours>
 <patch.git-04dd26be3043.your-ad-here.call-01630504868-ext-6188@work.hours>
 <CANpmjNOJN4yG8g+Qz0icppRK6coVdN5yKMhyTCQeBRFq7_YpfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOJN4yG8g+Qz0icppRK6coVdN5yKMhyTCQeBRFq7_YpfA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v-npZZ7suGUKNXWT00l8P8Pk2Mur_NlB
X-Proofpoint-GUID: t0sPbzVL_w0oFUWrkLU-SJAVzDU4tuoo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_05:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109010104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 01, 2021 at 07:51:06PM +0200, Marco Elver wrote:
> On Wed, 1 Sept 2021 at 16:06, Vasily Gorbik <gor@linux.ibm.com> wrote:
> > current_stack_pointer() simply returns current value of %r15. If
> > current_stack_pointer() caller allocates stack (which is the case in
> > unwind code) %r15 points to a stack frame allocated for callees, meaning
> > current_stack_pointer() caller (e.g. stack_trace_save) will end up in
> > the stacktrace. This is not expected by stack_trace_save*() callers and
> > causes problems.
> >
> > current_frame_address() on the other hand returns function stack frame
> > address, which matches %r15 upon function invocation. Using it in
> > get_stack_pointer() makes it more aligned with x86 implementation
> > (according to BACKTRACE_SELF_TEST output) and meets stack_trace_save*()
> > caller's expectations, notably KCSAN.
> >
> > Also make sure unwind_start is always inlined.
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> 
> Tested-by: Marco Elver <elver@google.com>
> 
> Thanks!
> 
> > ---
> >  arch/s390/include/asm/stacktrace.h | 20 ++++++++++----------
> >  arch/s390/include/asm/unwind.h     |  8 ++++----
> >  2 files changed, 14 insertions(+), 14 deletions(-)

Applied, thanks!
