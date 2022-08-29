Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A23EECAAD2
	for <linux-s390@archiver.kernel.org>; Mon, 29 Aug 2022 08:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiH2IbQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Aug 2022 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2IbP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Aug 2022 04:31:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D844540
        for <linux-s390@vger.kernel.org>; Mon, 29 Aug 2022 01:31:14 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T8PJoM019965;
        Mon, 29 Aug 2022 08:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KBQIj5Hh5D+qBZzR3wNqJuffB4rYi6rsMBVqcQRG6aQ=;
 b=LZJlj78pck70PgdR6PXp5kBmVKPiqvSeqhXlpJAypCO6XPmvgKaBli1/v1X+Hk8MQv27
 OllfiaWY+DvT8ZP7Lc6dBAbtKiQykb27j05lCA1rQBGEyCMYiqZkjKDI3zCSb8wWO0EC
 zGSr1QJv8IVsxQz5G0dWmJpQeCDAZkmohHz8gOFarENp8lqrD3E/uDpuGO0YHiuF2NG2
 92YwIu9euqd2nFxXwmHIV2GosnF45zfssFlIwmZyABdihg7oQGGGnpAlqt2nnjhfQ1vu
 dt8P9kguICII173EllyquFeotHjxww/N+jsv4vPpoo3m/GeM3HX4CJk8ufRph9RRwtov Gg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8sxb049w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 08:31:09 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27T8KhMk006764;
        Mon, 29 Aug 2022 08:31:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3j7aw8sfqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 08:31:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27T8VP6X42271006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 08:31:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 237B2A404D;
        Mon, 29 Aug 2022 08:31:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1B33A4040;
        Mon, 29 Aug 2022 08:31:03 +0000 (GMT)
Received: from osiris (unknown [9.145.9.115])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Aug 2022 08:31:03 +0000 (GMT)
Date:   Mon, 29 Aug 2022 10:31:02 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        svens@linux.ibm.com
Subject: Re: [PATCH] s390/appldata: Do not initialise statics to 0
Message-ID: <Ywx5Rpe/Lkso/tQn@osiris>
References: <20220827162230.19611-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827162230.19611-1-dengshaomin@cdjrlc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4OiizsXw6gIPRLpUhjnbs3YIcUNWnflX
X-Proofpoint-ORIG-GUID: 4OiizsXw6gIPRLpUhjnbs3YIcUNWnflX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_03,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 mlxlogscore=646 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290039
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Aug 27, 2022 at 12:22:30PM -0400, Shaomin Deng wrote:
> No need to do the initialization of statics to 0 or NULL.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  arch/s390/appldata/appldata_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
> index d74a4c7d5df6..e1721e2dd89e 100644
> --- a/arch/s390/appldata/appldata_base.c
> +++ b/arch/s390/appldata/appldata_base.c
> @@ -88,7 +88,7 @@ static struct vtimer_list appldata_timer;
>  static DEFINE_SPINLOCK(appldata_timer_lock);
>  static int appldata_interval = APPLDATA_CPU_INTERVAL;
>  static int appldata_timer_active;
> -static int appldata_timer_suspended = 0;
> +static int appldata_timer_suspended;

Why do you think its worth spending your and all the recipient's time
on such patches? What does this improve?
