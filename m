Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818DFC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 10 Nov 2021 15:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6115061107
	for <linux-s390@archiver.kernel.org>; Wed, 10 Nov 2021 15:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhKJPW4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Nov 2021 10:22:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231148AbhKJPWz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Nov 2021 10:22:55 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AAEidPo013969;
        Wed, 10 Nov 2021 15:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KTQMzr8/V0eMZthQi6n6Cwl8vmrIFyIah4GL8IWMuRE=;
 b=iid2yqDUVtPmPbXUdsQTJPUNaPcg+SKxlYFLBc3iIC8pevnagCfEhoRt1/TutRNTly7e
 PC7e4q03/6ECc9Ys6KZYhhqPKcMyBK62pVu0hGh/+JTW5d/z6PIphTVRZJLy+GIfLFfL
 UJvwFxOtKEtac1LpDyNE9zjizfM45Nh4xo5OnDrCIgDRlUQxyRKRfovNZp4z/61YwO1v
 VNF67zNpnhq5J6KaaL6sF/d+JlINsxEscHmCUH9AKP4UEp6kJPgYN1CwMz9X5KYeQApf
 YlSA/sNPRbPkMG3khyeEQDNny742KtsGliy2fcNBbBpIsAGIzg6v//Lu3XUXPN0EQAda mQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c8g3s0ws7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 15:20:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AAFCnL4029249;
        Wed, 10 Nov 2021 15:20:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3c5hbaksuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 15:20:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AAFDIlK63767034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 15:13:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FE095204F;
        Wed, 10 Nov 2021 15:20:00 +0000 (GMT)
Received: from osiris (unknown [9.145.55.149])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id CA1C352067;
        Wed, 10 Nov 2021 15:19:59 +0000 (GMT)
Date:   Wed, 10 Nov 2021 16:19:58 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/vdso: remove -nostdlib compiler flag
Message-ID: <YYvjHjD45+z8wTkH@osiris>
References: <20211107162111.323701-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107162111.323701-1-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SdVV0oAzT_d2UCPMypGbVaHgE2Aq4K9x
X-Proofpoint-ORIG-GUID: SdVV0oAzT_d2UCPMypGbVaHgE2Aq4K9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_05,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=693 clxscore=1011
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Nov 08, 2021 at 01:21:11AM +0900, Masahiro Yamada wrote:
> The -nostdlib option requests the compiler to not use the standard
> system startup files or libraries when linking. It is effective only
> when $(CC) is used as a linker driver.
> 
> Since commit 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to
> link vDSO"), $(LD) is directly used, hence -nostdlib is unneeded.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/kernel/vdso32/Makefile | 2 +-
>  arch/s390/kernel/vdso64/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!
