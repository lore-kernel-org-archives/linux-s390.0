Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbgDTHa6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 03:30:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K79w3r069254
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 03:30:57 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gj22754c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 03:30:57 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 20 Apr 2020 08:30:49 +0100
Subject: Re: linux-next: Tree for Apr 20
References: <20200420142610.390e5922@canb.auug.org.au>
 <2d87a4f9-9d87-e929-9b03-31f92dad5ca6@de.ibm.com>
 <DB6PR0802MB2533E416D358177D5CA53564E9D40@DB6PR0802MB2533.eurprd08.prod.outlook.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Apr 2020 09:30:50 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0802MB2533E416D358177D5CA53564E9D40@DB6PR0802MB2533.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9b70262a-10b5-beb5-e058-3a0a2fa0fb8f@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hadar Gat <Hadar.Gat@arm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, linux-s390 <linux-s390@vger.kernel.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Ofir Drang <Ofir.Drang@arm.com>, nd <nd@arm.com>


On 20.04.20 09:23, Hadar Gat wrote:
> 
>> On 20.04.20 06:26, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20200417:
>>>
>>> My fixes tree is empty again.
>>>
>>> The qcom tree still had its build failure for which I reverted a commit.
>>>
>>> The crypto tree still has its build failure for which I reverted 5 commits.
>>>
>>> The drm-misc tree gained a build failure for which I disabled a
>>> COMPILE_TEST setting.
>>>
>>> The sound-asoc tree still has its build failures so I used the version
>>> from next-20200414.
>>>
>>> The ipmi tree gained a build failure for which I applied a patch.
>>>
>>> Non-merge commits (relative to Linus' tree): 2732
>>>  3544 files changed, 76515 insertions(+), 37271 deletions(-)
>>
>> s390 defconfig still does not compile. While the media kconfig problem is
>> gone I now have
>>
>>   CC [M]  drivers/char/hw_random/cctrng.o
>> drivers/char/hw_random/cctrng.c: In function ‘cc_trng_compwork_handler’:
>> drivers/char/hw_random/cctrng.c:334:49: error: ‘fips_enabled’ undeclared
>> (first use in this function); did you mean ‘vdso_enabled’?
>>   334 |  if (CC_REG_FLD_GET(RNG_ISR, CRNGT_ERR, isr) && fips_enabled) {
>>       |                                                 ^~~~~~~~~~~~
>>       |                                                 vdso_enabled
>> drivers/char/hw_random/cctrng.c:334:49: note: each undeclared identifier is
>> reported only once for each function it appears in
>> drivers/char/hw_random/cctrng.c:335:3: error: implicit declaration of
>> function ‘fips_fail_notify’ [-Werror=implicit-function-declaration]
>>   335 |   fips_fail_notify();
>>       |   ^~~~~~~~~~~~~~~~
>> cc1: some warnings being treated as errors
>>
>> Can we maybe make this driver depend on ARM?
> 
> Hi,
> This compilation issue is already fixed.
> It was pushed few days ago and is waiting to be applied.
> https://lore.kernel.org/linux-crypto/096db769-a508-b0fa-f018-2c4c807061cb@infradead.org/

Herbert,

can these things be applied in a timely fashion? This DOES break several automated test 
cases that usually run on linux-next.
