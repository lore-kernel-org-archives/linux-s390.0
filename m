From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] virtio-spec: Add virtio-ccw spec.
Date: Thu, 06 Sep 2012 13:09:03 +1000
Message-ID: <1346900943.19098.22.camel@pasglop>
References: <1346771641-12136-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771641-12136-2-git-send-email-cornelia.huck@de.ibm.com>
	<87ehmfj38o.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <87ehmfj38o.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2012-09-06 at 11:56 +0930, Rusty Russell wrote:
> Excellent.  I have applied and pushed this revision.
> 
> I was tempted to ask for an explicit endian marker, as switching to
> explicit little endian was high on the TODO list for virtio2.  On the
> other hand, we could say virtio2-pci config space is always
> little-endian, and virtio-ccw config space is always big-endian.
> 
> That covers the config endian, and and if we introduce a new ring
> format, that endian debate can be separate. 

I'm not too happy with having different endians for the transport. That
somewhat relies on making sure "client" code always use the proper
size-based accessors to any element in the config space, whether it's
the common one or the device specific part.

I've seen that assumption broken multiple times in the past (iirc, maybe
I'm just mis-remembering here :-)

I would think that it would be much better to define the endianness of
the virtio config space once and for all regardless of the underlying
transport.

It's not like a few byteswaps on config accesses are going to hurt s390
performance...

Cheers,
Ben.
