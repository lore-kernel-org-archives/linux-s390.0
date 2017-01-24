From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: KVM: s390: Move two error code assignments in
 kvm_vm_ioctl_get_dirty_log()
Date: Tue, 24 Jan 2017 13:10:26 +0100
Message-ID: <75c6315c-8947-2816-64da-947f6a29ac57@users.sourceforge.net>
References: <70f41e59-d8a4-de42-6064-80ecf6acc065@users.sourceforge.net>
 <35411200-2bd6-1c65-7d7f-21a6353875ea@de.ibm.com>
 <01d581bb-9db6-cba1-e476-49c814c3ebf0@users.sourceforge.net>
 <50ae2ba4-572d-8524-fc31-acc1a8d1ad99@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <50ae2ba4-572d-8524-fc31-acc1a8d1ad99@de.ibm.com>
Sender: kernel-janitors-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

>> Would you like to check run time consequences
>> for the shown error code settings once more?
> 
> Sure, lets for now ignore the fact that the performance of an error path
> does not matter most of the time.

I am concerned that extra error code settings within the “success path”
could influence the run time behaviour in unwanted ways.


> After tree building and optimization your change should not matter at all
> regarding performance for a decent compiler.

I find your optimism interesting.


> The compiler can and will do much more complex transformations than this.

This technology is often fine.


> Since you have send several patches that trigger compile time warnings or
> errors, let me do this exercise for you and let us check what your patch
> changes in terms of run time consequences.
> 
> 
> $ git checkout v4.10-rc4
> HEAD is now at 49def18... Linux 4.10-rc4
> 
> $ make arch/s390/kvm/kvm-s390.o
> [..]


Thanks for your build demonstration.


> $ objdump -d arch/s390/kvm/kvm-s390.o | md5sum
> 55c1e081f55cef90b3ffcc06a13721c1  -
> 
> $ git am ~/code/elfring/[PATCH] KVM: s390: Move two error code assignments in kvm_vm_ioctl_get_dirty_log().eml
> Applying: KVM: s390: Move two error code assignments in kvm_vm_ioctl_get_dirty_log()
> 
> $ make arch/s390/kvm/kvm-s390.o
> [..]
> 
> $ objdump -d arch/s390/kvm/kvm-s390.o | md5sum
> 55c1e081f55cef90b3ffcc06a13721c1  -
> 
> As you can see the binary is identical,

The hashes became the same with the selected tool.


> so I can make an educated guess, that there is no performance improvement
> due to your patch.

How much does such a software generation result fit really to expectations?

Should the two shown implementation variants for a function like "kvm_vm_ioctl_get_dirty_log"
usually lead to different object code files?

Regards,
Markus
