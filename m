Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E88C433B4
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 20:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF38D611C9
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 20:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhECUjo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 16:39:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhECUjn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 May 2021 16:39:43 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143KXKHa111462;
        Mon, 3 May 2021 16:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=hrwndlR1o2NbTPjOjHlcK6hFRrHnfogOe/wIFv8415Y=;
 b=RyQRmAqEDu0B7B1ZTbQkwJUo8wbZV/DGMu4aMXN1Dh1W7LcoIhnY0/hBsALGd65FemKq
 35UyY6nDsyZLDMgs/YXpOdiEiic90VoViZ+26+jymY+fiRm12TLkrD/msAVzfc1gnXxv
 qfy1fcjL1vbVODgAaNUfK8W4OuZlZTTsdoAStR3nzgcC1FSfK/Ay1l06hZNJUtEvI/Er
 YknVRI/WjndkqSI6jBv5+r3ghhxa5kDCPcsyrMnf+LOEsxRSOQNEvD+O8n9Ny67rEU9S
 ZJaRDZ8Ytv4Im9MTZYOK5/x4zCTOkIZo/Wos+qDXmRQDtOXjpurZJCQ2MIwqbSsJUu7I Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38apb6b9fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 16:38:49 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143KXN4q111730;
        Mon, 3 May 2021 16:38:49 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38apb6b9f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 16:38:49 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143KYSEA005164;
        Mon, 3 May 2021 20:38:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 388xm8rv5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 20:38:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143KcikJ45744436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 20:38:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2E46A405B;
        Mon,  3 May 2021 20:38:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88DA6A405F;
        Mon,  3 May 2021 20:38:43 +0000 (GMT)
Received: from osiris.fritz.box (unknown [9.171.82.165])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 May 2021 20:38:43 +0000 (GMT)
Date:   Mon, 3 May 2021 22:38:42 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: fix detection of vector enhancements facility 1
 vs. vector packed decimal facility
Message-ID: <YJBfUn8ZXJw780ro@osiris.fritz.box>
References: <20210503121244.25232-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503121244.25232-1-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pl7DuD7WPbILdM0XVNxzmA4cMVvGJyqo
X-Proofpoint-GUID: hgroUldZqC8jvXrSqJhDJbKgaD1iDpde
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_19:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030141
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 03, 2021 at 02:12:44PM +0200, David Hildenbrand wrote:
> The PoP documents:
> 	134: The vector packed decimal facility is installed in the
> 	     z/Architecture architectural mode. When bit 134 is
> 	     one, bit 129 is also one.
> 	135: The vector enhancements facility 1 is installed in
> 	     the z/Architecture architectural mode. When bit 135
> 	     is one, bit 129 is also one.
> 
> Looks like we confuse the vector enhancements facility 1 ("EXT") with the
> Vector packed decimal facility ("BCD"). Let's fix the facility checks.
> 
> Detected while working on QEMU/tcg z14 support and only unlocking
> the vector enhancements facility 1, but not the vector packed decimal
> facility.
> 
> Fixes: 2583b848cad0 ("s390: report new vector facilities")
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Alexander Egorenkov <egorenar@linux.ibm.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kernel/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!
