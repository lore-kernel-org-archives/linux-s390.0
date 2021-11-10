Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A741C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 10 Nov 2021 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB8161205
	for <linux-s390@archiver.kernel.org>; Wed, 10 Nov 2021 14:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhKJOrv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:47:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232077AbhKJOrv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Nov 2021 09:47:51 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AADhQXG025477;
        Wed, 10 Nov 2021 14:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qrtOUARlNxFt0nyxxQJFykHNr55tEEq31MM0sJJdQ+w=;
 b=c6/WUCHyPhwMF87TD+Y0qzr8dFLxgPdbYxdyiZ+GIbAPoVdMwVFungngiMvjWgMYB8yW
 8GXvt54rcaed65H4lT5XLmphuJ/Yvz7gqEV+dccflYeloORZKIiNvuI2hc8k2nE+nbLF
 Aa7lo3QAzX/MmAQ/BOpDyjIktWejhjnPfV2ld9tNSclBx+zdcFlPjWI4Co+Jnp4st5Ok
 +NncB6b/IGlM0LIdQP/KSlmd43veE68TS64iAGVLoAmtEwbTWv0XT7po9ACP+mdQDoEW
 V3fkdtePDx9eM9ixUIF3LjKuP3FRBeAIYLMFeJrAamp/NAo9A3Staq3U3ijsuB8dA7El 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c8f7f9kwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 14:44:59 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AADsKMm012785;
        Wed, 10 Nov 2021 14:44:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c8f7f9kvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 14:44:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AAEX63F004042;
        Wed, 10 Nov 2021 14:44:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3c5hbakc8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 14:44:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AAEisp32097850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 14:44:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED1D811C050;
        Wed, 10 Nov 2021 14:44:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CBEB11C054;
        Wed, 10 Nov 2021 14:44:53 +0000 (GMT)
Received: from osiris (unknown [9.145.55.149])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Nov 2021 14:44:53 +0000 (GMT)
Date:   Wed, 10 Nov 2021 15:44:51 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     cgel.zte@gmail.com
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, egorenar@linux.ibm.com, geert@linux-m68k.org,
        zhang.mingyu@zte.com.cn, frankja@linux.ibm.com,
        ebiederm@xmission.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] s390:Use BUG_ON instead of if condition followed by BUG.
Message-ID: <YYva4z083aMSsEwW@osiris>
References: <20211103055622.25441-1-zhang.mingyu@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103055622.25441-1-zhang.mingyu@zte.com.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S7I6OuV1MIchDiIt6sVIH4J4YCoaeuPa
X-Proofpoint-GUID: WDH-7azIeI3gNArPt3IySihomsBnTmbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_05,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=418 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100076
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 03, 2021 at 05:56:22AM +0000, cgel.zte@gmail.com wrote:
> From: Zhang Mingyu <zhang.mingyu@zte.com.cn>
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
> ---
>  arch/s390/mm/fault.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

S-O-B chain is incorrect. Sent by cgel.zte@gmail.com, but not listed
anywhere. Therefore not applying.
