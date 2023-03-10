Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800D9C6FA99
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 13:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCJNgR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCJNgQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 08:36:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA671091E0
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 05:36:15 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ABCGdh020711
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=QDpf2/dA8cDf05wo4sDPcEscax8c31fzWGFE8wXIIXQ=;
 b=rrw7t4E7VQG0xg+uorFq6auJtbmVTOGE5z6yFh3vi1DoFlSVzfL89a+vslmVSzgxJ2Jt
 WG9QZnrwUzLCeaDaqhkFxQ0MQKJcuHDMFNc/Rf1CS38/VzhYzdC4gNSIopLj7Rh/uGzY
 Kt3LizVgYXvHcNTYwERCCUlUoxINEbvuimzJRanhxpaGJgL6IHksOycH5pxNVczLJmTb
 GFizm1H3QQD/xawPPrGXcBIqVxVtS6pGGWvo1JVGWTWoE/TuXwyEXOY7d3FGCpE2x2zA
 GzAY7WjKoLb+AL9umALZ8UkdlD+41mpwPAaP8DvlM4tHZGbGq4KOoAoRKZJs/I49JjZt dw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p7va7pb4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:36:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A8ICkB023001
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:36:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p6fysuw8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:36:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADa9fT32244082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:36:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5271120040;
        Fri, 10 Mar 2023 13:36:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E5EE2004F;
        Fri, 10 Mar 2023 13:36:08 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.36.141])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Mar 2023 13:36:08 +0000 (GMT)
Date:   Fri, 10 Mar 2023 14:36:06 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
Subject: Re: [PATCH v3 1/1] s390: ipl: fix physical-virtual confusion for
 diag308
Message-ID: <ZAsyRmBM+nX1pvhG@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20230310133411.139275-1-nrb@linux.ibm.com>
 <20230310133411.139275-2-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310133411.139275-2-nrb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tRFBBpWcNp7DCkp5TpSWXM03nWunN2CI
X-Proofpoint-GUID: tRFBBpWcNp7DCkp5TpSWXM03nWunN2CI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=917
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100109
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Mar 10, 2023 at 02:34:11PM +0100, Nico Boehr wrote:
> Diag 308 subcodes expect a physical address as their parameter.
> 
> This currently is not a bug, but in the future physical and virtual
> addresses might differ.
> 
> Fix the confusion by doing a virtual-to-physical conversion in the
> exported diag308() and leave the assembly wrapper __diag308() alone.
> 
> Note that several callers pass NULL as addr, so check for the case when
> NULL is passed and pass 0 to hardware since virt_to_phys(0) might be
> nonzero.
> 
> Suggested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>  arch/s390/kernel/ipl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 5f0f5c86963a..afac9970ce42 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -176,11 +176,11 @@ static bool reipl_fcp_clear;
>  static bool reipl_ccw_clear;
>  static bool reipl_eckd_clear;
>  
> -static inline int __diag308(unsigned long subcode, void *addr)
> +static inline int __diag308(unsigned long subcode, unsigned long addr)
>  {
>  	union register_pair r1;
>  
> -	r1.even = (unsigned long) addr;
> +	r1.even = addr;
>  	r1.odd	= 0;
>  	asm volatile(
>  		"	diag	%[r1],%[subcode],0x308\n"
> @@ -195,7 +195,7 @@ static inline int __diag308(unsigned long subcode, void *addr)
>  int diag308(unsigned long subcode, void *addr)
>  {
>  	diag_stat_inc(DIAG_STAT_X308);
> -	return __diag308(subcode, addr);
> +	return __diag308(subcode, addr ? virt_to_phys(addr) : 0);
>  }
>  EXPORT_SYMBOL_GPL(diag308);

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
