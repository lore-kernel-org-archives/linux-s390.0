Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2FAC433C1
	for <linux-s390@archiver.kernel.org>; Fri, 26 Mar 2021 20:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CD961A13
	for <linux-s390@archiver.kernel.org>; Fri, 26 Mar 2021 20:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhCZUAW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 Mar 2021 16:00:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230152AbhCZUAG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Mar 2021 16:00:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12QJXtKw149893;
        Fri, 26 Mar 2021 16:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MuCNBq+R4/NJunBn3EoE0FszXlecnAyueAsRVmou+yc=;
 b=MylWEIe1V8CiioiMhqovwYB0LXrBMInhbS/+2+lqifNTMbyUFFspi9aA4Lo1QK7ccoQw
 zasCv7dGwf0GQcT4Ph4hF1BxRT11cke4DNIUlUeZuli5dK2rBgtsVw3WGHe9FFQ/vtyM
 hFrA15cbHOgZPipi1vggh0DeWy+ZIfxzpbhIAQRQWOn2u3AGH6PFcgzqXmo5eLRG65Gn
 d7Av385nHj0TRa31WNQyngwjYbhhFHqAy9l23MC8SnOYKeB/Wv5HX5yjw8UCya6QY/7C
 zxDQLVJ9u0L0+ZD3NdNDUDYsmmvLF1HcrWFUqfIvPdQzux2qcJhTaARB8tt4KfhPKqMA +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37hhrn7vu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 15:59:59 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12QJY8Fs150975;
        Fri, 26 Mar 2021 15:59:59 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37hhrn7vtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 15:59:59 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12QJwDIi018975;
        Fri, 26 Mar 2021 19:59:57 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 37h14tggg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 19:59:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12QJxsWh28508472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 19:59:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ABB34C044;
        Fri, 26 Mar 2021 19:59:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A243E4C050;
        Fri, 26 Mar 2021 19:59:53 +0000 (GMT)
Received: from linux-2.fritz.box (unknown [9.145.50.237])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Mar 2021 19:59:53 +0000 (GMT)
Subject: Re: [PATCH] s390: dasd: Mundane spelling fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210322023930.376358-1-unixbhaskar@gmail.com>
From:   Stefan Haberland <sth@linux.ibm.com>
Message-ID: <7b18bc98-d177-78d3-ca6e-2e77f352a9ee@linux.ibm.com>
Date:   Fri, 26 Mar 2021 20:59:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322023930.376358-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F8_LzFS4QpwK4MYs565K83rFLaSRcWco
X-Proofpoint-GUID: Q7LMqPMdXHq4nI3cTDsBxj0phZwgLphJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_11:2021-03-26,2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260145
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 22.03.21 um 03:39 schrieb Bhaskar Chowdhury:
> s/Subssystem/Subsystem/ ......two different places
> s/reportet/reported/
> s/managemnet/management/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/s390/block/dasd_eckd.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

applied, thanks

