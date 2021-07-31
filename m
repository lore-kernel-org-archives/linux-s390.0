Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEBDC4338F
	for <linux-s390@archiver.kernel.org>; Sat, 31 Jul 2021 06:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1689361019
	for <linux-s390@archiver.kernel.org>; Sat, 31 Jul 2021 06:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhGaGsf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 31 Jul 2021 02:48:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232079AbhGaGse (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 31 Jul 2021 02:48:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16V6Y3FS102611;
        Sat, 31 Jul 2021 02:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=UJn1f82fPYuH0EDqeZOG7iaDJv4VgsrkUnsxJuSXLss=;
 b=ENVUAbz5UypOjj/eGDrSmqgALtDD27GqVchFrN3hv4YBl3B8v6YLxflJ4E580+7YQD41
 vDUd3svlEog/zsRh90UuUYs7tYkiE3lt/IPiwQZvkejz/qjWVgHg7ZpGh3kOW7+boOSY
 UwULQkdH0MJKAxTWxdhOi8JW6fMphKADVoLT37H9WYadEWh+OH75B+YsmzEecOLTC+9n
 V1dwrYQxC/8jPc3keY6/9ZlaN+QRURINrkJCeKpdUdpntFGGR8wz97VOsno4YKShkCuG
 qDAVVHHtmLm25AXLqXInLhtfoR+761Pi4DEAwN1q8QsvSjbBF/Sb55IG4rjHO8D95C+m zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a4x1hc4t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Jul 2021 02:48:02 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16V6YExI107321;
        Sat, 31 Jul 2021 02:48:01 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a4x1hc4t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Jul 2021 02:48:01 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16V6g2pQ017380;
        Sat, 31 Jul 2021 06:48:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3a4wshr6y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Jul 2021 06:47:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16V6luj727787618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 31 Jul 2021 06:47:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1CAD11C04A;
        Sat, 31 Jul 2021 06:47:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7192D11C04C;
        Sat, 31 Jul 2021 06:47:56 +0000 (GMT)
Received: from osiris (unknown [9.145.16.160])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 31 Jul 2021 06:47:56 +0000 (GMT)
Date:   Sat, 31 Jul 2021 08:47:55 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] s390/ftrace: implement hotpatching
Message-ID: <YQTyG6HwvJILMaU6@osiris>
References: <20210728212546.128248-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728212546.128248-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ACqbPHJIOD9feIqwx48tI2f6uO8cYTce
X-Proofpoint-GUID: 4Bb8RlyxZABVFyPnFjNAfbz3A_DjdIhX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=613 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107310029
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 28, 2021 at 11:25:44PM +0200, Ilya Leoshkevich wrote:
> Hello,
> 
> This series implements the stop_machine()-less ftrace code patching
> for s390. It's trickier than that of e.g. Intel, because the only
> on-the-fly code patching allowed by s390 is changing a mask of a
> conditional branch instruction. Patch 1 contains a new common code hook
> that we need for that, patch 2 contains the actual implementation as
> well as explanation of all the small details.
> 
> We would like to take this series through the s390 tree, and we need a
> review on the patch 1 for that. Could you please take a look?
> 
> Best regards,
> Ilya
> 
> Ilya Leoshkevich (2):
>   ftrace: Introduce ftrace_need_init_nop()
>   s390/ftrace: implement hotpatching
> 
>  arch/s390/include/asm/ftrace.h     |  46 +------
>  arch/s390/include/asm/ftrace.lds.h |  21 +++
>  arch/s390/include/asm/module.h     |   8 ++
>  arch/s390/kernel/ftrace.c          | 207 ++++++++++++++++++++++++++---
>  arch/s390/kernel/ftrace.h          |  24 ++++
>  arch/s390/kernel/module.c          |  45 +++++++
>  arch/s390/kernel/vmlinux.lds.S     |   2 +
>  include/linux/ftrace.h             |  16 +++
>  kernel/trace/ftrace.c              |   4 +-
>  9 files changed, 314 insertions(+), 59 deletions(-)
>  create mode 100644 arch/s390/include/asm/ftrace.lds.h
>  create mode 100644 arch/s390/kernel/ftrace.h

Series applied, thank you!
