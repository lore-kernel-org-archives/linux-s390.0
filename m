From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [GIT PULL 0/1] KVM: s390: fix for 4.9 (via kvm/master)
Date: Thu, 20 Oct 2016 20:47:20 +0200
Message-ID: <20161020184720.GA17270@potion>
References: <1476987606-123515-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476987606-123515-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

2016-10-20 20:20+0200, Christian Borntraeger:
> Paolo, Radim,
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.9-1
> 
> for you to fetch changes up to a5efb6b6c99a3a6dc4330f51d8066f638bdea0ac:
> 
>   KVM: s390: reject invalid modes for runtime instrumentation (2016-10-20 20:06:12 +0200)

Pulled, thanks.

> ----------------------------------------------------------------
> KVM: s390: Fix for user-triggerable WARN_ON
> 
> A malicious user space can provide an invalid mode for runtime
> instrumentation via the interfaces that are normally used on
> the target host during migration. This would trigger a WARN_ON
> via validity intercept. Let's detect this special case.
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390: reject invalid modes for runtime instrumentation
> 
>  arch/s390/kvm/intercept.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
