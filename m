From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 4/4] KVM: s390: Add a channel I/O based virtio transport
 driver.
Date: Wed, 12 Dec 2012 21:12:26 +0100
Message-ID: <50C8E52A.1@de.ibm.com>
References: <1355330201-36481-1-git-send-email-cornelia.huck@de.ibm.com> <1355330201-36481-5-git-send-email-cornelia.huck@de.ibm.com> <50C8CD8F.2000909@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <50C8CD8F.2000909@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 12/12/12 19:31, Alexander Graf wrote:
 +static inline long do_kvm_notify(struct subchannel_id schid,
>> +                 unsigned long queue_index)
>> +{
>> +    register unsigned long __nr asm("1") = KVM_S390_VIRTIO_CCW_NOTIFY;
>> +    register struct subchannel_id __schid asm("2") = schid;
> 
> How does the compiler know that the struct fits within a register?
> 

Well it knows that sizeof struct subchannel_id is 4.

then we have 
"ELF Application Binary Interface Supplement Linux on zSeries"

[...]
Parameter passing
[...]
- Structures with a size of 1, 2, 4, or 8 bytes are passed as integral values.  <=============
- All other structures are passed by reference. If needed, the called function makes
  a copy of the value.
[...]

while not being a perfect match it gives a good indication that this will work.

Furthermore, we know it is working at least since 
commit 94c12cc7d196bab34aaa98d38521549fa1e5ef76
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Thu Sep 28 16:56:43 2006 +0200
    [S390] Inline assembly cleanup.

in 
drivers/s390/cio/ioasm.h

[...]
94c12cc7 (Martin Schwidefsky  2006-09-28 16:56:43 +0200  30)    register struct subchannel_id reg1 asm ("1") = schid;
94c12cc7 (Martin Schwidefsky  2006-09-28 16:56:43 +0200  31)    int ccode = -EIO;
fb6958a5 (Cornelia Huck       2006-01-06 00:19:25 -0800  32) 
94c12cc7 (Martin Schwidefsky  2006-09-28 16:56:43 +0200  33)    asm volatile(
[...]

So this complies with the coding style of the s390 maintainer :-)

Christian
