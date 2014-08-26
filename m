From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 00/15] KVM: s390: Features and fixes for next (3.18)
Date: Tue, 26 Aug 2014 13:40:10 +0200
Message-ID: <53FC721A.4050202@redhat.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 26/08/2014 10:28, Christian Borntraeger ha scritto:
> 2. We use KVM_REQ_TLB_FLUSH instead of open coding tlb flushes

Why is this needed?  It seems slower than what you are replacing.

Supporting KVM_REQ_TLB_FLUSH is useful (the first hunk of the patch);
hiding the control block manipulation behind a function would also be
good.  However, x86 needs the KVM_REQ_TLB_FLUSH for local flushes only
because Intel wants you to flush on the CPU where the VM will next run.
 It would not be necessary on AMD for example.

So if you do not need it on s390, you do not have to do it.

Paolo
