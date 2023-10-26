Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36155C25B48
	for <linux-s390@archiver.kernel.org>; Thu, 26 Oct 2023 14:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbjJZO5M (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 26 Oct 2023 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbjJZO5L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Oct 2023 10:57:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2671893;
        Thu, 26 Oct 2023 07:57:09 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QEsh1N012174;
        Thu, 26 Oct 2023 14:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=tGqLposxrNDFe/v9DI1KYmIROdqCe7BBYC3oEYQTyZ8=;
 b=fOVJ4Xx2d4qSz2NTTgEumwVGXh3JPy1xYvZdDKR1F6o+86GKdLZgHskV5eqSlwc+Y8Zi
 tecAPM64txpJe6Uy1QSF8AnxW0f19niVpEsIVwdGPBzBFNtB2jpeiSmYkr/+shoHUJru
 9RaorU0SgroGCtcyx06xgZ27nEzarT2Lc6u1nNvK/uS8Vdx02o3UDkS5kise3ywFW4mJ
 WxISr0BDaIh0q2QKCo/qJYHdmpjhYPaq5qmJX6pSYXszfVSm3+77Rkxsx3iHruSToqAT
 pzUVvNxl8QLs6ByQbPuInLuTR1/ML+YgT/cROFjnUcNVaxDID/qivGr8bdGuaLagS2QH EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyt4wre4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:57:06 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QEiYhp026442;
        Thu, 26 Oct 2023 14:57:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyt4wre41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:57:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39QETnBM026853;
        Thu, 26 Oct 2023 14:57:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsyp6rvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:57:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39QEv1hV38535512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 14:57:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D088420040;
        Thu, 26 Oct 2023 14:57:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49E0720043;
        Thu, 26 Oct 2023 14:57:01 +0000 (GMT)
Received: from osiris (unknown [9.171.73.20])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Oct 2023 14:57:01 +0000 (GMT)
Date:   Thu, 26 Oct 2023 16:56:59 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "dcavalca@meta.com" <dcavalca@meta.com>, ngompa@fedoraproject.org,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: s390x stack unwinding with perf?
Message-ID: <20231026145659.7063-A-hca@linux.ibm.com>
References: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vLqupC5sjroqOTw1YesYLC8ooTXNOKLp
X-Proofpoint-GUID: VfvCWKQ2gJqXstJ8M-MKnfNXbQ7xxd_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_13,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=449 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260128
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 26, 2023 at 02:30:41PM +0200, Daan De Meyer wrote:
> Hi,
> 
> As part of enabling frame pointers system wide for Fedora to get fast
> system wide stack unwinding, we're now looking to do the same for
> s390x after previously enabling frame pointers for x86-64 and aarch64.
> From what we can find, on s390x stack unwinding is done via the
> "-mbackchain" compiler option. However, from some early experiments
> rebuilding a small part of the distro, this option alone does not seem
> to result in usable stack traces in perf (perf record -g => perf
> report).
> 
> Are there any other compiler options that need to be enabled in order
> to get usable stack traces in perf for s390x? Has anyone managed to
> get this working before?

So, are you saying that you want to enable "-mbackchain" for whole user
space for Fedora? If that is the case, what certainly is missing is kernel
support to unwind user space stack frames from the kernel, since until now
no distribution had user space where it would be possible to unwind the
user space stack from the kernel; which is the reason why this was never
implemented.

If this (or some other compiler options) will be enabled for user space, we
need to add kernel support in order to make this work.
