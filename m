Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F3C47094
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC8D610A2
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 10:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFGLAb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:00:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhFGLAb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 07:00:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157AXHkO195101;
        Mon, 7 Jun 2021 06:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4AN2CA0GuJHNAFTpN0s5mVh7V1bwkgGdEaCEZc4EmZA=;
 b=nah15DsKNTSEuw1FTKHDGfW0Dq1Nf57uBsw4VRhljFlvewI/gak/ma4R0KE7NixQk7Mk
 2WwlSr1geKwijnXVqT2jnxDx6mahBui0nvEaZ7/yoyAUEzSXR/4ZtYzr9zq1C1uw0H4E
 g9jChdlMALCtP+DQmgQKq7D8cLeHzvax7yVBpVjS+EeeQYqmjssnanYtuji6aAfKqixs
 Gf+IQEje/PEnkxHZ3LyOsYK6aCGOsLxTrvIRgzHUokvVi1HH6io5PgP/Oirc+7gZ6pGV
 gXeKR8jldsuSJwiktYRbYx6XHbZ8PALUIV1LCe/915IbjDqyyvoAwf6Nv0bS1/z1TbGp +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 391db4gaab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 06:58:02 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 157AguL4034323;
        Mon, 7 Jun 2021 06:58:01 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 391db4ga9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 06:58:01 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 157ArLHE026321;
        Mon, 7 Jun 2021 10:57:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3900hhruud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 10:57:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 157AvuLE31261016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jun 2021 10:57:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F19DE4203F;
        Mon,  7 Jun 2021 10:57:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58ECA42049;
        Mon,  7 Jun 2021 10:57:55 +0000 (GMT)
Received: from osiris (unknown [9.171.17.10])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  7 Jun 2021 10:57:55 +0000 (GMT)
Date:   Mon, 7 Jun 2021 12:57:53 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     akpm@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, gor@linux.ibm.com,
        borntraeger@de.ibm.com, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] kprobes: remove duplicated strong free_insn_page in
 x86 and s390
Message-ID: <YL37sTAUIfDulsDE@osiris>
References: <20210607091854.31580-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607091854.31580-1-song.bao.hua@hisilicon.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oDpWfoLYqSGBbqOS0oP66RlJBZuwVMXC
X-Proofpoint-ORIG-GUID: fSLjZx7Pw9a_vgp9UKRPpWUchr74zUMb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_07:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=906 phishscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 07, 2021 at 09:18:54PM +1200, Barry Song wrote:
> free_insn_page() in x86 and s390 are same with the common weak function
> in kernel/kprobes.c.
> Plus, the comment "Recover page to RW mode before releasing it" in x86
> seems insensible to be there since resetting mapping is done by common
> code in vfree() of module_memfree().
> So drop these two duplicated strong functions and related comment, then
> mark the common one in kernel/kprobes.c strong.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  -v2:
>  remove free_insn_page in s390 as well and remove the __weak in common
>  code according to Christoph's comment;
> 
>  arch/s390/kernel/kprobes.c     | 5 -----
>  arch/x86/kernel/kprobes/core.c | 6 ------
>  kernel/kprobes.c               | 2 +-
>  3 files changed, 1 insertion(+), 12 deletions(-)

For the s390 part:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
