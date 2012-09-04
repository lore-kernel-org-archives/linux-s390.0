From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2] virtio-spec: Add virtio-ccw spec.
Date: Tue,  4 Sep 2012 17:14:01 +0200
Message-ID: <1346771641-12136-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1346771641-12136-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1346771641-12136-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Add specifications for the new s390 specific virtio-ccw transport.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---

Changes v1->v2:
- support more than 32 feature bits
- allow to allocate less than requested queue size
- allow to transfer alignment

---
 virtio-spec.lyx |  534 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 534 insertions(+), 0 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 7a073f4..8247d2e 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -57,6 +57,7 @@
 \html_css_as_file 0
 \html_be_strict false
 \author -608949062 "Rusty Russell,,," 
+\author -385801441 "Cornelia Huck" cornelia.huck@de.ibm.com
 \author 1531152142 "Paolo Bonzini,,," 
 \end_header
 
@@ -9350,8 +9351,541 @@ tatus register description is asserted.
  After the interrupt is handled, the driver must acknowledge it by writing
  a bit mask corresponding to the serviced interrupt to the InterruptACK
  register.
+\change_inserted -385801441 1343732742
+
 \end_layout
 
 \end_deeper
+\begin_layout Chapter*
+
+\change_inserted -385801441 1343732726
+Appendix Y: virtio-ccw
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+S/390 based virtual machines support neither PCI nor MMIO, so a different
+ transport is needed there.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+The old s390-virtio mechanism used a special page mapped above the guest's
+ memory and several diagnose calls (hypercalls); it does have some drawbacks,
+ however, like a rather limited number of devices and very restricted hotplug
+ support.
+ Moreover, device discovery and operation differ from other environments
+ on the S/390 platform.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+virtio-ccw uses the standard channel I/O based mechanism used for the majority
+ of devices on S/390.
+ A virtual channel device with a special control unit type acts as proxy
+ to the virtio device (similar to the way virtio-pci uses a PCI device)
+ and configuration and operation of the virtio device is accomplished (mostly)
+ via channel commands.
+ This means virtio devices are discoverable via standard operating system
+ algorithms, and adding virtio support is mainly a question of supporting
+ a new control unit type.
+\end_layout
+
+\begin_layout Subsection*
+
+\change_inserted -385801441 1343732726
+Basic Concepts
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732817
+As a proxy device, virtio-ccw uses a channel-attached I/O control unit with
+ a special control unit type (0x3832) and a control unit model corresponding
+ to the attached virtio device's subsystem device ID, accessed via a virtual
+ I/O subchannel and a virtual channel path of type 0x32.
+ This proxy device is discoverable via normal channel subsystem device discovery
+ (usually a STORE SUBCHANNEL loop) and answers to the basic channel commands,
+ most importantly SENSE ID.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+In addition to the basic channel commands, virtio-ccw defines a set of channel
+ commands related to configuration and operation of virtio:
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+\begin_inset listings
+inline false
+status open
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+#define CCW_CMD_SET_VQ 0x13
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+#define CCW_CMD_VDEV_RESET 0x33
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+#define CCW_CMD_SET_IND 0x43
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+#define CCW_CMD_READ_FEAT 0x12
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+#define CCW_CMD_WRITE_FEAT 0x11
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+#define CCW_CMD_READ_CONF 0x22 
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+#define CCW_CMD_WRITE_CONF 0x21
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+#define CCW_CMD_WRITE_STATUS 0x31
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+#define CCW_CMD_READ_VQ_CONF 0x32
+\end_layout
+
+\end_inset
+
+
+\end_layout
+
+\begin_layout Subsection*
+
+\change_inserted -385801441 1343732726
+Device Initialization
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+virtio-ccw uses several channel commands to set up a device.
+\end_layout
+
+\begin_layout Subsubsection*
+
+\change_inserted -385801441 1343732726
+Configuring a Virtqueue
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+CCW_CMD_READ_VQ_CONF is issued by the guest to obtain information about
+ a queue.
+ It uses the following structure for communicating:
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+\begin_inset listings
+inline false
+status open
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+struct vq_config_block { 
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027276
+
+	__u16 index; 
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027280
+
+	__u16 max_num; 
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+} __attribute__ ((packed));
+\end_layout
+
+\end_inset
+
+
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1345020625
+The requested number of buffers for queue 
+\family typewriter
+index
+\family default
+ is returned in 
+\family typewriter
+max_num
+\family default
+.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+Afterwards, CCW_CMD_SET_VQ is issued by the guest to inform the host about
+ the location used for its queue.
+ The transmitted structure is
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+\begin_inset listings
+inline false
+status open
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+struct vq_info_block { 
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027266
+
+	__u64 queue; 
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027268
+
+	__u32 align;
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027270
+
+	__u16 index;
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027271
+
+	__u16 num; 
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1343732726
+
+} __attribute__ ((packed)); 
+\end_layout
+
+\end_inset
+
+
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1345020957
+
+\family typewriter
+queue
+\family default
+ contains the guest address for queue 
+\family typewriter
+index
+\family default
+.
+ The actual number of allocated buffers is transmitted in 
+\family typewriter
+num
+\family default
+ and their alignment in 
+\family typewriter
+align
+\family default
+.
+\end_layout
+
+\begin_layout Subsubsection*
+
+\change_inserted -385801441 1343732726
+Communicating Status Information
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+The guest can change the status of a device via the CCW_CMD_WRITE_STATUS
+ command, which transmits an 8 bit status value.
+\end_layout
+
+\begin_layout Subsubsection*
+
+\change_inserted -385801441 1343732726
+Handling Device Features
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1345027079
+Feature bits are arranged in an array of 32 bit values, making for a total
+ of 8192 feature bits.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1345027108
+The CCW commands dealing with features use the following communication block:
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027350
+\begin_inset listings
+inline false
+status open
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027350
+
+struct virtio_feature_desc { 
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027350
+
+	__u32 features; 
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027350
+
+	__u8 index;
+\end_layout
+
+\begin_layout LyX-Code
+
+\change_inserted -385801441 1345027350
+
+} __attribute__ ((packed)); 
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
+\change_inserted -385801441 1345027491
+
+\family typewriter
+features
+\family default
+ are the 32 bits of features currently accessed, while 
+\family typewriter
+index
+\family default
+ describes which of the feature bit values is to be accessed.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1345027568
+The guest may obtain the host's device feature set via the CCW_CMD_READ_FEAT
+ command.
+ The host stores the features at 
+\family typewriter
+index
+\family default
+ to 
+\family typewriter
+features
+\family default
+.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1345027622
+For communicating its device features to the host, the guest may use the
+ CCW_CMD_WRITE_FEAT command, denoting a 
+\family typewriter
+features
+\family default
+/
+\family typewriter
+index
+\family default
+ combination.
+\end_layout
+
+\begin_layout Subsubsection*
+
+\change_inserted -385801441 1343732726
+Device Configuration
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+The device's configuration space is located in host memory.
+ It is the same size as the standard PCI configuration space.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+To obtain information from the configuration space, the guest may use CCW_CMD_RE
+AD_CONF, specifying the guest memory for the host to write to.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+For changing configuration information, the guest may use CCW_CMD_WRITE_CONF,
+ specifying the guest memory for the host to read from.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+In both cases, the complete configuration space is transmitted.
+\end_layout
+
+\begin_layout Subsubsection*
+
+\change_inserted -385801441 1343732726
+Setting Up Indicators
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+To communicate the location of the indicator bits for host->guest notification,
+ the guest uses the CCW_CMD_SET_IND command which sends the guest address
+ of the indicators in a 64 bit value.
+\end_layout
+
+\begin_layout Subsection*
+
+\change_inserted -385801441 1343732726
+Device Operation
+\end_layout
+
+\begin_layout Subsubsection*
+
+\change_inserted -385801441 1343732726
+Host->Guest Notification
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+For notifying the guest of virtqueue buffers, the host sets the corresponding
+ bit in the guest-provided indicators.
+ If an interrupt is not already pending for the subchannel, the host generates
+ an unsolicited I/O interrupt.
+\end_layout
+
+\begin_layout Subsubsection*
+
+\change_inserted -385801441 1343732726
+Guest->Host Notification
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+For notifying the host of virtqueue buffers, the guest unfortunately can't
+ use a channel command (the asynchronous characteristics of channel I/O
+ interact badly with the host block I/O backend).
+ Instead, it uses a diagnose 0x500 call with subcode 3 specifying the queue.
+\end_layout
+
+\begin_layout Subsubsection*
+
+\change_inserted -385801441 1343732726
+Early printk for Virtio Consoles
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+For the early printk mechanism, diagnose 0x500 with subcode 0 is used.
+\end_layout
+
+\begin_layout Subsubsection*
+
+\change_inserted -385801441 1343732726
+Resetting Devices
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -385801441 1343732726
+In order to reset a device, a guest may send the CCW_CMD_VDEV_RESET command.
+\change_unchanged
+
+\end_layout
+
 \end_body
 \end_document
-- 
1.7.5.4
