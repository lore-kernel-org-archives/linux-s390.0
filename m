From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/2] KVM: s390: use switch vs jump table in priv.c
Date: Tue, 6 Feb 2018 13:32:48 +0100
Message-ID: <6f9b8d0d-56e3-6609-29e5-8b6c33792f0b@redhat.com>
References: <20180206112127.19014-1-borntraeger@de.ibm.com>
 <20180206112127.19014-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180206112127.19014-2-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06.02.2018 12:21, Christian Borntraeger wrote:
> instead of having huge jump tables for function selection,
> lets use normal switch/case statements for the instruction
> handlers in priv.c
> 
> bloat-o-meter shows that the saving are even bigger than
> just the removed jump tables.
> 
> add/remove: 0/11 grow/shrink: 8/0 up/down: 1934/-10246 (-8312)
> Function                                     old     new   delta
> kvm_s390_handle_b2                            42     958    +916
> handle_iske                                  178     558    +380
> handle_rrbe                                  178     546    +368
> kvm_s390_handle_b9                            42     222    +180
> kvm_s390_handle_01                            42      74     +32
> kvm_s390_handle_eb                            42      70     +28
> handle_sckpf                                 176     204     +28
> handle_lctlg                                 628     630      +2
> handle_ptff                                   36       -     -36
> handle_sckpf.part                             78       -     -78
> handle_epsw                                  154       -    -154
> handle_stfl                                  316       -    -316
> handle_rrbe.part                             470       -    -470
> handle_iske.part                             482       -    -482
> handle_io_inst                               518       -    -518
> x01_handlers                                2048       -   -2048
> eb_handlers                                 2048       -   -2048
> b9_handlers                                 2048       -   -2048
> b2_handlers                                 2048       -   -2048
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/priv.c | 183 +++++++++++++++++++++++++--------------------------
>  1 file changed, 91 insertions(+), 92 deletions(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index c4c4e157c036..a74578cdd3f3 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -795,55 +795,60 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>  	return rc;
>  }
>  
> -static const intercept_handler_t b2_handlers[256] = {
> -	[0x02] = handle_stidp,
> -	[0x04] = handle_set_clock,
> -	[0x10] = handle_set_prefix,
> -	[0x11] = handle_store_prefix,
> -	[0x12] = handle_store_cpu_address,
> -	[0x14] = kvm_s390_handle_vsie,
> -	[0x21] = handle_ipte_interlock,
> -	[0x29] = handle_iske,
> -	[0x2a] = handle_rrbe,
> -	[0x2b] = handle_sske,
> -	[0x2c] = handle_test_block,
> -	[0x30] = handle_io_inst,
> -	[0x31] = handle_io_inst,
> -	[0x32] = handle_io_inst,
> -	[0x33] = handle_io_inst,
> -	[0x34] = handle_io_inst,
> -	[0x35] = handle_io_inst,
> -	[0x36] = handle_io_inst,
> -	[0x37] = handle_io_inst,
> -	[0x38] = handle_io_inst,
> -	[0x39] = handle_io_inst,
> -	[0x3a] = handle_io_inst,
> -	[0x3b] = handle_io_inst,
> -	[0x3c] = handle_io_inst,
> -	[0x50] = handle_ipte_interlock,
> -	[0x56] = handle_sthyi,
> -	[0x5f] = handle_io_inst,
> -	[0x74] = handle_io_inst,
> -	[0x76] = handle_io_inst,
> -	[0x7d] = handle_stsi,
> -	[0xb1] = handle_stfl,
> -	[0xb2] = handle_lpswe,
> -};
> -
>  int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
>  {
> -	intercept_handler_t handler;
> -
> -	/*
> -	 * A lot of B2 instructions are priviledged. Here we check for
> -	 * the privileged ones, that we can handle in the kernel.
> -	 * Anything else goes to userspace.
> -	 */
> -	handler = b2_handlers[vcpu->arch.sie_block->ipa & 0x00ff];
> -	if (handler)
> -		return handler(vcpu);
> -
> -	return -EOPNOTSUPP;
> +	switch (vcpu->arch.sie_block->ipa & 0x00ff) {
> +	case 0x02:
> +		return handle_stidp(vcpu);
> +	case 0x04:
> +		return handle_set_clock(vcpu);
> +	case 0x10:
> +		return handle_set_prefix(vcpu);
> +	case 0x11:
> +		return handle_store_prefix(vcpu);
> +	case 0x12:
> +		return handle_store_cpu_address(vcpu);
> +	case 0x14:
> +		return kvm_s390_handle_vsie(vcpu);
> +	case 0x21:
> +	case 0x50:
> +		return handle_ipte_interlock(vcpu);
> +	case 0x29:
> +		return handle_iske(vcpu);
> +	case 0x2a:
> +		return handle_rrbe(vcpu);
> +	case 0x2b:
> +		return handle_sske(vcpu);
> +	case 0x2c:
> +		return handle_test_block(vcpu);
> +	case 0x30:
> +	case 0x31:
> +	case 0x32:
> +	case 0x33:
> +	case 0x34:
> +	case 0x35:
> +	case 0x36:
> +	case 0x37:
> +	case 0x38:
> +	case 0x39:
> +	case 0x3a:
> +	case 0x3b:
> +	case 0x3c:
> +	case 0x5f:
> +	case 0x74:
> +	case 0x76:
> +		return handle_io_inst(vcpu);
> +	case 0x56:
> +		return handle_sthyi(vcpu);
> +	case 0x7d:
> +		return handle_stsi(vcpu);
> +	case 0xb1:
> +		return handle_stfl(vcpu);
> +	case 0xb2:
> +		return handle_lpswe(vcpu);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
>  
>  static int handle_epsw(struct kvm_vcpu *vcpu)
> @@ -1105,25 +1110,22 @@ static int handle_essa(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> -static const intercept_handler_t b9_handlers[256] = {
> -	[0x8a] = handle_ipte_interlock,
> -	[0x8d] = handle_epsw,
> -	[0x8e] = handle_ipte_interlock,
> -	[0x8f] = handle_ipte_interlock,
> -	[0xab] = handle_essa,
> -	[0xaf] = handle_pfmf,
> -};
> -
>  int kvm_s390_handle_b9(struct kvm_vcpu *vcpu)
>  {
> -	intercept_handler_t handler;
> -
> -	/* This is handled just as for the B2 instructions. */
> -	handler = b9_handlers[vcpu->arch.sie_block->ipa & 0x00ff];
> -	if (handler)
> -		return handler(vcpu);
> -
> -	return -EOPNOTSUPP;
> +	switch (vcpu->arch.sie_block->ipa & 0x00ff) {
> +	case 0x8a:
> +	case 0x8e:
> +	case 0x8f:
> +		return handle_ipte_interlock(vcpu);
> +	case 0x8d:
> +		return handle_epsw(vcpu);
> +	case 0xab:
> +		return handle_essa(vcpu);
> +	case 0xaf:
> +		return handle_pfmf(vcpu);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
>  
>  int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
> @@ -1271,22 +1273,20 @@ static int handle_stctg(struct kvm_vcpu *vcpu)
>  	return rc ? kvm_s390_inject_prog_cond(vcpu, rc) : 0;
>  }
>  
> -static const intercept_handler_t eb_handlers[256] = {
> -	[0x2f] = handle_lctlg,
> -	[0x25] = handle_stctg,
> -	[0x60] = handle_ri,
> -	[0x61] = handle_ri,
> -	[0x62] = handle_ri,
> -};
> -
>  int kvm_s390_handle_eb(struct kvm_vcpu *vcpu)
>  {
> -	intercept_handler_t handler;
> -
> -	handler = eb_handlers[vcpu->arch.sie_block->ipb & 0xff];
> -	if (handler)
> -		return handler(vcpu);
> -	return -EOPNOTSUPP;
> +	switch (vcpu->arch.sie_block->ipb & 0x000000ff) {
> +	case 0x25:
> +		return handle_stctg(vcpu);
> +	case 0x2f:
> +		return handle_lctlg(vcpu);
> +	case 0x60:
> +	case 0x61:
> +	case 0x62:
> +		return handle_ri(vcpu);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
>  
>  static int handle_tprot(struct kvm_vcpu *vcpu)
> @@ -1346,10 +1346,12 @@ static int handle_tprot(struct kvm_vcpu *vcpu)
>  
>  int kvm_s390_handle_e5(struct kvm_vcpu *vcpu)
>  {
> -	/* For e5xx... instructions we only handle TPROT */
> -	if ((vcpu->arch.sie_block->ipa & 0x00ff) == 0x01)
> +	switch (vcpu->arch.sie_block->ipa & 0x00ff) {
> +	case 0x01:
>  		return handle_tprot(vcpu);
> -	return -EOPNOTSUPP;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
>  
>  static int handle_sckpf(struct kvm_vcpu *vcpu)
> @@ -1380,17 +1382,14 @@ static int handle_ptff(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> -static const intercept_handler_t x01_handlers[256] = {
> -	[0x04] = handle_ptff,
> -	[0x07] = handle_sckpf,
> -};
> -
>  int kvm_s390_handle_01(struct kvm_vcpu *vcpu)
>  {
> -	intercept_handler_t handler;
> -
> -	handler = x01_handlers[vcpu->arch.sie_block->ipa & 0x00ff];
> -	if (handler)
> -		return handler(vcpu);
> -	return -EOPNOTSUPP;
> +	switch (vcpu->arch.sie_block->ipa & 0x00ff) {
> +	case 0x04:
> +		return handle_ptff(vcpu);
> +	case 0x07:
> +		return handle_sckpf(vcpu);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
