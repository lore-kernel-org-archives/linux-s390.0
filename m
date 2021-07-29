Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFCEC4320E
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 12:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CC460EFF
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 12:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhG2MZk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:25:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236888AbhG2MZj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Jul 2021 08:25:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TCEURP161610;
        Thu, 29 Jul 2021 08:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GkmeYWDizMKTMJM7MmskuLB3P8agtCV0s0RJcAVmDWY=;
 b=oE83htfQgxYtsFm9DNM/wpFHmVfKHfUvYzXs3U9DUQ2vw9GP7Od27LRLdzrQYglQB6QS
 uPuW32UUf4cg+lTxIgTo0U8epfB3hJPDxaXt2ToQslu9tjHbo8KgonSVwY2IwT6AxzI8
 /IIt5g8irzxbNK+P6r1ANdWVsM4ova4X6LS9WMDQ8TvOtMjUL1BbSzqNw79VlKa87ir6
 0R9Al2B3cp0cPRFDiwv1iE8iHB3JM55mZmr2Eb9/Fc//xKyqQuzXi9ggdDRsZjfzYXs6
 4Lzfl9NFTMcXWKPs4YRqMU4oDadaBeiz5DX0w3UvQKNoipaEyK76HJtt8PCCsLvSNY8v ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3v5n0e8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 08:25:33 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16TCEe69162548;
        Thu, 29 Jul 2021 08:25:33 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3v5n0e88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 08:25:32 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TCDbWX009633;
        Thu, 29 Jul 2021 12:25:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3a235yhpx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 12:25:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TCPRun23068986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 12:25:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09D554204F;
        Thu, 29 Jul 2021 12:25:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A665742052;
        Thu, 29 Jul 2021 12:25:26 +0000 (GMT)
Received: from osiris (unknown [9.145.0.186])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Jul 2021 12:25:26 +0000 (GMT)
Date:   Thu, 29 Jul 2021 14:25:25 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/4] kfence: add function to mask address bits
Message-ID: <YQKeNbU4HJhFP8kn@osiris>
References: <20210728190254.3921642-1-hca@linux.ibm.com>
 <20210728190254.3921642-3-hca@linux.ibm.com>
 <YQJdarx6XSUQ1tFZ@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQJdarx6XSUQ1tFZ@elver.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9tRoZkGVyNh16-45AhbIjXuuDbx5xc_h
X-Proofpoint-ORIG-GUID: MAwPuY-TnMuaoJ-rs9aFpx9-iJqftGxF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=980 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290078
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 29, 2021 at 09:48:58AM +0200, Marco Elver wrote:
> On Wed, Jul 28, 2021 at 09:02PM +0200, Heiko Carstens wrote:
> > From: Sven Schnelle <svens@linux.ibm.com>
> > 
> > s390 only reports the page address during a translation fault.
> > To make the kfence unit tests pass, add a function that might
> > be implemented by architectures to mask out address bits.
> > 
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> I noticed this breaks on x86 if CONFIG_KFENCE_KUNIT_TEST=m, because x86
> conditionally declares some asm functions if !MODULE.
> 
> I think the below is the simplest to fix, and if you agree, please carry
> it as a patch in this series before this patch.

Will do.

> With the below, you can add to this patch:
> 
> 	Reviewed-by: Marco Elver <elver@google.com>

Done - Thank you! I silently assume this means also you have no
objections if we carry this via the s390 tree for upstreaming.
