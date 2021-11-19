Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A9C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 11:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1302161547
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 11:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhKSLMf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:12:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234960AbhKSLMe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Nov 2021 06:12:34 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ9i3TR005724;
        Fri, 19 Nov 2021 11:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=DMGGL+ptrDkHqbY8K7wsnL5eoa1Z6LiRarwnFfhbyEQ=;
 b=UmWy4BvtxMPzWhAZuiZygE3zGNr/96QrAoRbS5cCcTDj9TID/Q3v7U1zPAY7UN06/XZS
 TCpFwQ8KLw+DI2ewlrLgqbPQOYzDPQmZrOgFBwyId1QmD/ms9ffhlBPASus+euumNAhC
 W5fX+nBFs7PlZPb/5lfaM4wiq7XR+XkrzEa95hNR4irJ4pqLj6CJUVbMaPymGdgQxMOS
 nr+Yo6mOoZgg3PxR7vmY+1p7exgn1nT+1h8Yv7B60bzmQlF1O9n8Au9hWVJVdy/+wAwv
 ZoOPH04XcgnoYhboVE3peJr+MmWtM0f3ZDkzYXGWo1FCqvlm7yBYdt/GxTzTg4CqkfCA xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce9hxsrbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 11:09:30 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJB5aOK017787;
        Fri, 19 Nov 2021 11:09:30 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce9hxsraw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 11:09:30 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJB7ha3010426;
        Fri, 19 Nov 2021 11:09:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3ca4mkwg0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 11:09:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJB2NSJ50856220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 11:02:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60DD4A4065;
        Fri, 19 Nov 2021 11:09:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA3BDA4066;
        Fri, 19 Nov 2021 11:09:21 +0000 (GMT)
Received: from osiris (unknown [9.145.50.239])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 19 Nov 2021 11:09:21 +0000 (GMT)
Date:   Fri, 19 Nov 2021 12:09:20 +0100
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
Message-ID: <YZeF4JjWIcTMtaaT@osiris>
References: <20211117174822.3632412-1-ilie.halip@gmail.com>
 <CAKwvOd=9tsHHhPBOx2ORZoJP09VsX5dRZn58qj3MzCc2vmVosg@mail.gmail.com>
 <d9ec2704-f41c-eafa-1945-ce845d65be8a@de.ibm.com>
 <YZeCcSjh4yCzzDcH@osiris>
 <658a63b5-2d18-2837-9639-75a14c959f73@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658a63b5-2d18-2837-9639-75a14c959f73@de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yXjN38N57id5v6xLCKgrJxhtcqyAIWLK
X-Proofpoint-ORIG-GUID: Y8yjdJ5m2mzrHFDC_l0REOvIVXkdYtwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxlogscore=821
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111190062
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Nov 19, 2021 at 11:57:05AM +0100, Christian Borntraeger wrote:
> > > > > -                       "       mvcl    %%r1,%%r1\n"
> > > > > +                       "       .insn e,0x0e11\n"       /* mvcl %%r1,%%r1" */
> > 
> > Sorry, I disagree with this. As you said above rr would be the correct
> > format for this instruction. If we go for the e format then we should
> > also use an instruction with e format.
> > Which in this case would simply be an illegal opcode, which would be
> > sufficient for what this code is good for: ".insn e,0x0000".
> 
> Why not simply use .short then?

.short bypasses all sanity checks while .insn does not, so I think
that should be preferred. But I don't care too much.
