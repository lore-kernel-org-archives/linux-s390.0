Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55016C0015E
	for <linux-s390@archiver.kernel.org>; Fri, 28 Jul 2023 11:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjG1L3p (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 28 Jul 2023 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjG1L3j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Jul 2023 07:29:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2B04216
        for <linux-s390@vger.kernel.org>; Fri, 28 Jul 2023 04:29:22 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SBK5Ow016453;
        Fri, 28 Jul 2023 11:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=8Ncc0yMuXXFsnLW+gu+I/KHlbwW2iW0K16TLfKBqvHc=;
 b=SIlpSODyfYsg15PNxJ1Fwzn41AjanL7j4VOFGp3DPV2oIy3K+9wgd+JFQszWQxK1pkPH
 +S4ru/DSoxSYKeBgNGX+o5ZxU+ZlVhg0rkN65+FPJZP2LEzSpmJUBpTC7W1kZ/sszxp7
 GJWyvuhOCwBBhZoM3cGl7AAmbTLZ8FLrVc6aykwpklQ9lpPyWU61doKzuKj/E0MamiD8
 3WLj8Xo6d8ezwNjaiGUwN+tVKeziGgpMPUKT1QFLLyVzOp3l3NloCfsDT6OD3lzYJ4mN
 e1dnps/uAU7SZgsVN0aSxiQzYv86ueNizWE7kkd/oGSdn55C+e9lXlnn/2C+nsPan8sM 1g== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4cq686ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 11:29:15 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36SAv6Lu016644;
        Fri, 28 Jul 2023 11:29:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0v51w01p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 11:29:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36SBT82u28050094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 11:29:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 624C620049;
        Fri, 28 Jul 2023 11:29:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F30512006C;
        Fri, 28 Jul 2023 11:29:07 +0000 (GMT)
Received: from osiris (unknown [9.171.95.61])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Jul 2023 11:29:07 +0000 (GMT)
Date:   Fri, 28 Jul 2023 13:29:06 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-s390@vger.kernel.org, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, anastasia.eskova@ibm.com,
        oberpar@linux.ibm.com
Subject: Re: [PATCH -next] s390/cert_store: fix error return code in
 fill_cs_keyring()
Message-ID: <20230728112906.6761-C-hca@linux.ibm.com>
References: <20230728084228.3186083-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728084228.3186083-1-yangyingliang@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YX2a2BjlaizschVEhChl6xgchpe9E0q_
X-Proofpoint-ORIG-GUID: YX2a2BjlaizschVEhChl6xgchpe9E0q_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=674 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280102
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jul 28, 2023 at 04:42:28PM +0800, Yang Yingliang wrote:
> The 'rc' will be re-assigned to 0 after calling get_vcssb(), it
> needs be set to error code if create_cs_keyring() fails.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  arch/s390/kernel/cert_store.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index 1cbeb9ce0eb1..38ad11c2be12 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -703,8 +703,10 @@ static int fill_cs_keyring(void)
>  		goto cleanup_keys;
>  
>  	cs_keyring = create_cs_keyring();
> -	if (!cs_keyring)
> +	if (!cs_keyring) {
> +		rc = -ENOMEM;
>  		goto cleanup_keys;
> +	}

Slightly changed your patch and applied. Thanks!
