From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Sep 2018 13:21:54 +0000
Subject: Re: [GIT PULL 0/2] KVM: s390: Fixes for 4.19
Message-Id: <8eeb02a0-761a-d717-48b5-aa39258322c1@redhat.com>
In-Reply-To: <20180914125623.89084-1-borntraeger@de.ibm.com>
References: <20180914125623.89084-1-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 14/09/2018 14:56, Christian Borntraeger wrote:
> Paolo, Radim,
> 
> 2 more fixes for kvm/master (for 4.19).
> 
> The following changes since commit df88f3181f10565c6e3a89eb6f0f9e6afaaf15f1:
> 
>   KVM: s390: Properly lock mm context allow_gmap_hpage_1m setting (2018-09-04 11:40:26 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.19-2
> 
> for you to fetch changes up to 40ebdb8e59df36e2cc71810bd021a0808b16c956:
> 
>   KVM: s390: Make huge pages unavailable in ucontrol VMs (2018-09-12 14:46:37 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes for 4.19
> 
> - more fallout from the hugetlbfs enablement
> - bugfix for vma handling
> 
> ----------------------------------------------------------------
> Janosch Frank (2):
>       s390/mm: Check for valid vma before zapping in gmap_discard
>       KVM: s390: Make huge pages unavailable in ucontrol VMs
> 
>  Documentation/virtual/kvm/api.txt | 3 ++-
>  arch/s390/kvm/kvm-s390.c          | 4 ++--
>  arch/s390/mm/gmap.c               | 4 +++-
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 

Pulled, thanks.

Paolo
