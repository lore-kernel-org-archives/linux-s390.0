Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C84C072A2
	for <linux-s390@archiver.kernel.org>; Wed, 15 Nov 2023 15:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjKOPaX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Nov 2023 10:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjKOPaQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 10:30:16 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AAE1988;
        Wed, 15 Nov 2023 07:29:41 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFEu10a002860;
        Wed, 15 Nov 2023 15:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=mCRfXeVfqIfdj4/VheE7oWXWFYZcQ0SHTKDQdtVUyzU=;
 b=EZxZwSfY6jSm9cxeRn7GTebqRQOnUEwWPuBqcQxMJ+YJ2CIoO/RZjiTklhhDg6gQsj/X
 CtXAvtm4TA3ZxTI6l5dUeZuEO1teUVzcPblnLEQyeMQfMAW4sNC0/yhIrv5Z1FIwF207
 AMlIuIzotQvu7KY3zOht0LYlK+UzxbHY5MEAAUGZXwFl5wJ/U8Awh5u8Q2iBT/+aPFEG
 yNmIrmsvLh/vkEMEFWkJfqGvo2slTEhpE+GHFUL1qpiOpN5zniUn4PU8nc8VYzi7euvR
 oEeqqdLiqMgLt/AQ0Lmjgi83/BsAAA4Mj66g7TExXK8j4pnTj6p6Esw2CIAL7MKtPB5k zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud068946p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 15:29:27 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFEv1b8006656;
        Wed, 15 Nov 2023 15:29:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud0689461-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 15:29:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDn20Z018837;
        Wed, 15 Nov 2023 15:29:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekqxwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 15:29:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFFTMl821561876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 15:29:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 470512004F;
        Wed, 15 Nov 2023 15:29:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED20A2004D;
        Wed, 15 Nov 2023 15:29:21 +0000 (GMT)
Received: from [9.152.224.39] (unknown [9.152.224.39])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 15:29:21 +0000 (GMT)
Message-ID: <8130636d3a46329a5f18cc55ec4946d4adb8c9f5.camel@linux.ibm.com>
Subject: Re: [PATCH net] s390/ism: ism driver implies smc protocol
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, dust.li@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Date:   Wed, 15 Nov 2023 16:29:21 +0100
In-Reply-To: <20231115102304.GN74656@kernel.org>
References: <b152ec7c0e690027da1086b777a3ec512001ba1f.camel@linux.ibm.com>
         <20231114091718.3482624-1-gbayer@linux.ibm.com>
         <20231115102304.GN74656@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F8J7LDGbOIxk1cEC3jhbjcbpoBPILYD6
X-Proofpoint-ORIG-GUID: XrPaLA6I8H1b4MrvK015HOk20Syy69vZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 mlxlogscore=874 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150115
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2023-11-15 at 10:23 +0000, Simon Horman wrote:
> Hi Gerd,
>=20
> In a similar vein, I am wondering if the forward declaration of
> ism_ops could be removed.=C2=A0 In my very light compile test it shows up
> as unused when CONFIG_SMC is unset.

Hi Simon,

sure, will do. Guess I need to make it a habit to compile with W=3D1.
ism (and smc) need some more work, though anyway.
I'll send a v2.

Thanks for spotting this!

Gerd
