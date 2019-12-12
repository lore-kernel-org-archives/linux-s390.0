Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729457AbfLLNfx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 08:35:53 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCDWBCD095681
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 08:35:52 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wr8m12x1n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 08:35:52 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 12 Dec 2019 13:35:49 -0000
Subject: Re: [kvm-unit-tests PATCH v4 3/9] s390x: interrupt registration
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-4-git-send-email-pmorel@linux.ibm.com>
 <a60310e3-baac-65b7-ee4f-d2ec913c3600@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 12 Dec 2019 14:35:45 +0100
MIME-Version: 1.0
In-Reply-To: <a60310e3-baac-65b7-ee4f-d2ec913c3600@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a146433c-40b8-772e-19af-f6530379c1d6@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2019-12-12 10:41, Janosch Frank wrote:
> On 12/11/19 4:46 PM, Pierre Morel wrote:
>> Define two functions to register and to unregister a call back for IO
>> Interrupt handling.
>>
>> Per default we keep the old behavior, so does a successful unregister
>> of the callback.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Nearly forgot this:
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 

:)

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
