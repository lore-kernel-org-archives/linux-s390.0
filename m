Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C69C4338F
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 18:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AF061262
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 18:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhHWSIt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:08:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7418 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbhHWSIs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 14:08:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NI2eYA000916;
        Mon, 23 Aug 2021 14:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=BsmQ/QtYydbGgRYekxdtssjs1AP9/Jwu8/43joObmqI=;
 b=jcgi4upEDmFs4IcT0FY8k6QLRi5bMBERfY5L0/6hXiZf7APP/oLxNoVtsbYuTZl7FqOY
 jGFnmvDoNsaGe8JFmLwCxF5Mkcdks97aCt1ymmTkIL965ussqUB0u1NGno/YGN2dP0dZ
 nn6MZPKyFsnzzQ6B+uN71rrV87b1Ptq0vN/p5pLJbdYOUpy7fmEx5pPhrO9G0RurFU17
 KMnXwOyhKUT8/WluFL3CSfublTzwGoqQ6W6IeAamK7GfSBDVAsIjR+WnZuMuSEZS9fv2
 HtY46wGmpDXi4xvwkESlB6kTuJJXD7wlNOG4piIp3QVo2Fy49xyoXw1JCUEkScgSSMXA 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amg8e0phg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 14:08:05 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17NI554D008743;
        Mon, 23 Aug 2021 14:08:05 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amg8e0pgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 14:08:04 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NI7YS3025467;
        Mon, 23 Aug 2021 18:08:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ajs48bpd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 18:08:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NI7x9654133228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 18:07:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A35F1A4051;
        Mon, 23 Aug 2021 18:07:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F9FEA4040;
        Mon, 23 Aug 2021 18:07:59 +0000 (GMT)
Received: from osiris (unknown [9.145.169.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Aug 2021 18:07:59 +0000 (GMT)
Date:   Mon, 23 Aug 2021 20:07:57 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     jing yangyang <cgel.zte@gmail.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] s390:fix Coccinelle warnings
Message-ID: <YSPj/YRDlGqoVu26@osiris>
References: <20210820025159.11914-1-jing.yangyang@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820025159.11914-1-jing.yangyang@zte.com.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AreCwmGScj-BfeIvgViOUTCC6Q1XLpD3
X-Proofpoint-GUID: gg_ePrLtXLkHXFJ_54k7Cu1QFe9Rtby5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_04:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=843 phishscore=0
 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230124
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Aug 19, 2021 at 07:51:59PM -0700, jing yangyang wrote:
> WARNING !A || A && B is equivalent to !A || B
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> ---
>  arch/s390/include/asm/scsw.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
> index a7c3ccf..754122d 100644
> --- a/arch/s390/include/asm/scsw.h
> +++ b/arch/s390/include/asm/scsw.h
> @@ -691,9 +691,8 @@ static inline int scsw_tm_is_valid_pno(union scsw *scsw)
>  {
>  	return (scsw->tm.fctl != 0) &&
>  	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
> -	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
> -		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
> -		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
> +		(!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
> +		(scsw->tm.actl & SCSW_ACTL_SUSPENDED));

This turns something unreadable into something else which is
unreadable. It's up to Vineeth to decide what to do with this.

However I'd prefer if this would be changed into something readable,
maybe as addon patch, like e.g.:

static inline bool scsw_tm_is_valid_pno(union scsw *scsw)
{
	if (scsw->tm.fctl == 0)
		return false;
	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
		return false;
	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
		return false;
	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
		return false;
	return true;
}

Chances are that the above is wrong... it's just to illustrate ;)
