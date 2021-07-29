Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAD9C4338F
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 16:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C6860F46
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 16:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhG2QHg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:07:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19075 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232963AbhG2QF7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Jul 2021 12:05:59 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TG43E9006711;
        Thu, 29 Jul 2021 12:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=+hvYv+gTA03BfCESrF6+SKmI0tlkNnXdZDWckobVI8M=;
 b=Tprljk8GllmYyJd4By/GA+4co1zMZH9JEk3PMJsgxnKJmdh3Fy+iXB08Ffv/fSVC/SFW
 rmsW2NaoFoTM0JuBVJFVvD3B+igYsWZXjFysUFlZ2sLHmKoItKLBLod24j5WDq6wxmCD
 AzacmVBatkTnbcn7eSFkgaW180GNtOl8a96S3wBFrG+sDRXJxK5BQs95iU5A1raczhpF
 2Nh2wmicFFIgHqhXu0/2nDLjJFr5OT4QMBZK4/5qm+0JcxWQoVrmrSnwxB9AsDYu0MWa
 r0XNoVzrL/pMsKTfC9BNVKY1LgdpgCedwll4LOdm5dk18lLHD0m3gBrvKndcvNtYvSUz Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3shafnqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 12:05:12 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16TG4Jg9011471;
        Thu, 29 Jul 2021 12:05:12 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3shafnpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 12:05:11 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TG0BOM018534;
        Thu, 29 Jul 2021 16:05:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3a235xs9c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 16:05:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TG56Uj22151634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 16:05:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 296BFA4075;
        Thu, 29 Jul 2021 16:05:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBEB9A4066;
        Thu, 29 Jul 2021 16:05:05 +0000 (GMT)
Received: from osiris (unknown [9.145.0.186])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Jul 2021 16:05:05 +0000 (GMT)
Date:   Thu, 29 Jul 2021 18:05:04 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] kcsan: use u64 instead of cycles_t
Message-ID: <YQLRsNjn/lQwiIcl@osiris>
References: <20210729142811.1309391-1-hca@linux.ibm.com>
 <CANpmjNM=rSFwmJCEq6gxHZBdYKVZas4rbnd2gk8GCAEjiJ_5UQ@mail.gmail.com>
 <20210729155834.GX4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729155834.GX4397@paulmck-ThinkPad-P17-Gen-1>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qTIWVnuHtf-8duyggWgGst_ghBh7F0Sj
X-Proofpoint-GUID: 7OxKO8CAHGaWRanJ6MkPTxV7gmUbu9bW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_12:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=939 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290101
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 29, 2021 at 08:58:34AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 29, 2021 at 04:53:10PM +0200, Marco Elver wrote:
> > +Cc: Paul
> > 
> > On Thu, 29 Jul 2021 at 16:28, Heiko Carstens <hca@linux.ibm.com> wrote:
> > >
> > > cycles_t has a different type across architectures: unsigned int,
> > > unsinged long, or unsigned long long. Depending on architecture this
> > > will generate this warning:
> > >
> > > kernel/kcsan/debugfs.c: In function ‘microbenchmark’:
> > > ./include/linux/kern_levels.h:5:25: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘cycles_t’ {aka ‘long unsigned int’} [-Wformat=]
> > >
> > > To avoid this simple change the type of cycle to u64 in
> > > microbenchmark(), since u64 is of type unsigned long long for all
> > > architectures.
> > >
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > 
> > Acked-by: Marco Elver <elver@google.com>
> > 
> > Do you have a series adding KCSAN support for s390, i.e. would you
> > like to keep it together with those changes?
> > 
> > Otherwise this would go the usual route through Paul's -rcu tree.
> 
> Either way, please let me know!

We will enable KCSAN support for s390 with the next merge window, so
I'll queue this patch also on the s390 tree.

Thanks!
