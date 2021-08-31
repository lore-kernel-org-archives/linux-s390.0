Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5397C432BE
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 10:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA0F60ED4
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 10:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbhHaKOk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 Aug 2021 06:14:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241145AbhHaKOg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Aug 2021 06:14:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VA76SD152223;
        Tue, 31 Aug 2021 06:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=FQz/KL/YGeAhHXRrjkckE3vzqICbAzZQNvvHjUNWRXU=;
 b=XTr+A4Big/MUNZa+2JMBVjD7z350iW0nuTnYaRKSAu4+YXltceFOrDOfwx0bxxsbNY5w
 lkZ05c1UF2wtH2vrxE5gvGdzNzo0lhDAnABE3+jnjvQ8kk/8JIC4k/9/4g9EYiCDfVpf
 Xm+EqD5yFjUi6llNCrXff4/jqfPE/J2t0So6u9tGevBXhjDcHVWofN/W5X0gAc4xHAo8
 a889ERPoIe1PK7IZIz93jUgKruvihIW90BSKP+fwenkUM7EL/vOXQkqZpnm71LnXVqLZ
 zl8roeD31yrQQjvb5OlMyFJBh6Pg/jYFUrliO9l8Cx+kjFaTN+Ouxey5fpy9WrH/GBtd iQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3asjbw08k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 06:13:23 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17VA2wic017063;
        Tue, 31 Aug 2021 10:13:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3aqcs8pyht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 10:13:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17VADFR342598660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 10:13:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACD8BA405B;
        Tue, 31 Aug 2021 10:13:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52CCAA4062;
        Tue, 31 Aug 2021 10:13:15 +0000 (GMT)
Received: from osiris (unknown [9.145.60.147])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 31 Aug 2021 10:13:15 +0000 (GMT)
Date:   Tue, 31 Aug 2021 12:13:13 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
Message-ID: <YS4AufXrOCa4rzN0@osiris>
References: <YSzZFgBt6nMvpVgc@osiris>
 <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
 <82161448-2770-158c-fdd3-d253b4ae476f@de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82161448-2770-158c-fdd3-d253b4ae476f@de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1_-cpaVSn1WqCzPphNX0SLhtSiTm7s8S
X-Proofpoint-GUID: 1_-cpaVSn1WqCzPphNX0SLhtSiTm7s8S
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_04:2021-08-30,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310058
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 31, 2021 at 09:09:10AM +0200, Christian Borntraeger wrote:
> 
> 
> On 31.08.21 04:19, Nathan Chancellor wrote:
> > Hi Heiko,
> > 
> > On Mon, Aug 30, 2021 at 03:11:50PM +0200, Heiko Carstens wrote:
> > > - Enable KCSAN for s390. This comes with a small common code change to fix a
> > >    compile warning. Acked by Marco Elver:
> > >    https://lore.kernel.org/r/20210729142811.1309391-1-hca@linux.ibm.com/
> > 
> > This caught my eye, as we are boot testing KCSAN + KCSAN_KUNIT_TEST in
> > our CI [1] for x86_64 so it would be nice to enable this for s390 as
> > well. However, it does not seem like the unit tests pass when booting up
> > in QEMU, is this expected or am I doing something wrong? The results and
> > compiler versions are below (the results are the same), they should both
> > have the commits that are mentioned in the KCSAN message.
> 
> Do you have a branch somewhere where you have the s390 build rules as well as
> the qemu command line? Maybe its a QEMU TCG issue, dont know. CC qemu-s390x
> just in case.

I really don't think this is QEMU related. The test fails are sort of
expected: we've seen KCSAN reports when the kernel boots and wanted to
fix them later.
However I have to admit that I wasn't aware of the KCSAN KUNIT tests,
and wouldn't have sent the s390 KCSAN enablement upstream if I would
have been aware of failing self tests.

We'll fix them, and I let you know if things are supposed to work.

Thanks a lot for making aware of this!
