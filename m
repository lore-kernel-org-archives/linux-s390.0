Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73045C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 10:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DC0610E5
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 10:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhJ2KYJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 29 Oct 2021 06:24:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231701AbhJ2KYI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Oct 2021 06:24:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19T9lqtb020716;
        Fri, 29 Oct 2021 10:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=mw0pJ1gO1tFYnxyVJkF91pyC6Iew6hFN+PIzj8sGWjQ=;
 b=i9XlOEOPISs4razFI3yz2JBN6FK4c2lgMVJ9bImrcdMEoN4Vp/CboWIvqValec/uAJYV
 jnw91Z1E5tyHsDBr666y2yNADCtVLpqNhUXNZ4cRF7KJ4k3LBVqs6GuVpY0tzFMuql7T
 GITDvCVdrA52aYQQXXJCII7B0HEyYit9BNnwG1hKvL6AOX/NpKbrV9rIuI0L380UTnXC
 RAUvcZTJFt+vPwvY4+2GpZoCOgWshg7r/bFKI1zEE9AjMNMWPM3ujq5Esd3mhS2Ehv4C
 b/haxuE1ebWGNPrWqd5Swd0fXxYPyiNHV62qgGjWEVn/zNlIFkaAm4CEsJJRlRCGQKej Sg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c0en0gn2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 10:21:34 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19TAKOcr000876;
        Fri, 29 Oct 2021 10:21:33 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3bx4es83m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 10:21:32 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19TAFHCd50004280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 10:15:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 487A04C052;
        Fri, 29 Oct 2021 10:21:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F09ED4C04A;
        Fri, 29 Oct 2021 10:21:28 +0000 (GMT)
Received: from localhost (unknown [9.171.45.126])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Oct 2021 10:21:28 +0000 (GMT)
Date:   Fri, 29 Oct 2021 12:21:27 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: add <linux/minmax.h> to <asm/facility.h>
Message-ID: <your-ad-here.call-01635502887-ext-5860@work.hours>
References: <20211029002633.31323-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211029002633.31323-1-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3pD2gPJG0FAZqPKFxY7BoqHux8b9MT9K
X-Proofpoint-ORIG-GUID: 3pD2gPJG0FAZqPKFxY7BoqHux8b9MT9K
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_02,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxlogscore=639 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290057
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 28, 2021 at 05:26:33PM -0700, Randy Dunlap wrote:
> S390's <asm/facility.h> uses the min_t() macro, so it should
> include <linux/minmax.h> to avoid build errors.
> 
> In file included from arch/s390/pci/pci_insn.c:12:
> arch/s390/include/asm/facility.h: In function '__stfle':
> arch/s390/include/asm/facility.h:98:22: error: implicit declaration of
> function 'min_t' [-Werror=implicit-function-declaration]
>    98 |                 nr = min_t(unsigned long, (nr + 1) * 8, size * 8);
> arch/s390/include/asm/facility.h:98:28: error: expected expression
> before 'unsigned'
>    98 |                 nr = min_t(unsigned long, (nr + 1) * 8, size * 8);

Thank you, but it has been addressed in latest linux-next by:
https://lore.kernel.org/all/20211028170143.56523-1-andriy.shevchenko@linux.intel.com/
