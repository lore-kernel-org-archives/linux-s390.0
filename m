Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B392FE7B5E2
	for <linux-s390@archiver.kernel.org>; Wed,  4 Oct 2023 09:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjJDJ7v (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 4 Oct 2023 05:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjJDJ7u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Oct 2023 05:59:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD858A7;
        Wed,  4 Oct 2023 02:59:47 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3949sE6j025751;
        Wed, 4 Oct 2023 09:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Bp/EmzSSU8jFBY2TIgWtfMvhr+UqBiHzWjjGZ+tmiSY=;
 b=W1bXjflL1hWBchtPcjf9WD0wucpiHl7hs49KaEfgWgvKe1bHY7ir28G9V0R+9te3A29S
 wkJldKj1nczJy0vi5b6MOzsrherAf6k/fBCuOY/IYXMeXbAcQqdJ8BaL8nWPqt/LlEZP
 DMpkwgPodFNlWD6elHh21FQB35iQ3PdNYnJO/W2XU5ikGSNaeFPK4x8rPhwlqYpjCTx4
 W6zoh5cICLNfb1wLr1yylMGkYRnjfuSs47s1dmFrDLe6hU8cirY2lh1nzaNHX7ZXfcFL
 i3anblGpyhX/r+b/OxDBBiqwug7zJttlzYkUQjJbqwfeIlxiwSZ85BM1v3nETcqAtXM2 Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th5u0r3vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 09:59:45 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3949tHqk028077;
        Wed, 4 Oct 2023 09:59:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th5u0r3vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 09:59:45 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3948Z4bn005863;
        Wed, 4 Oct 2023 09:59:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0su0me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 09:59:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3949xeG419923576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 09:59:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACE6020043;
        Wed,  4 Oct 2023 09:59:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27A7020040;
        Wed,  4 Oct 2023 09:59:40 +0000 (GMT)
Received: from [9.171.71.190] (unknown [9.171.71.190])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 09:59:40 +0000 (GMT)
Message-ID: <c9c468df-e67a-4cb8-ef26-12c380fd55e2@linux.ibm.com>
Date:   Wed, 4 Oct 2023 11:59:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] partitions/ibm: Replace strncpy() and cleanups
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Justin Stitt <justinstitt@google.com>
References: <20230915131001.697070-1-sth@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20230915131001.697070-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ItPerJnwHdh6ykSuqzH6SJgWmqV7xO-2
X-Proofpoint-GUID: -Njy6KLmLVG_iGK9mGIkR_66QxkajMO6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=989 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310040060
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 15.09.23 um 15:09 schrieb Stefan Haberland:
> Hi Jens,
>
> please apply the following patches for the next merge window that remove
> strncpy() from DASD partition detection. This includes some cleanups that
> should increase readability of the code.
>
> This is based on the discussion started with the patches by Justin Stitt:
> https://lore.kernel.org/linux-s390/20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com/
> https://lore.kernel.org/linux-s390/20230823-strncpy-block-partitions-cmdline-ibm-v2-1-40c77f7182fc@google.com/
>
> Thanks.
>
> Jan Höppner (3):
>    partitions/ibm: Remove unnecessary memset
>    partitions/ibm: Replace strncpy() and improve readability
>    partitions/ibm: Introduce defines for magic string length values
>
>   block/partitions/ibm.c | 98 +++++++++++++++++++++++++++++-------------
>   1 file changed, 68 insertions(+), 30 deletions(-)
>

Hi Jens,

polite ping.
Any objections against the patches?

regards,
Stefan
