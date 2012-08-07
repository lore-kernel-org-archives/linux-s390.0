From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/4] s390/kvm: Handle hosts not supporting s390-virtio.
Date: Tue,  7 Aug 2012 16:52:45 +0200
Message-ID: <1344351168-2568-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Running under a kvm host does not necessarily imply the presence of
a page mapped above the main memory with the virtio information;
however, the code includes a hard coded access to that page.

Instead, check for the presence of the page and exit gracefully
before we hit an addressing exception if it does not exist.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/kvm_virtio.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index 47cccd5..408447c 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -418,6 +418,21 @@ static void kvm_extint_handler(struct ext_code ext_code,
 	}
 }
 
+static int __init test_devices_support(void)
+{
+	int ccode = -EIO;
+
+	asm volatile(
+		"0:	cli	0(%1),0\n"
+		"	ipm	%0\n"
+		"	srl	%0,28\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "+d" (ccode)
+		: "a" (kvm_devices)
+		: "cc");
+	return ccode;
+}
 /*
  * Init function for virtio
  * devices are in a single page above top of "normal" mem
@@ -443,6 +458,12 @@ static int __init kvm_devices_init(void)
 	}
 
 	kvm_devices = (void *) real_memory_size;
+	if (test_devices_support() < 0) {
+		vmem_remove_mapping(real_memory_size, PAGE_SIZE);
+		root_device_unregister(kvm_root);
+		/* No error. */
+		return 0;
+	}
 
 	INIT_WORK(&hotplug_work, hotplug_devices);
 
-- 
1.7.11.4
