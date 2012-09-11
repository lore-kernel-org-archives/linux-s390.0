From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Date: Tue, 11 Sep 2012 17:34:35 +0200
Message-Id: <1347377675-22865-2-git-send-email-graalfs@linux.vnet.ibm.com>
In-Reply-To: <1347377675-22865-1-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1347377675-22865-1-git-send-email-graalfs@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] virtio-ccw: Add secondary indicators.
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/qemu-devel/>
To: rusty@rustcorp.com.au
Cc: linux-s390@vger.kernel.org, aliguori@us.ibm.com, cornelia.huck@de.ibm.com, cotte@de.ibm.com, heiko.carstens@de.ibm.com, mtosatti@redhat.com, sebott@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, avi@redhat.com, schwidefsky@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Add a ccw to specify the location of indicators for configuration
changes and notice how they are to be used.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 virtio-spec.lyx | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 8247d2e..41318b1 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -9442,13 +9442,20 @@ status open
 
 \begin_layout LyX-Code
 
-\change_inserted -385801441 1343732726
+\change_inserted -385801441 1347015671
 
 #define CCW_CMD_SET_IND 0x43
 \end_layout
 
 \begin_layout LyX-Code
 
+\change_inserted -385801441 1347015690
+
+#define CCW_CMD_SET_CONF_IND 0x53
+\end_layout
+
+\begin_layout LyX-Code
+
 \change_inserted -385801441 1343732726
 
 #define CCW_CMD_READ_FEAT 0x12
@@ -9819,12 +9826,19 @@ Setting Up Indicators
 
 \begin_layout Standard
 
-\change_inserted -385801441 1343732726
+\change_inserted -385801441 1347015710
 To communicate the location of the indicator bits for host->guest notification,
  the guest uses the CCW_CMD_SET_IND command which sends the guest address
  of the indicators in a 64 bit value.
 \end_layout
 
+\begin_layout Standard
+
+\change_inserted -385801441 1347015749
+For the indicator bits used in the configuration change host->guest notification
+, the CCW_CMD_SET_CONF_IND command is used analogously.
+\end_layout
+
 \begin_layout Subsection*
 
 \change_inserted -385801441 1343732726
@@ -9839,13 +9853,21 @@ Host->Guest Notification
 
 \begin_layout Standard
 
-\change_inserted -385801441 1343732726
+\change_inserted -385801441 1347015762
 For notifying the guest of virtqueue buffers, the host sets the corresponding
  bit in the guest-provided indicators.
  If an interrupt is not already pending for the subchannel, the host generates
  an unsolicited I/O interrupt.
 \end_layout
 
+\begin_layout Standard
+
+\change_inserted -385801441 1347015847
+If the host wants to notify the guest about configuration changes, it sets
+ bit 0 in the configuration indicators and generates an unsolicited I/O
+ interrupt, if needed.
+\end_layout
+
 \begin_layout Subsubsection*
 
 \change_inserted -385801441 1343732726
-- 
1.7.11.5
