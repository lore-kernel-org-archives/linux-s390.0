From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: KVM: s390: Move two error code assignments in
 kvm_vm_ioctl_get_dirty_log()
Date: Mon, 23 Jan 2017 12:58:42 +0100
Message-ID: <50ae2ba4-572d-8524-fc31-acc1a8d1ad99@de.ibm.com>
References: <70f41e59-d8a4-de42-6064-80ecf6acc065@users.sourceforge.net>
 <35411200-2bd6-1c65-7d7f-21a6353875ea@de.ibm.com>
 <01d581bb-9db6-cba1-e476-49c814c3ebf0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <01d581bb-9db6-cba1-e476-49c814c3ebf0@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/23/2017 12:08 PM, SF Markus Elfring wrote:
> Would you like to check run time consequences
> for the shown error code settings once more?

Sure, lets for now ignore the fact that the performance of an error path
does not matter most of the time.

Have you actually looked at your patch? After tree building and optimization
your change should not matter at all regarding performance for a decent
compiler. The compiler can and will do much more complex transformations
than this.

Since you have send several patches that trigger compile time warnings or
errors, let me do this exercise for you and let us check what your patch
changes in terms of run time consequences.


$ git checkout v4.10-rc4
HEAD is now at 49def18... Linux 4.10-rc4

$ make arch/s390/kvm/kvm-s390.o
[..]

$ objdump -d arch/s390/kvm/kvm-s390.o | md5sum
55c1e081f55cef90b3ffcc06a13721c1  -

$ git am ~/code/elfring/[PATCH] KVM: s390: Move two error code assignments in kvm_vm_ioctl_get_dirty_log().eml
Applying: KVM: s390: Move two error code assignments in kvm_vm_ioctl_get_dirty_log()

$ make arch/s390/kvm/kvm-s390.o
[..]

$ objdump -d arch/s390/kvm/kvm-s390.o | md5sum
55c1e081f55cef90b3ffcc06a13721c1  -

As you can see the binary is identical, so I can make an educated guess, that 
there is no performance improvement due to your patch. The bad news is that 
there are reasons to not apply this patch as outlined by me and by Paolo.

Can we come back to a point, where you accept feedback?

Christian

PS: and maybe you should also start to test your patches in a cross-compile
environment before submitting or - heaven forbid - maybe even test your
changes.
