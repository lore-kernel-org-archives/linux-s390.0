Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD11C4338F
	for <linux-s390@archiver.kernel.org>; Sat, 31 Jul 2021 06:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD0760EC0
	for <linux-s390@archiver.kernel.org>; Sat, 31 Jul 2021 06:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhGaGsT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 31 Jul 2021 02:48:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232079AbhGaGsT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 31 Jul 2021 02:48:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16V6Xswk072896;
        Sat, 31 Jul 2021 02:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=55r+2JCsXAeqcjXgen83P7RHTNtuAbv6he7zsEbZUtI=;
 b=Ou+VvEnf7DLw028wb9VcTJ709EgCvI1RN3nkT2bIB36IzIzscaSk8LlWrn5DA8dVPL6m
 3/u/O3RWJxAHRuRH33tlmWiynXU5wvl/BflwoTxe9TC079kAs5rUKZ16+XFnzOSKfxXv
 Ns4SjiCYDNaUV17LXCD2nlHFQwz7Lph/mEWxiToNtQQ7cCvUpmCsrtromYREWrKQ2J+w
 1eqA6wRQ2gQi+XusCA6cnnskmeoH18jMlgAzsPQKz1auEk6w16QFQDOULjGTdkGLdIW4
 fpKk7qH9ircv5m001zV8JHqMmUsaRwXnPh3bwsFFqez3IJjns2cuM5Kt88phy9cuLfV0 hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a51awg878-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Jul 2021 02:47:43 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16V6ZDOs080269;
        Sat, 31 Jul 2021 02:47:42 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a51awg86q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Jul 2021 02:47:42 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16V6hASX010277;
        Sat, 31 Jul 2021 06:47:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3a4x58g6fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Jul 2021 06:47:40 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16V6imQd34210120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 31 Jul 2021 06:44:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC22BAE045;
        Sat, 31 Jul 2021 06:47:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BD2EAE04D;
        Sat, 31 Jul 2021 06:47:36 +0000 (GMT)
Received: from osiris (unknown [9.145.16.160])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 31 Jul 2021 06:47:36 +0000 (GMT)
Date:   Sat, 31 Jul 2021 08:47:35 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] ftrace: Introduce ftrace_need_init_nop()
Message-ID: <YQTyB5eeC0FvDm06@osiris>
References: <20210728212546.128248-1-iii@linux.ibm.com>
 <20210728212546.128248-2-iii@linux.ibm.com>
 <20210730220741.4da6fdf6@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730220741.4da6fdf6@oasis.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tqCo0P08jxZEBeCc-2YgUKreUEvyOFRR
X-Proofpoint-ORIG-GUID: J1IvfW7LxhilDrbsEMhhaQfH8dmY_bzV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=989
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107310029
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jul 30, 2021 at 10:07:41PM -0400, Steven Rostedt wrote:
> On Wed, 28 Jul 2021 23:25:45 +0200
> Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> 
> > Implementing live patching on s390 requires each function's prologue to
> > contain a very special kind of nop, which gcc and clang don't generate.
> > However, the current code assumes that if CC_USING_NOP_MCOUNT is
> > defined, then whatever the compiler generates is good enough.
> > 
> > Move the CC_USING_NOP_MCOUNT check into the new ftrace_need_init_nop()
> > macro, that the architectures can override.
> > 
> > An alternative solution is to disable using -mnop-mcount in the
> > Makefile, however, this makes the build logic (even) more complicated
> > and forces the arch-specific code to deal with the useless __fentry__
> > symbol.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> I'm fine with this patch, and also you taking it in via the s390 tree.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks a lot!
