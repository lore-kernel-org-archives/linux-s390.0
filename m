Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F031CC6FD18
	for <linux-s390@archiver.kernel.org>; Fri, 31 Mar 2023 07:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCaHQn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 31 Mar 2023 03:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCaHQj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Mar 2023 03:16:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD06F754
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 00:16:22 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V6uQte026315
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 07:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references : cc :
 subject : from : to : message-id : date; s=pp1;
 bh=2h5fAkroqn90lQB8l40hhBop9HpfIPQMFtYvtRRjr8Y=;
 b=PwJLICRzzSzQ6XgFSZ7iC7J6C5bjQdCmv9svTCXDs7yUtGNVrPcI8m/gP9G/k7Y7Tmkp
 doFJwiBv4MPawlB91prEdo4mTvUbiKrDIPe45/Hvoa8d+ooOG//ck0QbRJ4q/N4hCJhv
 75iJ8YF8Xa4bEEqtvhnDrmexB4R/RtvjADim3z7fdj8YtLlr6mU+7QR+EdyGdxReYEt2
 kZVvVNOaVpyLQjgmozgDEKiY5/0uTw1QoOOECKeK+AAHV4k56s0WPZTq4/P1ElanUSmS
 Gt/xjF/dTrOLCs6at7JwhBHyUAIw0Kh65xxNkN+fnmjJzxo0fZEPTLMiemJriQ6BEjHr 0w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pntpagdr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 07:16:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32V2t1fF004449
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 07:16:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3phr7fphq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 07:16:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32V7GFKt23659230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 07:16:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3347C20049;
        Fri, 31 Mar 2023 07:16:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10CFC20043;
        Fri, 31 Mar 2023 07:16:15 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.12.80])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 31 Mar 2023 07:16:14 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZCaCRTNEJKDMfhQo@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230310133411.139275-1-nrb@linux.ibm.com> <20230310133411.139275-2-nrb@linux.ibm.com> <ZCaCRTNEJKDMfhQo@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
Subject: Re: [PATCH v3 1/1] s390: ipl: fix physical-virtual confusion for diag308
From:   Nico Boehr <nrb@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Message-ID: <168024697476.295696.16876742423274337392@t14-nrb>
User-Agent: alot/0.8.1
Date:   Fri, 31 Mar 2023 09:16:14 +0200
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hi1vI-XW9w4x8RXB_c-iZbekFilLcha_
X-Proofpoint-GUID: hi1vI-XW9w4x8RXB_c-iZbekFilLcha_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_02,2023-03-30_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=436 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310058
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Quoting Alexander Gordeev (2023-03-31 08:48:37)
> Hi Nico,
>=20
> Anything prevents this one from pushing?

No, can be pushed.
