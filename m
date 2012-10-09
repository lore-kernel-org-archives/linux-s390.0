From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 5/5] [HACK] Handle multiple virtio
	aliases.
Date: Tue, 9 Oct 2012 16:39:24 +0200
Message-ID: <20121009163924.376e0dad@BR9GNB5Z>
References: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771633-53081-6-git-send-email-cornelia.huck@de.ibm.com>
	<87lig4rcqz.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <87lig4rcqz.fsf@codemonkey.ws>
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
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 20 Sep 2012 09:27:00 -0500
Anthony Liguori <aliguori@us.ibm.com> wrote:

> Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> 
> > This patch enables using both virtio-xxx-s390 and virtio-xxx-ccw
> > by making the alias lookup code verify that a driver is actually
> > registered.
> >
> > (Only included in order to allow testing of virtio-ccw; should be
> > replaced by cleaning up the virtio bus model.)
> >
> > Not-signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> No more aliases.  Just drop the whole thing.

The whole alias stuff I put in there was just to be able to test
virtio-ccw. I agree that we should use the cleaned-up virtio driver
model that had been proposed for virtio-mmio earlier; I just want to
make sure the virtio-ccw interface is sane first.

> 
> Regards,
> 
> Anthony Liguori
