Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24586 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbgBSTgS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 14:36:18 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JJXtWP075459
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 14:36:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y92xdgv85-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 14:36:15 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 19 Feb 2020 19:36:13 -0000
Subject: Re: [PATCH v2 31/42] KVM: s390: protvirt: Report CPU state to
 Ultravisor
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-32-borntraeger@de.ibm.com>
 <33cffbe7-9d87-d94f-dc56-6d31ea2e56eb@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Feb 2020 20:36:05 +0100
MIME-Version: 1.0
In-Reply-To: <33cffbe7-9d87-d94f-dc56-6d31ea2e56eb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <7e74ad84-b0ae-9dc1-91cc-52be989d6c34@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 18.02.20 10:48, David Hildenbrand wrote:
> On 14.02.20 23:26, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> VCPU states have to be reported to the ultravisor for SIGP
>> interpretation, kdump, kexec and reboot.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/uv.h | 15 +++++++++++++++
>>  arch/s390/kvm/kvm-s390.c   |  7 ++++++-
>>  arch/s390/kvm/kvm-s390.h   |  2 ++
>>  arch/s390/kvm/pv.c         | 22 ++++++++++++++++++++++
>>  4 files changed, 45 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index 254d5769d136..7b82881ec3b4 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -37,6 +37,7 @@
>>  #define UVC_CMD_UNPACK_IMG		0x0301
>>  #define UVC_CMD_VERIFY_IMG		0x0302
>>  #define UVC_CMD_PREPARE_RESET		0x0320
>> +#define UVC_CMD_CPU_SET_STATE		0x0330
>>  #define UVC_CMD_SET_UNSHARE_ALL		0x0340
>>  #define UVC_CMD_PIN_PAGE_SHARED		0x0341
>>  #define UVC_CMD_UNPIN_PAGE_SHARED	0x0342
>> @@ -58,6 +59,7 @@ enum uv_cmds_inst {
>>  	BIT_UVC_CMD_SET_SEC_PARMS = 11,
>>  	BIT_UVC_CMD_UNPACK_IMG = 13,
>>  	BIT_UVC_CMD_VERIFY_IMG = 14,
>> +	BIT_UVC_CMD_CPU_SET_STATE = 17,
>>  	BIT_UVC_CMD_PREPARE_RESET = 18,
>>  	BIT_UVC_CMD_UNSHARE_ALL = 20,
>>  	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
>> @@ -164,6 +166,19 @@ struct uv_cb_unp {
>>  	u64 reserved38[3];
>>  } __packed __aligned(8);
>>  
>> +#define PV_CPU_STATE_OPR	1
>> +#define PV_CPU_STATE_STP	2
>> +#define PV_CPU_STATE_CHKSTP	3
>> +
>> +struct uv_cb_cpu_set_state {
>> +	struct uv_cb_header header;
>> +	u64 reserved08[2];
>> +	u64 cpu_handle;
>> +	u8  reserved20[7];
>> +	u8  state;
>> +	u64 reserved28[5];
>> +};
>> +
>>  /*
>>   * A common UV call struct for calls that take no payload
>>   * Examples:
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index ad84c1144908..5426b01e3da1 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4396,6 +4396,7 @@ static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
>>  void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
>>  {
>>  	int i, online_vcpus, started_vcpus = 0;
>> +	u16 rc, rrc;
>>  
>>  	if (!is_vcpu_stopped(vcpu))
>>  		return;
>> @@ -4421,7 +4422,8 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
>>  		 */
>>  		__disable_ibs_on_all_vcpus(vcpu->kvm);
>>  	}
>> -
>> +	/* Let's tell the UV that we want to start again */
>> +	kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR, &rc, &rrc);
>>  	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_STOPPED);
>>  	/*
>>  	 * Another VCPU might have used IBS while we were offline.
>> @@ -4436,6 +4438,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>>  {
>>  	int i, online_vcpus, started_vcpus = 0;
>>  	struct kvm_vcpu *started_vcpu = NULL;
>> +	u16 rc, rrc;
>>  
>>  	if (is_vcpu_stopped(vcpu))
>>  		return;
>> @@ -4449,6 +4452,8 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>>  	kvm_s390_clear_stop_irq(vcpu);
>>  
>>  	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOPPED);
>> +	/* Let's tell the UV that we successfully stopped the vcpu */
>> +	kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_STP, &rc, &rrc);
>>  	__disable_ibs_on_vcpu(vcpu);
>>  
>>  	for (i = 0; i < online_vcpus; i++) {
>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
>> index d5503dd0d1e4..1af1e30beead 100644
>> --- a/arch/s390/kvm/kvm-s390.h
>> +++ b/arch/s390/kvm/kvm-s390.h
>> @@ -218,6 +218,8 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
>>  			      u16 *rrc);
>>  int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
>>  		       unsigned long tweak, u16 *rc, u16 *rrc);
>> +int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state, u16 *rc,
>> +			      u16 *rrc);
>>  
>>  static inline bool kvm_s390_pv_is_protected(struct kvm *kvm)
>>  {
>> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
>> index 80169a9b43ec..b4bf6b6eb708 100644
>> --- a/arch/s390/kvm/pv.c
>> +++ b/arch/s390/kvm/pv.c
>> @@ -271,3 +271,25 @@ int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
>>  		KVM_UV_EVENT(kvm, 3, "%s", "PROTVIRT VM UNPACK: successful");
>>  	return ret;
>>  }
>> +
>> +int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state, u16 *rc,
>> +			      u16 *rrc)
>> +{
>> +	struct uv_cb_cpu_set_state uvcb = {
>> +		.header.cmd	= UVC_CMD_CPU_SET_STATE,
>> +		.header.len	= sizeof(uvcb),
>> +		.cpu_handle	= kvm_s390_pv_handle_cpu(vcpu),
>> +		.state		= state,
>> +	};
>> +	int cc;
>> +
>> +	if (!kvm_s390_pv_handle_cpu(vcpu))
> 
> I'd actually prefer to move this to the caller. (and sue the _protected
> variant)

