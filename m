Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273CCC001DF
	for <linux-s390@archiver.kernel.org>; Tue,  1 Aug 2023 14:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjHAOm0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 1 Aug 2023 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjHAOmZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Aug 2023 10:42:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EF71712
        for <linux-s390@vger.kernel.org>; Tue,  1 Aug 2023 07:42:24 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371Ectxo022185
        for <linux-s390@vger.kernel.org>; Tue, 1 Aug 2023 14:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=uh1RtxRpvP4pM/wx43DSBnnDIfqPPKb5234dg8Gzdlc=;
 b=azQ8wNTrxgXLTT82nISgeNquWLi0IrwqwCVMV7BdzGv4PXCIJ44ENLRT0PvAKfWXpDgf
 VlMGKYQaatg8ClzBlMayLrAXTEcM3ov06HrXF+Iooe6P0WVwO+QLtSntV9v1JCs0QDvD
 nmhXXL9wuv01ZLcE6pm9Ksmwm36IJHewORNzE1JD8pp2fl0wOhfq0Bd0u3uqqIf6uf6N
 FFCpB9grQuH0Bvfo1ny3sQzuZxTonzPd2tyen0/wG1KMipAmw+rgRffirBK4svo/yayA
 TGwsoW0buO7K+1T6ZRnOWEpKsfhJ43dpsziyB357FgEy3nRUv6bKYpRvffyMoknWkpRi Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s73r2rkxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 01 Aug 2023 14:42:24 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 371EdHmV024610
        for <linux-s390@vger.kernel.org>; Tue, 1 Aug 2023 14:42:23 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s73r2rkwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 14:42:23 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 371DB3Ld014553;
        Tue, 1 Aug 2023 14:42:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5ft1c0eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 14:42:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 371EgKpG37880214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Aug 2023 14:42:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3A5C20049;
        Tue,  1 Aug 2023 14:42:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C91462004D;
        Tue,  1 Aug 2023 14:42:19 +0000 (GMT)
Received: from osiris (unknown [9.152.212.233])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Aug 2023 14:42:19 +0000 (GMT)
Date:   Tue, 1 Aug 2023 16:42:19 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/ptrace: add missing linux/const.h include
Message-ID: <20230801144219.6883-D-hca@linux.ibm.com>
References: <20230731183926.330932-1-hca@linux.ibm.com>
 <ZMkSm+CWmAJ9EOY5@dcbz.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMkSm+CWmAJ9EOY5@dcbz.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U81NOROaAlbJExepQEYnS4s2wx1Lm3C9
X-Proofpoint-ORIG-GUID: iZB_biglUszABEULbHQ5galMQXHxBWY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_10,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=494 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010132
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 01, 2023 at 04:11:39PM +0200, Adrian Reber wrote:
> On Mon, Jul 31, 2023 at 08:39:26PM +0200, Heiko Carstens wrote:
> > Adrian Reber reported the following CRIU build bug after
> > commit b8af5999779d ("s390/ptrace: make all psw related
> > defines also available for asm"):
> > 
> > compel/arch/s390/src/lib/infect.c: In function 'arch_can_dump_task':
> > compel/arch/s390/src/lib/infect.c:523:25: error: 'UL' undeclared (first use in this function)
> >   523 |         if (psw->mask & PSW_MASK_RI) {
> >       |                         ^~~~~~~~~~~
> > 
> > Add the missing linux/const.h include to fix this.
> 
> Thanks. That fixes the build failure for me.

Thanks for verifying. This should make it into rc5.
