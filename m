Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfIDJGh (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 4 Sep 2019 05:06:37 -0400
Subject: Re: [PATCH v2 2/2] KVM: selftests: Test invalid bits in
 kvm_valid_regs and kvm_dirty_regs on s390x
References: <20190904085200.29021-1-thuth@redhat.com>
 <20190904085200.29021-3-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ca031254-adff-b321-0aa7-385ae3332898@redhat.com>
Date: Wed, 4 Sep 2019 11:06:34 +0200
MIME-Version: 1.0
In-Reply-To: <20190904085200.29021-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 04.09.19 10:52, Thomas Huth wrote:
> Now that we disallow invalid bits in kvm_valid_regs and kvm_dirty_regs
> on s390x, too, we should also check this condition in the selftests.
> The code has been taken from the x86-version of the sync_regs_test.
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../selftests/kvm/s390x/sync_regs_test.c      | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> index bbc93094519b..d5290b4ad636 100644
> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> @@ -85,6 +85,36 @@ int main(int argc, char *argv[])
>  
>  	run = vcpu_state(vm, VCPU_ID);
>  
> +	/* Request reading invalid register set from VCPU. */
> +	run->kvm_valid_regs = INVALID_SYNC_FIELD;
> +	rv = _vcpu_run(vm, VCPU_ID);
> +	TEST_ASSERT(rv < 0 && errno == EINVAL,
> +		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
> +		    rv);
> +	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
> +
> +	run->kvm_valid_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
> +	rv = _vcpu_run(vm, VCPU_ID);
> +	TEST_ASSERT(rv < 0 && errno == EINVAL,
> +		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
> +		    rv);
> +	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
> +
> +	/* Request setting invalid register set into VCPU. */
> +	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
> +	rv = _vcpu_run(vm, VCPU_ID);
> +	TEST_ASSERT(rv < 0 && errno == EINVAL,
> +		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
> +		    rv);
> +	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
> +
> +	run->kvm_dirty_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
> +	rv = _vcpu_run(vm, VCPU_ID);
> +	TEST_ASSERT(rv < 0 && errno == EINVAL,
> +		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
> +		    rv);
> +	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
> +
>  	/* Request and verify all valid register sets. */
>  	run->kvm_valid_regs = TEST_SYNC_FIELDS;
>  	rv = _vcpu_run(vm, VCPU_ID);
> 

Looks sane to me.

-- 

Thanks,

David / dhildenb
