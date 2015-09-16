From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] Fixes: 805de8f43c20 (atomic: Replace
 atomic_{set,clear}_mask() usage)
Date: Wed, 16 Sep 2015 16:47:02 +0200
Message-ID: <20150916164702.2850db6d.cornelia.huck@de.ibm.com>
References: <1442409230-10806-1-git-send-email-jjherne@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442409230-10806-1-git-send-email-jjherne@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, peterz@infradead.org, tglx@linutronix.de, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 16 Sep 2015 09:13:50 -0400
"Jason J. Herne" <jjherne@linux.vnet.ibm.com> wrote:
> The offending commit accidentally replaces an atomic_clear with an
> atomic_or instead of an atomic_andnot in kvm_s390_vcpu_request_handled.
> The symptom is that kvm guests on s390 hang on startup.
> This patch simply replaces the incorrect atomic_or with atomic_andnot
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c91eb94..49e76be 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1574,7 +1574,7 @@ static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
> 
>  static void kvm_s390_vcpu_request_handled(struct kvm_vcpu *vcpu)
>  {
> -	atomic_or(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
> +	atomic_andnot(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
>  }
> 
>  /*

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
