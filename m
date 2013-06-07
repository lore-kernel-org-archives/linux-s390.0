From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC] Adapter interrupts for virtio-ccw.
Date: Fri,  7 Jun 2013 12:37:03 +0200
Message-ID: <1370601424-23412-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's a proposal to support adapter (aka thin) interrupts for virtio-ccw.

The basic idea is to make host->guest signalling on s390 more lightweight.
Normal I/O interrupts have two parts: an interrupt that is made pending on
any of the guest cpus, and status that is made pending on the subchannel.
This means that we need two exits for every interrupt.

With adapter interrupts, only the I/O interrupt remains - no status is made
pending for the subchannel. To find out which virtqueue the signal was for
we rely on indicators.

To set this up, the guest uses a new ccw (which is used instead of the
normal ccw to set up indicators). The payload contains pointers to two
indicators (first level and second level) and the offset at which the
virtqueue indicators start in the second level indicators, as well as the
interruption subclass (which will usually be the same as the isc for the
device). This is partially inspired by what qdio does today.

I have seen some nice speedup on simple dd with my current implementation.
Adapter interrupts are also a prereq for implementing irqfd on s390, since
they eliminate the need for manipulating subchannel status.

Cornelia Huck (1):
  virtio-ccw: Document adapter interrupts.

 virtio-spec.lyx |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 144 insertions(+), 3 deletions(-)

-- 
1.7.9.5
