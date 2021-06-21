Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582C9C48BE5
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 07:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302DA60E0B
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 07:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUHjw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 03:39:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhFUHjw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 03:39:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15L7YhNX090047;
        Mon, 21 Jun 2021 03:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : references :
 from : subject : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XPJwls8YdjtseKrI89JOvtem2q5qFpTOTjytg9mB9Yo=;
 b=qaXhZzCOFo5S62aBXTbKDSHk+HbgVa3/kk/JRDclRUfy86bod4AOXsVKa7hz405dE6vw
 xmGRuZf6K/XB2Qb7DAQ9vFwrKKnGryXgfQz0lZYYgN6MFVglpVJ9RTZ72WrCtJ69WF4V
 DGYCcDn+VvhvzwmlqFQ9EK2aK7L+qsU7g32dTdyUDIrDy16K0tn4Vu0BvLXMyItf0F8m
 2DPfZM37KdSX17avG2vLL+qdbmOpIFvVyKVHG1dAqcaj5kk2RGQ16PGEZJUEjC+XIXu3
 O9XJJszeDDVId9K9vSyv/zZGT9CM3glA7L3x9UrdCDjGO0BanMXr80C8+fk6no/AmJss BA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39an30anhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 03:37:35 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15L7bXUg029513;
        Mon, 21 Jun 2021 07:37:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3998788r4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 07:37:33 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15L7bUMi23855492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 07:37:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8484942042;
        Mon, 21 Jun 2021 07:37:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B0D842047;
        Mon, 21 Jun 2021 07:37:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.90.47])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jun 2021 07:37:30 +0000 (GMT)
To:     Christoph Hellwig <hch@lst.de>
Cc:     hoeppner@linux.ibm.com, linux-s390@vger.kernel.org
References: <20210614060440.3965603-1-hch@lst.de>
 <4e202558-05b4-9c63-f08e-a5762b93c9ce@linux.ibm.com>
 <20210621072745.GA6896@lst.de>
From:   Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH] dasd: unexport dasd_set_target_state
Message-ID: <313adc69-a0b3-3fec-7be0-73d97d39c659@linux.ibm.com>
Date:   Mon, 21 Jun 2021 09:37:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210621072745.GA6896@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kjcLAKhM6wufDXQwU46Gsn2VoOo6FsH2
X-Proofpoint-GUID: kjcLAKhM6wufDXQwU46Gsn2VoOo6FsH2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_02:2021-06-20,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210043
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 21.06.21 um 09:27 schrieb Christoph Hellwig:
> On Thu, Jun 17, 2021 at 02:40:06PM +0200, Stefan Haberland wrote:
>> Am 14.06.21 um 08:04 schrieb Christoph Hellwig:
>>> dasd_set_target_state is only used inside of dasd_mod.ko, so don't
>>> export it.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>> Acked-by: Stefan Haberland <sth@linux.ibm.com>
> Can you pick this up through the s390 tree?

Sure.
But FYI: I will send it to Jens since we bring DASD patches upstream
through the block tree.


