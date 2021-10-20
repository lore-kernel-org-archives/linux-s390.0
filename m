Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A164EC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 14:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E48610A1
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 14:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTOqX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:46:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229632AbhJTOqW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Oct 2021 10:46:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KCfeIp030056;
        Wed, 20 Oct 2021 10:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZK8jnYkL1n0N2Nup4rimcPgfzRHmdKfqVDA18sM2YTM=;
 b=l186xdpbquDkaZwhw4kh7VDkwZ7rbCPWbyeLTbR8maY+silu+5iac51pn3V1ywoGqXeo
 KUoB+6TtNA2JiwVz5obI25XuesrKxEzIQY1b8EX9Ty0zFOmMmPXrHpAF8C41t7OlSkGi
 wKES1kYPTXdBunbYoXRrzSvKuyo1trZVoimE16FjgnrnyyPAsXG1MbRBgauWBBK/XeNJ
 1Rkk6mFzYjkQDn/SET0WIEfgjK1JkwCUF5XC5IfOA9a91AHPqKdoOu5Ve7XbeZheP+jr
 YHcSJnGAvlFXXRlAo19/8zLHUUik43Q1MWvmSSIcWTEcErceXMQaxQjNd9LX9k5Oh+xg DA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btcaa4hb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 10:44:07 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KEc8jn005370;
        Wed, 20 Oct 2021 14:44:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3bqpca368w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 14:44:05 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KEi2io42336564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 14:44:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED1E0A405F;
        Wed, 20 Oct 2021 14:44:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9419BA405B;
        Wed, 20 Oct 2021 14:44:01 +0000 (GMT)
Received: from [9.145.45.114] (unknown [9.145.45.114])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 14:44:01 +0000 (GMT)
Message-ID: <1955ef45-d30f-5354-e514-2bc8f7d9cfb6@linux.ibm.com>
Date:   Wed, 20 Oct 2021 16:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] s390: replace snprintf in show functions with sysfs_emit
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1634280655-4908-1-git-send-email-wangqing@vivo.com>
From:   Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <1634280655-4908-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: akxf7yLa1SCqUuG80wPEEJZMnW1FFPg8
X-Proofpoint-ORIG-GUID: akxf7yLa1SCqUuG80wPEEJZMnW1FFPg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_05,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1011 mlxlogscore=926 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 15.10.21 um 08:50 schrieb Qing Wang:
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
>   drivers/s390/block/dasd_devmap.c | 74 ++++++++++++++++++++--------------------
>

Thanks for the DASD changes. While I am totally fine with the change 
itself I agree with Joe's remark.
Would you like to improve your patch? Otherwise I can add a small follow 
on patch. Just let me know.


