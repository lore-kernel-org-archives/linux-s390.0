From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH trivial] KVM: s390: Spelling s/intance/instance/
Date: Tue, 10 Mar 2015 08:58:36 +0100
Message-ID: <54FEA42C.9010104@de.ibm.com>
References: <1425932832-6244-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425932832-6244-1-git-send-email-geert+renesas@glider.be>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jiri Kosina <trivial@kernel.org>
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am 09.03.2015 um 21:27 schrieb Geert Uytterhoeven:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/s390/kvm/kvm-s390.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index fda3f3146eb636d3..83f32a147d72c0f3 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -125,7 +125,7 @@ static inline void kvm_s390_set_psw_cc(struct kvm_vcpu *vcpu, unsigned long cc)
>  	vcpu->arch.sie_block->gpsw.mask |= cc << 44;
>  }
> 
> -/* test availability of facility in a kvm intance */
> +/* test availability of facility in a kvm instance */
>  static inline int test_kvm_facility(struct kvm *kvm, unsigned long nr)
>  {
>  	return __test_facility(nr, kvm->arch.model.fac->mask) &&
> 

Applied, thanks.
