From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/1] KVM: s390: Fix for 4.8 (via kvm/master)
Date: Mon, 5 Sep 2016 16:17:11 +0200
Message-ID: <6cb4c375-049d-7ee9-4132-a965fca843e6@redhat.com>
References: <20160905120703.9491-1-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160905120703.9491-1-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 05/09/2016 14:07, Cornelia Huck wrote:
> Paolo, Radim,
> 
> The following changes since commit 20b8f9e2dde171c69da4a79c34fccdc2a8492797:
> 
>   Merge tag 'kvm-s390-master-4.8-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-master (2016-08-30 14:11:33 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-4.8-3
> 
> for you to fetch changes up to 4d21cef3ea00ba3ac508eb61fb8db70e3e31df67:
> 
>   KVM: s390: vsie: fix riccbd (2016-09-05 13:48:50 +0200)
> 
> ----------------------------------------------------------------
> A bugfix for the vsie code (setting the wrong field).
> 
> ----------------------------------------------------------------
> 
> David Hildenbrand (1):
>   KVM: s390: vsie: fix riccbd
> 
>  arch/s390/kvm/vsie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Pulled, thanks.

Paolo
