Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349DEC001DE
	for <linux-s390@archiver.kernel.org>; Wed, 26 Jul 2023 05:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGZFm7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 Jul 2023 01:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjGZFm4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Jul 2023 01:42:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30DA2705
        for <linux-s390@vger.kernel.org>; Tue, 25 Jul 2023 22:42:40 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q5fJnQ029146;
        Wed, 26 Jul 2023 05:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=rtBMx1qHHm/VMWvHLeKO/IYcj5KdR3lMJMypjaMjUHQ=;
 b=PoGX7SaNVilXWNcEhf5atQZgwWBDfTgSZcPA4FQpMKwbg03YrShWj0lF+1KuUm0JZSL4
 4v99tsB3y/cPApyHcTlNq8YkWVghB/oexyx4diRCUiACKs8Vaa6cePSEzgTv06F2uoAT
 gd5DLu2jyBZfN5bBj/vrn1w5f4nLBecSwiV8bzxGJY3JXlnRd5zlssCc0I0kY3Pu4WNp
 6bDFGArqdX1a86jRlyAzc/7441Hex6iQchIE7ePa2SmTbJV+KuuNq2GVq9LjWqbvAQBP
 7Nnx047e0Ck4lBnE/6bC0hpaXv+BvvsmwRvcrOrYk1fxFj91ErR4MDWdCPDp5eX0D/Ft iA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2w5d8end-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:42:30 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q4pc4s026217;
        Wed, 26 Jul 2023 05:42:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0ses2qk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:42:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36Q5gR0d57672166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 05:42:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EF0C2004B;
        Wed, 26 Jul 2023 05:42:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 217C220040;
        Wed, 26 Jul 2023 05:42:27 +0000 (GMT)
Received: from osiris (unknown [9.152.212.233])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 26 Jul 2023 05:42:27 +0000 (GMT)
Date:   Wed, 26 Jul 2023 07:42:25 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: Build error around 'aghik' after commit 1256e70a082a
 ("s390/ftrace: enable HAVE_FUNCTION_GRAPH_RETVAL")
Message-ID: <20230726054225.6242-A-hca@linux.ibm.com>
References: <20230725211105.GA224840@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725211105.GA224840@dev-arch.thelio-3990X>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zwJcLJLgGlQklJuRlKYTg-ZeL8dX5LAR
X-Proofpoint-GUID: zwJcLJLgGlQklJuRlKYTg-ZeL8dX5LAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=529 impostorscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260048
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Nathan,

> Apologies if this has been reported/fixed already, I checked the s390
> tree but I did not see any changes there nor did I find anything when
> searching lore. After commit 1256e70a082a ("s390/ftrace: enable
> HAVE_FUNCTION_GRAPH_RETVAL") in -next, I see the following errors when
> building Debian's configuration [1], which selects CONFIG_MARCH_Z10=y.
> 
> GCC/binutils:
> 
>   arch/s390/kernel/mcount.S: Assembler messages:
>   arch/s390/kernel/mcount.S:140: Error: Unrecognized opcode: `aghik'
> 
> clang:
> 
>   arch/s390/kernel/mcount.S:140:2: error: instruction requires: distinct-ops
>    aghik %r3,%r15,160
>    ^
> 
> It seems like there is already some handling for this situation in
> mcount.S but my knowledge of s390 assembly is basically non-existent,
> hence this report in lieu of a patch. I am more than happy to provide
> any additional information or test any patches if necessary.

Thanks, for reporting. Yet another bug where an instruction which is only
available on later machines (in this case z196) is used unconditionally. I
really need to add some automated test so this kind of trivial bugs don't
escape.

Will fix.
