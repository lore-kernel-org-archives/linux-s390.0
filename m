Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgKKI1A (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Nov 2020 03:27:00 -0500
Subject: Re: [PATCH] kvm: s390: pv: Mark mm as protected after the set secure
 parameters and improve cleanup
References: <20201030140141.106641-1-frankja@linux.ibm.com>
 <f4381509-bf28-2159-b5a6-7dd9e9ee4816@de.ibm.com>
 <fbb49f93-0b73-f1b4-1630-6c973058a420@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <fd5a1f1b-1e4f-b9f1-6dc8-a7da90a655fe@de.ibm.com>
Date: Wed, 11 Nov 2020 09:26:53 +0100
MIME-Version: 1.0
In-Reply-To: <fbb49f93-0b73-f1b4-1630-6c973058a420@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, thuth@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

On 11.11.20 09:17, Janosch Frank wrote:
> On 10/30/20 3:23 PM, Christian Borntraeger wrote:
>> On 30.10.20 15:01, Janosch Frank wrote:
>>> We can only have protected guest pages after a successful set secure
>>> parameters call as only then the UV allows imports and unpacks.
>>>
>>> By moving the test we can now also check for it in s390_reset_acc()
>>> and do an early return if it is 0.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>
>> Can we check this into devel to give it some test coverage?
> 
> I think this also lacks:
> Fixes: 29b40f105ec8 ("KVM: s390: protvirt: Add initial vm and cpu
> lifecycle handling")

Yes, it does. I will schedule for kvm/master.