ack this makes sense.
> 
>> +		return -EINVAL;
>> +
>> +	cc = uv_call(0, (u64)&uvcb);
>> +	*rc = uvcb.header.rc;
>> +	*rrc = uvcb.header.rrc;
>> +	if (cc)
>> +		return -EINVAL;
> 
> All return values are ignored. warn instead and make this a void function?

Hmm, I think userspace can trigger errors (e.g. invalid state or invalid point in time)
So Warning is not good.  We should actually return an error to userspace I guess.

by requiring user sigp for protvirt we can minimize the changes.
Something like this on top of the current tree


diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7bc63e0ed740..5c99a0441f70 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2441,6 +2441,8 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	case KVM_S390_PV_COMMAND: {
 		struct kvm_pv_cmd args;
 
+		/* protvirt means user sigp */
+		kvm->arch.user_cpu_state_ctrl = 1;
 		r = 0;
 		if (!is_prot_virt_host()) {
 			r = -EINVAL;
@@ -3702,17 +3704,17 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 
 	switch (mp_state->mp_state) {
 	case KVM_MP_STATE_STOPPED:
-		kvm_s390_vcpu_stop(vcpu);
+		rc = kvm_s390_vcpu_stop(vcpu);
 		break;
 	case KVM_MP_STATE_OPERATING:
-		kvm_s390_vcpu_start(vcpu);
+		rc = kvm_s390_vcpu_start(vcpu);
 		break;
 	case KVM_MP_STATE_LOAD:
 		if (!kvm_s390_pv_cpu_is_protected(vcpu)) {
 			rc = -ENXIO;
 			break;
 		}
-		kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);
+		rc = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);
 		break;
 	case KVM_MP_STATE_CHECK_STOP:
 		/* fall through - CHECK_STOP and LOAD are not supported yet */
@@ -4444,12 +4446,12 @@ static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 	kvm_s390_sync_request(KVM_REQ_ENABLE_IBS, vcpu);
 }
 
-void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
+int kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 {
-	int i, online_vcpus, started_vcpus = 0;
+	int i, online_vcpus, r= 0, started_vcpus = 0;
 
 	if (!is_vcpu_stopped(vcpu))
-		return;
+		return 0;
 
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 1);
 	/* Only one cpu at a time may enter/leave the STOPPED state. */
@@ -4473,7 +4475,8 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 		__disable_ibs_on_all_vcpus(vcpu->kvm);
 	}
 	/* Let's tell the UV that we want to start again */
-	kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR);
+	if (kvm_s390_pv_cpu_is_protected(vcpu))
+		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR);
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_STOPPED);
 	/*
 	 * The real PSW might have changed due to a RESTART interpreted by the
@@ -4488,16 +4491,16 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 	 */
 	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
-	return;
+	return r;
 }
 
-void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
+int kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 {
-	int i, online_vcpus, started_vcpus = 0;
+	int i, online_vcpus, r = 0, started_vcpus = 0;
 	struct kvm_vcpu *started_vcpu = NULL;
 
 	if (is_vcpu_stopped(vcpu))
-		return;
+		return 0;
 
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 0);
 	/* Only one cpu at a time may enter/leave the STOPPED state. */
@@ -4509,7 +4512,8 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 
 	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOPPED);
 	/* Let's tell the UV that we successfully stopped the vcpu */
-	kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_STP);
+	if (kvm_s390_pv_cpu_is_protected(vcpu))
+		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_STP);
 	__disable_ibs_on_vcpu(vcpu);
 
 	for (i = 0; i < online_vcpus; i++) {
@@ -4528,7 +4532,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 	}
 
 	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
-	return;
+	return r;
 }
 
 static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index cd05c1bbda0e..e9e1996d643b 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -333,8 +333,8 @@ void kvm_s390_set_tod_clock(struct kvm *kvm,
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
-void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
-void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
+int kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
+int kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu);
 bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu);
