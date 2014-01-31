From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Fixup for patch 5
Date: Fri, 31 Jan 2014 15:58:38 +0100
Message-ID: <52EBBA1E.6010000@redhat.com>
References: <52EBA166.5060805@redhat.com> <1391175166-47032-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1391175166-47032-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Il 31/01/2014 14:32, Christian Borntraeger ha scritto:
> This fixup fixes patch 5 and makes it equivalent to the code that
> went through testing. Looks like the change from patch 5 does
> not cause real problems. x86 will simply inject the completion
> via kvm_arch_async_page_present in kvm_check_async_pf_completion.
> s390 will inject twice (sync in execute but also async), but the
> guest OS can handle that. (thats why I did not catch this in
> my regression test after rebasing). So the only visible effect is
> in the counters and in performance. We can handle this as an addon
> patch

Good!

I will pull and apply this patch as soon as -rc1 is out.

Paolo
