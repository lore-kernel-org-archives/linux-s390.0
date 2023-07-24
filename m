Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C499FC05052
	for <linux-s390@archiver.kernel.org>; Mon, 24 Jul 2023 09:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjGXJyW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 Jul 2023 05:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjGXJxw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Jul 2023 05:53:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E321FCF;
        Mon, 24 Jul 2023 02:50:24 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O9goi1016383;
        Mon, 24 Jul 2023 09:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OSkfCtzSFqAJGeAqL4V+pXsWx0yB7M8d9tLrPrc5i/4=;
 b=D29cdY0VSzumMibjzISS/jMSrGwRMl5p8Yzh13iDGEHzV/Xcy7q458UY0C2P/AJYP0Hz
 TVZq9jhvgKBfXh+1VEGFR+6QNMAWPFak75tpzOQodtKFebgFPC74W4GMjLZspLJdyNHV
 HdwoISChpcYs4M5AeKNi4uWQeNlWPCPLu/LWMSWn5e0WNt4MebxjZlqfyd3yCQQxafwO
 e58B2MOofKeR+sCBiLe/+wHsFsJWGYqc0HCORmRhUUy0nsVbtmjzhpHMB3VlbOMEgRl6
 045FErWfXB1N/nVw7HIWgYxECJ5iEYbd+dnLHQ2F5hoDYEZ6HDfuBkjO78YFmrRP0YZi lw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1pwg857c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 09:49:37 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36O7XZwh002278;
        Mon, 24 Jul 2023 09:49:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0unj1kg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 09:49:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36O9nWT520644394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 09:49:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FBAE2004B;
        Mon, 24 Jul 2023 09:49:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3312820043;
        Mon, 24 Jul 2023 09:49:32 +0000 (GMT)
Received: from [9.179.17.111] (unknown [9.179.17.111])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jul 2023 09:49:32 +0000 (GMT)
Message-ID: <4a0b4798-c58c-8aaa-f3d9-fbce2ac54ab2@linux.ibm.com>
Date:   Mon, 24 Jul 2023 11:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] dasd fixes
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20230721193647.3889634-1-sth@linux.ibm.com>
 <42f33274-6877-1e39-1caf-d8ff0a9bc357@kernel.dk>
Content-Language: en-US
From:   Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <42f33274-6877-1e39-1caf-d8ff0a9bc357@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -A4glP34dgQrvAJ6lLmqGQ8seSnDWk5M
X-Proofpoint-GUID: -A4glP34dgQrvAJ6lLmqGQ8seSnDWk5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=877 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 21.07.23 um 21:44 schrieb Jens Axboe:
> On 7/21/23 1:36 PM, Stefan Haberland wrote:
>> Hello Jens,
>>
>> please apply the following patches that fix some errors in the DASD device
>> driver. Thanks.
> 6.6 fine, or were you targeting 6.5?
>

6.5 would be great if possible.
One of the fixes is for a customer issue which we should get into the 
Distros asap.

Thanks.
