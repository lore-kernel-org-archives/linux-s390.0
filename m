From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 0/5] KVM: s390: Fixups for changes in merge window
 for 4.0
Date: Thu, 05 Mar 2015 09:41:06 +0100
Message-ID: <54F816A2.50607@de.ibm.com>
References: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com> <20150305010743.GA10924@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20150305010743.GA10924@amt.cnet>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Am 05.03.2015 um 02:07 schrieb Marcelo Tosatti:
> On Wed, Mar 04, 2015 at 12:41:49PM +0100, Christian Borntraeger wrote:
>> Paolo, Marcelo,
>>
>> here is a pull request for kvm/master targetting 4.0. It is based on
>> 4.0-rc1 as I want all patches in an upcoming pull request against 
>> kvm/next as well to avoid nasty merge conflicts with other changes
>> that we have pending. So my next pull request for kvm/next will
>> be based on fb5bf93f84c277546473, which is the HEAD of this pull
>> request.
>>
>> All patches fix commits that were merged during this merge window.
>>
>> Please pull.
> 
> Can you generate pull against current master?
> 
> $ git pull --ff-only git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git

Can you use git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-20150303
                                                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> tags/kvm-s390-master-20150303   
> From git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux
>  * tag               kvm-s390-master-20150303 -> FETCH_HEAD
> fatal: Not possible to fast-forward, aborting.

I can certainly rebase to master, but this pull request was intentionally a non-ff-only request as it
is based of 4.0-rc1. So your pull is expected to be a merge. (just like
333bce5 Merge tag 'kvm-arm-for-3.19-take2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
8a5de18 Merge tag 'kvm-arm-for-3.18-take-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm
e77d99d Merge tag 'kvm-arm-for-3.18' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into kvm-next
9542639 Merge tag 'kvm-arm-for-v3.17-rc7-or-final' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into kvm-master
...
)

The result should look somiliar to:

git log --oneline --graph
*   2076a88 Merge tag 'kvm-s390-master-20150303' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
|\  
| * fb5bf93 KVM: s390: non-LPAR case obsolete during facilities mask init
| * 981467c KVM: s390: include guest facilities in kvm facility test
| * 94422ee KVM: s390: fix in memory copy of facility lists
| * 86044c8 KVM: s390/cpacf: Fix kernel bug under z/VM
| * ed6f76b KVM: s390/cpacf: Enable key wrapping by default
* | cfec0e7 KVM: MIPS: Enable after disabling interrupt
* | b3cffac KVM: MIPS: Fix trace event to save PC directly
* | f563db4 KVM: SVM: fix interrupt injection (apic->isr_count always 0)
* | 4ff6f8e KVM: emulate: fix CMPXCHG8B on 32-bit hosts
* | 21bc8dc KVM: VMX: fix build without CONFIG_SMP
* | 91314cb arm/arm64: KVM: Add exit reaons to kvm_exit event tracing
* | a050dfb ARM: KVM: Fix size check in __coherent_cache_guest_page
|/  
* c517d83 Linux 4.0-rc1


Let me know if you prefer it --ff-only (which will result in a merge conflict in the next merge window)
or as is.


Christian
