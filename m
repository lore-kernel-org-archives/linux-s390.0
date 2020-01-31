Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47483 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728500AbgAaN7J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Jan 2020 08:59:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id s13so3372635wru.7
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 05:59:06 -0800 (PST)
Subject: Re: [PATCH v10 4/6] selftests: KVM: Add fpu and one reg set/get
 library functions
References: <20200131100205.74720-1-frankja@linux.ibm.com>
 <20200131100205.74720-5-frankja@linux.ibm.com>
 <6a990f23-832b-86f7-28bf-761e84fd33fb@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75bddb63-fb5a-90b0-64bf-2de1d53f2b82@redhat.com>
Date: Fri, 31 Jan 2020 14:59:01 +0100
MIME-Version: 1.0
In-Reply-To: <6a990f23-832b-86f7-28bf-761e84fd33fb@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 31/01/20 12:43, Christian Borntraeger wrote:
> Paolo,
> 
> are you ok with me taking this patch for my s390 pull request to you?
> Ideally still for 5.6?

Yes to both questions, of course.

Paolo

> On 31.01.20 11:02, Janosch Frank wrote:
>> Add library access to more registers.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  .../testing/selftests/kvm/include/kvm_util.h  |  6 ++++
>>  tools/testing/selftests/kvm/lib/kvm_util.c    | 36 +++++++++++++++++++
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> index 29cccaf96baf..ae0d14c2540a 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -125,6 +125,12 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>>  		    struct kvm_sregs *sregs);
>>  int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>>  		    struct kvm_sregs *sregs);
>> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
>> +		  struct kvm_fpu *fpu);
>> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
>> +		  struct kvm_fpu *fpu);
>> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
>> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
>>  #ifdef __KVM_HAVE_VCPU_EVENTS
>>  void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>>  		     struct kvm_vcpu_events *events);
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index 41cf45416060..a6dd0401eb50 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -1373,6 +1373,42 @@ int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
>>  	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
>>  }
>>
>> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
>> +{
>> +	int ret;
>> +
>> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
>> +	TEST_ASSERT(ret == 0, "KVM_GET_FPU failed, rc: %i errno: %i (%s)",
>> +		    ret, errno, strerror(errno));
>> +}
>> +
>> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
>> +{
>> +	int ret;
>> +
>> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
>> +	TEST_ASSERT(ret == 0, "KVM_SET_FPU failed, rc: %i errno: %i (%s)",
>> +		    ret, errno, strerror(errno));
>> +}
>> +
>> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
>> +{
>> +	int ret;
>> +
>> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
>> +	TEST_ASSERT(ret == 0, "KVM_GET_ONE_REG failed, rc: %i errno: %i (%s)",
>> +		    ret, errno, strerror(errno));
>> +}
>> +
>> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
>> +{
>> +	int ret;
>> +
>> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
>> +	TEST_ASSERT(ret == 0, "KVM_SET_ONE_REG failed, rc: %i errno: %i (%s)",
>> +		    ret, errno, strerror(errno));
>> +}
>> +
>>  /*
>>   * VCPU Ioctl
>>   *
>>
> 
