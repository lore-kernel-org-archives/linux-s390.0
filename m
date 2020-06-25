Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405364AbgFYOmV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 10:42:21 -0400
Subject: Re: [PATCH 1/2] docs: kvm: add documentation for KVM_CAP_S390_DIAG318
References: <20200624202200.28209-1-walling@linux.ibm.com>
 <20200624202200.28209-2-walling@linux.ibm.com>
 <151bb070-f083-5011-2f04-291058bc9cc2@linux.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <0503ff8d-21ad-1e6c-783b-3857bda76161@linux.ibm.com>
Date: Thu, 25 Jun 2020 10:42:15 -0400
MIME-Version: 1.0
In-Reply-To: <151bb070-f083-5011-2f04-291058bc9cc2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On 6/25/20 3:16 AM, Janosch Frank wrote:
> On 6/24/20 10:21 PM, Collin Walling wrote:
>> Documentation for the s390 DIAGNOSE 0x318 instruction handling.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  Documentation/virt/kvm/api.rst | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 426f94582b7a..056608e8f243 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6150,3 +6150,22 @@ KVM can therefore start protected VMs.
>>  This capability governs the KVM_S390_PV_COMMAND ioctl and the
>>  KVM_MP_STATE_LOAD MP_STATE. KVM_SET_MP_STATE can fail for protected
>>  guests when the state change is invalid.
>> +
>> +8.24 KVM_CAP_S390_DIAG318
>> +-------------------------
>> +
>> +:Architecture: s390
>> +
>> +This capability allows for information regarding the control program that may
>> +be observed via system/firmware service events. The availability of this
> 
> I'm not sure if control program is understood universally, it's a rather
> old term to say guest kernel.
> 
> How about:
> 
> This capability allows a guest to set information about its control
> program (i.e. guest kernel type and version). The information is helpful
> on system/firmware service events, providing additional data about what
> environments are running on the machine.
> 
> 

Fair point. I'll add some clarity to this.

>> +capability indicates that KVM handling of the register synchronization, reset,
>> +and VSIE shadowing of the DIAGNOSE 0x318 related information is present.
>> +
>> +The information associated with the instruction is an 8-byte value consisting
>> +of a one-byte Control Program Name Code (CPNC), and a 7-byte Control Program
>> +Version Code (CPVC). The CPNC determines what environment the control program
>> +is running in (e.g. Linux, z/VM...), and the CPVC is used for extraneous
>> +information specific to OS (e.g. Linux version, Linux distribution...)
>> +
>> +If this capability is available, then the CPNC and CPVC can be synchronized
>> +between KVM and userspace via the sync regs mechanism (KVM_SYNC_DIAG318).
>>
> 
> 


-- 
Regards,
Collin

Stay safe and stay healthy
