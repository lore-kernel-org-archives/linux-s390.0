Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729127AbhAVPpL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 Jan 2021 10:45:11 -0500
Subject: Re: [kvm-unit-tests PATCH v5 1/3] s390x: pv: implement routine to
 share/unshare memory
References: <1611322060-1972-1-git-send-email-pmorel@linux.ibm.com>
 <1611322060-1972-2-git-send-email-pmorel@linux.ibm.com>
 <9c488fa9-9b65-ea7f-124e-f9468dc05a54@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <bf4e68f2-6134-e85c-8bd5-4966852f7481@linux.ibm.com>
Date: Fri, 22 Jan 2021 16:44:23 +0100
MIME-Version: 1.0
In-Reply-To: <9c488fa9-9b65-ea7f-124e-f9468dc05a54@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/22/21 2:33 PM, Janosch Frank wrote:
> On 1/22/21 2:27 PM, Pierre Morel wrote:
>> When communicating with the host we need to share part of
>> the memory.
>>
>> Let's implement the ultravisor calls for this.
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Thanks,
Pierre

...snip...

-- 
Pierre Morel
IBM Lab Boeblingen
