Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729989AbfG3SEN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jul 2019 14:04:13 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UI34Mf030828
        for <linux-s390@vger.kernel.org>; Tue, 30 Jul 2019 14:04:12 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u2r94xnjd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 30 Jul 2019 14:04:11 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 30 Jul 2019 19:04:09 +0100
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <d48ac43b-c960-54af-a145-360a67b4a3d9@de.ibm.com>
 <02c5c7b4-c45e-4573-d2c3-ebfa2cd2c9d1@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 30 Jul 2019 20:04:01 +0200
MIME-Version: 1.0
In-Reply-To: <02c5c7b4-c45e-4573-d2c3-ebfa2cd2c9d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <341c3705-c2cb-9e87-cc03-42e0cefba308@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>



On 30.07.19 19:11, Thomas Huth wrote:
> On 30/07/2019 16.57, Christian Borntraeger wrote:
>>
>>
>> On 30.07.19 12:01, Thomas Huth wrote:
>>> To run the dirty_log_test on s390x, we have to make sure that we
>>> access the dirty log bitmap with little endian byte ordering and
>>> we have to properly align the memslot of the guest.
>>> Also all dirty bits of a segment are set once on s390x when one
>>> of the pages of a segment are written to for the first time, so
>>> we have to make sure that we touch all pages during the first
>>> iteration to keep the test in sync here.
>>
>> While this fixes the test (and the migration does work fine), it still
>> means that s390x overindicates the dirty bit for sparsely populated
>> 1M segments. It is just a performance issue, but maybe we should try 
>> to get this fixed.
> 
> I hope you don't expect me to fix this - the gmap code is really not my
> turf...

No, this is clearly on our turf. 
> 
>> Not sure what to do here to remember us about this, 
>> adding this as expected fail?
> 
> There is no such thing like an expected failure in KVM selftests -
> that's only available in kvm-unit-tests.
> 
> So the only option that I currently see is to add a printf("TODO: ...")
> on s390x here... would that work for you?

Maybe just keep this as is - we should just not forget about it.
