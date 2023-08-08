Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B95C04A94
	for <linux-s390@archiver.kernel.org>; Tue,  8 Aug 2023 18:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjHHSBx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjHHSBY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Aug 2023 14:01:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F92D1D2
        for <linux-s390@vger.kernel.org>; Tue,  8 Aug 2023 09:28:12 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DehYB001821;
        Tue, 8 Aug 2023 13:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wH+XVbml4PWZLeFFMXTb8CkeGQK/ylxrsb4suuw7v8w=;
 b=A28vobJ1hqwQPEeZXnzTI9OAxjoJeimMSTozgbq5flRkOkyrRLoo6YyyItQQZjyDWuMJ
 mpgfnsqBDSDcPpoPh/crX9XAllFtT5pfexngEK2/nTFsq3TxlQm63Bkp0WgQ5KJ3DNcF
 wziQusWK7zYuM6YlgpusUy1RjS19/rPS0UgDkXKVp5OymhBWg1IhomHhrDOwBRwc1J17
 QDHnE1fZ0IZpkCa8Uz2DJ2BMLxn9Sy0nWXbFZREBAj5uxB9Z8ETgSUjIh5jkkRJIM9oi
 atHbVs87nXvhrgzQBVA6XdR7o3T3MrLNhJUBCOnxQynIzxDRmaVYAYopbYFWx0VD3wt9 ag== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbph1gtdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 13:57:30 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 378CI2NL006653;
        Tue, 8 Aug 2023 13:57:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa0rsyfye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 13:57:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 378DvQKI42795616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Aug 2023 13:57:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1703B20043;
        Tue,  8 Aug 2023 13:57:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4E8720040;
        Tue,  8 Aug 2023 13:57:25 +0000 (GMT)
Received: from osiris (unknown [9.171.5.170])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Aug 2023 13:57:25 +0000 (GMT)
Date:   Tue, 8 Aug 2023 15:57:24 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-s390@vger.kernel.org, vneethv@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH -next] s390: remove unnecessary dev_set_drvdata()
Message-ID: <20230808135724.9396-E-hca@linux.ibm.com>
References: <20230808125501.566824-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808125501.566824-1-yangyingliang@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pKINBnvB74mRSGKM2ZRbpSDyu5Zw5Kgx
X-Proofpoint-GUID: pKINBnvB74mRSGKM2ZRbpSDyu5Zw5Kgx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_11,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=380 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080121
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 08, 2023 at 08:55:01PM +0800, Yang Yingliang wrote:
> The driver data will be cleared in device_unbind_cleanup() in driver
> core code. So the dev_set_drvdata(..., NULL) called in remove and
> error path in probe can be removed.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/s390/block/scm_drv.c      | 2 --
>  drivers/s390/char/con3215.c       | 1 -
>  drivers/s390/char/tape_core.c     | 1 -
>  drivers/s390/cio/chsc_sch.c       | 2 --
>  drivers/s390/cio/vfio_ccw_drv.c   | 2 --
>  drivers/s390/crypto/vfio_ap_ops.c | 1 -
>  6 files changed, 9 deletions(-)

And now you expect us to review six drivers if this trivial change may
or may not introduce subtle bugs?

This is not going to happen, unless there is a really good reason why
this patch makes sense besides some cleanup.
