Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5D5C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 18 Oct 2021 10:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD85D6008E
	for <linux-s390@archiver.kernel.org>; Mon, 18 Oct 2021 10:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhJRKut (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:50:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229569AbhJRKus (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Oct 2021 06:50:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19IAFlRB014610;
        Mon, 18 Oct 2021 06:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=s6D1fOlgYRHPYWdvtp17gLzTb+jDyzyFm28TSrL/N+c=;
 b=QEsOvjaa0AAdR7nKfRbYA8wt0+jBsE3a7bGDZ4deppUF3cSQcdoJOV9E/2radrolbZNz
 Sw+AyVuM3d3wJmdn6Lkhgp1pddlw8AIJS5Ezd+GWIdkN1iEFMfrm2e1bwPUV6sq97tk5
 hi+kXjyQ3fTyAJIe4bUZAfLtpR23X8znk6Yu3DGb1NFeuXp4bNoU7Lycn8frm+ed56Ja
 l5K1x1YI5hOENcsbYsOe+DE68a07GPxHOHDsvGYuN6PAyior88zIVUr3jW5Yzrnh26pH
 dvIKdX7CGEc6OV2GMvdKbw1BTVpl30fo2fufOLzMDdp1cx9tRNBMR0xHOgSU+7DmRI2w sw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bs7148mts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 06:48:37 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19IAmLfr007223;
        Mon, 18 Oct 2021 10:48:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3bqpc9c01v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 10:48:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19IAmPVH41484594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Oct 2021 10:48:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E1695207A;
        Mon, 18 Oct 2021 10:48:25 +0000 (GMT)
Received: from osiris (unknown [9.145.168.130])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 15AE552078;
        Mon, 18 Oct 2021 10:48:25 +0000 (GMT)
Date:   Mon, 18 Oct 2021 12:48:23 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: replace snprintf in show functions with sysfs_emit
Message-ID: <YW1Q93cGfKxbS6Iy@osiris>
References: <1634280655-4908-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634280655-4908-1-git-send-email-wangqing@vivo.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dPV0rssMXLjrRzbGK-imLHA5OyCjcDp8
X-Proofpoint-ORIG-GUID: dPV0rssMXLjrRzbGK-imLHA5OyCjcDp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_03,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=507 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110180065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 14, 2021 at 11:50:54PM -0700, Qing Wang wrote:
> show() must not use snprintf() when formatting the value to be
> returned to user space.
> 
> Fix the coccicheck warnings:
> WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/s390/block/dasd_devmap.c | 74 ++++++++++++++++++++--------------------
>  drivers/s390/char/raw3270.c      |  6 ++--
>  drivers/s390/cio/chp.c           |  2 +-
>  3 files changed, 41 insertions(+), 41 deletions(-)

This requires either Reviewed-by or Acked-by from dasd and cio
maintainers, which you already cc'ed.
