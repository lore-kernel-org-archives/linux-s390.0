Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58E2C433F5
	for <linux-s390@archiver.kernel.org>; Sun, 17 Oct 2021 08:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF4360F44
	for <linux-s390@archiver.kernel.org>; Sun, 17 Oct 2021 08:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbhJQIpS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 17 Oct 2021 04:45:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234310AbhJQIpR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 17 Oct 2021 04:45:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19H7HXAw016844;
        Sun, 17 Oct 2021 04:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6RwZW99qh3M/ds06hYXsN2uDhgqT4qYMGiB8BadkOvY=;
 b=QM77rOr0jNmrSyK/HJxmFeOQC43mZclwNaSfoGyZp7h4czek6GBUod3jao7u1lc1lPya
 STWufwATXmrV1VXfXz28RI+LQDlOG2zO0C4Mfx/4iPqSagq74Y/BBa0yS6I0eI/j+A2F
 QBUzXvVqQ+MV3AP44mitO/75fl/qWbnK4hEI/4/WqjUTGbpklQ08wXdHm0RrRxvtk0QA
 YykQ5TXUI9/1uRLGStT7/iW/j4z6Y/RnaGYXr0AqXUO9/eLWUSXKm86guZgkic3wR/pr
 y1g5yhXIRudKFda3JfIAdbLbzk93BvJwqx2sY9OkYEJX59bPWXgxuqllIv4fgsrWK9pI Bw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3brfahrypd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 04:43:05 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19H8gjjs009405;
        Sun, 17 Oct 2021 08:43:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3bqpc94t62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 08:43:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19H8bD4462259542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Oct 2021 08:37:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 060844C040;
        Sun, 17 Oct 2021 08:43:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7AB94C044;
        Sun, 17 Oct 2021 08:42:59 +0000 (GMT)
Received: from osiris (unknown [9.145.149.250])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 17 Oct 2021 08:42:59 +0000 (GMT)
Date:   Sun, 17 Oct 2021 10:42:58 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [GIT PULL] s390 updates for 5.15-rc6
Message-ID: <YWviEupI518iFjOb@osiris>
References: <your-ad-here.call-01634376368-ext-7035@work.hours>
 <CAHk-=whoe211F8ND-9hZvfnib0UA4gga8DZJ+YaBZNbE4fubdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whoe211F8ND-9hZvfnib0UA4gga8DZJ+YaBZNbE4fubdg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YQ0PcJdQPRWhq4Htd9fKKbebFbd8eDan
X-Proofpoint-ORIG-GUID: YQ0PcJdQPRWhq4Htd9fKKbebFbd8eDan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-17_03,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=843
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110170058
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Oct 16, 2021 at 09:22:12AM -0700, Linus Torvalds wrote:
> On Sat, Oct 16, 2021 at 2:26 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> >
> > - Fix broken strrchr implementation.
> 
> I pulled this, but had to look at this commit just because it struck me as odd.
> 
> Is the generic strrchr() implementation so bad for s390 that it shows
> up? It looks like the s390 implementation wants to avoid checking
> separately against the final NUL character and basically uses the
> optimized strlen function to do so, but when strrchr has to walk the
> string _anyway_ this all looks a bit odd.

The difference is that it walks the string from the end to the start,
taking into account that searching for the end of the string can be
considered fast.

> Not a big deal. I just get the feeling that s390 (and probably other
> architectures) might be a bit too eager to make their own helper
> string functions for reasons that may be historical ("we didn't have
> generic string functions at all long ago") or misguided ("we'll do an
> architecture-optimized version even for things that don't matter").

This function exists for historical reasons, and in this case it is
probably more the "optimized version for things that don't matter".

The only caller which sort of gets called more frequently seems to be
kbasename().

Some numbers, running 1.000.000 strrchr on an 80 byte string:

 s390  generic   search for
 57us     55us   first character in string
 15us     55us   last character in string
 44us     55us   character in middle of string

So yes, we could probably just drop our own implementation, given that
it hardly matters in real life.
