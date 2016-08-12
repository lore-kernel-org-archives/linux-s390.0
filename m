From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [GIT PULL 0/2] KVM: s390: Fixes for 4.8 (via kvm/master)
Date: Fri, 12 Aug 2016 14:38:57 +0200
Message-ID: <20160812123856.GF8001@potion>
References: <1470989196-95234-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470989196-95234-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Julius Niedworok <jniedwor@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

2016-08-12 10:06+0200, Christian Borntraeger:
> Paolo, Radim,
> 
> two fixes for 4.8 which prevent a user triggerable WARN_ON_ONCE.
> Found by Julius Niedworok with fuzzing.

Pulled, thanks.

> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> 
>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.8-1
> 
> for you to fetch changes up to aca411a4b17a4aebe14ecdf253373db5b7ee6058:
> 
>   KVM: s390: reset KVM_REQ_MMU_RELOAD if mapping the prefix failed (2016-08-12 09:11:08 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes for 4.8 (via kvm/master)
> 
> Here are two fixes found by fuzzing of the ioctl interface.
> Both cases can trigger a WARN_ON_ONCE from user space.
> 
> ----------------------------------------------------------------
> Julius Niedworok (2):
>       KVM: s390: set the prefix initially properly
>       KVM: s390: reset KVM_REQ_MMU_RELOAD if mapping the prefix failed
> 
>  arch/s390/kvm/kvm-s390.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
