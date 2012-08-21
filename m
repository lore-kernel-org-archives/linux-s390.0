From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/4] s390/kvm: Add a channel I/O based
	virtio transport driver.
Date: Tue, 21 Aug 2012 15:05:18 +0930
Message-ID: <87k3ws3izt.fsf@rustcorp.com.au>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351168-2568-4-git-send-email-cornelia.huck@de.ibm.com>
	<87fw7ps0x4.fsf@codemonkey.ws> <878vdgr4v2.fsf@rustcorp.com.au>
	<502B545C.8000904@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <502B545C.8000904@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Avi Kivity <avi@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 Aug 2012 09:48:44 +0200, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >> Have you written an appendix for the virtio specification for
> >> virtio-ccw?  I think it would be good to include in this series for the
> >> purposes of review.
> > 
> > Might be nice, but don't get fancy about it.  Text will be fine and I
> > can cut & paste it in once it's finalized.
> 
> There was a patch against the virtio spec in the patch series. Did it not
> make it to you?

Yes, I got it, thanks (not in this thread, but that's OK).  Will hold
off until finalized.

Cheers,
Rusty.
