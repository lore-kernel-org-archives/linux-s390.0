Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50484 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727024AbgA3LKk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 06:10:40 -0500
Subject: Re: [PATCH v8 4/4] selftests: KVM: testing the local IRQs resets
References: <20200129200312.3200-1-frankja@linux.ibm.com>
 <20200129200312.3200-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a9fd8939-503e-bf11-7f5e-bb83a79a1bf9@redhat.com>
Date: Thu, 30 Jan 2020 12:10:29 +0100
MIME-Version: 1.0
In-Reply-To: <20200129200312.3200-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 29/01/2020 21.03, Janosch Frank wrote:
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
> ---
>  tools/testing/selftests/kvm/s390x/resets.c | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
> index 2b2378cc9e80..299c1686f98c 100644
> --- a/tools/testing/selftests/kvm/s390x/resets.c
> +++ b/tools/testing/selftests/kvm/s390x/resets.c
> @@ -14,6 +14,9 @@
>  #include "kvm_util.h"
>  
>  #define VCPU_ID 3
> +#define LOCAL_IRQS 32
> +
> +struct kvm_s390_irq buf[VCPU_ID + LOCAL_IRQS];
>  
>  struct kvm_vm *vm;
>  struct kvm_run *run;
> @@ -52,6 +55,29 @@ static void test_one_reg(uint64_t id, uint64_t value)
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
> +
> +	irq_state.len = sizeof(buf);
> +	irq_state.buf = (unsigned long)buf;
> +	irqs = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_GET_IRQ_STATE, &irq_state);
> +	/*
> +	 * irqs contains the number of retrieved interrupts, apart from the
> +	 * emergency call that should be cleared by the resets, there should be
> +	 * none.
> +	 */
> +	if (irqs < 0)
> +		printf("Error by getting IRQ: errno %d\n", errno);
> +
> +	TEST_ASSERT(!irqs, "IRQ pending");
> +}
> +
>  static void assert_clear(void)
>  {
>  	struct kvm_sregs sregs;
> @@ -93,6 +119,31 @@ static void assert_initial(void)
>  static void assert_normal(void)
>  {
>  	test_one_reg(KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
> +	assert_noirq();
> +}
> +
> +static int inject_irq(int cpu_id)
> +{
> +	struct kvm_s390_irq_state irq_state;
> +	struct kvm_s390_irq *irq = &buf[0];
> +	int irqs;
> +
> +	if (!(kvm_check_cap(KVM_CAP_S390_INJECT_IRQ) &&
> +	    kvm_check_cap(KVM_CAP_S390_IRQ_STATE)))
> +		return 0;
> +
> +	/* Inject IRQ */
> +	irq_state.len = sizeof(struct kvm_s390_irq);
> +	irq_state.buf = (unsigned long)buf;
> +	irq->type = KVM_S390_INT_EMERGENCY;
> +	irq->u.emerg.code = cpu_id;
> +	irqs = _vcpu_ioctl(vm, cpu_id, KVM_S390_SET_IRQ_STATE, &irq_state);
> +	if (irqs < 0) {
> +		printf("Error by injecting INT_EMERGENCY: errno %d\n", errno);
> +		return errno;
> +	}

Can you turn this into a TEST_ASSERT() instead? Otherwise the printf()
error might go unnoticed.

Apart from that (and the nits that Cornelia already mentioned), the
patch looks fine to me.

 Thomas
