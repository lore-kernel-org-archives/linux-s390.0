From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2] virtio-spec: Add virtio-ccw spec.
Date: Thu, 06 Sep 2012 11:56:31 +0930
Message-ID: <87ehmfj38o.fsf@rustcorp.com.au>
References: <1346771641-12136-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771641-12136-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1346771641-12136-2-git-send-email-cornelia.huck@de.ibm.com>
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Cornelia Huck <cornelia.huck@de.ibm.com> writes:

> Add specifications for the new s390 specific virtio-ccw transport.
>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Excellent.  I have applied and pushed this revision.

I was tempted to ask for an explicit endian marker, as switching to
explicit little endian was high on the TODO list for virtio2.  On the
other hand, we could say virtio2-pci config space is always
little-endian, and virtio-ccw config space is always big-endian.

That covers the config endian, and and if we introduce a new ring
format, that endian debate can be separate.

Cheers,
Rusty.
