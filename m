From: Richard Henderson <rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 8/8] s390: Add new channel I/O based virtio
 transport.
Date: Wed, 16 Jan 2013 08:46:02 -0800
Message-ID: <50F6D94A.40600@twiddle.net>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com> <1354884626-15060-9-git-send-email-cornelia.huck@de.ibm.com> <22014A51-6745-4B48-AF72-4AEEE5AB67E2@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <22014A51-6745-4B48-AF72-4AEEE5AB67E2@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

$SUBJECT reminds me that the tcg s390x port is now prepared
to implement channel insns, but previously there were no
channels worth talking about:

> /* I/O Instructions.  For each we simply indicate non-operation.  */
>     C(0xb276, XSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>     C(0xb230, CSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>     C(0xb231, HSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>     C(0xb232, MSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>     C(0xb23b, RCHP,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>     C(0xb238, RSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>     C(0xb233, SSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)
>     C(0xb234, STSCH,   S,     Z,   0, 0, 0, 0, subchannel, 0)
>     C(0xb235, TSCH,    S,     Z,   0, 0, 0, 0, subchannel, 0)

With a bit of help, I can make these emulated insns implement
virtio as well.


r~
