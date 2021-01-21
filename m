Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387569AbhAUPsb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 10:48:31 -0500
Subject: Re: [kvm-unit-tests PATCH v4 2/3] s390x: define UV compatible I/O
 allocation
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-3-git-send-email-pmorel@linux.ibm.com>
 <6c232520-dbd1-80e4-e3a3-949964df7403@linux.ibm.com>
 <3bce47db-c58c-6a2e-be72-9953f16a2dd4@linux.ibm.com>
 <0a46a299-c52d-2c7f-bb38-8d58afe053e0@redhat.com>
 <ab6a5d6d-29e1-4ccd-64dd-6e39888cb439@linux.ibm.com>
 <e32a6fba-0d93-3468-e180-f9b157146daf@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <c6fce8e1-80a0-4484-7812-b6f31c2c073a@linux.ibm.com>
Date: Thu, 21 Jan 2021 16:47:44 +0100
MIME-Version: 1.0
In-Reply-To: <e32a6fba-0d93-3468-e180-f9b157146daf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/21/21 2:56 PM, Thomas Huth wrote:
> On 21/01/2021 14.47, Pierre Morel wrote:
> [...]
>> For MAINTAINERS, the Linux kernel checkpatch warns that we should use
>> TABS instead of SPACES between item and names.
> 
> Interesting, I wasn't aware of that. I guess it's simply because the 
> MAINTAINERS file in kvm-unit-tests is older than the patch that changed 
> the checkpatch script in the kernel, and updates to the MAINTAINRS file 
> in k-u-t are so seldom that nobody really noticed afterwards.
> 
> If it bothers you, feel free to send a patch to fix k-u-t's MAINTAINERS 
> file, it might be nice indeed to be aligned with the kernel here again.
> 
>   Thomas
> 
> 

OK, I will do,
Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
