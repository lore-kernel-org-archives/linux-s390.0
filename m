Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732244AbhAUN0O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 08:26:14 -0500
Subject: Re: [kvm-unit-tests PATCH v4 3/3] s390x: css: pv: css test adaptation
 for PV
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
 <b9d65d43-6a72-802f-127d-6b66d7ccc32c@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <c2f435b3-2f3f-765d-36b2-b520f8564951@linux.ibm.com>
Date: Thu, 21 Jan 2021 14:25:27 +0100
MIME-Version: 1.0
In-Reply-To: <b9d65d43-6a72-802f-127d-6b66d7ccc32c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/21/21 10:57 AM, Janosch Frank wrote:
> On 1/21/21 10:13 AM, Pierre Morel wrote:
>> We want the tests to automatically work with or without protected
>> virtualisation.
>> To do this we need to share the I/O memory with the host.
>>
>> Let's replace all static allocations with dynamic allocations
>> to clearly separate shared and private memory.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> Acked-by: Janosch Frank <frankja@de.ibm.com>

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
