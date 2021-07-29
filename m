Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4DAC4338F
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 13:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEE16023F
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 13:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbhG2Nrj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 09:47:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48540 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237503AbhG2Nri (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Jul 2021 09:47:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TDXWBw110609;
        Thu, 29 Jul 2021 09:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=9O/GEXoZTqlR+xJfXv/WGh/M7l0aIVQd0qAa+HW+Jb4=;
 b=coJYu/Zt4KQyNuAJsFjZKgC2d9R85IJRz0q/e8r6/5m+RSV6IN9G1K0a6XkBIy9TP2OI
 fHwl3ccbMPd9m7nrH6gj+FLL8b98Z+DpQ0NQ1wRg4HUj7imZ42r/KwjNtXzMowZDHzFU
 VYo+Z8PPrFE4wBMrIbtFHN+WxhKoUBH+CYZ/wfgtuBn3hCs1LKuQf/TC6pv1x2J/GzOX
 kP6EsMclJkS6Z9KLjUdYk7Cq3Anv6yQOgRhIB/db6pYmF8sbq8j9GqUJACk80o/FdzPV
 esdO0Dl/NErjdG3p59+3Jl1fiTXMjuf9G+qeUASNY78+uLBRiM7URIkK8UdWFHxl0EsL YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3tw7nkue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 09:47:32 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16TDYInm117541;
        Thu, 29 Jul 2021 09:47:32 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3tw7nktt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 09:47:32 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TDZnjZ002896;
        Thu, 29 Jul 2021 13:47:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3a235ks4ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 13:47:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TDigBD25428294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 13:44:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF0C6A4051;
        Thu, 29 Jul 2021 13:47:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58190A4080;
        Thu, 29 Jul 2021 13:47:25 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Jul 2021 13:47:25 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>, Marco Elver <elver@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 2/4] kfence: add function to mask address bits
References: <20210728190254.3921642-1-hca@linux.ibm.com>
        <20210728190254.3921642-3-hca@linux.ibm.com>
        <CAG_fn=VS_WFjL+qjm79Jvq5M0KaNScvX2vCw=aNxPx14Hffa0A@mail.gmail.com>
Date:   Thu, 29 Jul 2021 15:47:24 +0200
In-Reply-To: <CAG_fn=VS_WFjL+qjm79Jvq5M0KaNScvX2vCw=aNxPx14Hffa0A@mail.gmail.com>
        (Alexander Potapenko's message of "Thu, 29 Jul 2021 14:43:51 +0200")
Message-ID: <yt9dtukdteoj.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Grps8gXUt09Y6zVx3mspHN6fv6-rv4W
X-Proofpoint-GUID: dN18rwQmbCZAayJ0xzHHDeX5X82kCHcf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290087
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Alexander Potapenko <glider@google.com> writes:

> On Wed, Jul 28, 2021 at 9:03 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>>
>> From: Sven Schnelle <svens@linux.ibm.com>
>>
>> s390 only reports the page address during a translation fault.
>> To make the kfence unit tests pass, add a function that might
>> be implemented by architectures to mask out address bits.
>>
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
>> ---
>>  mm/kfence/kfence_test.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
>> index 942cbc16ad26..eb6307c199ea 100644
>> --- a/mm/kfence/kfence_test.c
>> +++ b/mm/kfence/kfence_test.c
>> @@ -23,8 +23,15 @@
>>  #include <linux/tracepoint.h>
>>  #include <trace/events/printk.h>
>>
>> +#include <asm/kfence.h>
>> +
>>  #include "kfence.h"
>>
>> +/* May be overridden by <asm/kfence.h>. */
>> +#ifndef arch_kfence_test_address
>> +#define arch_kfence_test_address(addr) (addr)
>> +#endif
>> +
>>  /* Report as observed from console. */
>>  static struct {
>>         spinlock_t lock;
>> @@ -82,6 +89,7 @@ static const char *get_access_type(const struct expect_report *r)
>>  /* Check observed report matches information in @r. */
>>  static bool report_matches(const struct expect_report *r)
>>  {
>> +       unsigned long addr = (unsigned long)r->addr;
>>         bool ret = false;
>>         unsigned long flags;
>>         typeof(observed.lines) expect;
>> @@ -131,22 +139,25 @@ static bool report_matches(const struct expect_report *r)
>>         switch (r->type) {
>>         case KFENCE_ERROR_OOB:
>>                 cur += scnprintf(cur, end - cur, "Out-of-bounds %s at", get_access_type(r));
>> +               addr = arch_kfence_test_address(addr);
>
> Can we normalize addr once before (or after) this switch?
>

I don't think so. When reporing corrupted memory or an invalid free the
address is not generated by hardware but kfence itself, and therefore we
would strip valid bits.

>>                 break;
>>         case KFENCE_ERROR_UAF:
>>                 cur += scnprintf(cur, end - cur, "Use-after-free %s at", get_access_type(r));
>> +               addr = arch_kfence_test_address(addr);
>>                 break;
>>         case KFENCE_ERROR_CORRUPTION:
>>                 cur += scnprintf(cur, end - cur, "Corrupted memory at");
>>                 break;
>>         case KFENCE_ERROR_INVALID:
>>                 cur += scnprintf(cur, end - cur, "Invalid %s at", get_access_type(r));
>> +               addr = arch_kfence_test_address(addr);
>>                 break;
>>         case KFENCE_ERROR_INVALID_FREE:
>>                 cur += scnprintf(cur, end - cur, "Invalid free of");
>>                 break;
>>         }
>>
>> -       cur += scnprintf(cur, end - cur, " 0x%p", (void *)r->addr);
>> +       cur += scnprintf(cur, end - cur, " 0x%p", (void *)addr);
>>
>>         spin_lock_irqsave(&observed.lock, flags);
>>         if (!report_available())
>> --
>> 2.25.1
>>
