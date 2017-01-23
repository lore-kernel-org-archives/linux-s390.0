From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] KVM: s390: Move two error code assignments in
 kvm_vm_ioctl_get_dirty_log()
Date: Mon, 23 Jan 2017 09:22:55 +0100
Message-ID: <35411200-2bd6-1c65-7d7f-21a6353875ea@de.ibm.com>
References: <70f41e59-d8a4-de42-6064-80ecf6acc065@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <70f41e59-d8a4-de42-6064-80ecf6acc065@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/21/2017 05:03 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Jan 2017 16:52:23 +0100
> 
> A local variable was set to an error code in two cases before a concrete
> error situation was detected. Thus move the corresponding assignments into
> if branches to indicate a software failure there.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>


Patches that changes open coded things to common helpers or things like
kmalloc_array where appropriate or things that make the code more robust
are fine and welcome, but I am not going to take this as it just shuffles
things around. It does not fix anything and it does not improve the code,
but it certainly carries the risk of breaking something (yes in this case
it looks perfectly fine, though).

PS: When you look at the kvm/mips change that you have recently made, this 
case is better and qualifies as in improvement, because you remove lines and 
the code does get simpler. Due to the locking requirements we cannot do
such a simplification here.

Christian

> ---
>  arch/s390/kvm/kvm-s390.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4f74511015b8..bc875d08b838 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -443,16 +443,17 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
>  	int is_dirty = 0;
> 
>  	mutex_lock(&kvm->slots_lock);
> -
> -	r = -EINVAL;
> -	if (log->slot >= KVM_USER_MEM_SLOTS)
> +	if (log->slot >= KVM_USER_MEM_SLOTS) {
> +		r = -EINVAL;
>  		goto out;
> +	}
> 
>  	slots = kvm_memslots(kvm);
>  	memslot = id_to_memslot(slots, log->slot);
> -	r = -ENOENT;
> -	if (!memslot->dirty_bitmap)
> +	if (!memslot->dirty_bitmap) {
> +		r = -ENOENT;
>  		goto out;
> +	}
> 
>  	kvm_s390_sync_dirty_log(kvm, memslot);
>  	r = kvm_get_dirty_log(kvm, log, &is_dirty);
> 
