From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 00/11] KVM: s390: Fixes and features for 4.14
Date: Mon, 28 Aug 2017 14:17:38 +0200
Message-ID: <20170828141738.5e9b47ed.cohuck@redhat.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 28 Aug 2017 10:07:27 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> This is what I have pending for 4.14 in 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  kvm-s390-next-4.14-1
> 
> It contains 2 merges (on topic branch from Martin for the tlb flushing

Have those been posted anywhere? Might have made looking at the feature
easier to post them as well so you do not have to track down the branch.

> and a back-merge from the s390 fixes for master to avoid merge conflicts
> with followup fixes). 
> 
> "New" patches are marked (x) below. (patches 5,6,10,11).
> Pull request will come later this week.
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes and features for 4.14
> 
> - merge of topic branch tlb-flushing from the s390 tree to get the
>   no-dat base features
> - wire up the no-dat enhancements in KVM
> - multiple epoch facility (z14 feature)
> - Configuration z/Architecture Mode fixup
> - merge of kvm/master to avoid conflicts with additional sthyi fixes
> - more sthyi fixes
> 
> ----------------------------------------------------------------
> Christian Borntraeger (3):
>       Merge branch 'tlb-flushing' of git://git.kernel.org/.../s390/linux  into kernelorgnext
>       KVM: s390: take srcu lock when getting/setting storage keys
>       Merge tag 'kvm-s390-master-4.13-2' into kvms390/next
> 
> Claudio Imbrenda (1):
> (x)   KVM: s390: expose no-DAT to guest and migration support
> 
> Collin L. Walling (1):
> (x)   KVM: s390: Multiple Epoch Facility support
> 
> Heiko Carstens (3):
>       KVM: s390: sthyi: fix sthyi inline assembly
>       KVM: s390: sthyi: fix specification exception detection
> (x)   KVM: s390: sthyi: remove invalid guest write access
> 
> Jason J. Herne (1):
> (x)   KVM: s390: Support Configuration z/Architecture Mode
> 
> Martin Schwidefsky (4):
>       s390/mm: tag normal pages vs pages used in page tables
>       s390/mm: add no-dat TLB flush optimization
>       s390/mm: add guest ASCE TLB flush optimization
>       s390/mm,kvm: use nodat PGSTE tag to optimize TLB flushing

I have not reviewed Martin's patches (not surprising, I guess), but the
series looks fine.
