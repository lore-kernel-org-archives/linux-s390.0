Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8475EC433EF
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 18:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6173F61175
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 18:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243281AbhJGSJN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:09:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243373AbhJGSJN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Oct 2021 14:09:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197HX7bc009387;
        Thu, 7 Oct 2021 14:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7LpLDTRHXFsC4nZgyOmnyv5fLVJVby6YT8fyKx6CqSk=;
 b=j0XwB64Jz/PM6yWyDzpg9V9/oROfqgCi61BMMCnypeKMcDs2quRYDuoKCr/75Zp7NHfB
 6pNpYo+lA9b8oLP6CfAsaMOnF2Rzq2X7IpaXXF6e5z3UFIDCRZO7KJS65a1aeFwJqd9z
 zgUrUC1E6u+bbMQ2gb/EqXsbxbh6uU3h2J+NwKGzg4Kr+ue+V5kWSLK1MrbPzG/ggUMA
 zz+sYRcwwmE3vVmAsaWaFjwEgVqpuQV/p735/jSUL7UT+FrGG+z4NwgResyIo3toyQlX
 Y71MpJntwV4LkkLztOYpIJ6by+WeqCR+ZhJa5O23ZCLIRMEkaPPGwBvUK8D4iq7uZDEt JQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bj1dsynp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 14:07:18 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 197I42nZ023658;
        Thu, 7 Oct 2021 18:07:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3bef2bjtmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 18:07:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 197I7CuX67043740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Oct 2021 18:07:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A09604C044;
        Thu,  7 Oct 2021 18:07:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D2084C062;
        Thu,  7 Oct 2021 18:07:12 +0000 (GMT)
Received: from osiris (unknown [9.145.86.18])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Oct 2021 18:07:12 +0000 (GMT)
Date:   Thu, 7 Oct 2021 20:07:10 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Message-ID: <YV83TqdODBXRomA4@osiris>
References: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NJDm2HhHsc2Lk0BADRBRAQBMHCa1MCNw
X-Proofpoint-ORIG-GUID: NJDm2HhHsc2Lk0BADRBRAQBMHCa1MCNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxlogscore=904
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110070117
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 01, 2021 at 04:02:01PM +0300, Andy Shevchenko wrote:
> Use string_upper() from string helper module instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/s390/mm/cmm.c    | 11 ++++-------
>  arch/s390/mm/extmem.c | 21 ++++++++++++---------
>  2 files changed, 16 insertions(+), 16 deletions(-)

Applied, but as discussed only the cmm part.
