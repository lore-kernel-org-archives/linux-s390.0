From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 5/6] vfio: ccw: Documenting state transitions
Date: Wed, 28 Nov 2018 13:41:06 +0100
Message-ID: <1543408867-16465-6-git-send-email-pmorel@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com
Cc: cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Let's document the state transitions.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 Documentation/s390/vfio-ccw.txt | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/s390/vfio-ccw.txt b/Documentation/s390/vfio-ccw.txt
index 2be11ad..0a1a19f 100644
--- a/Documentation/s390/vfio-ccw.txt
+++ b/Documentation/s390/vfio-ccw.txt
@@ -263,6 +263,51 @@ Q6. Get the signal and event handler reads out the result from the I/O
     region.
 Q7. Update the irb for the guest.
 
+
+States transitions
+------------------
+
+The CCW VFIO driver maintain a device states to determine the response
+- to external events like interruptions, data send, halt and clear
+  from sub-channels.
+- to configuration events, device binding, mdev creation, VM start/stop.
+- to other events like errors or reset of the VM
+
+The event and states are summed up in the diagramme below:
+
+      bind() unbind()
+        |       ^
+        v       |
+      -------------
+      | NOT_OPER  |<---- error
+      -------------    |
+        |       ^      |
+     create() remove() |
+        v       |      |
+      -------------    |
+      | STANDBY   |<--- release()
+      -------------    |
+        |       ^      |
+      open() release() |
+        v       |      |
+      -------------    |
+   -->|   IDLE    |<--- reset
+   |  -------------    |
+   |    |       ^      |
+   |  write()  err     |
+   |    v       |      |
+   |  -------------    |
+   |  |   BOXED   |    |
+   |  -------------    |
+   |       |           |
+  irq   success        |
+   |       v           |
+   |  -------------    |
+   ---|   BUSY    |>----
+      -------------
+
+
+
 Limitations
 -----------
 
-- 
2.7.4
