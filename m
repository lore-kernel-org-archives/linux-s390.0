From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH] KVM: s390: virtio-ccw bugfix.
Date: Thu, 4 Apr 2013 12:00:05 +0300
Message-ID: <20130404090005.GA17411@redhat.com>
References: <1365063906-61392-1-git-send-email-cornelia.huck@de.ibm.com>
 <20130404082739.GA17009@redhat.com>
 <20130404103554.03b81d3c@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130404103554.03b81d3c@gondolin>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 04, 2013 at 10:35:54AM +0200, Cornelia Huck wrote:
> On Thu, 4 Apr 2013 11:27:39 +0300
> Gleb Natapov <gleb@redhat.com> wrote:
> 
> > On Thu, Apr 04, 2013 at 10:25:05AM +0200, Cornelia Huck wrote:
> > > Hi,
> > > 
> > > another virtio-ccw bugfix for a problem where we would not reset
> > > old I/O errors. Please apply.
> > > 
> > > Cornelia Huck (1):
> > >   KVM: s390: virtio_ccw: reset errors for new I/O.
> > > 
> > >  drivers/s390/kvm/virtio_ccw.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > Is this for 3.9 or 3.10?
> 
> I created the patch on top of kvm/queue (the problem won't surface with
> the current code, I only noticed it when I was mucking around with some
> experimental stuff).
Applied to queue. Thanks.

--
			Gleb.
