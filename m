Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A0FC4338F
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 08:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B326660F59
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 08:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbhHFIrm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:47:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231572AbhHFIrl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Aug 2021 04:47:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1768YZLi172583;
        Fri, 6 Aug 2021 04:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ppgRYHyx08vp3ntOoPEDrsaY15wraqD6zbtQ/7JDfkk=;
 b=SwQkIj47na9WmWdyt5DhN1PmkfoGvqmewt/JvlISvySoRM1cnAPUS2w1LP1xg1eF2pWJ
 5w+oFTQvPJNOtrB0lPTsjqivvut6SeGu2lyXXjyFalGyyKBTxZmywx7MEsBIuWrQhcgl
 EFMSpLxUwdyp8jUrveoBwiIYnVPWjeWDeL5nzO/mSlY1wAfyb8zp0Pia/go1FIazIL5J
 wPXtrnk3QHDLXjjTuPHOJm+/XEYhQ4ma595OSCb29na+2j+R7U78REmxFiL/6KFXl/3J
 gn0P5fytsmGjAVJrYoJOuDjSHIQ6CRYm1U5v8oO44ArNSXpz4hM9LFwQBcySX52+TZNS jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a8k45n9a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 04:47:26 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1768YvV4174608;
        Fri, 6 Aug 2021 04:47:26 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a8k45n99d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 04:47:25 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1768be2g025145;
        Fri, 6 Aug 2021 08:47:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3a4wshvw54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 08:47:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1768lJjr50528652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Aug 2021 08:47:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C8FA5205A;
        Fri,  6 Aug 2021 08:47:19 +0000 (GMT)
Received: from osiris (unknown [9.145.14.196])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 5BC9E52052;
        Fri,  6 Aug 2021 08:47:19 +0000 (GMT)
Date:   Fri, 6 Aug 2021 10:47:17 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v1] s390/mm: remove unused cmma functions
Message-ID: <YQz3FQVRnuZuYT3+@osiris>
References: <20210806075430.6103-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806075430.6103-1-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 88DveIWrVuZQlhASRNFLsuVV0EHxwyDy
X-Proofpoint-ORIG-GUID: 4_FU3BHFTXaTzD0GoO6RHi2ue0OQsFy9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_02:2021-08-05,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=815
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108060060
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 06, 2021 at 09:54:30AM +0200, David Hildenbrand wrote:
> The last user of arch_set_page_states(), arch_set_page_nodat() and
> arch_test_page_nodat() was removed in commit 394216275c7d
> ("s390: remove broken hibernate / power management support"),
> let's remove these functions.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/include/asm/page.h |  3 ---
>  arch/s390/mm/page-states.c   | 43 ------------------------------------
>  2 files changed, 46 deletions(-)

Applied, thanks.
