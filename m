Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE03C433DB
	for <linux-s390@archiver.kernel.org>; Mon, 22 Mar 2021 06:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D216196C
	for <linux-s390@archiver.kernel.org>; Mon, 22 Mar 2021 06:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVGvt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Mar 2021 02:51:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229979AbhCVGv0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Mar 2021 02:51:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12M6XCTM031327;
        Mon, 22 Mar 2021 02:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WK/jSPbp6XxXj259B33pfsdWq8CMHUKLiYL1n8TU8po=;
 b=FrJ1vJdeYj3+y0MGg3QuNEeMau3SkBiatFIO9fdTFu6m6H+h4V1BPqOde+3jeQw73An/
 X13tYuCVzKGKH6Scm9PUVn/lemALZsrFguAliAtzy7LBWFM79StMVw7XKbYPVYmHFSHK
 zXOyAKFY7IoeMP09/xb2pHhh474vLVAX3GI4bJgPJazspnz2U+fckRMcVZGuea8Yx5sq
 /nHeaoZTm1ke7ji4phQmtd04HpAgUoTRBNmSXANo9UtbuOA3lPGdtlPl3Mf3vwyku7te
 11QIRkOHpCRhy1oUYUTchEJe4BS8HdKCdtheC9rvP8nqP3Oa654EMQ++Uh1nXIPgTlAX nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37e03emwxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 02:51:11 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12M6XaJ3032377;
        Mon, 22 Mar 2021 02:51:11 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37e03emwwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 02:51:10 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12M6lm8k032419;
        Mon, 22 Mar 2021 06:51:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 37d9d8s1np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 06:51:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12M6p5GM42140040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 06:51:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0A4952059;
        Mon, 22 Mar 2021 06:51:05 +0000 (GMT)
Received: from osiris (unknown [9.171.51.204])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 564BB52052;
        Mon, 22 Mar 2021 06:51:05 +0000 (GMT)
Date:   Mon, 22 Mar 2021 07:51:04 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] s390/kernel: Fix a typo
Message-ID: <YFg+WAjyE2lRP7Fj@osiris>
References: <20210322062500.3109603-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322062500.3109603-1-unixbhaskar@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_02:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=977 malwarescore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220048
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Mar 22, 2021 at 11:55:00AM +0530, Bhaskar Chowdhury wrote:
> 
> s/struture/structure/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/s390/kernel/os_info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/os_info.c b/arch/s390/kernel/os_info.c
> index 0a5e4bafb6ad..5a7420b23aa8 100644
> --- a/arch/s390/kernel/os_info.c
> +++ b/arch/s390/kernel/os_info.c
> @@ -52,7 +52,7 @@ void os_info_entry_add(int nr, void *ptr, u64 size)
>  }
> 
>  /*
> - * Initialize OS info struture and set lowcore pointer
> + * Initialize OS info structure and set lowcore pointer

Applied, thanks.
