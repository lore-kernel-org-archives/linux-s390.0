From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 0/3] virtio-ccw: updates
Date: Mon, 21 Jan 2019 13:19:41 +0100
Message-ID: <20190121121944.12309-1-cohuck@redhat.com>
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
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

[Now not as pull request, as requested. The first patch had already been
in my last pull request. Patches are against master, but should apply
basically anywhere.

Git branch:
git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git virtio-ccw]

Some updates: documentation, gracefully handle invalid queues, and wire
up the ->bus_name callback (which had somehow fallen through the cracks.)

Cornelia Huck (2):
  virtio-ccw: diag 500 may return a negative cookie
  virtio-ccw: wire up ->bus_name callback

Halil Pasic (1):
  s390/virtio: handle find on invalid queue gracefully

 Documentation/virtual/kvm/s390-diag.txt |  3 ++-
 drivers/s390/virtio/virtio_ccw.c        | 12 +++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.17.2
