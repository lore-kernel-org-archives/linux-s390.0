Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2591FC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 10 Nov 2021 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5D4610D2
	for <linux-s390@archiver.kernel.org>; Wed, 10 Nov 2021 15:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhKJPW3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Nov 2021 10:22:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231743AbhKJPW3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Nov 2021 10:22:29 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AADhhL2026170;
        Wed, 10 Nov 2021 15:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9e7TbNuFhpPJna7mEf3veQQwSa9591D1EPiO2DDRRuQ=;
 b=slnFBFeWoSL/eATElX2c/SypPYGx08amG73X/02OPabR0Bb6ZbN5o5+sSnQ7mBDALMd4
 CQg+HsVraDOXCSY9cd8jkcZBRuRPyRRJjXaMxVQKC9hYNOjbCsvZr4cMkBKDh7WcDNOd
 LZavtvWTWO6hims9176g2dtq4yinS4JVK/B8ODu7/9joLgBoB5FjFk8ERhAl4bkClYN8
 H5WhufieNH1SoxgfMtikZ5QXklzV4+PKJMbjXZOgBamqj6s0my12y2JQWO7gU4qBkydY
 RBih6VWtUdy29gDYOzB+4hVE2QyOT909a+zGplHYK1fpSrqF1Udx+cUP/zIXbFcbDvni hQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c8f7fak0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 15:19:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AAFD8aH006584;
        Wed, 10 Nov 2021 15:19:39 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3c5hbaksfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 15:19:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AAFJZCf43057470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 15:19:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A291D52051;
        Wed, 10 Nov 2021 15:19:35 +0000 (GMT)
Received: from osiris (unknown [9.145.55.149])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 403CA5205F;
        Wed, 10 Nov 2021 15:19:35 +0000 (GMT)
Date:   Wed, 10 Nov 2021 16:19:33 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Qing Wang <wangqing@vivo.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: replace snprintf in show functions with sysfs_emit
Message-ID: <YYvjBWx1vgdsktJ1@osiris>
References: <1634280655-4908-1-git-send-email-wangqing@vivo.com>
 <1955ef45-d30f-5354-e514-2bc8f7d9cfb6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1955ef45-d30f-5354-e514-2bc8f7d9cfb6@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7XfM9LeA3WMEjRmEhOKE_LDWD6YGg8DW
X-Proofpoint-GUID: 7XfM9LeA3WMEjRmEhOKE_LDWD6YGg8DW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_05,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=819 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 20, 2021 at 04:44:01PM +0200, Stefan Haberland wrote:
> Am 15.10.21 um 08:50 schrieb Qing Wang:
> > show() must not use snprintf() when formatting the value to be
> > returned to user space.
> > 
> > Fix the coccicheck warnings:
> > WARNING: use scnprintf or sprintf.
> > 
> > Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> > 
> > Signed-off-by: Qing Wang <wangqing@vivo.com>
> > ---
> >   drivers/s390/block/dasd_devmap.c | 74 ++++++++++++++++++++--------------------
> > 
> 
> Thanks for the DASD changes. While I am totally fine with the change itself
> I agree with Joe's remark.
> Would you like to improve your patch? Otherwise I can add a small follow on
> patch. Just let me know.

I translated this to Acked-by. Please provide an addon patch if you
want to have this changed.
Applied, thanks!
