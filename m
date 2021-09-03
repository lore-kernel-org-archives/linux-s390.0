Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFFC433EF
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 08:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0A860F92
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 08:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348295AbhICIZ5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Sep 2021 04:25:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34024 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348265AbhICIZ4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Sep 2021 04:25:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18383RPf088144;
        Fri, 3 Sep 2021 04:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UcstyxnwlpgF+Ay1ob7lx18NvkC4MYru10qsDJHiJbs=;
 b=cWABf8Gfer47mlZ3ZAae0HBN2LEdp03ML5IMZz1rCkVJRF5OUGJnNwgwuIiIAJ41pDdf
 YLlF6Ou8QfmlPMyPqwxT6eQdcgqArbrrI7vn8ifwgocVH+NS3n67Da5Ss5sL1dFs7nB/
 tDrbw/oTUEvSz5T1kVKnxCIk0cR/6bmXQ5iwYWAq8yg75H+UXkeTrhSQ1B2r3xLGEnb5
 6WX8yVZDhE4OgWinaTKnCjhEdNgcNBfn177mEqd64DRw5GGpkeHu77dk0Km13Q7yGpOy
 oyHQSMSK1WDeQ4uEaxd3de+A0G4dMCvK70HLLIfiX1c6fAvoHGpgUZ3jcy8DNdOHMK6+ mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aud7yvcnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 04:24:47 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18386LMv103061;
        Fri, 3 Sep 2021 04:24:47 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aud7yvcnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 04:24:47 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18388A6x026039;
        Fri, 3 Sep 2021 08:24:45 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3au6q754xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 08:24:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1838Ofpp39584204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 08:24:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E99211C052;
        Fri,  3 Sep 2021 08:24:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BE3311C071;
        Fri,  3 Sep 2021 08:24:41 +0000 (GMT)
Received: from sig-9-145-171-221.de.ibm.com (unknown [9.145.171.221])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 08:24:41 +0000 (GMT)
Message-ID: <b4a5f322d035d75c97abf2aaa19d033adc68527d.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/io: Fix ioremap and iounmap undefinded issue for
 s390
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 03 Sep 2021 10:24:40 +0200
In-Reply-To: <20210903080316.2808017-1-zhang.lyra@gmail.com>
References: <20210903075641.2807623-1-zhang.lyra@gmail.com>
         <20210903080316.2808017-1-zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 83mqzz2AmZE1E1ac8HXSteQ4nn3Fo0Gn
X-Proofpoint-ORIG-GUID: ESRTZmQtjwF5NndeOsa7_mlEwKbKIUyS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_02:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030048
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 2021-09-03 at 16:03 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> There would not be ioremap and iounmap implementations if CONFIG_PCI is
> not set for s390, so add default declarations of these two functions
> for the case to avoid 'undefined reference' issue.
> 
> Fixes: 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> The issue was reported from https://lkml.org/lkml/2021/8/1/18

Thanks for the patch but I'm a little skeptical about adding
ioremap()/iounmap() stubs that don't do anything useful and on top ofn
that would do so silently.

In the above discussion you said that TIMER_OF should depend on
HAS_IOMEM. In arch/s390/Kconfig HAS_IOMEM is set if and only if
CONFIG_PCI is set so that sounds to me like it would prevent the
undefined reference without the risk of someone trying to use io*map()
without CONFIG_PCI.

At the very least I think the functions should do a WARN_ONCE() but
then we have the same situation as discussed below with Linus making it
pretty clear that he prefers these cases to be compile time checked:

https://lkml.org/lkml/2021/7/2/511


> ---
>  arch/s390/include/asm/io.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> index e3882b012bfa..9438370c6445 100644
> --- a/arch/s390/include/asm/io.h
> +++ b/arch/s390/include/asm/io.h
> @@ -23,11 +23,8 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
>  #define IO_SPACE_LIMIT 0
>  
> 
.. snip ..

