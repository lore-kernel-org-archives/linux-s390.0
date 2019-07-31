Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbfGaHRI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 03:17:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V781A7027689
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2019 03:17:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3430nhaj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2019 03:17:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 31 Jul 2019 08:17:04 +0100
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <d48ac43b-c960-54af-a145-360a67b4a3d9@de.ibm.com>
 <e9cd12ce-d4cf-95b7-15f8-84112527f6a7@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 31 Jul 2019 09:16:58 +0200
MIME-Version: 1.0
In-Reply-To: <e9cd12ce-d4cf-95b7-15f8-84112527f6a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fc736e13-17f4-6f7a-2c0d-366950e96bab@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>



On 30.07.19 21:06, Paolo Bonzini wrote:
> On 30/07/19 16:57, Christian Borntraeger wrote:
>> While this fixes the test (and the migration does work fine), it still
>> means that s390x overindicates the dirty bit for sparsely populated
>> 1M segments. It is just a performance issue, but maybe we should try 
>> to get this fixed. Not sure what to do here to remember us about this, 
>> adding this as expected fail?
> 
> if it's only on the first access after enabling dirty logging, that
> shouldn't be that bad?

No its not bad, but certainly something to improve if time allows. 
