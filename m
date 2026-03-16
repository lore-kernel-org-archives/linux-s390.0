Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F62EA16A;
	Mon, 16 Mar 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672438; cv=none; b=cdMkAKrzB2XsEYOp7Cuec6EaLnEPNpVSms/EtLZX973kBuSGBYwjdGS85+BFKl0ZgT6nnaDYgLrq0bVBAoUguh5k5+klBi3XYpoup5ZZ5F+oq41bmcvm469wTkyZCnM58r7YEXie7L4D4+lzYtHmZFn+uHNIs8/RGwvK6VcHRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672438; c=relaxed/simple;
	bh=+Z/h/54tyvQ2WYBNBXUJdP1NqYgE/hvXLmQNrCExWJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkI5N/LGyBteh2Vo0SIj0hdwtVIEdIz9H8XysdqzP9b9g5rko8hO1OOp5eeo2litUnFLBX/ntZPsDt3EZFVei8hHr8Wcq/1fdVdZ3/tCyCmTzpbTkzHSu1LY1BTIGgG7S91j8Z/drD1yysVhXZN2D9Bae8MQ21fBFhNX9ITJwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F/PD+nIp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F/PD+nIp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEfEL7646456;
	Mon, 16 Mar 2026 14:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=auZQzz
	E/e3aNA/WH2lEiBhSu2bZXn4wbGHRE3G0MDYo=; b=F/PD+nIpX8djrLybECOrOH
	sJnciFQ+TFt9PG2nCwEXEdPk1xc+JwMWt5f2XO7PZ/tCOs0GqF9OxZbMD5x9qskc
	M1XjFQBRG2fwRurOKiyTesR6Pa0X1iop1BiSknucyHqBHQ3wp8LWBMRAYGieAN/t
	m0zGkxJVLcfn4F8ubxnq0C92TQ6V9ADeIInCdMqdN84UvuRxLN1BXsR0bA/kJlev
	SNV/rd1oCcq3W1bsnUiYPv+Vf/fP8eZleMi57E5o9cD054kTg+OrYkkbZoVDDgwE
	b59r6UEswsb+Qv/TLC7Dnrj3H6HXuiXHLjETGS4b++mpiXCOO7rsM8k9R4cE6OcA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hr6jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 14:47:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GB2c7h032320;
	Mon, 16 Mar 2026 14:47:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jn1ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 14:47:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GEl8sO27328894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 14:47:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C57020043;
	Mon, 16 Mar 2026 14:47:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F3EC20040;
	Mon, 16 Mar 2026 14:47:08 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 14:47:08 +0000 (GMT)
Message-ID: <46e5720f-bd08-4076-bc10-e6834d58af73@linux.ibm.com>
Date: Mon, 16 Mar 2026 15:47:07 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: s390: vsie: Avoid injecting machine check on
 signal
To: Janosch Frank <frankja@linux.ibm.com>, KVM <kvm@vger.kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260316130947.40466-1-borntraeger@linux.ibm.com>
 <cf8b6d86-0919-4644-aaa3-de3241df2684@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <cf8b6d86-0919-4644-aaa3-de3241df2684@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OBNhQniGnC2o51lKWpS-uAjnCc-NPXDv
X-Proofpoint-ORIG-GUID: OBNhQniGnC2o51lKWpS-uAjnCc-NPXDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExMSBTYWx0ZWRfX6A1N3hlmNKmW
 oP0IPtRjFwrjdBrTo5VlEHcC0Omcu8W6z1RVND0ZquqEN+zqn+Dns//d30PvStg0o9SSQxVy3jG
 DLPxq7HpzYNqVvVgsjqpXCth5O8TgXo2JBsNi6B/lavVX07DGa+tp7pFAl1nt9VFntKfijzZn8K
 Tk0tyrUKFxgz7byCjdQZkS5lIZ4WFnEAn19yIAZRuPUqQ5Cnzf1MK362KtExKcOAGpho04HSNc+
 c5St3KHgyABlNnZ5OsBfvwcE5vBf3fBMS6v0AuPnXbxaTH5ixHWS1T337Dah3aepohRySu4Gaj4
 kAt71VqRRA1nsKPyeBGOHVOuVnMQE2I0ODgXnchF4TkhnIYGtSAKGK5eWDXzvP5yh3B2/Y5LNSx
 w0Je9v5VJZmCWOO4l7SWILcH+3u4+EPTHijULwrWEjz+GEsm5JY3dX45nGgX+DY8EXoba6+sX7I
 yyXd6AVggdXkZ3grgVQ==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b817f1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=55WJwGWxtmJmBke_E0sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160111



