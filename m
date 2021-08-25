Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6C5C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 25 Aug 2021 08:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F9C61058
	for <linux-s390@archiver.kernel.org>; Wed, 25 Aug 2021 08:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhHYIcx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 25 Aug 2021 04:32:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231697AbhHYIcw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Aug 2021 04:32:52 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17P83KOB031074;
        Wed, 25 Aug 2021 04:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=n9SHBptqzWZ2B6k5FIRVom2V/ZJEr2Jom/F7F5i63pA=;
 b=KbvTTas8AhiorHuwWBEYl4/SCCxm4HR259SxeCpOXcUmH74O7LKEXMgG7r+KJcN7HWiR
 PFyClVU7FdHIjMOgTob7cA0MS0Ae8civ/5USE38rJ5MPmeEPvQE9auQJQ7jYswpNbQ77
 +f6Qif/EzClBeGh9he2AtmEiZaSRftRn3ke//QNst5Svx0da3SiFZHGZZ9oyew9Isf//
 yz3TY5WceFpnJ0HFz6P40Kxtb40ZydQkKp10yyLjZFQj4uaSECbex68spANjzh4IxYhu
 CQx5M5afw8i+ve7OsrAOxCxGV+k6OTInAwBZnHs7vBgI6ftmF84wIxg3NYQDYllmG7e+ +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3anhydgvmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 04:32:06 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17P84LmI037127;
        Wed, 25 Aug 2021 04:32:06 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3anhydgvkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 04:32:06 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17P8HRcv015024;
        Wed, 25 Aug 2021 08:32:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ajrrheqhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 08:32:04 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17P8VvJ514614974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 08:31:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41C224C059;
        Wed, 25 Aug 2021 08:31:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E35FC4C040;
        Wed, 25 Aug 2021 08:31:56 +0000 (GMT)
Received: from osiris (unknown [9.145.63.47])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Aug 2021 08:31:56 +0000 (GMT)
Date:   Wed, 25 Aug 2021 10:31:55 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] s390:raw3270: Convert sysfs sprintf/snprintf
 family to sysfs_emit
Message-ID: <YSX/+4zj+fFQxtDa@osiris>
References: <20210825064523.70563-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825064523.70563-1-deng.changcheng@zte.com.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7H_vkXazW-dx9DOCRH3lUxMKZ-hN5Xbi
X-Proofpoint-GUID: -f2I0Wgove-Dh6SsBsmQishT1kutBbet
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-25_02:2021-08-25,2021-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=800
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250048
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 24, 2021 at 11:45:23PM -0700, CGEL wrote:
> From: jing yangyang <jing.yangyang@zte.com.cn>
> 
> Fix the following coccicheck warning:
> ./drivers/s390/char/raw3270.c:1066:8-16: WARNING: use scnprintf or sprintf
> ./drivers/s390/char/raw3270.c:1050:8-16: WARNING:use scnprintf or sprintf
> ./drivers/s390/char/raw3270.c:1058:8-16: WARNING:use scnprintf or sprintf
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> ---
>  drivers/s390/char/raw3270.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Ignoring comments and resending the same unmodified patch is not helpful.
