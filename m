From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/2] virtio/s390 patches
Date: Tue,  1 Mar 2016 13:44:51 +0100
Message-ID: <1456836293-49239-1-git-send-email-cornelia.huck@de.ibm.com>
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
To: mst@redhat.com
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Michael,

here are two virtio/s390 patches (one cleanup, one bugfix), prepared
against your vhost branch of mst/vhost.git.

Please apply.

Cornelia Huck (1):
  virtio/s390: size of SET_IND payload

Geliang Tang (1):
  virtio/s390: use dev_to_virtio

 drivers/s390/virtio/virtio_ccw.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.3.9
