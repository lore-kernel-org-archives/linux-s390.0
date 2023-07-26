Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9E9C001DC
	for <linux-s390@archiver.kernel.org>; Wed, 26 Jul 2023 07:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGZHSl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 Jul 2023 03:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjGZHSW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Jul 2023 03:18:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620A35252
        for <linux-s390@vger.kernel.org>; Wed, 26 Jul 2023 00:15:14 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q7CZPM006139;
        Wed, 26 Jul 2023 07:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=FNI/2rTPWHJVlJCXKKNxMm8pMigr+CowxwVDdiGZmMI=;
 b=ophRVJU8xTuCCV4QZVPslwcNkZfIuuTiZyeqdmwVlF25LnV/Va5e9vVPTgUivAwpLgJc
 4bHrIMmY+3Mji0kaGr39XhdrZOLpl1+p/DoanTKNV5SsE6j1ekn8wZNdHfL4AeIa/53a
 P47jo7ZquT9Wrm1uuh3HouD2ELJd9hN4Foazex7c5zSIYxHzrFUFQxxBtInFl0IBJ/bW
 w884W3g02A2zF/pNukusGR6OWwlxd4bAnTHtwfgwk3WyW2J3OcvLSYZ7rmT0ztPwWguE
 JrkDlyG+i795bhTPi5xHAj+h/WmtQ6S31SyuNAVUJdsq4clERif8T6AKm8gM9TgHKOVa ew== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2xvvg2bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:15:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q64KLH002013;
        Wed, 26 Jul 2023 07:15:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0ten2ue2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:15:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36Q7F6Vj16515588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 07:15:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCBCB20040;
        Wed, 26 Jul 2023 07:15:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B31592004B;
        Wed, 26 Jul 2023 07:15:06 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 26 Jul 2023 07:15:06 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/ftrace: use la instead of aghik in
 return_to_handler()
References: <20230726061834.1300984-1-hca@linux.ibm.com>
Date:   Wed, 26 Jul 2023 09:15:06 +0200
In-Reply-To: <20230726061834.1300984-1-hca@linux.ibm.com> (Heiko Carstens's
        message of "Wed, 26 Jul 2023 08:18:34 +0200")
Message-ID: <yt9do7jz4005.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: txoSo3VCY5J3YYQoWN4mom8g5FFQbnKv
X-Proofpoint-GUID: txoSo3VCY5J3YYQoWN4mom8g5FFQbnKv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=867 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260063
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Heiko Carstens <hca@linux.ibm.com> writes:

> Nathan Chancellor reported the following build error when compiling the
> kernel with CONFIG_MARCH_Z10=y:
>
>   arch/s390/kernel/mcount.S: Assembler messages:
>   arch/s390/kernel/mcount.S:140: Error: Unrecognized opcode: `aghik'
>
> The aghik instruction is only available since z196. Use the la instruction
> instead which is available for all machines.
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20230725211105.GA224840@dev-arch.thelio-3990X
> Fixes: 1256e70a082a ("s390/ftrace: enable HAVE_FUNCTION_GRAPH_RETVAL")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/mcount.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
> index d2596e0df6fa..71c5fa05e7f1 100644
> --- a/arch/s390/kernel/mcount.S
> +++ b/arch/s390/kernel/mcount.S
> @@ -137,7 +137,7 @@ SYM_FUNC_START(return_to_handler)
>  	lgr	%r1,%r15
>  	aghi	%r15,-(STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE)
>  	stg	%r1,__SF_BACKCHAIN(%r15)
> -	aghik	%r3,%r15,STACK_FRAME_OVERHEAD
> +	la	%r3,STACK_FRAME_OVERHEAD(%r15)
>  	stg	%r1,__FGRAPH_RET_FP(%r3)
>  	stg	%r2,__FGRAPH_RET_GPR2(%r3)
>  	lgr	%r2,%r3

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
