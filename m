From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL 3/8] KVM: s390: fix get_all_floating_irqs
Date: Tue, 31 Mar 2015 16:12:57 +0200
Message-ID: <20150331141257.GC4479@osiris>
References: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
 <1427806923-21910-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427806923-21910-4-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Mar 31, 2015 at 03:01:58PM +0200, Christian Borntraeger wrote:
> From: Jens Freimann <jfrei@linux.vnet.ibm.com>
> 
> This fixes a bug introduced with commit c05c4186bbe4 ("KVM: s390:
> add floating irq controller").
> 
> get_all_floating_irqs() does copy_to_user() while holding
> a spin lock. Let's fix this by filling a temporary buffer
> first and copy it to userspace after giving up the lock.
> 
> Cc: <stable@vger.kernel.org> # 3.18+: 69a8d4562638 KVM: s390: no need to hold...
> 
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

...

> -static int get_all_floating_irqs(struct kvm *kvm, __u8 *buf, __u64 len)
> +static int get_all_floating_irqs(struct kvm *kvm, __user u8 *usrbuf, u64 len)

fwiw, this is probably the only place within the kernel where we see
"__user u8 *" instead of "u8 __user *". This is odd within this whole
patch.

> +		if (copy_to_user((void __user *) usrbuf,

The cast shouldn't be necessary at all...
