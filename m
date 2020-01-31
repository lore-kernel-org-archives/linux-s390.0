Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728479AbgAaMSr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 07:18:47 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VCHnNV065917
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 07:18:46 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xvfy91qy8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 07:18:45 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 12:18:43 -0000
Subject: Re: [PATCH v10 4/6] selftests: KVM: Add fpu and one reg set/get
 library functions
References: <20200131100205.74720-1-frankja@linux.ibm.com>
 <20200131100205.74720-5-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 31 Jan 2020 13:18:39 +0100
MIME-Version: 1.0
In-Reply-To: <20200131100205.74720-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8fe67b28-a329-25fa-0ccf-f45fd84b527f@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org



On 31.01.20 11:02, Janosch Frank wrote:
> Add library access to more registers.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

thanks applied (assuming Paolos agreement)
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  6 ++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 36 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
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
> index 41cf45416060..a6dd0401eb50 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1373,6 +1373,42 @@ int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
>  	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
>  }
>  
> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
> +{
> +	int ret;
> +
> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
> +	TEST_ASSERT(ret == 0, "KVM_GET_FPU failed, rc: %i errno: %i (%s)",
> +		    ret, errno, strerror(errno));
> +}
> +
> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
> +{
> +	int ret;
> +
> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
> +	TEST_ASSERT(ret == 0, "KVM_SET_FPU failed, rc: %i errno: %i (%s)",
> +		    ret, errno, strerror(errno));
> +}
> +
> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
> +{
> +	int ret;
> +
> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
> +	TEST_ASSERT(ret == 0, "KVM_GET_ONE_REG failed, rc: %i errno: %i (%s)",
> +		    ret, errno, strerror(errno));
> +}
> +
> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
> +{
> +	int ret;
> +
> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
> +	TEST_ASSERT(ret == 0, "KVM_SET_ONE_REG failed, rc: %i errno: %i (%s)",
> +		    ret, errno, strerror(errno));
> +}
> +
>  /*
>   * VCPU Ioctl
>   *
> 
