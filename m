From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/1] KVM: s390: fixup missing srcu lock for 4.13
 (kvm/master)
Date: Tue, 25 Jul 2017 15:32:18 +0200
Message-ID: <29f333ba-6fff-18c3-7c31-2217b3544eb5@redhat.com>
References: <1500988866-28288-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1500988866-28288-1-git-send-email-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 25/07/2017 15:21, Christian Borntraeger wrote:
> Paolo, Radim,
> 
> The following changes since commit f1ff89ec4447c4e39d275a1ca3de43eed2a92745:
> 
>   kvm: x86: hyperv: avoid livelock in oneshot SynIC timers (2017-07-20 17:00:00 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.13-1
> 
> for you to fetch changes up to 4f899147424a189b0ad1fdd6f35784ed5a642e83:
> 
>   KVM: s390: take srcu lock when getting/setting storage keys (2017-07-25 14:59:52 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: fixup missing srcu lock
> 
> We need to hold the srcu lock when accessing memory slots
> during migration
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390: take srcu lock when getting/setting storage keys
> 
>  arch/s390/kvm/kvm-s390.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Pulled, thanks.

Paolo
