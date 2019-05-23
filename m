Return-Path: <SRS0=0NiW=TX=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 23 May 2019 19:57:53 +0200
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 2/9] KVM: selftests: Guard struct kvm_vcpu_events with
 __KVM_HAVE_VCPU_EVENTS
Message-ID: <20190523175753.fpfapsh2hg3pjpqe@kamzik.brq.redhat.com>
References: <20190523164309.13345-1-thuth@redhat.com>
 <20190523164309.13345-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523164309.13345-3-thuth@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 23, 2019 at 06:43:02PM +0200, Thomas Huth wrote:
> The struct kvm_vcpu_events code is only available on certain architectures
> (arm, arm64 and x86). To be able to compile kvm_util.c also for other
> architectures, we have to fence the code with __KVM_HAVE_VCPU_EVENTS.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 2 ++
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index a5a4b28f14d8..b8bf961074fe 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -114,10 +114,12 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>  		    struct kvm_sregs *sregs);
>  int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>  		    struct kvm_sregs *sregs);
> +#ifdef __KVM_HAVE_VCPU_EVENTS
>  void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>  		     struct kvm_vcpu_events *events);
>  void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
>  		     struct kvm_vcpu_events *events);
> +#endif
>  #ifdef __x86_64__
>  void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
>  			   struct kvm_nested_state *state);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index ba1359ac504f..08edb8436c47 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1224,6 +1224,7 @@ void vcpu_regs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs)
>  		ret, errno);
>  }
>  
> +#ifdef __KVM_HAVE_VCPU_EVENTS
>  void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>  		     struct kvm_vcpu_events *events)
>  {
> @@ -1249,6 +1250,7 @@ void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
>  	TEST_ASSERT(ret == 0, "KVM_SET_VCPU_EVENTS, failed, rc: %i errno: %i",
>  		ret, errno);
>  }
> +#endif
>  
>  #ifdef __x86_64__
>  void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
> -- 
> 2.21.0
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
