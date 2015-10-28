From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/3] virtio_net: Stop doing DMA from the stack
Date: Tue, 27 Oct 2015 19:14:32 -0700
Message-ID: <CALCETrXsOQN28W0eMJcMR+oj8LeMJM=MUiNyECx=ysscE8vQxA@mail.gmail.com>
References: <cover.1445994839.git.luto@kernel.org> <b049d57c66d2fa62e0bafa9cf982de62310f4423.1445994839.git.luto@kernel.org>
 <20151028020750.GB18467@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20151028020750.GB18467@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 27, 2015 at 7:07 PM, Joerg Roedel <jroedel@suse.de> wrote:
> On Tue, Oct 27, 2015 at 06:17:08PM -0700, Andy Lutomirski wrote:
>> From: Andy Lutomirski <luto@amacapital.net>
>>
>> Once virtio starts using the DMA API, we won't be able to safely DMA
>> from the stack.  virtio-net does a couple of config DMA requests
>> from small stack buffers -- switch to using dynamically-allocated
>> memory.
>>
>> This should have no effect on any performance-critical code paths.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>  drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 36 insertions(+), 17 deletions(-)
>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>

Should I just send this to netdev now for 4.4?  We could get this one
out of the way, maybe.

--Andy

-- 
Andy Lutomirski
AMA Capital Management, LLC
