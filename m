From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 00/15] KVM: s390: Features and fixes for next (3.18)
Date: Tue, 26 Aug 2014 14:26:59 +0200
Message-ID: <53FC7D13.3050806@redhat.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com> <53FC721A.4050202@redhat.com> <53FC76A0.8060007@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53FC76A0.8060007@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 26/08/2014 13:59, Christian Borntraeger ha scritto:
> This patch is more of a cleanup - making clear whats going on. Its not needed for something special.
> 
> It does two things:
> - encapsulate the TLB flushing - Yes, a function hiding that would also work. We decided to reuse an existing interface
> - serialize the TLB flushing against other control block updates. This is not necessary, it just happens as a consequence of being a request
> 
> Agreed, it will be a bit slower (instead of setting a field we now also set and test a request bit).
> Since we only need to do that in rare cases (specific control register updates via userspace and prefix setting) The performance does not matter at all.
> 
> I can take out that patch and redo the tag, or leave it in. Let me know.

You can leave it in, I just wanted to understand better.

In fact, supporting KVM_REQ_FLUSH_TLB is in general a good thing since
generic MMU notifier code refers to it.

Paolo
