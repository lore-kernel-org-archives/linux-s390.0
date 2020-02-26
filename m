Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727686AbgBZLDm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Feb 2020 06:03:42 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QAu3qY189015
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 06:03:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yden0yqnv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 06:03:36 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 26 Feb 2020 11:03:22 -0000
Subject: Re: [PATCH v4.5 09/36] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <f80a0b58-5ed2-33b7-5292-2c4899d765b7@redhat.com>
 <20200225214822.3611-1-borntraeger@de.ibm.com>
 <20200226113840.46880055.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Feb 2020 12:03:16 +0100
MIME-Version: 1.0
In-Reply-To: <20200226113840.46880055.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ce81be7c-c62e-735d-7989-920daa9abadd@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: david@redhat.com, Ulrich.Weigand@de.ibm.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 26.02.20 11:38, Cornelia Huck wrote:
> On Tue, 25 Feb 2020 16:48:22 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> This contains 3 main changes:
>> 1. changes in SIE control block handling for secure guests
>> 2. helper functions for create/destroy/unpack secure guests
>> 3. KVM_S390_PV_COMMAND ioctl to allow userspace dealing with secure
>> machines
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  24 ++-
>>  arch/s390/include/asm/uv.h       |  69 ++++++++
>>  arch/s390/kvm/Makefile           |   2 +-
>>  arch/s390/kvm/kvm-s390.c         | 209 +++++++++++++++++++++++-
>>  arch/s390/kvm/kvm-s390.h         |  33 ++++
>>  arch/s390/kvm/pv.c               | 269 +++++++++++++++++++++++++++++++
>>  include/uapi/linux/kvm.h         |  31 ++++
>>  7 files changed, 633 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/s390/kvm/pv.c
> 
>> +int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
>> +{
>> +		struct uv_cb_cgc uvcb = {
> 
> Broken indentation.

Fixes.

> 
>> +		.header.cmd = UVC_CMD_CREATE_SEC_CONF,
>> +		.header.len = sizeof(uvcb)
>> +	};
>> +	int cc, ret;
>> +	u16 dummy;
>> +
>> +	ret = kvm_s390_pv_alloc_vm(kvm);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Inputs */
>> +	uvcb.guest_stor_origin = 0; /* MSO is 0 for KVM */
> 
> What is 'MSO'? (i.e., where is that 'M' coming from?)

Origin. (the one for the sie block).

> 
>> +	uvcb.guest_stor_len = kvm->arch.pv.guest_len;
>> +	uvcb.guest_asce = kvm->arch.gmap->asce;
>> +	uvcb.guest_sca = (unsigned long)kvm->arch.sca;
>> +	uvcb.conf_base_stor_origin = (u64)kvm->arch.pv.stor_base;
>> +	uvcb.conf_virt_stor_origin = (u64)kvm->arch.pv.stor_var;
>> +
>> +	cc = uv_call(0, (u64)&uvcb);
>> +	*rc = uvcb.header.rc;
>> +	*rrc = uvcb.header.rrc;
>> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT CREATE VM: handle %llx len %llx rc %x rrc %x",
>> +		     uvcb.guest_handle, uvcb.guest_stor_len, *rc, *rrc);
>> +
>> +	/* Outputs */
>> +	kvm->arch.pv.handle = uvcb.guest_handle;
> 
> Is this valid if the call failed?

if not we would clear it below
> 
>> +
>> +	if (cc) {
>> +		if (uvcb.header.rc & UVC_RC_NEED_DESTROY)
>> +			kvm_s390_pv_deinit_vm(kvm, &dummy, &dummy);

		here

>> +		else
>> +			kvm_s390_pv_dealloc_vm(kvm);

		or here

>> +		return -EIO;
>> +	}
>> +	kvm->arch.gmap->guest_handle = uvcb.guest_handle;
> 
> ...especially as you assign that handle only down here.


> 
>> +	atomic_set(&kvm->mm->context.is_protected, 1);
>> +	return 0;
>> +}
>> +
>> +int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
>> +			      u16 *rrc)
>> +{
>> +	struct uv_cb_ssc uvcb = {
>> +		.header.cmd = UVC_CMD_SET_SEC_CONF_PARAMS,
>> +		.header.len = sizeof(uvcb),
>> +		.sec_header_origin = (u64)hdr,
>> +		.sec_header_len = length,
>> +		.guest_handle = kvm_s390_pv_get_handle(kvm),
>> +	};
>> +	int cc = uv_call(0, (u64)&uvcb);
>> +
>> +	*rc = uvcb.header.rc;
>> +	*rrc = uvcb.header.rrc;
>> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM SET PARMS: rc %x rrc %x",
>> +		     *rc, *rrc);
>> +	if (cc)
>> +		return -EINVAL;
>> +	return 0;
> 
> Maybe
> 	return cc ? -EINVAL : 0;

Yes.
