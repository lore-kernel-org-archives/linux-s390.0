Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C6FC6FA99
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 14:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjCJOKw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 09:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjCJOKW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 09:10:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207EA570BD
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 06:10:03 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AAeuOT022575
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=5QbQdg5d9WJWzFL5jkwsk2bO1JKDc+9GvaRG0drnk2c=;
 b=lQ1fgy48rwP0ALJmQHwGF1v3rLyp/hP/fxrmetxVxhOybkA6aWHvMIMcBBb/puntI/M3
 ACAgvU+KWsc6SA+8klss+NSz2rekago4jDGYI+9cctuSTLzlnIaGnY/QYMLuMhfJLvNB
 rFdTCG0PkoV1AgfobsTtSOYZU44yBviWMPmJvt/vVcxr3mCvmiI1NjkMbjJr3X8ngNCH
 RCXV8TzZygcSUbXfzcxWI2N8ibv3fF5tAoVv5sNeqTkBF+Tstp4rVglJ5NuM1YqtBcH1
 D+M+qBJBvnGxyQfsaV/QpAoreapeUHUqWwthxqLwG1Tifyuk2+N/F0Hs8NbULb22lwh8 gg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p7j15wbqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:23:53 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A9B1OU014773
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:23:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p6gdqavtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:23:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADNmYd58524126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:23:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4127C20043;
        Fri, 10 Mar 2023 13:23:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8268D20040;
        Fri, 10 Mar 2023 13:23:47 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.36.141])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Mar 2023 13:23:47 +0000 (GMT)
Date:   Fri, 10 Mar 2023 14:23:45 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390: ipl: fix physical-virtual confusion for
 diag308
Message-ID: <ZAsvYcIPW5G94q94@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20230310130236.106661-1-nrb@linux.ibm.com>
 <20230310130236.106661-2-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310130236.106661-2-nrb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hQ3cQWCtqr1vf0r4SBJfaY_MWsN2rKfq
X-Proofpoint-GUID: hQ3cQWCtqr1vf0r4SBJfaY_MWsN2rKfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=807 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Mar 10, 2023 at 02:02:36PM +0100, Nico Boehr wrote:
> Diag 308 subcodes expect a physical address as their parameter.
> 
> This currently is not a bug, but in the future physical and virtual
> addresses might differ.
> 
> Fix the confusion by doing a virtual-to-physical conversion in the
> exported diag308() and leave the assembly wrapper __diag308() alone.

You change the prototype though ;)

> Note that several callers pass NULL as addr, this is _currently_ fine since
> virt_to_phys(0) == 0. But in the future, lowcore addresses might no
> longer be special, so make sure we pass 0 to hardware in case addr is
> NULL.

This paragraph seems to me is extra or not precise at least.
The reason for explicit NULL check is not virt_to_phys(NULL)
might return non-0 in the future, but rather virt_to_phys(NULL)
is not expected returning 0 on any architecture.

> Suggested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>  arch/s390/kernel/ipl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 5f0f5c86963a..d8b8a87626f7 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -176,7 +176,7 @@ static bool reipl_fcp_clear;
>  static bool reipl_ccw_clear;
>  static bool reipl_eckd_clear;
>  
> -static inline int __diag308(unsigned long subcode, void *addr)
> +static inline int __diag308(unsigned long subcode, u64 addr)

Physical addresses are unsigned longs. Why u64 then?
Also the cast to unsigned long (not seen here) becomes redundant.

>  {
>  	union register_pair r1;
