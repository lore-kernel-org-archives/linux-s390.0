Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390482AbfKESXN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 13:23:13 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5IETLp075714
        for <linux-s390@vger.kernel.org>; Tue, 5 Nov 2019 13:23:12 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3e19rq8g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 13:23:12 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 5 Nov 2019 18:23:10 -0000
Subject: Re: [kvm-unit-tests PATCH 0/2] s390x: Improve architectural
 compliance for diag308
References: <20191105162828.2490-1-frankja@linux.ibm.com>
 <70BDB5DE-489D-4718-B6C2-0EABD89414D2@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 5 Nov 2019 19:23:05 +0100
MIME-Version: 1.0
In-Reply-To: <70BDB5DE-489D-4718-B6C2-0EABD89414D2@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <0560e27d-dac8-a569-2e3f-f8188724c822@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com



On 05.11.19 18:34, David Hildenbrand wrote:
> 
> 
>> Am 05.11.2019 um 17:29 schrieb Janosch Frank <frankja@linux.ibm.com>:
>>
>> ﻿When testing diag308 subcodes 0/1 on lpar with virtual mem set up, I
>> experienced spec PGMs and addressing PGMs due to the tests not setting
>> short psw bit 12 and leaving the DAT bit on.
>>
>> The problem was not found under KVM/QEMU, because Qemu just ignores
>> all cpu mask bits... I'm working on a fix for that too.
>>
> 
> I don‘t have access to documentation. Is what LPAR does documented behavior or is this completely undocumented and therefore undefined behavior? Then we should remove these test cases completely instead.

Yes. It was just that KVM/QEMU never looked at the mask and just used a default
one. The short PSW on address 0 clearly contains a mask and we should better set
it.
> 
>> Janosch Frank (2):
>>  s390x: Add CR save area
>>  s390x: Remove DAT and add short indication psw bits on diag308 reset
>>
>> lib/s390x/asm-offsets.c  |  3 ++-
>> lib/s390x/asm/arch_def.h |  5 +++--
>> lib/s390x/interrupt.c    |  4 ++--
>> lib/s390x/smp.c          |  2 +-
>> s390x/cstart64.S         | 29 ++++++++++++++++++++---------
>> 5 files changed, 28 insertions(+), 15 deletions(-)
>>
>> -- 
>> 2.20.1
>>
