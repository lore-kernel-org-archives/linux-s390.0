From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2] virtio-spec: Add virtio-ccw spec.
Date: Thu, 6 Sep 2012 15:51:47 +0200
Message-ID: <20120906155147.56e08f10@BR9GNB5Z>
References: <1346771641-12136-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771641-12136-2-git-send-email-cornelia.huck@de.ibm.com>
	<87ehmfj38o.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <87ehmfj38o.fsf@rustcorp.com.au>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 06 Sep 2012 11:56:31 +0930
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> 
> > Add specifications for the new s390 specific virtio-ccw transport.
> >
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Excellent.  I have applied and pushed this revision.

Cool.

Unfortunately, we just discovered that we probably need to expand the
protocol to allow for a configuration-changed marker in addition to the
indicator bits. Can we easily amend the spec later on?
