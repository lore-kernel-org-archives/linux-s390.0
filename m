Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729309AbgFVQp7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 12:45:59 -0400
Subject: Re: [PATCH v9 2/2] s390/kvm: diagnose 0x318 sync and reset
References: <20200622154636.5499-1-walling@linux.ibm.com>
 <20200622154636.5499-3-walling@linux.ibm.com>
 <20200622180459.4cf7cbf4.cohuck@redhat.com>
 <93bd30de-2cd0-a044-4e9b-05b1eda9acb3@linux.ibm.com>
 <cda0b27f-ec26-e596-9814-c4ce81915bcb@linux.ibm.com>
 <20200622183512.3547d21b.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <effbf851-452b-bdf0-6455-3df2ec0b9a87@linux.ibm.com>
Date: Mon, 22 Jun 2020 12:45:51 -0400
MIME-Version: 1.0
In-Reply-To: <20200622183512.3547d21b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On 6/22/20 12:35 PM, Cornelia Huck wrote:
> On Mon, 22 Jun 2020 12:23:45 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> Mind if I get some early feedback for the first run? How does this sound:
>>
>> 8.24 KVM_CAP_S390_DIAG318
>> -------------------------
>>
>> :Architecture: s390
>>
>> This capability allows for information regarding the control program
>> that may be observed via system/firmware service events. The
>> availability of this capability indicates that KVM handling of the
>> register synchronization, reset, and VSIE shadowing of the DIAGNOSE
>> 0x318 related information is present.
>>
>> The information associated with the instruction is an 8-byte value
>> consisting of a one-byte Control Program Name Code (CPNC), and a 7-byte
>> Control Program Version Code (CPVC). The CPNC determines what
>> environment the control program is running in (e.g. Linux, z/VM...), and
>> the CPVC is used for extraneous information specific to OS (e.g. Linux
>> version, Linux distribution...)
>>
>> The CPNC must be stored in the SIE block for the CPU that executes the
>> diag instruction, which is communicated from userspace to KVM via
>> register synchronization using the KVM_SYNC_DIAG318 flag. Both codes are
>> stored together in the kvm_vcpu_arch struct.
> 
> Hm... what about replacing that last paragraph with
> 
> "If this capability is available, the CPNC and CPVC are available for
> synchronization between KVM and userspace via the sync regs mechanism
> (KVM_SYNC_DIAG318)."
> 
> ?
> 

I like it!

-- 
Regards,
Collin

Stay safe and stay healthy
