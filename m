Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544CCC0015E
	for <linux-s390@archiver.kernel.org>; Tue, 15 Aug 2023 12:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjHOMO0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Aug 2023 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjHOMN6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Aug 2023 08:13:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B11171B
        for <linux-s390@vger.kernel.org>; Tue, 15 Aug 2023 05:13:57 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FC3f6B008017;
        Tue, 15 Aug 2023 12:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=FTmu1yh1FM/BCvnH1LGOAiNtqoTZkE9v07NRjdKk+7c=;
 b=LwQBgRrSFG7EcRe56AynBJQpUHJEpwfTPdjKpKN/IY96Ea4DMdEKmJoqA+33faiqOYSp
 odsYKuzVKba4Lt58Fm/k1xhcUZW3C0kjAxWlhZuPIo8gLQMrCRFGa7rt2CDejhMh6aK8
 goCKaRoFEDd9EnYn3S6fiUuPzfk5OOM72y0XyO7JqNwCvY9eXVGWv/jHQTRqthqL5lrv
 H2GCjqCriP6XcxldF3DFPGxvp1mC9S24RjX0cNvaCNPn19rYopydJMIoU6ZA+d0cAy4e
 KXfrUuUEmGVMKxU14knatOkfe6kwjUQandZ7uV2kHmfQ7h1py08IYYzKMwkZ8ry0gU63 pg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg919rauv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 12:13:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37FCANEv013500;
        Tue, 15 Aug 2023 12:13:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmjm64h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 12:13:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37FCDh6f44040734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 12:13:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97E7420043;
        Tue, 15 Aug 2023 12:13:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B6AC2004B;
        Tue, 15 Aug 2023 12:13:43 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Aug 2023 12:13:43 +0000 (GMT)
Date:   Tue, 15 Aug 2023 14:13:41 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH -next] s390/hmcdrv: Switch to memdup_user_nul() helper
Message-ID: <20230815121341.18151-A-hca@linux.ibm.com>
References: <20230815115546.1604722-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815115546.1604722-1-ruanjinjie@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LhGvJ5ZY5ZY5HQi1cCNZGj79m2Ie04Sp
X-Proofpoint-ORIG-GUID: LhGvJ5ZY5ZY5HQi1cCNZGj79m2Ie04Sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=553 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308150108
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 15, 2023 at 07:55:46PM +0800, Ruan Jinjie wrote:
> Use memdup_user_nul() helper instead of open-coding
> to simplify the code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/s390/char/hmcdrv_dev.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
> index 8d50c894711f..504cdbf9998d 100644
> --- a/drivers/s390/char/hmcdrv_dev.c
> +++ b/drivers/s390/char/hmcdrv_dev.c
> @@ -252,19 +252,12 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
>  		 fp, (long long) *pos, len);
>  
>  	if (!fp->private_data) { /* first expect a cmd write */
> -		fp->private_data = kmalloc(len + 1, GFP_KERNEL);
> -
> -		if (!fp->private_data)
> -			return -ENOMEM;
> -
> -		if (!copy_from_user(fp->private_data, ubuf, len)) {
> -			((char *)fp->private_data)[len] = '\0';
> -			return len;
> +		fp->private_data = memdup_user_nul(ubuf, len);
> +		if (IS_ERR(fp->private_data)) {
> +			fp->private_data = NULL;
> +			return PTR_ERR(fp->private_data);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is obviously broken. Sorry, but I'm not willing to review such
"trivial" cleanup patches for subtle bugs anymore - maybe you would
sooner or later succeed and I would apply such a broken patch.

Just don't send such patches; at least I won't take them.
