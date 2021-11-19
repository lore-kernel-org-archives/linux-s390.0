Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC2FC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 10:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F09615E2
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 10:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhKSK55 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:57:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231810AbhKSK54 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Nov 2021 05:57:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJAfZOP006962;
        Fri, 19 Nov 2021 10:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=wKWz7PHrj+SFmnjEdVEFIIOfyl2jlIe2KgIrClAfM7Q=;
 b=NyVCYfqj5BC/PNiX75psXkQzQVcRWc6ue2pg0llb2/qwKBMYiN9qAn7eRuCQ/UPbX0M0
 NLIGDaXeBS7DomE6XpAQd08v8IN0Cw/9S/P9Py/NDKuAqYM+S26kETA/6n+Rd0TnqrV3
 szIZGueA9Be4Tpc3WpLYSlCrFGiq11ts5zIk6nc4XkbdBhHd3c4SFNo7BtWYOP04mxdi
 iHJPTpi9daPEh+yjwjV/gs8+XAL/+yWSa8IuUeNgaZaDKS/Bj8bUkbqnjG3KGBlqlmXc
 P2Zm4B9JINZrNwxfXCsoUvT/kqUMO0ccROhU7rE63HCm+RepQ6dUWh8Np8NzSHmGrMcF pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cead2r7hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 10:54:52 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJAmXOt027623;
        Fri, 19 Nov 2021 10:54:52 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cead2r7h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 10:54:52 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJAs2B8003588;
        Fri, 19 Nov 2021 10:54:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ca50bymap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 10:54:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJAlfte66060774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 10:47:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9320C4C050;
        Fri, 19 Nov 2021 10:54:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A59F4C044;
        Fri, 19 Nov 2021 10:54:43 +0000 (GMT)
Received: from osiris (unknown [9.145.50.239])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 19 Nov 2021 10:54:43 +0000 (GMT)
Date:   Fri, 19 Nov 2021 11:54:41 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mete Durlu <meted@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Subject: Re: [PATCH] s390/test_unwind: use raw opcode instead of invalid
 instruction
Message-ID: <YZeCcSjh4yCzzDcH@osiris>
References: <20211117174822.3632412-1-ilie.halip@gmail.com>
 <CAKwvOd=9tsHHhPBOx2ORZoJP09VsX5dRZn58qj3MzCc2vmVosg@mail.gmail.com>
 <d9ec2704-f41c-eafa-1945-ce845d65be8a@de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ec2704-f41c-eafa-1945-ce845d65be8a@de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a4LJblKPqLYsaAXSHs8M1b4Ofvm5NmIQ
X-Proofpoint-ORIG-GUID: _CE_H8hXaCG5BNnRJtbCrc4BxLsn7moO
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_08,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111190058
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Nov 19, 2021 at 10:39:15AM +0100, Christian Borntraeger wrote:
> > So if I understand
> > https://sourceware.org/binutils/docs/as/s390-Directives.html#s390-Directives
> > https://sourceware.org/binutils/docs/as/s390-Formats.html
> > that `e,` prefix is for 16B opcodes?
> 
> e is an instruction format as specified by the architecture.
> See http://publibfp.dhe.ibm.com/epubs/pdf/a227832c.pdf
> without any parameters.
> Normally RR would be the right thing for MVCL, but since
> we try to build an invalid opcode without the assembler
> noticing (ab)using e seem like a safer approach.
> > 
> > LGTM, thanks again.
> > Suggested-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> added those and added my RB. applied to the s390 tree. Thanks
..
> > > diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
> > > index cfc5f5557c06..d342bc884b94 100644
> > > --- a/arch/s390/lib/test_unwind.c
> > > +++ b/arch/s390/lib/test_unwind.c
> > > @@ -176,7 +176,7 @@ static noinline int unwindme_func4(struct unwindme *u)
> > >                   * trigger specification exception
> > >                   */
> > >                  asm volatile(
> > > -                       "       mvcl    %%r1,%%r1\n"
> > > +                       "       .insn e,0x0e11\n"       /* mvcl %%r1,%%r1" */

Sorry, I disagree with this. As you said above rr would be the correct
format for this instruction. If we go for the e format then we should
also use an instruction with e format.
Which in this case would simply be an illegal opcode, which would be
sufficient for what this code is good for: ".insn e,0x0000".

Plus a fixup of the comment above, since this would generate an
operation insteand of a specification exception. Just a generic
"exception" would be good enough for the comment.
