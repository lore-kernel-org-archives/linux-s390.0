Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34339 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgA3Kgf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 05:36:35 -0500
Subject: Re: [PATCH v8 2/4] selftests: KVM: Add fpu and one reg set/get
 library functions
References: <20200129200312.3200-1-frankja@linux.ibm.com>
 <20200129200312.3200-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <72ff36e1-9170-dfb0-4050-f398f9a467eb@redhat.com>
Date: Thu, 30 Jan 2020 11:36:21 +0100
MIME-Version: 1.0
In-Reply-To: <20200129200312.3200-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org, Andrew Jones <drjones@redhat.com>

On 29/01/2020 21.03, Janosch Frank wrote:
> Add library access to more registers.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  6 +++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 48 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 29cccaf96baf..ae0d14c2540a 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -125,6 +125,12 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>  		    struct kvm_sregs *sregs);
>  int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>  		    struct kvm_sregs *sregs);
> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
> +		  struct kvm_fpu *fpu);
> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
> +		  struct kvm_fpu *fpu);
> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
>  #ifdef __KVM_HAVE_VCPU_EVENTS
>  void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>  		     struct kvm_vcpu_events *events);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 41cf45416060..dae117728ec6 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1373,6 +1373,54 @@ int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
>  	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
>  }
>  
> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
> +{
> +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> +	int ret;
> +
> +	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
> +
> +	ret = ioctl(vcpu->fd, KVM_GET_FPU, fpu);
> +	TEST_ASSERT(ret == 0, "KVM_GET_FPU failed, rc: %i errno: %i",
> +		    ret, errno);
> +}
> +
> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
> +{
> +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> +	int ret;
> +
> +	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
> +
> +	ret = ioctl(vcpu->fd, KVM_SET_FPU, fpu);
> +	TEST_ASSERT(ret == 0, "KVM_SET_FPU failed, rc: %i errno: %i",
> +		    ret, errno);
> +}
> +
> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
> +{
> +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> +	int ret;
> +
> +	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
> +
> +	ret = ioctl(vcpu->fd, KVM_GET_ONE_REG, reg);
> +	TEST_ASSERT(ret == 0, "KVM_GET_ONE_REG failed, rc: %i errno: %i",
> +		    ret, errno);
> +}
> +
> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
> +{
> +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> +	int ret;
> +
> +	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
> +
> +	ret = ioctl(vcpu->fd, KVM_SET_ONE_REG, reg);
> +	TEST_ASSERT(ret == 0, "KVM_SET_ONE_REG failed, rc: %i errno: %i",
> +		    ret, errno);
> +}
> +
>  /*
>   * VCPU Ioctl
>   *
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
