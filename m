From: Alexander Graf <agraf@suse.de>
Subject: Re: [Qemu-devel] [PATCH 8/8] s390: Add new channel I/O based virtio transport.
Date: Wed, 16 Jan 2013 18:05:17 +0100
Message-ID: <19CBE2CE-4F9E-4C58-9CA0-68DDA226CB75@suse.de>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com> <1354884626-15060-9-git-send-email-cornelia.huck@de.ibm.com> <22014A51-6745-4B48-AF72-4AEEE5AB67E2@suse.de> <50F6D94A.40600@twiddle.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <50F6D94A.40600@twiddle.net>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Richard Henderson <rth@twiddle.net>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 16.01.2013, at 17:46, Richard Henderson wrote:

> $SUBJECT reminds me that the tcg s390x port is now prepared
> to implement channel insns, but previously there were no
> channels worth talking about:
> 
>> /* I/O Instructions.  For each we simply indicate non-operation.  */
>>    C(0xb276, XSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>>    C(0xb230, CSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>>    C(0xb231, HSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>>    C(0xb232, MSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>>    C(0xb23b, RCHP,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>>    C(0xb238, RSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>>    C(0xb233, SSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>>    C(0xb234, STSCH,   S,     Z,   0, 0, 0, 0, subchannel, 0)
>>    C(0xb235, TSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
> 
> With a bit of help, I can make these emulated insns implement
> virtio as well.

Cool! I would assume that

  http://marc.info/?l=linux-s390&m=135488344028834&w=2

and most of this thread

  http://lists.gnu.org/archive/html/qemu-devel/2012-12/msg00837.html

would be enough help to actually implement them. Though I'd personally prefer if we can get the IBM folks to do a proper implementation that works for KVM first. Once that is there, doing the rest of the plumbing shouldn't be too hard.


Alex
