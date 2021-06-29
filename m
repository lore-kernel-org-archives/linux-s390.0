Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B21C11F67
	for <linux-s390@archiver.kernel.org>; Tue, 29 Jun 2021 15:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBF461D07
	for <linux-s390@archiver.kernel.org>; Tue, 29 Jun 2021 15:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhF2Pxf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:53:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12504 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233867AbhF2Pxe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Jun 2021 11:53:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TFXvoN142597;
        Tue, 29 Jun 2021 11:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : references :
 from : subject : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cfbdMSBNRioXD0RiokwRCZqxeJRXrOuC//dlu0v2erc=;
 b=lQVdr11Pwta+j4ZhNFVvTSYEy3vHkOwrE7JuwIRV/D1b7uXxSOAgkmkR/UeZUnO502FT
 zeyRBmnKWxaxewfnLTL1hGusTvTwBNE6SUSg4Ir0FPRRyzh291OzbarBP4drtgCwpF3N
 bX/lhuNyPOoeyUjZ/YrDZ0dPyuCFW9JuWogl1ucFfjyr8geojVph0U0IpqI21N0vHdly
 Yb03wDVUGa5aEhZC63CDzVZn9QHBYSivqgEJn02qEYTHYFm/MmQKpEMDzFOg5l24rnSN
 940k/Dm89f5gfSoaISxQ+5OuLlQi0LOcuEI8TDRZLsPu2IXzvh2K/FuIYOqxCTyMn9CY Bw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g63eguj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 11:51:06 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TFXdpG003248;
        Tue, 29 Jun 2021 15:51:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 39dughhcfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 15:51:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TFp1rF21168546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 15:51:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C391A4090;
        Tue, 29 Jun 2021 15:51:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE001A407D;
        Tue, 29 Jun 2021 15:51:00 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.9.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 15:51:00 +0000 (GMT)
To:     Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Jan Hoeppner <hoeppner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210616201917.1246079-1-keescook@chromium.org>
From:   Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH] s390/dasd: Avoid field over-reading memcpy()
Message-ID: <bea0aa5b-a150-e5af-c22a-367f475c172f@linux.ibm.com>
Date:   Tue, 29 Jun 2021 17:51:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616201917.1246079-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7v49Gt2J-yt-7Plw4aPn2Fr2marbQg02
X-Proofpoint-GUID: 7v49Gt2J-yt-7Plw4aPn2Fr2marbQg02
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_07:2021-06-29,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 priorityscore=1501 mlxlogscore=947 phishscore=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290102
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 16.06.21 um 22:19 schrieb Kees Cook:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field array bounds checking for memcpy(), memmove(), and memset(),
> avoid intentionally reading across neighboring array fields.
>
> Add a wrapping structure to serve as the memcpy() source, so the compil=
er
> can do appropriate bounds checking, avoiding this future warning:
>
> In function '__fortify_memcpy',
>     inlined from 'create_uid' at drivers/s390/block/dasd_eckd.c:749:2:
> ./include/linux/fortify-string.h:246:4: error: call to '__read_overflow=
2_field' declared with attribute error: detected read beyond size of fiel=
d (2nd parameter)
>
> Signed-off-by: Kees Cook <keescook@chromium.org

Thanks,

applied.


