From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [GIT PULL 0/5] KVM: s390: Fixups for changes in merge window for
 4.0
Date: Wed, 4 Mar 2015 22:07:43 -0300
Message-ID: <20150305010743.GA10924@amt.cnet>
References: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 04, 2015 at 12:41:49PM +0100, Christian Borntraeger wrote:
> Paolo, Marcelo,
> 
> here is a pull request for kvm/master targetting 4.0. It is based on
> 4.0-rc1 as I want all patches in an upcoming pull request against 
> kvm/next as well to avoid nasty merge conflicts with other changes
> that we have pending. So my next pull request for kvm/next will
> be based on fb5bf93f84c277546473, which is the HEAD of this pull
> request.
> 
> All patches fix commits that were merged during this merge window.
> 
> Please pull.

Can you generate pull against current master?

$ git pull --ff-only git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
tags/kvm-s390-master-20150303   
From git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux
 * tag               kvm-s390-master-20150303 -> FETCH_HEAD
fatal: Not possible to fast-forward, aborting.

> Christian
> 
> 
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-20150303
> 
> for you to fetch changes up to fb5bf93f84c277546473be35543ed7890f6e6742:
> 
>   KVM: s390: non-LPAR case obsolete during facilities mask init (2015-03-04 10:33:25 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: Fixups for changes in merge window for 4.0
> 
> Here are some fixups/improvements for
> 
> commit 658b6eda204 ("KVM: s390: add cpu model support")
> commit 9d8d578605b ("KVM: s390: use facilities and cpu_id per KVM")
> commit a374e892c34 ("KVM: s390/cpacf: Enable/disable protected key
> functions for kvm guest")
> commit 45c9b47c588 ("KVM: s390/CPACF: Choose crypto control block format")
> 
> which all have been merged during the merge window for 4.0.
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390/cpacf: Fix kernel bug under z/VM
> 
> Michael Mueller (3):
>       KVM: s390: fix in memory copy of facility lists
>       KVM: s390: include guest facilities in kvm facility test
>       KVM: s390: non-LPAR case obsolete during facilities mask init
> 
> Tony Krowiak (1):
>       KVM: s390/cpacf: Enable key wrapping by default
> 
>  arch/s390/include/asm/kvm_host.h | 12 +++----
>  arch/s390/kvm/kvm-s390.c         | 68 ++++++++++++++++++----------------------
>  arch/s390/kvm/kvm-s390.h         |  3 +-
>  arch/s390/kvm/priv.c             |  2 +-
>  4 files changed, 40 insertions(+), 45 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
