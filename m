From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/4] s390/kvm: Add a channel I/O based
	virtio transport driver.
Date: Wed, 15 Aug 2012 16:58:33 +0930
Message-ID: <878vdgr4v2.fsf@rustcorp.com.au>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351168-2568-4-git-send-email-cornelia.huck@de.ibm.com>
	<87fw7ps0x4.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <87fw7ps0x4.fsf@codemonkey.ws>
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
To: Anthony Liguori <aliguori@us.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 14 Aug 2012 14:56:07 -0500, Anthony Liguori <aliguori@us.ibm.com> wrote:
> Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> 
> > Add a driver for kvm guests that matches virtual ccw devices provided
> > by the host as virtio bridge devices.
> >
> > These virtio-ccw devices use a special set of channel commands in order
> > to perform virtio functions.
> >
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Hi,
> 
> Have you written an appendix for the virtio specification for
> virtio-ccw?  I think it would be good to include in this series for the
> purposes of review.

Might be nice, but don't get fancy about it.  Text will be fine and I
can cut & paste it in once it's finalized.

Cheers,
Rusty.
