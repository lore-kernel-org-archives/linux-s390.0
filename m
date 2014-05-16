From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/1] KVM: s390: Fix for 3.15
Date: Fri, 16 May 2014 10:30:12 +0200
Message-ID: <5375CC94.7040403@redhat.com>
References: <1400144571-17011-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1400144571-17011-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 15/05/2014 11:02, Christian Borntraeger ha scritto:
> Paolo,
>
> here is a fix for kvm/master targetting 3.15
>
> The following changes since commit 5367742ad5321dd38058420adb4750ed9c7ead1e:
>
>   Merge tag 'signed-for-3.15' of git://github.com/agraf/linux-2.6 into kvm-master (2014-05-13 18:15:16 +0200)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-for-3.15-1
>
> for you to fetch changes up to ebc3226202d5956a5963185222982d435378b899:
>
>   KVM: s390: announce irqfd capability (2014-05-15 10:55:10 +0200)
>
> ----------------------------------------------------------------
> Here is a fix that aligns the irqfd code changes for 3.15
> with the right capability number. irqfd for s390x was
> introduced with 3.15-rc1, so this fix should still go into
> Linus tree for 3.15
>
> ----------------------------------------------------------------
> Cornelia Huck (1):
>       KVM: s390: announce irqfd capability
>
>  Documentation/virtual/kvm/api.txt | 2 +-
>  arch/s390/kvm/kvm-s390.c          | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Pulled, thanks.

Paolo
