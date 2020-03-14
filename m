Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15788 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbgCOBg2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 14 Mar 2020 21:36:28 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02EFwfba097646
        for <linux-s390@vger.kernel.org>; Sat, 14 Mar 2020 12:02:12 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yrt32aqhv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 14 Mar 2020 12:02:11 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Sat, 14 Mar 2020 16:02:07 -0000
Subject: Re: [PATCH 0/5] selftests: KVM: s390: Accumulated fixes and
 extensions
References: <20200310130144.9921-1-borntraeger@de.ibm.com>
 <8d09a198-ba35-1591-6a79-57f336e2f1c5@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Sat, 14 Mar 2020 17:02:02 +0100
MIME-Version: 1.0
In-Reply-To: <8d09a198-ba35-1591-6a79-57f336e2f1c5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <53e50e61-cb80-fd7c-1ef4-991fd7f10603@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Andrew Jones <drjones@redhat.com>, Cornelia Huck <cohuck@redhat.com>



On 14.03.20 12:48, Paolo Bonzini wrote:
> On 10/03/20 14:01, Christian Borntraeger wrote:
>> - do more and better testing for reset
>> - fix fprintf formats (thanks to Andrew Jones)
>>
>> Paolo, I would schedule this for next and not for master. ok?
>>
>> Christian Borntraeger (5):
>>   selftests: KVM: s390: fix early guest crash
>>   selftests: KVM: s390: test more register variants for the reset ioctl
>>   selftests: KVM: s390: check for registers to NOT change on reset
>>   selftests: KVM: s390: fixup fprintf format error in reset.c
>>   selftests: KVM: s390: fix format strings for access reg test
>>
>>  tools/testing/selftests/kvm/s390x/resets.c    | 132 ++++++++++++++----
>>  .../selftests/kvm/s390x/sync_regs_test.c      |  11 +-
>>  2 files changed, 116 insertions(+), 27 deletions(-)
>>
> 
> Queued, thanks.  I pulled the format strings fixes before -Wformat is
> enabled.

So I should drop them from my next branch, I guess?
