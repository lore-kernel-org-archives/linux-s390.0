From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 00/15] KVM: s390: Features and fixes for next (3.18)
Date: Tue, 26 Aug 2014 13:59:28 +0200
Message-ID: <53FC76A0.8060007@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com> <53FC721A.4050202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53FC721A.4050202@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 26/08/14 13:40, Paolo Bonzini wrote:
> Il 26/08/2014 10:28, Christian Borntraeger ha scritto:
>> 2. We use KVM_REQ_TLB_FLUSH instead of open coding tlb flushes
> 
> Why is this needed?  It seems slower than what you are replacing.
> 
> Supporting KVM_REQ_TLB_FLUSH is useful (the first hunk of the patch);
> hiding the control block manipulation behind a function would also be
> good.  However, x86 needs the KVM_REQ_TLB_FLUSH for local flushes only
> because Intel wants you to flush on the CPU where the VM will next run.
>  It would not be necessary on AMD for example.
> 
> So if you do not need it on s390, you do not have to do it.
> 
> Paolo
> 

David is on vacation, so let my try to answer :-)

This patch is more of a cleanup - making clear whats going on. Its not needed for something special.

It does two things:
- encapsulate the TLB flushing - Yes, a function hiding that would also work. We decided to reuse an existing interface
- serialize the TLB flushing against other control block updates. This is not necessary, it just happens as a consequence of being a request

Agreed, it will be a bit slower (instead of setting a field we now also set and test a request bit).
Since we only need to do that in rare cases (specific control register updates via userspace and prefix setting) The performance does not matter at all.

I can take out that patch and redo the tag, or leave it in. Let me know.

Christian
