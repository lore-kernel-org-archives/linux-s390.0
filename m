Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C9CC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 10:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F4660F0F
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 10:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhJKKDW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Oct 2021 06:03:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235602AbhJKKDV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Oct 2021 06:03:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B938RY021282;
        Mon, 11 Oct 2021 06:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=WCNQW008KqRadTwMEqOJX2IJ4+dVZVQvodrIMlZrvdQ=;
 b=GmGL0WOzVowCFmYLDtnYmlEVWSiAIMvDubcuzEeu3q5Z6JHAsT/nEHi+tufCwmYmwAF9
 fiU4kEEfcsLoOXBRPChU75uyfrdsvXBT+iMhdSS7wXXMvBRbwNZgrWtRBJIzWdaaxx6R
 r4ycO9ZlNL+UCOFMG2zc5bE9iZBpw4Y18LZNl1itwRMdAfI5Hi9IhwYbSwlNu1EITSKh
 BSYsvCJiNwXli/m3XhPJy4p1O7EmzeTijy0MdCSXbSyrsIkMGSucnuqMcoSZHZ58Kuwx
 byUE7xB/m2Woj6eRjgFJbgylF0lOlCAl4rt1flcFrevDCob3329YK5z3XFyaSLQLoqJO 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bmj9s13ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 06:01:11 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19B9S7Fu030037;
        Mon, 11 Oct 2021 06:01:11 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bmj9s13k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 06:01:11 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19B9vmlt021154;
        Mon, 11 Oct 2021 10:01:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3bk2bhvj5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 10:01:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19BA0pHq60490126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 10:00:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2C7A11C069;
        Mon, 11 Oct 2021 10:00:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22A0B11C073;
        Mon, 11 Oct 2021 10:00:51 +0000 (GMT)
Received: from osiris (unknown [9.145.33.245])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Oct 2021 10:00:51 +0000 (GMT)
Date:   Mon, 11 Oct 2021 12:00:49 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     llvm@lists.linux.dev, linux-s390@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>
Subject: Re: clang-13: s390/kernel/head64.S:24:17: error: invalid operand for
 instruction
Message-ID: <YWQLUd+BQ1Cc88HG@osiris>
References: <CA+G9fYuqwJD5bFO74vG6Mvbbt1G8rxzd_NDHg-gtOZ6rPjeu3A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuqwJD5bFO74vG6Mvbbt1G8rxzd_NDHg-gtOZ6rPjeu3A@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IkMHF_JJLk0yR1ir2y9ttGHU4E_89xur
X-Proofpoint-ORIG-GUID: 4joU-_84x3xGn-j9pomuJqH9vVMSAvf1
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=853 clxscore=1011 mlxscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110057
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 11, 2021 at 11:47:42AM +0530, Naresh Kamboju wrote:
> [Please ignore this email if it is already reported ]
> 
> Following s390 builds failed due to warnings / errors.
> 
> metadata:
>     git_describe: v5.15-rc5
>     git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>     git_short_log: 64570fbc14f8 (\"Linux 5.15-rc5\")
>     target_arch: s390
>     toolchain: clang-13
> 
> 
> Fail (2861 errors) s390 (tinyconfig) with clang-nightly
>   @ https://builds.tuxbuild.com/1zL35IUSGhDGeVuyIrAp7eyzEUi/
> Fail (2861 errors) s390 (tinyconfig) with clang-13
>   @ https://builds.tuxbuild.com/1zL35Hn7wjErKsLDM6zAgh27BYJ/
> Fail (4112 errors) s390 (allnoconfig) with clang-13
>   @ https://builds.tuxbuild.com/1zL35HR60hSFvBmAcYJvKHm8Lko/
> Fail (4112 errors) s390 (allnoconfig) with clang-nightly
>   @ https://builds.tuxbuild.com/1zL35DTlrX9qRGCtGqgtmmMDjnQ/
> Fail (23048 errors) s390 (defconfig) with clang-13
>   @ https://builds.tuxbuild.com/1zL35DE2KWQUPxbbXeTbwIJaWXS/
> Fail (23045 errors) s390 (defconfig) with clang-nightly
>   @ https://builds.tuxbuild.com/1zL35EgeQfWQDXDupp4itkUO5At/
> 
> 
> Build errors log:
> ----------------
> arch/s390/kernel/head64.S:24:17: error: invalid operand for instruction
>  lctlg %c0,%c15,.Lctl-.LPG1(%r13) # load control registers
>                 ^
> arch/s390/kernel/head64.S:40:8: error: invalid operand for instruction
>  lpswe .Ldw-.(%r13) # load disabled wait psw

You need to pass LLVM_IAS=0 on the make command line on s390 since
commit f12b034afeb3 ("scripts/Makefile.clang: default to LLVM_IAS=1").

LLVM's integrated assembler doesn't seem to work well when compiling
the kernel for s390 yet.
