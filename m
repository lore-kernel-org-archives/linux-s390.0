Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24093 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727263AbgA3Q2M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jan 2020 11:28:12 -0500
Date: Thu, 30 Jan 2020 17:27:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 6/6] selftests: KVM: testing the local IRQs resets
Message-ID: <20200130172757.09b1bbed.cohuck@redhat.com>
In-Reply-To: <20200130123434.68129-7-frankja@linux.ibm.com>
References: <20200130123434.68129-1-frankja@linux.ibm.com>
        <20200130123434.68129-7-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org

On Thu, 30 Jan 2020 07:34:34 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> Local IRQs are reset by a normal cpu reset.  The initial cpu reset and
> the clear cpu reset, as superset of the normal reset, both clear the
> IRQs too.
> 
> Let's inject an interrupt to a vCPU before calling a reset and see if
> it is gone after the reset.
> 
> We choose to inject only an emergency interrupt at this point and can
> extend the test to other types of IRQs later.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>[minor fixups]
> ---
>  tools/testing/selftests/kvm/s390x/resets.c | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
> index 4e173517f909..8a2507930e7d 100644
> --- a/tools/testing/selftests/kvm/s390x/resets.c
> +++ b/tools/testing/selftests/kvm/s390x/resets.c
> @@ -14,6 +14,9 @@
>  #include "kvm_util.h"
>  
>  #define VCPU_ID 3
> +#define LOCAL_IRQS 32

The choice of 32 here is still a bit unclear (although not a problem).

> +
> +struct kvm_s390_irq buf[VCPU_ID + LOCAL_IRQS];
>  
>  struct kvm_vm *vm;
>  struct kvm_run *run;
> @@ -53,6 +56,27 @@ static void test_one_reg(uint64_t id, uint64_t value)
>  	TEST_ASSERT(eval_reg == value, "value == %s", value);
>  }
>  
> +static void assert_noirq(void)
> +{
> +	struct kvm_s390_irq_state irq_state;
> +	int irqs;
> +
> +	if (!(kvm_check_cap(KVM_CAP_S390_INJECT_IRQ) &&
> +	    kvm_check_cap(KVM_CAP_S390_IRQ_STATE)))
> +		return;

I think you should drop the capability check here as well.

> +
> +	irq_state.len = sizeof(buf);
> +	irq_state.buf = (unsigned long)buf;
> +	irqs = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_GET_IRQ_STATE, &irq_state);
> +	/*
> +	 * irqs contains the number of retrieved interrupts, apart from the
> +	 * emergency call that should be cleared by the resets, there should be
> +	 * none.

What about the updated comment? :)

> +	 */
> +	TEST_ASSERT(irqs >= 0, "Could not fetch IRQs: errno %d\n", errno);
> +	TEST_ASSERT(!irqs, "IRQ pending");
> +}
> +
>  static void assert_clear(void)
>  {
>  	struct kvm_sregs sregs;

Else, looks sane to me.
