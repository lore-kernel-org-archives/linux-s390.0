From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: s390: virtio_ccw: reset errors for new I/O.
Date: Thu, 4 Apr 2013 13:34:35 +0200
Message-ID: <406B1D16-3735-4604-A9DD-9478690F3B83@suse.de>
References: <1365063906-61392-1-git-send-email-cornelia.huck@de.ibm.com> <1365063906-61392-2-git-send-email-cornelia.huck@de.ibm.com> <FFC59559-C498-4EA4-971A-A61436932654@suse.de> <20130404122003.17bd05fa@gondolin>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130404122003.17bd05fa@gondolin>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


On 04.04.2013, at 12:20, Cornelia Huck wrote:

> On Thu, 4 Apr 2013 11:28:35 +0200
> Alexander Graf <agraf@suse.de> wrote:
> 
>> 
>> On 04.04.2013, at 10:25, Cornelia Huck wrote:
>> 
>>> ccw_io_helper neglected to reset vcdev->err after a new channel
>>> program had been successfully started, resulting in stale errors
>>> delivered after one I/O failed. Reset the error after a new
>>> channel program has been successfully started with no old I/O
>>> pending.
>>> 
>>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> 
>> Shouldn't this be CC: stable?
> 
> I don't think so, current code will not continue after errors anyway.

Yeah, I got confused by the cover letter for a single patch. Usually, when you only send a single patch, you wouldn't also send a cover letter :).


Alex
