Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142B3ECAAD8
	for <linux-s390@archiver.kernel.org>; Wed, 21 Sep 2022 21:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiIUVQU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIUVQT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Sep 2022 17:16:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF99B9FAAB
        for <linux-s390@vger.kernel.org>; Wed, 21 Sep 2022 14:16:18 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LKwdul003445;
        Wed, 21 Sep 2022 21:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ykGgtTCJx0zenThgSwB6pkFXq7pNdvsqQqiHp2cXOdY=;
 b=KMtlt5W41ABpG4ewL81fBsaL2w4BtQRNrAk6U6lm8sW8xn8gUZL3ghDDUEEGpWF93l36
 /ehQB2hN+PaxVcjSD/pd0/q+yCMSLZU7cqbo6j0GVdbgxoW/6uYPw4VIVqkFo+Do7nO1
 ahzVLhA7uL9whVNHDyKJlZYwUgSOtTkH6u9gU9Pz3zA9H3mWwEQqCueMmxMynlBjU0o4
 Z9hgIIle2V5Byw662XtnoJRFwD1uxSubnE7o26UGWhmPwvMGgMz5UP4J1Z0gNyZlNNw2
 wCKmjZo7Mr/FMybsvxwHAjnsgbwH5u9Sha1UXBFtryGJaHwwUlGiPOh58nPHXIrTnPmJ bw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jra4dgkxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 21:16:10 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28LL6SwC000451;
        Wed, 21 Sep 2022 21:16:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3jn5ghm92a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 21:16:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28LLG4n541091370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 21:16:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8861BA405B;
        Wed, 21 Sep 2022 21:16:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77D9CA4054;
        Wed, 21 Sep 2022 21:16:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Sep 2022 21:16:04 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55398)
        id 37A95E0675; Wed, 21 Sep 2022 23:16:04 +0200 (CEST)
Date:   Wed, 21 Sep 2022 23:16:04 +0200
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cuigaosheng1@huawei.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/cio: remove unused ccw_device_force_console()
 declaration
Message-ID: <Yyt/FAUQDBpWD/8v@tuxmaker.boeblingen.de.ibm.com>
References: <20220914125233.1485890-1-cuigaosheng1@huawei.com>
 <CAFpxydJVFEYK588_GQ_HAgo4uqU4X2i1pHrnZsNzin-imK9_Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFpxydJVFEYK588_GQ_HAgo4uqU4X2i1pHrnZsNzin-imK9_Kw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nfaR-PXI8rgvvkA6F8IbzQoiKgjOuXtm
X-Proofpoint-ORIG-GUID: nfaR-PXI8rgvvkA6F8IbzQoiKgjOuXtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_11,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=537 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1011 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210141
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thank you.
This will be part of next s390-tree patchset.

Also,
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>

> 
> ccw_device_force_console() has been removed by
> commit 8cc0dcfdc1c0 ("s390/cio: remove pm support from
> ccw bus driver"), so remove the declaration, too.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  arch/s390/include/asm/ccwdev.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
> index d4e90f2ba77e..bd1596810cc1 100644
> --- a/arch/s390/include/asm/ccwdev.h
> +++ b/arch/s390/include/asm/ccwdev.h
> @@ -214,7 +214,6 @@ extern struct ccw_device
> *ccw_device_create_console(struct ccw_driver *);
>  extern void ccw_device_destroy_console(struct ccw_device *);
>  extern int ccw_device_enable_console(struct ccw_device *);
>  extern void ccw_device_wait_idle(struct ccw_device *);
> -extern int ccw_device_force_console(struct ccw_device *);
> 
>  extern void *ccw_device_dma_zalloc(struct ccw_device *cdev, size_t size);
>  extern void ccw_device_dma_free(struct ccw_device *cdev,
> -- 
> 2.25.1
