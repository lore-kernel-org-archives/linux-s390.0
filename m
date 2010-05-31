From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/3] arch/s390/kvm: Use GFP_ATOMIC when a lock is held
Date: Mon, 31 May 2010 10:38:07 +0200
Message-ID: <201005311038.07755.borntraeger@de.ibm.com>
References: <Pine.LNX.4.64.1005302227470.19253@ask.diku.dk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005302227470.19253@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: Carsten Otte <cotte@de.ibm.com>, linux390@de.ibm.com, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> The containing function is called from several places.  At one of them, in
> the function __sigp_stop, the spin lock &fi->lock is held.
[...]
> Signed-off-by: Julia Lawall <julia@diku.dk>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

[...]
> --- a/arch/s390/kvm/sigp.c
> +++ b/arch/s390/kvm/sigp.c
> @@ -113,7 +113,7 @@ static int __inject_sigp_stop(struct kvm
>  {
>  	struct kvm_s390_interrupt_info *inti;
> 
> -	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
> +	inti = kzalloc(sizeof(*inti), GFP_ATOMIC);
>  	if (!inti)
>  		return -ENOMEM;
>  	inti->type = KVM_S390_SIGP_STOP;
