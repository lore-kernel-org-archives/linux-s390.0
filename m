Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731390AbgFPQIW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 12:08:22 -0400
Subject: Re: [kvm-unit-tests PATCH v9 01/12] s390x: Use PSW bits definitions
 in cstart
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-2-git-send-email-pmorel@linux.ibm.com>
 <f160d328-694a-4476-4863-c49a1d0e5349@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <eebf1927-f1b2-cca0-529a-9a97c761345d@linux.ibm.com>
Date: Tue, 16 Jun 2020 18:08:14 +0200
MIME-Version: 1.0
In-Reply-To: <f160d328-694a-4476-4863-c49a1d0e5349@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-16 15:13, Thomas Huth wrote:
> On 15/06/2020 11.31, Pierre Morel wrote:
>> This patch defines the PSW bits EA/BA used to initialize the PSW masks
>> for exceptions.

...snip...

>>   svc_int_psw:
>> -	.quad	0x0000000180000000, svc_int
>> +	.quad	PSW_MASK_ON_EXCEPTION, svc_int
>>   initial_cr0:
>>   	/* enable AFP-register control, so FP regs (+BFP instr) can be used */
>>   	.quad	0x0000000000040000
>>
> 
> I'm afraid, by when I compile this on RHEL7, the toolchain complains:
> 
> s390x/cstart64.S: Assembler messages:
> s390x/cstart64.S:239: Error: found 'L', expected: ')'
> s390x/cstart64.S:239: Error: junk at end of line, first unrecognized
...snip...
> character is `L'
> s390x/cstart64.S:254: Error: junk at end of line, first unrecognized
> character is `L'
> 
> Shall we skip the update to the assembler file for now?

I think it is the best to do to go rapidly forward.

alternative:
I propose a local macro for the PSW_MASK_ON_EXCEPTION and 
PSW_MASK_SHORT_PSW inside the assembler in the respin, put it at the end 
of the serie and we choose if we keep the changes of csstart.S

this would not slow us.

Should I keep your RB for the arch_def.h ?

thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
