Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237143AbhA0Ml0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Jan 2021 07:41:26 -0500
Subject: Re: [kvm-unit-tests PATCH v5 0/3] s390x: css: pv: css test adaptation
 for PV
References: <1611322060-1972-1-git-send-email-pmorel@linux.ibm.com>
 <6c141deb-819a-ef03-f44c-bd61561a2087@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <6e253468-160c-fc5b-65fc-56e8a8c67758@linux.ibm.com>
Date: Wed, 27 Jan 2021 13:40:39 +0100
MIME-Version: 1.0
In-Reply-To: <6c141deb-819a-ef03-f44c-bd61561a2087@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/27/21 1:37 PM, Janosch Frank wrote:
> On 1/22/21 2:27 PM, Pierre Morel wrote:
>> Hi all,
>>    
>> To adapt the CSS I/O tests to protected virtualisation we need
>> utilities to:
>>
>> 1- allocate the I/O buffers in a private page using (patch 2)
>>     It must be in a dedicated page to avoid exporting code or
>>     guest private data to the host.
>>     We accept a size in byte and flags and allocate page integral
>>     memory to handle the Protected Virtualization.
>>   
>> 2- share the I/O buffers with the host (patch 1)
>>     This patch uses the page allocator reworked by Claudio.
>>   
>> The 2 first patches are the implementation of the tools,
>> patch 3 is the modification of the css.c test for PV.
>>
>> The checkpatch always asked me to modify MAINTAINERS,
>> so I added me as reviewer to be in copy for CSS at least.
>> May be we could create a finer grain MAINTAINERS in the
>> future.
>>
>> regards,
>> Pierre
> 
> Thanks, picked.

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
