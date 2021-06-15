Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587B8C48BE5
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 23:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2800B61245
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 23:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhFOXHy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Jun 2021 19:07:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1926 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230043AbhFOXHy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Jun 2021 19:07:54 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FN4DkS096067;
        Tue, 15 Jun 2021 19:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VRd/qr35+S3j0HU3zjfgTYFgw+QuMF2USsC+SQ3HaDA=;
 b=DXkhXPCo2lrcQi03b/Qex6fOFTpwAYAfZZXhDVRLf8ESvkIRS3SGK4acsVMEJ2A5Pb9d
 b42NVtgnEE2zNuIx3lakggCM5bJsLht1H/BAtxDr011uq6eVg+2Y+odP+FfNrAQb8CaW
 V+S8/lZLJaGVMFmIr6pO2FD2IVN8Z8ksX28NucBKD3Ap49Z3mUIQABEcVzZqxAD7WcB0
 vXC8lmfg78g4gc0No0ltyU+ycLxcTflB/wGpxUOmmJ9Mt8FpLwV3AvyoQ1BOeMPSfSyX
 mA8OGW0OkTzB6VaRCQq6uTIHjEUWj43/iRfx7MbjaTJ4fxxhgcy6Qeg3mXq7by5Fp+iJ 0A== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3975cer92y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 19:05:40 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15FN2mMZ024668;
        Tue, 15 Jun 2021 23:05:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3966jpgep8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 23:05:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15FN5ZOG34799874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 23:05:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CBA54C040;
        Tue, 15 Jun 2021 23:05:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28D574C058;
        Tue, 15 Jun 2021 23:05:35 +0000 (GMT)
Received: from localhost (unknown [9.171.72.121])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Jun 2021 23:05:35 +0000 (GMT)
Date:   Wed, 16 Jun 2021 01:05:33 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     hca@linux.ibm.com, borntraeger@de.ibm.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        vneethv@linux.ibm.com, dsterba@suse.com, oberpar@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] s390/sclp: convert list_for_each to entry variant
Message-ID: <your-ad-here.call-01623798333-ext-7548@work.hours>
References: <1623740220-15846-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1623740220-15846-1-git-send-email-zou_wei@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S40vlL13GhrUD5kQ2v8fzY6WZTZaLhKB
X-Proofpoint-GUID: S40vlL13GhrUD5kQ2v8fzY6WZTZaLhKB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_07:2021-06-15,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150142
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 15, 2021 at 02:57:00PM +0800, Zou Wei wrote:
> convert list_for_each() to list_for_each_entry() where
> applicable.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/s390/char/sclp_tty.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks!
