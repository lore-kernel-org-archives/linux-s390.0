From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 00/11] KVM: multiple address spaces (for SMM)
Date: Wed, 20 May 2015 10:58:09 +0200
Message-ID: <555C4CA1.3080704@redhat.com>
References: <1431956923-35602-1-git-send-email-pbonzini@redhat.com> <555C467E.5060106@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <555C467E.5060106@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>, rkrcmar@redhat.com, bdas@redhat.com, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On 20/05/2015 10:31, Christian Borntraeger wrote:
> 
> So in essence this allows to have each vcpu in separate address space if
> necessary. These address space might overlap or be identical and allow
> permutations by having different memslots for each address space.
> And we can have several address spaces per vcpu. Correct?

Yes, exactly.

I've also posted QEMU patches that may give more insight on how this is
used.

Paolo

> This might be useful for kvm on s390 (e.g. we did the ucontrol thing that
> also has one guest address space per vcpu). I need to have a look at that.
