From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2] qemu: Adapter interrupts for virtio-ccw.
Date: Tue,  9 Jul 2013 13:34:04 +0200
Message-ID: <1373369645-3184-1-git-send-email-cornelia.huck@de.ibm.com>
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

here's the current implementation of virtio-ccw adapter interrupts in qemu.

Code is unchanged, only rebased against current master.

Cornelia Huck (1):
  s390/virtio-ccw: Adapter interrupt support.

 hw/s390x/css.c        |   10 ++++++++
 hw/s390x/css.h        |    2 ++
 hw/s390x/virtio-ccw.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/s390x/virtio-ccw.h |    4 ++++
 target-s390x/ioinst.h |    2 ++
 target-s390x/kvm.c    |    8 +++++--
 trace-events          |    1 +
 7 files changed, 88 insertions(+), 3 deletions(-)

-- 
1.7.9.5