Am 16.03.26 um 14:57 schrieb Janosch Frank:
> On 3/16/26 14:09, Christian Borntraeger wrote:
>> The recent XFER_TO_GUEST_WORK change resulted in a situation, where the
>> vsie code would interpret a signal during work as a machine check during
>> SIE as both use the EINTR return code.
>> The exit_reason of the sie64a function has nothing to do with the
>> kvm_run exit_reason. Rename it and define a specific code for machine
>> checks instead of abusing -EINTR.
>> rename exit_reason into sie_return to avoid the naming conflict
>> and change the code flow in vsie.c to have a separate variable for rc
>> and sie_return.
>>
>> Fixes: 2bd1337a1295e ("KVM: s390: Use generic VIRT_XFER_TO_GUEST_WORK functions")
>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> ---
>> v1->v2:
>> instead of a band-aid, make the machine check more direct
>> v2->v3:
>> avoid overloading the rc variable in vsie.c
>>
>>   arch/s390/include/asm/kvm_host.h   |  3 +++
>>   arch/s390/include/asm/stacktrace.h |  2 +-
>>   arch/s390/kernel/asm-offsets.c     |  2 +-
>>   arch/s390/kernel/entry.S           |  4 ++--
>>   arch/s390/kernel/nmi.c             |  4 ++--
>>   arch/s390/kvm/kvm-s390.c           | 15 ++++++++-------
>>   arch/s390/kvm/vsie.c               |  7 +++++--
>>   7 files changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 64a50f0862aa..3039c88daa63 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -710,6 +710,9 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm);
>>   void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
>>                      unsigned long *aqm, unsigned long *adm);
>> +#define SIE64_RETURN_NORMAL    0
>> +#define SIE64_RETURN_MCCK    1
>> +
>>   int __sie64a(phys_addr_t sie_block_phys, struct kvm_s390_sie_block *sie_block, u64 *rsa,
>>            unsigned long gasce);
>> diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
>> index c9ae680a28af..ac3606c3babe 100644
>> --- a/arch/s390/include/asm/stacktrace.h
>> +++ b/arch/s390/include/asm/stacktrace.h
>> @@ -62,7 +62,7 @@ struct stack_frame {
>>           struct {
>>               unsigned long sie_control_block;
>>               unsigned long sie_savearea;
>> -            unsigned long sie_reason;
>> +            unsigned long sie_return;
>>               unsigned long sie_flags;
>>               unsigned long sie_control_block_phys;
>>               unsigned long sie_guest_asce;
>> diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
>> index e1a5b5b54e4f..fbd26f3e9f96 100644
>> --- a/arch/s390/kernel/asm-offsets.c
>> +++ b/arch/s390/kernel/asm-offsets.c
>> @@ -63,7 +63,7 @@ int main(void)
>>       OFFSET(__SF_EMPTY, stack_frame, empty[0]);
>>       OFFSET(__SF_SIE_CONTROL, stack_frame, sie_control_block);
>>       OFFSET(__SF_SIE_SAVEAREA, stack_frame, sie_savearea);
>> -    OFFSET(__SF_SIE_REASON, stack_frame, sie_reason);
>> +    OFFSET(__SF_SIE_RETURN, stack_frame, sie_return);
>>       OFFSET(__SF_SIE_FLAGS, stack_frame, sie_flags);
>>       OFFSET(__SF_SIE_CONTROL_PHYS, stack_frame, sie_control_block_phys);
>>       OFFSET(__SF_SIE_GUEST_ASCE, stack_frame, sie_guest_asce);
>> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
>> index 4873fe9d891b..5817cb47b2d0 100644
>> --- a/arch/s390/kernel/entry.S
>> +++ b/arch/s390/kernel/entry.S
>> @@ -200,7 +200,7 @@ SYM_FUNC_START(__sie64a)
>>       stg    %r3,__SF_SIE_CONTROL(%r15)    # ...and virtual addresses
>>       stg    %r4,__SF_SIE_SAVEAREA(%r15)    # save guest register save area
>>       stg    %r5,__SF_SIE_GUEST_ASCE(%r15)    # save guest asce
>> -    xc    __SF_SIE_REASON(8,%r15),__SF_SIE_REASON(%r15) # reason code = 0
>> +    xc    __SF_SIE_RETURN(8,%r15),__SF_SIE_RETURN(%r15) # return code = 0
>>       mvc    __SF_SIE_FLAGS(8,%r15),__TI_flags(%r14) # copy thread flags
>>       lmg    %r0,%r13,0(%r4)            # load guest gprs 0-13
>>       mvi    __TI_sie(%r14),1
>> @@ -237,7 +237,7 @@ SYM_INNER_LABEL(sie_exit, SYM_L_GLOBAL)
>>       xgr    %r4,%r4
>>       xgr    %r5,%r5
>>       lmg    %r6,%r14,__SF_GPRS(%r15)    # restore kernel registers
>> -    lg    %r2,__SF_SIE_REASON(%r15)    # return exit reason code
>> +    lg    %r2,__SF_SIE_RETURN(%r15)    # return sie return code
>>       BR_EX    %r14
>>   SYM_FUNC_END(__sie64a)
>>   EXPORT_SYMBOL(__sie64a)
>> diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
>> index a55abbf65333..fc1f775e4517 100644
>> --- a/arch/s390/kernel/nmi.c
>> +++ b/arch/s390/kernel/nmi.c
>> @@ -487,8 +487,8 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
>>       mcck_dam_code = (mci.val & MCIC_SUBCLASS_MASK);
>>       if (test_cpu_flag(CIF_MCCK_GUEST) &&
>>       (mcck_dam_code & MCCK_CODE_NO_GUEST) != mcck_dam_code) {
>> -        /* Set exit reason code for host's later handling */
>> -        *((long *)(regs->gprs[15] + __SF_SIE_REASON)) = -EINTR;
>> +        /* Set sie return code for host's later handling */
>> +        *((long *)(regs->gprs[15] + __SF_SIE_RETURN)) = SIE64_RETURN_MCCK;
> 
> We don't need to cast this to long anymore, do we?
> Since sie_return is ulong, and we if we stay with positive numbers ulong would make the most sense.
> 
> Although I'd prefer a cast to stack_frame but I'm unsure if that would make it more readable if we stay with a one line change.
something like
-               *((long *)(regs->gprs[15] + __SF_SIE_RETURN)) = SIE64_RETURN_MCCK;
+               ((struct stack_frame *) regs->gprs[15])->sie_return = SIE64_RETURN_MCCK;

What do you think?

This reminds me that I should probably also make the local variable in vsie.c unsigned long instead of int.


