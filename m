From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/1] virtio/s390: one bugfix
Date: Thu, 10 Sep 2015 16:35:07 +0200
Message-ID: <1441895708-70657-1-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Michael,

here's a bugfix for the virtio-ccw driver.

Question: How would you like to get patches? This one is formatted
against your current linux-next branch; I can prepare a branch for
you to pull from as well.

Pierre Morel (1):
  virtio/s390: handle failures of READ_VQ_CONF ccw

 drivers/s390/virtio/virtio_ccw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.3.8
