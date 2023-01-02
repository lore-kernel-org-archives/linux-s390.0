Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D88AC46467
	for <linux-s390@archiver.kernel.org>; Mon,  2 Jan 2023 12:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjABMXa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Jan 2023 07:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjABMX2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Jan 2023 07:23:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7778A5FD9;
        Mon,  2 Jan 2023 04:23:27 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3028u31X022341;
        Mon, 2 Jan 2023 12:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=rN4lOheEc0Q2rvQ32848ukta5ml0lI+OTI92+CdXu6k=;
 b=eAuD0As9vy4A/y9ZvsqiZ+jq9U22H4JK2zxxDqS0NZuS6L8woKyunIoipBAyQb4apu3m
 fl1dyZy8bsJNREWGB/UVh7/0qWr26TnYoQij4NFwgZlrymRzQB7ojbk6sG54gyMuZOkf
 uhNG+2oLMsRYDBkMBhiKdGEYm3GWxYqhrI2ntnTvb266LFVTbTZm4eaJi/ta/IzYHEQH
 VUdJAOfHHAeWfXW477ged4/TiU71fY3IYovn1ijHKZfL7mmkAH4XANDLDptqP+RbCutY
 cglvSttakNUTWrkUrtnzL/UHJdyel1iY9WBkT2TF8E0GL1EM/kZrbNoF4QN671+V1zWY bA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mty110117-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 12:23:26 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 301LejIH021495;
        Mon, 2 Jan 2023 12:23:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mtcq69ryk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 12:23:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302CNKBf39846230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 12:23:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5D8620043;
        Mon,  2 Jan 2023 12:23:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24A8920040;
        Mon,  2 Jan 2023 12:23:20 +0000 (GMT)
Received: from osiris (unknown [9.171.22.101])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Jan 2023 12:23:20 +0000 (GMT)
Date:   Mon, 2 Jan 2023 13:23:13 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     yang.yang29@zte.com.cn
Cc:     freude@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] s390/zcrypt: use strscpy() to instead of
 strncpy()
Message-ID: <Y7LMsfB8T59d0Ujk@osiris>
References: <202212231045217042473@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212231045217042473@zte.com.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9Q9sacKPaX8M6qvtqYsKYXI0UjBWiFZp
X-Proofpoint-ORIG-GUID: 9Q9sacKPaX8M6qvtqYsKYXI0UjBWiFZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_06,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=709 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301020110
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Dec 23, 2022 at 10:45:21AM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>  drivers/s390/crypto/zcrypt_api.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Please resend and make sure that your Signed-off-by Name+Email address
actually matches the From: field of your Email.

Thank you!
