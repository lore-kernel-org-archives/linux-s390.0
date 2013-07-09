From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2] virtio-ccw: Document adapter interrupts.
Date: Tue,  9 Jul 2013 13:33:51 +0200
Message-ID: <1373369631-3148-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1373369631-3148-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1373369631-3148-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 virtio-spec.lyx |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 144 insertions(+), 3 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index c920155..4729766 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -10721,11 +10721,18 @@ status open
 
 \begin_layout LyX-Code
 
-\change_inserted -385801441 1343732726
+\change_inserted -385801441 1369814105
 
 #define CCW_CMD_READ_VQ_CONF 0x32
 \end_layout
 
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1369814140
+
+#define CCW_CMD_SET_IND_ADAPTER 0x63
+\end_layout
+
 \end_inset
 
 
@@ -11065,11 +11072,136 @@ To communicate the location of the indicator bits for host->guest notification,
 
 \begin_layout Standard
 
-\change_inserted -385801441 1347015749
+\change_inserted -385801441 1369814376
 For the indicator bits used in the configuration change host->guest notification
 , the CCW_CMD_SET_CONF_IND command is used analogously.
 \end_layout
 
+\begin_layout Subsubsection*
+
+\change_inserted -385801441 1369814399
+Setting Up Indicators For Adapter Interrupts
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1369815013
+If the guest wishes to use adapter interrupts for host->guest notification,
+ it may use the CCW_CMD_SET_IND_ADAPTER command instead of CCW_CMD_SET_IND.
+ Note that usage of those two mechanisms is mutually exclusive.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1369815065
+CCW_CMD_SET_IND_ADAPTER uses the following communication block:
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1369815367
+\begin_inset listings
+inline false
+status open
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1369815367
+
+struct thinint_area {
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1369815367
+
+        unsigned long summary_indicator;
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1369815367
+
+        unsigned long indicator;
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1369815367
+
+        u16 shift;
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1369815367
+
+        u8 isc;
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1369815367
+
+} __packed;
+\change_unchanged
+
+\end_layout
+
+\end_inset
+
+
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1370345028
+
+\family typewriter
+summary_indicator
+\family default
+ contains the guest address of a byte value to be used as a summary indicator
+ which is set to != 0 every time the host wants to signal the guest for
+ any of the indictors and unset by the guest to signify that it received
+ the notification.
+ 
+\family typewriter
+isc
+\family default
+ is the interruption subclass to be used for the adapter interrupt.
+ Note that an isc/summary indicator pair must match for any subsequent requests
+ to set up adapter interrupts .
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1369816401
+
+\family typewriter
+indicator
+\family default
+ contains the guest address of the 64 bit indicators to be used; 
+\family typewriter
+shift
+\family default
+ contains the offset of the queue indicators for the device in this value.
+ All queue indicators for a device must fit into the same 64 bit value.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1369814707
+Hosts not supporting adapter interrupts for virtio-ccw may fail this command
+ with a command reject.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1369814766
+Configuration change host->guest notification is always setup using CCW_CMD_SET_
+CONF_IND.
+\end_layout
+
 \begin_layout Subsection*
 
 \change_inserted -385801441 1343732726
@@ -11084,7 +11216,7 @@ Host->Guest Notification
 
 \begin_layout Standard
 
-\change_inserted -385801441 1347015762
+\change_inserted -385801441 1369814838
 For notifying the guest of virtqueue buffers, the host sets the corresponding
  bit in the guest-provided indicators.
  If an interrupt is not already pending for the subchannel, the host generates
@@ -11093,6 +11225,15 @@ For notifying the guest of virtqueue buffers, the host sets the corresponding
 
 \begin_layout Standard
 
+\change_inserted -385801441 1369815397
+Alternatively, if the guest enabled adapter interrupts for a device, notificatio
+n happens via setting the bit in the guest-provided indicators, setting
+ the summary indicator and generating an adapter interrupt for the registered
+ interruption subclass.
+\end_layout
+
+\begin_layout Standard
+
 \change_inserted -385801441 1347015847
 If the host wants to notify the guest about configuration changes, it sets
  bit 0 in the configuration indicators and generates an unsolicited I/O
-- 
1.7.9.5
