Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727020AbgBSLGi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 06:06:38 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JB5FQQ129546
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 06:06:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubx07yd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 06:06:36 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 19 Feb 2020 11:06:35 -0000
Subject: Re: [PATCH v2 32/42] KVM: s390: protvirt: Support cmd 5 operation
 state
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-33-borntraeger@de.ibm.com>
 <f84bdd3a-a305-9bc1-af92-0b1ff36bfca8@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Feb 2020 12:06:27 +0100
MIME-Version: 1.0
In-Reply-To: <f84bdd3a-a305-9bc1-af92-0b1ff36bfca8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <31c40864-4f34-42b2-0435-f0580033f1d1@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 18.02.20 10:50, David Hildenbrand wrote:
> On 14.02.20 23:26, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Code 5 for the set cpu state UV call tells the UV to load a PSW from
>> the SE header (first IPL) or from guest location 0x0 (diag 308 subcode
>> 0/1). Also it sets the cpu into operating state afterwards, so we can
>> start it.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/uv.h | 1 +
>>  arch/s390/kvm/kvm-s390.c   | 8 ++++++++
>>  include/uapi/linux/kvm.h   | 1 +
>>  3 files changed, 10 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index 7b82881ec3b4..d59825d95b9d 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -169,6 +169,7 @@ struct uv_cb_unp {
>>  #define PV_CPU_STATE_OPR	1
>>  #define PV_CPU_STATE_STP	2
>>  #define PV_CPU_STATE_CHKSTP	3
>> +#define PV_CPU_STATE_OPR_LOAD	5
>>  
>>  struct uv_cb_cpu_set_state {
>>  	struct uv_cb_header header;
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 5426b01e3da1..b6113285f47f 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4656,6 +4656,14 @@ static int kvm_s390_handle_pv_vcpu(struct kvm_vcpu *vcpu,
>>  		r = kvm_s390_pv_destroy_cpu(vcpu, &cmd->rc, &cmd->rrc);
>>  		break;
>>  	}
>> +	case KVM_PV_VCPU_SET_IPL_PSW: {
>> +		if (!kvm_s390_pv_handle_cpu(vcpu))
>> +			return -EINVAL;
>> +
>> +		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD,
>> +					      &cmd->rc, &cmd->rrc);
> 
> Can we squeeze that into kvm_arch_vcpu_ioctl_set_mpstate() instead? The
> interface seems to do exactly what you want it to do.
> 
> KVM_MP_STATE_OPERATING_LOAD
> 
> Allow it only when in PV.

Ack, something like this seems to work.


diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a95c82089386..9496616cccc7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3710,6 +3710,12 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
                kvm_s390_vcpu_start(vcpu);
                break;
        case KVM_MP_STATE_LOAD:
+               if (!kvm_s390_pv_cpu_is_protected(vcpu)) {
+                       rc = -ENXIO;
+                       break;
+               }
+               kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);
+               break;
        case KVM_MP_STATE_CHECK_STOP:
                /* fall through - CHECK_STOP and LOAD are not supported yet */
        default:
