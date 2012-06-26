From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/6] KVM: s390: fix sigp set prefix status stored cases
Date: Tue, 26 Jun 2012 16:56:08 +0200
Message-ID: <FBB4695B-5B84-4644-9C26-C037258DC20A@suse.de>
References: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com> <1340719601-11867-5-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1340719601-11867-5-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


On 26.06.2012, at 16:06, Cornelia Huck wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> If an invalid parameter is passed or the addressed cpu is in an
> incorrect state sigp set prefix will store a status.
> This status must only have bits set as defined by the architecture.
> The current kvm implementation missed to clear bits and also did
> not set the intended status bit ("and" instead of "or" operation).
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

What was the net effect of this for a guest? Any problems rising from it?


Alex

> ---
> arch/s390/kvm/sigp.c |    7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
> index caccc0e..ca544d5 100644
> --- a/arch/s390/kvm/sigp.c
> +++ b/arch/s390/kvm/sigp.c
> @@ -207,6 +207,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
> 	address = address & 0x7fffe000u;
> 	if (copy_from_guest_absolute(vcpu, &tmp, address, 1) ||
> 	   copy_from_guest_absolute(vcpu, &tmp, address + PAGE_SIZE, 1)) {
> +		*reg &= 0xffffffff00000000UL;
> 		*reg |= SIGP_STATUS_INVALID_PARAMETER;
> 		return 1; /* invalid parameter */
> 	}
> @@ -220,8 +221,9 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
> 		li = fi->local_int[cpu_addr];
> 
> 	if (li == NULL) {
> +		*reg &= 0xffffffff00000000UL;
> +		*reg |= SIGP_STATUS_INCORRECT_STATE;
> 		rc = 1; /* incorrect state */
> -		*reg &= SIGP_STATUS_INCORRECT_STATE;
> 		kfree(inti);
> 		goto out_fi;
> 	}
> @@ -229,8 +231,9 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
> 	spin_lock_bh(&li->lock);
> 	/* cpu must be in stopped state */
> 	if (!(atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
> +		*reg &= 0xffffffff00000000UL;
> +		*reg |= SIGP_STATUS_INCORRECT_STATE;
> 		rc = 1; /* incorrect state */
> -		*reg &= SIGP_STATUS_INCORRECT_STATE;
> 		kfree(inti);
> 		goto out_li;
> 	}
> -- 
> 1.7.10.4
> 
