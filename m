From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] Fixup for patch 5
Date: Fri, 31 Jan 2014 14:32:45 +0100
Message-ID: <1391175166-47032-1-git-send-email-borntraeger@de.ibm.com>
References: <52EBA166.5060805@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <52EBA166.5060805@redhat.com>
In-Reply-To: <52EB960B.2000307@de.ibm.com>
References: <52EB960B.2000307@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This fixup fixes patch 5 and makes it equivalent to the code that
went through testing. Looks like the change from patch 5 does 
not cause real problems. x86 will simply inject the completion
via kvm_arch_async_page_present in kvm_check_async_pf_completion.
s390 will inject twice (sync in execute but also async), but the
guest OS can handle that. (thats why I did not catch this in
my regression test after rebasing). So the only visible effect is
in the counters and in performance. We can handle this as an addon
patch

Dominik Dingel (1):
  KVM: async_pf: Add missing call for async page present

 virt/kvm/async_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.4.2
