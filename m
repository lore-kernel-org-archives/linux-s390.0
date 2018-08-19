From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 8/9] PCI: hotplug: Embed hotplug_slot
Date: Sun, 19 Aug 2018 16:29:00 +0200
Message-ID: <9918fbca94bcfc03d1560b191d138d3e6664cc86.1534686485.git.lukas@wunner.de>
References: <cover.1534686484.git.lukas@wunner.de>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <cover.1534686484.git.lukas@wunner.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Scott Murray <scott@spiteful.org>, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, acpi4asus-user@lists.sourceforge.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Corentin Chary <corentin.chary@gmail.com>, Darren Hart <dvhart@infradead.org>, linuxppc-dev@lists.ozlabs.org, Andy Shevchenko <andy@infradead.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Len Brown <lenb@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

When the PCI hotplug core and its first user, cpqphp, were introduced in
February 2002 with historic commit a8a2069f432c, cpqphp allocated a slot
struct for its internal use plus a hotplug_slot struct to be registered
with the hotplug core and linked the two with pointers:
https://git.kernel.org/tglx/history/c/a8a2069f432c

Nowadays, the predominant pattern in the tree is to embed ("subclass")
such structures in one another and cast to the containing struct with
container_of().  But it wasn't until July 2002 that container_of() was
introduced with historic commit ec4f214232cf:
https://git.kernel.org/tglx/history/c/ec4f214232cf

pnv_php, introduced in 2016, did the right thing and embedded struct
hotplug_slot in its internal struct pnv_php_slot, but all other drivers
cargo-culted cpqphp's design and linked separate structs with pointers.

Embedding structs is preferrable to linking them with pointers because
it requires fewer allocations, thereby reducing overhead and simplifying
error paths.  Casting an embedded struct to the containing struct
becomes a cheap subtraction rather than a dereference.  And having fewer
pointers reduces the risk of them pointing nowhere either accidentally
or due to an attack.

Convert all drivers to embed struct hotplug_slot in their internal slot
struct.  The "private" pointer in struct hotplug_slot thereby becomes
unused, so drop it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Scott Murray <scott@spiteful.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Corentin Chary <corentin.chary@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
---
 drivers/pci/hotplug/acpiphp.h           |  9 ++-
 drivers/pci/hotplug/acpiphp_core.c      | 28 +++-----
 drivers/pci/hotplug/acpiphp_ibm.c       |  2 +-
 drivers/pci/hotplug/cpci_hotplug.h      |  9 ++-
 drivers/pci/hotplug/cpci_hotplug_core.c | 37 ++++------
 drivers/pci/hotplug/cpci_hotplug_pci.c  |  6 +-
 drivers/pci/hotplug/cpqphp.h            |  9 ++-
 drivers/pci/hotplug/cpqphp_core.c       | 37 ++++------
 drivers/pci/hotplug/cpqphp_ctrl.c       |  2 -
 drivers/pci/hotplug/ibmphp.h            |  7 +-
 drivers/pci/hotplug/ibmphp_core.c       | 92 +++++++++++--------------
 drivers/pci/hotplug/ibmphp_ebda.c       | 37 +++-------
 drivers/pci/hotplug/pciehp.h            | 11 ++-
 drivers/pci/hotplug/pciehp_core.c       | 37 ++++------
 drivers/pci/hotplug/pciehp_ctrl.c       |  4 +-
 drivers/pci/hotplug/pciehp_hpc.c        |  8 +--
 drivers/pci/hotplug/pnv_php.c           |  9 ++-
 drivers/pci/hotplug/rpaphp.h            |  7 +-
 drivers/pci/hotplug/rpaphp_core.c       | 14 ++--
 drivers/pci/hotplug/rpaphp_slot.c       | 15 ++--
 drivers/pci/hotplug/s390_pci_hpc.c      | 30 ++++----
 drivers/pci/hotplug/sgi_hotplug.c       | 52 ++++++--------
 drivers/pci/hotplug/shpchp.h            |  6 +-
 drivers/pci/hotplug/shpchp_core.c       | 17 ++---
 drivers/platform/x86/asus-wmi.c         | 26 +++----
 drivers/platform/x86/eeepc-laptop.c     | 30 ++++----
 include/linux/pci_hotplug.h             |  3 -
 27 files changed, 223 insertions(+), 321 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index 8377e736ea69..cf3058404f41 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -33,14 +33,19 @@ struct acpiphp_slot;
  * struct slot - slot information for each *physical* slot
  */
 struct slot {
-	struct hotplug_slot	*hotplug_slot;
+	struct hotplug_slot	hotplug_slot;
 	struct acpiphp_slot	*acpi_slot;
 	unsigned int sun;	/* ACPI _SUN (Slot User Number) value */
 };
 
 static inline const char *slot_name(struct slot *slot)
 {
-	return hotplug_slot_name(slot->hotplug_slot);
+	return hotplug_slot_name(&slot->hotplug_slot);
+}
+
+static inline struct slot *to_slot(struct hotplug_slot *hotplug_slot)
+{
+	return container_of(hotplug_slot, struct slot, hotplug_slot);
 }
 
 /*
diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
index abd4f8d7e16a..c9e2bd40c038 100644
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -118,7 +118,7 @@ EXPORT_SYMBOL_GPL(acpiphp_unregister_attention);
  */
 static int enable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	pr_debug("%s - physical_slot = %s\n", __func__, slot_name(slot));
 
@@ -135,7 +135,7 @@ static int enable_slot(struct hotplug_slot *hotplug_slot)
  */
 static int disable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	pr_debug("%s - physical_slot = %s\n", __func__, slot_name(slot));
 
@@ -179,7 +179,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
  */
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	pr_debug("%s - physical_slot = %s\n", __func__, slot_name(slot));
 
@@ -225,7 +225,7 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
  */
 static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	pr_debug("%s - physical_slot = %s\n", __func__, slot_name(slot));
 
@@ -245,7 +245,7 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
  */
 static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	pr_debug("%s - physical_slot = %s\n", __func__, slot_name(slot));
 
@@ -266,12 +266,7 @@ int acpiphp_register_hotplug_slot(struct acpiphp_slot *acpiphp_slot,
 	if (!slot)
 		goto error;
 
-	slot->hotplug_slot = kzalloc(sizeof(*slot->hotplug_slot), GFP_KERNEL);
-	if (!slot->hotplug_slot)
-		goto error_slot;
-
-	slot->hotplug_slot->private = slot;
-	slot->hotplug_slot->ops = &acpi_hotplug_slot_ops;
+	slot->hotplug_slot.ops = &acpi_hotplug_slot_ops;
 
 	slot->acpi_slot = acpiphp_slot;
 
@@ -279,20 +274,18 @@ int acpiphp_register_hotplug_slot(struct acpiphp_slot *acpiphp_slot,
 	slot->sun = sun;
 	snprintf(name, SLOT_NAME_SIZE, "%u", sun);
 
-	retval = pci_hp_register(slot->hotplug_slot, acpiphp_slot->bus,
+	retval = pci_hp_register(&slot->hotplug_slot, acpiphp_slot->bus,
 				 acpiphp_slot->device, name);
 	if (retval == -EBUSY)
-		goto error_hpslot;
+		goto error_slot;
 	if (retval) {
 		pr_err("pci_hp_register failed with error %d\n", retval);
-		goto error_hpslot;
+		goto error_slot;
 	}
 
 	pr_info("Slot [%s] registered\n", slot_name(slot));
 
 	return 0;
-error_hpslot:
-	kfree(slot->hotplug_slot);
 error_slot:
 	kfree(slot);
 error:
@@ -306,8 +299,7 @@ void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *acpiphp_slot)
 
 	pr_info("Slot [%s] unregistered\n", slot_name(slot));
 
-	pci_hp_deregister(slot->hotplug_slot);
-	kfree(slot->hotplug_slot);
+	pci_hp_deregister(&slot->hotplug_slot);
 	kfree(slot);
 }
 
diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 41713f16ff97..df48b3b03ab4 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -41,7 +41,7 @@ MODULE_VERSION(DRIVER_VERSION);
 #define IBM_HARDWARE_ID1 "IBM37D0"
 #define IBM_HARDWARE_ID2 "IBM37D4"
 
-#define hpslot_to_sun(A) (((struct slot *)((A)->private))->sun)
+#define hpslot_to_sun(A) (to_slot(A)->sun)
 
 /* union apci_descriptor - allows access to the
  * various device descriptors that are embedded in the
diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
index 146b06fd12c0..817c84e0b2fe 100644
--- a/drivers/pci/hotplug/cpci_hotplug.h
+++ b/drivers/pci/hotplug/cpci_hotplug.h
@@ -35,7 +35,7 @@ struct slot {
 	bool latch_status;
 	bool adapter_status;
 	unsigned int extracting;
-	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot hotplug_slot;
 	struct list_head slot_list;
 };
 
@@ -60,7 +60,12 @@ struct cpci_hp_controller {
 
 static inline const char *slot_name(struct slot *slot)
 {
-	return hotplug_slot_name(slot->hotplug_slot);
+	return hotplug_slot_name(&slot->hotplug_slot);
+}
+
+static inline struct slot *to_slot(struct hotplug_slot *hotplug_slot)
+{
+	return container_of(hotplug_slot, struct slot, hotplug_slot);
 }
 
 int cpci_hp_register_controller(struct cpci_hp_controller *controller);
diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index a17fb24c28cd..603eadf3d965 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -70,7 +70,7 @@ static const struct hotplug_slot_ops cpci_hotplug_slot_ops = {
 static int
 enable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	int retval = 0;
 
 	dbg("%s - physical_slot = %s", __func__, slot_name(slot));
@@ -83,7 +83,7 @@ enable_slot(struct hotplug_slot *hotplug_slot)
 static int
 disable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	int retval = 0;
 
 	dbg("%s - physical_slot = %s", __func__, slot_name(slot));
@@ -139,7 +139,7 @@ cpci_get_power_status(struct slot *slot)
 static int
 get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	*value = cpci_get_power_status(slot);
 	return 0;
@@ -148,7 +148,7 @@ get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 static int
 get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	*value = cpci_get_attention_status(slot);
 	return 0;
@@ -157,13 +157,13 @@ get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 static int
 set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 {
-	return cpci_set_attention_status(hotplug_slot->private, status);
+	return cpci_set_attention_status(to_slot(hotplug_slot), status);
 }
 
 static int
 get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	*value = slot->adapter_status;
 	return 0;
@@ -172,7 +172,7 @@ get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 static int
 get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	*value = slot->latch_status;
 	return 0;
@@ -180,7 +180,6 @@ get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 static void release_slot(struct slot *slot)
 {
-	kfree(slot->hotplug_slot);
 	pci_dev_put(slot->dev);
 	kfree(slot);
 }
@@ -191,7 +190,6 @@ int
 cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last)
 {
 	struct slot *slot;
-	struct hotplug_slot *hotplug_slot;
 	char name[SLOT_NAME_SIZE];
 	int status;
 	int i;
@@ -210,28 +208,19 @@ cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last)
 			goto error;
 		}
 
-		hotplug_slot =
-			kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
-		if (!hotplug_slot) {
-			status = -ENOMEM;
-			goto error_slot;
-		}
-		slot->hotplug_slot = hotplug_slot;
-
 		slot->bus = bus;
 		slot->number = i;
 		slot->devfn = PCI_DEVFN(i, 0);
 
 		snprintf(name, SLOT_NAME_SIZE, "%02x:%02x", bus->number, i);
 
-		hotplug_slot->private = slot;
-		hotplug_slot->ops = &cpci_hotplug_slot_ops;
+		slot->hotplug_slot.ops = &cpci_hotplug_slot_ops;
 
 		dbg("registering slot %s", name);
-		status = pci_hp_register(slot->hotplug_slot, bus, i, name);
+		status = pci_hp_register(&slot->hotplug_slot, bus, i, name);
 		if (status) {
 			err("pci_hp_register failed with error %d", status);
-			goto error_hpslot;
+			goto error_slot;
 		}
 		dbg("slot registered with name: %s", slot_name(slot));
 
@@ -242,8 +231,6 @@ cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last)
 		up_write(&list_rwsem);
 	}
 	return 0;
-error_hpslot:
-	kfree(hotplug_slot);
 error_slot:
 	kfree(slot);
 error:
@@ -269,7 +256,7 @@ cpci_hp_unregister_bus(struct pci_bus *bus)
 			slots--;
 
 			dbg("deregistering slot %s", slot_name(slot));
-			pci_hp_deregister(slot->hotplug_slot);
+			pci_hp_deregister(&slot->hotplug_slot);
 			release_slot(slot);
 		}
 	}
@@ -571,7 +558,7 @@ cleanup_slots(void)
 		goto cleanup_null;
 	list_for_each_entry_safe(slot, tmp, &slot_list, slot_list) {
 		list_del(&slot->slot_list);
-		pci_hp_deregister(slot->hotplug_slot);
+		pci_hp_deregister(&slot->hotplug_slot);
 		release_slot(slot);
 	}
 cleanup_null:
diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
index 389b8fb50cd9..2c16adb7f4ec 100644
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -194,8 +194,7 @@ int cpci_led_on(struct slot *slot)
 					      slot->devfn,
 					      hs_cap + 2,
 					      hs_csr)) {
-			err("Could not set LOO for slot %s",
-			    hotplug_slot_name(slot->hotplug_slot));
+			err("Could not set LOO for slot %s", slot_name(slot));
 			return -ENODEV;
 		}
 	}
@@ -223,8 +222,7 @@ int cpci_led_off(struct slot *slot)
 					      slot->devfn,
 					      hs_cap + 2,
 					      hs_csr)) {
-			err("Could not clear LOO for slot %s",
-			    hotplug_slot_name(slot->hotplug_slot));
+			err("Could not clear LOO for slot %s", slot_name(slot));
 			return -ENODEV;
 		}
 	}
diff --git a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
index db78b394a075..77e4e0142fbc 100644
--- a/drivers/pci/hotplug/cpqphp.h
+++ b/drivers/pci/hotplug/cpqphp.h
@@ -260,7 +260,7 @@ struct slot {
 	u8 hp_slot;
 	struct controller *ctrl;
 	void __iomem *p_sm_slot;
-	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot hotplug_slot;
 };
 
 struct pci_resource {
@@ -445,7 +445,12 @@ extern u8 cpqhp_disk_irq;
 
 static inline const char *slot_name(struct slot *slot)
 {
-	return hotplug_slot_name(slot->hotplug_slot);
+	return hotplug_slot_name(&slot->hotplug_slot);
+}
+
+static inline struct slot *to_slot(struct hotplug_slot *hotplug_slot)
+{
+	return container_of(hotplug_slot, struct slot, hotplug_slot);
 }
 
 /*
diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index bb354a7fc112..95b7d60cf119 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -275,8 +275,7 @@ static int ctrl_slot_cleanup(struct controller *ctrl)
 
 	while (old_slot) {
 		next_slot = old_slot->next;
-		pci_hp_deregister(old_slot->hotplug_slot);
-		kfree(old_slot->hotplug_slot);
+		pci_hp_deregister(&old_slot->hotplug_slot);
 		kfree(old_slot);
 		old_slot = next_slot;
 	}
@@ -418,7 +417,7 @@ cpqhp_set_attention_status(struct controller *ctrl, struct pci_func *func,
 static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 {
 	struct pci_func *slot_func;
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	struct controller *ctrl = slot->ctrl;
 	u8 bus;
 	u8 devfn;
@@ -445,7 +444,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 static int process_SI(struct hotplug_slot *hotplug_slot)
 {
 	struct pci_func *slot_func;
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	struct controller *ctrl = slot->ctrl;
 	u8 bus;
 	u8 devfn;
@@ -477,7 +476,7 @@ static int process_SI(struct hotplug_slot *hotplug_slot)
 static int process_SS(struct hotplug_slot *hotplug_slot)
 {
 	struct pci_func *slot_func;
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	struct controller *ctrl = slot->ctrl;
 	u8 bus;
 	u8 devfn;
@@ -504,7 +503,7 @@ static int process_SS(struct hotplug_slot *hotplug_slot)
 
 static int hardware_test(struct hotplug_slot *hotplug_slot, u32 value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	struct controller *ctrl = slot->ctrl;
 
 	dbg("%s - physical_slot = %s\n", __func__, slot_name(slot));
@@ -515,7 +514,7 @@ static int hardware_test(struct hotplug_slot *hotplug_slot, u32 value)
 
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	struct controller *ctrl = slot->ctrl;
 
 	dbg("%s - physical_slot = %s\n", __func__, slot_name(slot));
@@ -526,7 +525,7 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	struct controller *ctrl = slot->ctrl;
 
 	dbg("%s - physical_slot = %s\n", __func__, slot_name(slot));
@@ -537,7 +536,7 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	struct controller *ctrl = slot->ctrl;
 
 	dbg("%s - physical_slot = %s\n", __func__, slot_name(slot));
@@ -549,7 +548,7 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	struct controller *ctrl = slot->ctrl;
 
 	dbg("%s - physical_slot = %s\n", __func__, slot_name(slot));
@@ -577,7 +576,6 @@ static int ctrl_slot_setup(struct controller *ctrl,
 			void __iomem *smbios_table)
 {
 	struct slot *slot;
-	struct hotplug_slot *hotplug_slot;
 	struct pci_bus *bus = ctrl->pci_bus;
 	u8 number_of_slots;
 	u8 slot_device;
@@ -603,14 +601,6 @@ static int ctrl_slot_setup(struct controller *ctrl,
 			goto error;
 		}
 
-		slot->hotplug_slot = kzalloc(sizeof(*(slot->hotplug_slot)),
-						GFP_KERNEL);
-		if (!slot->hotplug_slot) {
-			result = -ENOMEM;
-			goto error_slot;
-		}
-		hotplug_slot = slot->hotplug_slot;
-
 		slot->ctrl = ctrl;
 		slot->bus = ctrl->bus;
 		slot->device = slot_device;
@@ -659,21 +649,20 @@ static int ctrl_slot_setup(struct controller *ctrl,
 			((read_slot_enable(ctrl) << 2) >> ctrl_slot) & 0x04;
 
 		/* register this slot with the hotplug pci core */
-		hotplug_slot->private = slot;
 		snprintf(name, SLOT_NAME_SIZE, "%u", slot->number);
-		hotplug_slot->ops = &cpqphp_hotplug_slot_ops;
+		slot->hotplug_slot.ops = &cpqphp_hotplug_slot_ops;
 
 		dbg("registering bus %d, dev %d, number %d, ctrl->slot_device_offset %d, slot %d\n",
 				slot->bus, slot->device,
 				slot->number, ctrl->slot_device_offset,
 				slot_number);
-		result = pci_hp_register(hotplug_slot,
+		result = pci_hp_register(&slot->hotplug_slot,
 					 ctrl->pci_dev->bus,
 					 slot->device,
 					 name);
 		if (result) {
 			err("pci_hp_register failed with error %d\n", result);
-			goto error_hpslot;
+			goto error_slot;
 		}
 
 		slot->next = ctrl->slot;
@@ -685,8 +674,6 @@ static int ctrl_slot_setup(struct controller *ctrl,
 	}
 
 	return 0;
-error_hpslot:
-	kfree(hotplug_slot);
 error_slot:
 	kfree(slot);
 error:
diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index 9c4826ac6a4f..b7f4e1f099d9 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -1130,8 +1130,6 @@ static u8 set_controller_speed(struct controller *ctrl, u8 adapter_speed, u8 hp_
 	for (slot = ctrl->slot; slot; slot = slot->next) {
 		if (slot->device == (hp_slot + ctrl->slot_device_offset))
 			continue;
-		if (!slot->hotplug_slot)
-			continue;
 		if (get_presence_status(ctrl, slot) == 0)
 			continue;
 		/* If another adapter is running on the same segment but at a
diff --git a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
index db387e10581e..b89f850c3a4e 100644
--- a/drivers/pci/hotplug/ibmphp.h
+++ b/drivers/pci/hotplug/ibmphp.h
@@ -698,7 +698,7 @@ struct slot {
 	u8 supported_bus_mode;
 	u8 flag;		/* this is for disable slot and polling */
 	u8 ctlr_index;
-	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot hotplug_slot;
 	struct controller *ctrl;
 	struct pci_func *func;
 	u8 irq[4];
@@ -742,5 +742,10 @@ int ibmphp_configure_card(struct pci_func *, u8);
 int ibmphp_unconfigure_card(struct slot **, int);
 extern const struct hotplug_slot_ops ibmphp_hotplug_slot_ops;
 
+static inline struct slot *to_slot(struct hotplug_slot *hotplug_slot)
+{
+	return container_of(hotplug_slot, struct slot, hotplug_slot);
+}
+
 #endif				//__IBMPHP_H
 
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 96e5b1f544ac..08a58e911fc2 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -247,11 +247,8 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 			break;
 		}
 		if (rc == 0) {
-			pslot = hotplug_slot->private;
-			if (pslot)
-				rc = ibmphp_hpc_writeslot(pslot, cmd);
-			else
-				rc = -ENODEV;
+			pslot = to_slot(hotplug_slot);
+			rc = ibmphp_hpc_writeslot(pslot, cmd);
 		}
 	} else
 		rc = -ENODEV;
@@ -273,19 +270,15 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 	ibmphp_lock_operations();
 	if (hotplug_slot) {
-		pslot = hotplug_slot->private;
-		if (pslot) {
-			memcpy(&myslot, pslot, sizeof(struct slot));
-			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
-						&(myslot.status));
-			if (!rc)
-				rc = ibmphp_hpc_readslot(pslot,
-						READ_EXTSLOTSTATUS,
-						&(myslot.ext_status));
-			if (!rc)
-				*value = SLOT_ATTN(myslot.status,
-						myslot.ext_status);
-		}
+		pslot = to_slot(hotplug_slot);
+		memcpy(&myslot, pslot, sizeof(struct slot));
+		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
+					 &myslot.status);
+		if (!rc)
+			rc = ibmphp_hpc_readslot(pslot, READ_EXTSLOTSTATUS,
+						 &myslot.ext_status);
+		if (!rc)
+			*value = SLOT_ATTN(myslot.status, myslot.ext_status);
 	}
 
 	ibmphp_unlock_operations();
@@ -303,14 +296,12 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot) {
-		pslot = hotplug_slot->private;
-		if (pslot) {
-			memcpy(&myslot, pslot, sizeof(struct slot));
-			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
-						&(myslot.status));
-			if (!rc)
-				*value = SLOT_LATCH(myslot.status);
-		}
+		pslot = to_slot(hotplug_slot);
+		memcpy(&myslot, pslot, sizeof(struct slot));
+		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
+					 &myslot.status);
+		if (!rc)
+			*value = SLOT_LATCH(myslot.status);
 	}
 
 	ibmphp_unlock_operations();
@@ -330,14 +321,12 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot) {
-		pslot = hotplug_slot->private;
-		if (pslot) {
-			memcpy(&myslot, pslot, sizeof(struct slot));
-			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
-						&(myslot.status));
-			if (!rc)
-				*value = SLOT_PWRGD(myslot.status);
-		}
+		pslot = to_slot(hotplug_slot);
+		memcpy(&myslot, pslot, sizeof(struct slot));
+		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
+					 &myslot.status);
+		if (!rc)
+			*value = SLOT_PWRGD(myslot.status);
 	}
 
 	ibmphp_unlock_operations();
@@ -357,18 +346,16 @@ static int get_adapter_present(struct hotplug_slot *hotplug_slot, u8 *value)
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot) {
-		pslot = hotplug_slot->private;
-		if (pslot) {
-			memcpy(&myslot, pslot, sizeof(struct slot));
-			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
-						&(myslot.status));
-			if (!rc) {
-				present = SLOT_PRESENT(myslot.status);
-				if (present == HPC_SLOT_EMPTY)
-					*value = 0;
-				else
-					*value = 1;
-			}
+		pslot = to_slot(hotplug_slot);
+		memcpy(&myslot, pslot, sizeof(struct slot));
+		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
+					 &myslot.status);
+		if (!rc) {
+			present = SLOT_PRESENT(myslot.status);
+			if (present == HPC_SLOT_EMPTY)
+				*value = 0;
+			else
+				*value = 1;
 		}
 	}
 
@@ -382,7 +369,7 @@ static int get_max_bus_speed(struct slot *slot)
 	int rc = 0;
 	u8 mode = 0;
 	enum pci_bus_speed speed;
-	struct pci_bus *bus = slot->hotplug_slot->pci_slot->bus;
+	struct pci_bus *bus = slot->hotplug_slot.pci_slot->bus;
 
 	debug("%s - Entry slot[%p]\n", __func__, slot);
 
@@ -582,7 +569,7 @@ static int validate(struct slot *slot_cur, int opn)
  ****************************************************************************/
 int ibmphp_update_slot_info(struct slot *slot_cur)
 {
-	struct pci_bus *bus = slot_cur->hotplug_slot->pci_slot->bus;
+	struct pci_bus *bus = slot_cur->hotplug_slot.pci_slot->bus;
 	u8 bus_speed;
 	u8 mode;
 
@@ -652,7 +639,7 @@ static void free_slots(void)
 
 	list_for_each_entry_safe(slot_cur, next, &ibmphp_slot_head,
 				 ibm_slot_list) {
-		pci_hp_del(slot_cur->hotplug_slot);
+		pci_hp_del(&slot_cur->hotplug_slot);
 		slot_cur->ctrl = NULL;
 		slot_cur->bus_on = NULL;
 
@@ -662,8 +649,7 @@ static void free_slots(void)
 		 */
 		ibmphp_unconfigure_card(&slot_cur, -1);
 
-		pci_hp_destroy(slot_cur->hotplug_slot);
-		kfree(slot_cur->hotplug_slot);
+		pci_hp_destroy(&slot_cur->hotplug_slot);
 		kfree(slot_cur);
 	}
 	debug("%s -- exit\n", __func__);
@@ -985,7 +971,7 @@ static int enable_slot(struct hotplug_slot *hs)
 	ibmphp_lock_operations();
 
 	debug("ENABLING SLOT........\n");
-	slot_cur = hs->private;
+	slot_cur = to_slot(hs);
 
 	rc = validate(slot_cur, ENABLE);
 	if (rc) {
@@ -1146,7 +1132,7 @@ static int enable_slot(struct hotplug_slot *hs)
 **************************************************************/
 static int ibmphp_disable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	int rc;
 
 	ibmphp_lock_operations();
diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index c05d066ab0d5..11a2661dc062 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -666,10 +666,7 @@ static int fillslotinfo(struct hotplug_slot *hotplug_slot)
 	struct slot *slot;
 	int rc = 0;
 
-	if (!hotplug_slot || !hotplug_slot->private)
-		return -EINVAL;
-
-	slot = hotplug_slot->private;
+	slot = to_slot(hotplug_slot);
 	rc = ibmphp_hpc_readslot(slot, READ_ALLSTAT, NULL);
 	return rc;
 }
@@ -687,7 +684,6 @@ static int __init ebda_rsrc_controller(void)
 	u8 ctlr_id, temp, bus_index;
 	u16 ctlr, slot, bus;
 	u16 slot_num, bus_num, index;
-	struct hotplug_slot *hp_slot_ptr;
 	struct controller *hpc_ptr;
 	struct ebda_hpc_bus *bus_ptr;
 	struct ebda_hpc_slot *slot_ptr;
@@ -746,7 +742,7 @@ static int __init ebda_rsrc_controller(void)
 				bus_info_ptr1 = kzalloc(sizeof(struct bus_info), GFP_KERNEL);
 				if (!bus_info_ptr1) {
 					rc = -ENOMEM;
-					goto error_no_hp_slot;
+					goto error_no_slot;
 				}
 				bus_info_ptr1->slot_min = slot_ptr->slot_num;
 				bus_info_ptr1->slot_max = slot_ptr->slot_num;
@@ -817,7 +813,7 @@ static int __init ebda_rsrc_controller(void)
 						     (hpc_ptr->u.isa_ctlr.io_end - hpc_ptr->u.isa_ctlr.io_start + 1),
 						     "ibmphp")) {
 					rc = -ENODEV;
-					goto error_no_hp_slot;
+					goto error_no_slot;
 				}
 				hpc_ptr->irq = readb(io_mem + addr + 4);
 				addr += 5;
@@ -832,7 +828,7 @@ static int __init ebda_rsrc_controller(void)
 				break;
 			default:
 				rc = -ENODEV;
-				goto error_no_hp_slot;
+				goto error_no_slot;
 		}
 
 		//reorganize chassis' linked list
@@ -845,13 +841,6 @@ static int __init ebda_rsrc_controller(void)
 
 		// register slots with hpc core as well as create linked list of ibm slot
 		for (index = 0; index < hpc_ptr->slot_count; index++) {
-
-			hp_slot_ptr = kzalloc(sizeof(*hp_slot_ptr), GFP_KERNEL);
-			if (!hp_slot_ptr) {
-				rc = -ENOMEM;
-				goto error_no_hp_slot;
-			}
-
 			tmp_slot = kzalloc(sizeof(*tmp_slot), GFP_KERNEL);
 			if (!tmp_slot) {
 				rc = -ENOMEM;
@@ -878,7 +867,6 @@ static int __init ebda_rsrc_controller(void)
 
 			bus_info_ptr1 = ibmphp_find_same_bus_num(hpc_ptr->slots[index].slot_bus_num);
 			if (!bus_info_ptr1) {
-				kfree(tmp_slot);
 				rc = -ENODEV;
 				goto error;
 			}
@@ -888,22 +876,19 @@ static int __init ebda_rsrc_controller(void)
 
 			tmp_slot->ctlr_index = hpc_ptr->slots[index].ctl_index;
 			tmp_slot->number = hpc_ptr->slots[index].slot_num;
-			tmp_slot->hotplug_slot = hp_slot_ptr;
-
-			hp_slot_ptr->private = tmp_slot;
 
-			rc = fillslotinfo(hp_slot_ptr);
+			rc = fillslotinfo(&tmp_slot->hotplug_slot);
 			if (rc)
 				goto error;
 
-			rc = ibmphp_init_devno((struct slot **) &hp_slot_ptr->private);
+			rc = ibmphp_init_devno(&tmp_slot);
 			if (rc)
 				goto error;
-			hp_slot_ptr->ops = &ibmphp_hotplug_slot_ops;
+			tmp_slot->hotplug_slot.ops = &ibmphp_hotplug_slot_ops;
 
 			// end of registering ibm slot with hotplug core
 
-			list_add(&((struct slot *)(hp_slot_ptr->private))->ibm_slot_list, &ibmphp_slot_head);
+			list_add(&tmp_slot->ibm_slot_list, &ibmphp_slot_head);
 		}
 
 		print_bus_info();
@@ -913,7 +898,7 @@ static int __init ebda_rsrc_controller(void)
 
 	list_for_each_entry(tmp_slot, &ibmphp_slot_head, ibm_slot_list) {
 		snprintf(name, SLOT_NAME_SIZE, "%s", create_file_name(tmp_slot));
-		pci_hp_register(tmp_slot->hotplug_slot,
+		pci_hp_register(&tmp_slot->hotplug_slot,
 			pci_find_bus(0, tmp_slot->bus), tmp_slot->device, name);
 	}
 
@@ -922,10 +907,8 @@ static int __init ebda_rsrc_controller(void)
 	return 0;
 
 error:
-	kfree(hp_slot_ptr->private);
+	kfree(tmp_slot);
 error_no_slot:
-	kfree(hp_slot_ptr);
-error_no_hp_slot:
 	free_ebda_hpc(hpc_ptr);
 error_no_hpc:
 	iounmap(io_mem);
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index f3c0a376ffd5..b1179d445945 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -88,7 +88,7 @@ do {									\
  *	protects scheduling, execution and cancellation of @button_work
  * @button_work: work item to turn the slot on or off after 5 seconds
  *	in response to an Attention Button press
- * @hotplug_slot: pointer to the structure registered with the PCI hotplug core
+ * @hotplug_slot: structure registered with the PCI hotplug core
  * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
  *	Link Status register and to the Presence Detect State bit in the Slot
  *	Status register during a slot reset which may cause them to flap
@@ -120,7 +120,7 @@ struct controller {
 	struct mutex state_lock;
 	struct delayed_work button_work;
 
-	struct hotplug_slot *hotplug_slot;	/* hotplug core interface */
+	struct hotplug_slot hotplug_slot;	/* hotplug core interface */
 	struct rw_semaphore reset_lock;
 	int request_result;
 	wait_queue_head_t requester;
@@ -206,7 +206,12 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
 static inline const char *slot_name(struct controller *ctrl)
 {
-	return hotplug_slot_name(ctrl->hotplug_slot);
+	return hotplug_slot_name(&ctrl->hotplug_slot);
+}
+
+static inline struct controller *to_ctrl(struct hotplug_slot *hotplug_slot)
+{
+	return container_of(hotplug_slot, struct controller, hotplug_slot);
 }
 
 #endif				/* _PCIEHP_H */
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index dda90030005d..6292ddc0876b 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -51,19 +51,14 @@ static int get_adapter_status(struct hotplug_slot *slot, u8 *value);
 
 static int init_slot(struct controller *ctrl)
 {
-	struct hotplug_slot *hotplug = NULL;
-	struct hotplug_slot_ops *ops = NULL;
+	struct hotplug_slot_ops *ops;
 	char name[SLOT_NAME_SIZE];
-	int retval = -ENOMEM;
-
-	hotplug = kzalloc(sizeof(*hotplug), GFP_KERNEL);
-	if (!hotplug)
-		goto out;
+	int retval;
 
 	/* Setup hotplug slot ops */
 	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 	if (!ops)
-		goto out;
+		return -ENOMEM;
 
 	ops->enable_slot = pciehp_sysfs_enable_slot;
 	ops->disable_slot = pciehp_sysfs_disable_slot;
@@ -81,30 +76,24 @@ static int init_slot(struct controller *ctrl)
 	}
 
 	/* register this slot with the hotplug pci core */
-	hotplug->private = ctrl;
-	hotplug->ops = ops;
-	ctrl->hotplug_slot = hotplug;
+	ctrl->hotplug_slot.ops = ops;
 	snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
 
-	retval = pci_hp_initialize(hotplug,
+	retval = pci_hp_initialize(&ctrl->hotplug_slot,
 				   ctrl->pcie->port->subordinate, 0, name);
-	if (retval)
-		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
-out:
 	if (retval) {
+		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
 		kfree(ops);
-		kfree(hotplug);
 	}
 	return retval;
 }
 
 static void cleanup_slot(struct controller *ctrl)
 {
-	struct hotplug_slot *hotplug_slot = ctrl->hotplug_slot;
+	struct hotplug_slot *hotplug_slot = &ctrl->hotplug_slot;
 
 	pci_hp_destroy(hotplug_slot);
 	kfree(hotplug_slot->ops);
-	kfree(hotplug_slot);
 }
 
 /*
@@ -112,7 +101,7 @@ static void cleanup_slot(struct controller *ctrl)
  */
 static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 {
-	struct controller *ctrl = hotplug_slot->private;
+	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl->pcie->port;
 
 	pci_config_pm_runtime_get(pdev);
@@ -123,7 +112,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct controller *ctrl = hotplug_slot->private;
+	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl->pcie->port;
 
 	pci_config_pm_runtime_get(pdev);
@@ -134,7 +123,7 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct controller *ctrl = hotplug_slot->private;
+	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl->pcie->port;
 
 	pci_config_pm_runtime_get(pdev);
@@ -145,7 +134,7 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct controller *ctrl = hotplug_slot->private;
+	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl->pcie->port;
 
 	pci_config_pm_runtime_get(pdev);
@@ -223,7 +212,7 @@ static int pciehp_probe(struct pcie_device *dev)
 	}
 
 	/* Publish to user space */
-	rc = pci_hp_add(ctrl->hotplug_slot);
+	rc = pci_hp_add(&ctrl->hotplug_slot);
 	if (rc) {
 		ctrl_err(ctrl, "Publication to user space failed (%d)\n", rc);
 		goto err_out_shutdown_notification;
@@ -246,7 +235,7 @@ static void pciehp_remove(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
 
-	pci_hp_del(ctrl->hotplug_slot);
+	pci_hp_del(&ctrl->hotplug_slot);
 	pcie_shutdown_notification(ctrl);
 	cleanup_slot(ctrl);
 	pciehp_release_ctrl(ctrl);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 005d88ccbcaa..ba0ae8dae7dc 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -354,7 +354,7 @@ static int pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
 
 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct controller *ctrl = hotplug_slot->private;
+	struct controller *ctrl = to_ctrl(hotplug_slot);
 
 	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
@@ -392,7 +392,7 @@ int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 
 int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct controller *ctrl = hotplug_slot->private;
+	struct controller *ctrl = to_ctrl(hotplug_slot);
 
 	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 71ae78732145..6b0b0ed7c565 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -315,7 +315,7 @@ static int pciehp_link_enable(struct controller *ctrl)
 int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 				    u8 *status)
 {
-	struct controller *ctrl = hotplug_slot->private;
+	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 
@@ -328,7 +328,7 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 
 int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
 {
-	struct controller *ctrl = hotplug_slot->private;
+	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 
@@ -408,7 +408,7 @@ int pciehp_query_power_fault(struct controller *ctrl)
 int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 				    u8 status)
 {
-	struct controller *ctrl = hotplug_slot->private;
+	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 
 	pci_config_pm_runtime_get(pdev);
@@ -744,7 +744,7 @@ void pcie_clear_hotplug_events(struct controller *ctrl)
  */
 int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 {
-	struct controller *ctrl = hotplug_slot->private;
+	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 stat_mask = 0, ctrl_mask = 0;
 	int rc;
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 5bb63430262e..5070620a4f9f 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -336,7 +336,7 @@ static inline struct pnv_php_slot *to_pnv_php_slot(struct hotplug_slot *slot)
 int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 				 uint8_t state)
 {
-	struct pnv_php_slot *php_slot = slot->private;
+	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
 	struct opal_msg msg;
 	int ret;
 
@@ -368,7 +368,7 @@ EXPORT_SYMBOL_GPL(pnv_php_set_slot_power_state);
 
 static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 {
-	struct pnv_php_slot *php_slot = slot->private;
+	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
 	uint8_t power_state = OPAL_PCI_SLOT_POWER_ON;
 	int ret;
 
@@ -390,7 +390,7 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 
 static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 {
-	struct pnv_php_slot *php_slot = slot->private;
+	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
 	uint8_t presence = OPAL_PCI_SLOT_EMPTY;
 	int ret;
 
@@ -521,7 +521,7 @@ static int pnv_php_enable_slot(struct hotplug_slot *slot)
 
 static int pnv_php_disable_slot(struct hotplug_slot *slot)
 {
-	struct pnv_php_slot *php_slot = slot->private;
+	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
 	int ret;
 
 	if (php_slot->state != PNV_PHP_STATE_POPULATED)
@@ -607,7 +607,6 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	php_slot->id	                = id;
 	php_slot->power_state_check     = false;
 	php_slot->slot.ops              = &php_slot_ops;
-	php_slot->slot.private          = php_slot;
 
 	INIT_LIST_HEAD(&php_slot->children);
 	INIT_LIST_HEAD(&php_slot->link);
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 26a3dd731b5e..bdc954d70869 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -68,12 +68,17 @@ struct slot {
 	struct device_node *dn;
 	struct pci_bus *bus;
 	struct list_head *pci_devs;
-	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot hotplug_slot;
 };
 
 extern const struct hotplug_slot_ops rpaphp_hotplug_slot_ops;
 extern struct list_head rpaphp_slot_head;
 
+static inline struct slot *to_slot(struct hotplug_slot *hotplug_slot)
+{
+	return container_of(hotplug_slot, struct slot, hotplug_slot);
+}
+
 /* function prototypes */
 
 /* rpaphp_pci.c */
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 898e78dcd311..bcd5d357ca23 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -52,7 +52,7 @@ module_param_named(debug, rpaphp_debug, bool, 0644);
 static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 {
 	int rc;
-	struct slot *slot = (struct slot *)hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	switch (value) {
 	case 0:
@@ -79,7 +79,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	int retval, level;
-	struct slot *slot = (struct slot *)hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	retval = rtas_get_power_level(slot->power_domain, &level);
 	if (!retval)
@@ -94,14 +94,14 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
  */
 static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = (struct slot *)hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	*value = slot->attention_status;
 	return 0;
 }
 
 static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = (struct slot *)hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	int rc, state;
 
 	rc = rpaphp_get_sensor_state(slot, &state);
@@ -409,7 +409,7 @@ static void __exit cleanup_slots(void)
 	list_for_each_entry_safe(slot, next, &rpaphp_slot_head,
 				 rpaphp_slot_list) {
 		list_del(&slot->rpaphp_slot_list);
-		pci_hp_deregister(slot->hotplug_slot);
+		pci_hp_deregister(&slot->hotplug_slot);
 		dealloc_slot_struct(slot);
 	}
 	return;
@@ -434,7 +434,7 @@ static void __exit rpaphp_exit(void)
 
 static int enable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = (struct slot *)hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	int state;
 	int retval;
 
@@ -464,7 +464,7 @@ static int enable_slot(struct hotplug_slot *hotplug_slot)
 
 static int disable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = (struct slot *)hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	if (slot->state == NOT_CONFIGURED)
 		return -EINVAL;
 
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 6e2658ce300b..5282aa3e33c5 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -22,7 +22,6 @@
 void dealloc_slot_struct(struct slot *slot)
 {
 	kfree(slot->name);
-	kfree(slot->hotplug_slot);
 	kfree(slot);
 }
 
@@ -34,22 +33,16 @@ struct slot *alloc_slot_struct(struct device_node *dn,
 	slot = kzalloc(sizeof(struct slot), GFP_KERNEL);
 	if (!slot)
 		goto error_nomem;
-	slot->hotplug_slot = kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
-	if (!slot->hotplug_slot)
-		goto error_slot;
 	slot->name = kstrdup(drc_name, GFP_KERNEL);
 	if (!slot->name)
-		goto error_hpslot;
+		goto error_slot;
 	slot->dn = dn;
 	slot->index = drc_index;
 	slot->power_domain = power_domain;
-	slot->hotplug_slot->private = slot;
-	slot->hotplug_slot->ops = &rpaphp_hotplug_slot_ops;
+	slot->hotplug_slot.ops = &rpaphp_hotplug_slot_ops;
 
 	return (slot);
 
-error_hpslot:
-	kfree(slot->hotplug_slot);
 error_slot:
 	kfree(slot);
 error_nomem:
@@ -70,7 +63,7 @@ static int is_registered(struct slot *slot)
 int rpaphp_deregister_slot(struct slot *slot)
 {
 	int retval = 0;
-	struct hotplug_slot *php_slot = slot->hotplug_slot;
+	struct hotplug_slot *php_slot = &slot->hotplug_slot;
 
 	 dbg("%s - Entry: deregistering slot=%s\n",
 		__func__, slot->name);
@@ -86,7 +79,7 @@ EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
 
 int rpaphp_register_slot(struct slot *slot)
 {
-	struct hotplug_slot *php_slot = slot->hotplug_slot;
+	struct hotplug_slot *php_slot = &slot->hotplug_slot;
 	struct device_node *child;
 	u32 my_index;
 	int retval;
diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index d04634b0defe..30ee72268790 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -32,10 +32,15 @@ static int zpci_fn_configured(enum zpci_state state)
  */
 struct slot {
 	struct list_head slot_list;
-	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot hotplug_slot;
 	struct zpci_dev *zdev;
 };
 
+static inline struct slot *to_slot(struct hotplug_slot *hotplug_slot)
+{
+	return container_of(hotplug_slot, struct slot, hotplug_slot);
+}
+
 static inline int slot_configure(struct slot *slot)
 {
 	int ret = sclp_pci_configure(slot->zdev->fid);
@@ -60,7 +65,7 @@ static inline int slot_deconfigure(struct slot *slot)
 
 static int enable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	int rc;
 
 	if (slot->zdev->state != ZPCI_FN_STATE_STANDBY)
@@ -88,7 +93,7 @@ static int enable_slot(struct hotplug_slot *hotplug_slot)
 
 static int disable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 	struct pci_dev *pdev;
 	int rc;
 
@@ -110,7 +115,7 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
+	struct slot *slot = to_slot(hotplug_slot);
 
 	switch (slot->zdev->state) {
 	case ZPCI_FN_STATE_STANDBY:
@@ -139,7 +144,6 @@ static const struct hotplug_slot_ops s390_hotplug_slot_ops = {
 
 int zpci_init_slot(struct zpci_dev *zdev)
 {
-	struct hotplug_slot *hotplug_slot;
 	char name[SLOT_NAME_SIZE];
 	struct slot *slot;
 	int rc;
@@ -151,18 +155,11 @@ int zpci_init_slot(struct zpci_dev *zdev)
 	if (!slot)
 		goto error;
 
-	hotplug_slot = kzalloc(sizeof(*hotplug_slot), GFP_KERNEL);
-	if (!hotplug_slot)
-		goto error_hp;
-	hotplug_slot->private = slot;
-
-	slot->hotplug_slot = hotplug_slot;
 	slot->zdev = zdev;
-
-	hotplug_slot->ops = &s390_hotplug_slot_ops;
+	slot->hotplug_slot.ops = &s390_hotplug_slot_ops;
 
 	snprintf(name, SLOT_NAME_SIZE, "%08x", zdev->fid);
-	rc = pci_hp_register(slot->hotplug_slot, zdev->bus,
+	rc = pci_hp_register(&slot->hotplug_slot, zdev->bus,
 			     ZPCI_DEVFN, name);
 	if (rc)
 		goto error_reg;
@@ -171,8 +168,6 @@ int zpci_init_slot(struct zpci_dev *zdev)
 	return 0;
 
 error_reg:
-	kfree(hotplug_slot);
-error_hp:
 	kfree(slot);
 error:
 	return -ENOMEM;
@@ -187,8 +182,7 @@ void zpci_exit_slot(struct zpci_dev *zdev)
 		if (slot->zdev != zdev)
 			continue;
 		list_del(&slot->slot_list);
-		pci_hp_deregister(slot->hotplug_slot);
-		kfree(slot->hotplug_slot);
+		pci_hp_deregister(&slot->hotplug_slot);
 		kfree(slot);
 	}
 }
diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index e103826c83e3..231f5bdd3d2d 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -56,7 +56,7 @@ struct slot {
 	int device_num;
 	struct pci_bus *pci_bus;
 	/* this struct for glue internal only */
-	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot hotplug_slot;
 	struct list_head hp_list;
 	char physical_path[SN_SLOT_NAME_SIZE];
 };
@@ -88,10 +88,15 @@ static const struct hotplug_slot_ops sn_hotplug_slot_ops = {
 
 static DEFINE_MUTEX(sn_hotplug_mutex);
 
+static struct slot *to_slot(struct hotplug_slot *bss_hotplug_slot)
+{
+	return container_of(bss_hotplug_slot, struct slot, hotplug_slot);
+}
+
 static ssize_t path_show(struct pci_slot *pci_slot, char *buf)
 {
 	int retval = -ENOENT;
-	struct slot *slot = pci_slot->hotplug->private;
+	struct slot *slot = to_slot(pci_slot->hotplug);
 
 	if (!slot)
 		return retval;
@@ -156,7 +161,7 @@ static int sn_pci_bus_valid(struct pci_bus *pci_bus)
 	return -EIO;
 }
 
-static int sn_hp_slot_private_alloc(struct hotplug_slot *bss_hotplug_slot,
+static int sn_hp_slot_private_alloc(struct hotplug_slot **bss_hotplug_slot,
 				    struct pci_bus *pci_bus, int device,
 				    char *name)
 {
@@ -168,7 +173,6 @@ static int sn_hp_slot_private_alloc(struct hotplug_slot *bss_hotplug_slot,
 	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
 	if (!slot)
 		return -ENOMEM;
-	bss_hotplug_slot->private = slot;
 
 	slot->device_num = device;
 	slot->pci_bus = pci_bus;
@@ -179,8 +183,8 @@ static int sn_hp_slot_private_alloc(struct hotplug_slot *bss_hotplug_slot,
 
 	sn_generate_path(pci_bus, slot->physical_path);
 
-	slot->hotplug_slot = bss_hotplug_slot;
 	list_add(&slot->hp_list, &sn_hp_list);
+	*bss_hotplug_slot = &slot->hotplug_slot;
 
 	return 0;
 }
@@ -192,10 +196,9 @@ static struct hotplug_slot *sn_hp_destroy(void)
 	struct hotplug_slot *bss_hotplug_slot = NULL;
 
 	list_for_each_entry(slot, &sn_hp_list, hp_list) {
-		bss_hotplug_slot = slot->hotplug_slot;
+		bss_hotplug_slot = &slot->hotplug_slot;
 		pci_slot = bss_hotplug_slot->pci_slot;
-		list_del(&((struct slot *)bss_hotplug_slot->private)->
-			 hp_list);
+		list_del(&slot->hp_list);
 		sysfs_remove_file(&pci_slot->kobj,
 				  &sn_slot_path_attr.attr);
 		break;
@@ -227,7 +230,7 @@ static void sn_bus_free_data(struct pci_dev *dev)
 static int sn_slot_enable(struct hotplug_slot *bss_hotplug_slot,
 			  int device_num, char **ssdt)
 {
-	struct slot *slot = bss_hotplug_slot->private;
+	struct slot *slot = to_slot(bss_hotplug_slot);
 	struct pcibus_info *pcibus_info;
 	struct pcibr_slot_enable_resp resp;
 	int rc;
@@ -267,7 +270,7 @@ static int sn_slot_enable(struct hotplug_slot *bss_hotplug_slot,
 static int sn_slot_disable(struct hotplug_slot *bss_hotplug_slot,
 			   int device_num, int action)
 {
-	struct slot *slot = bss_hotplug_slot->private;
+	struct slot *slot = to_slot(bss_hotplug_slot);
 	struct pcibus_info *pcibus_info;
 	struct pcibr_slot_disable_resp resp;
 	int rc;
@@ -323,7 +326,7 @@ static int sn_slot_disable(struct hotplug_slot *bss_hotplug_slot,
  */
 static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 {
-	struct slot *slot = bss_hotplug_slot->private;
+	struct slot *slot = to_slot(bss_hotplug_slot);
 	struct pci_bus *new_bus = NULL;
 	struct pci_dev *dev;
 	int num_funcs;
@@ -469,7 +472,7 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 
 static int disable_slot(struct hotplug_slot *bss_hotplug_slot)
 {
-	struct slot *slot = bss_hotplug_slot->private;
+	struct slot *slot = to_slot(bss_hotplug_slot);
 	struct pci_dev *dev, *temp;
 	int rc;
 	acpi_handle ssdt_hdl = NULL;
@@ -571,7 +574,7 @@ static int disable_slot(struct hotplug_slot *bss_hotplug_slot)
 static inline int get_power_status(struct hotplug_slot *bss_hotplug_slot,
 				   u8 *value)
 {
-	struct slot *slot = bss_hotplug_slot->private;
+	struct slot *slot = to_slot(bss_hotplug_slot);
 	struct pcibus_info *pcibus_info;
 	u32 power;
 
@@ -585,8 +588,7 @@ static inline int get_power_status(struct hotplug_slot *bss_hotplug_slot,
 
 static void sn_release_slot(struct hotplug_slot *bss_hotplug_slot)
 {
-	kfree(bss_hotplug_slot->private);
-	kfree(bss_hotplug_slot);
+	kfree(to_slot(bss_hotplug_slot));
 }
 
 static int sn_hotplug_slot_register(struct pci_bus *pci_bus)
@@ -606,14 +608,7 @@ static int sn_hotplug_slot_register(struct pci_bus *pci_bus)
 		if (sn_pci_slot_valid(pci_bus, device) != 1)
 			continue;
 
-		bss_hotplug_slot = kzalloc(sizeof(*bss_hotplug_slot),
-					   GFP_KERNEL);
-		if (!bss_hotplug_slot) {
-			rc = -ENOMEM;
-			goto alloc_err;
-		}
-
-		if (sn_hp_slot_private_alloc(bss_hotplug_slot,
+		if (sn_hp_slot_private_alloc(&bss_hotplug_slot,
 					     pci_bus, device, name)) {
 			rc = -ENOMEM;
 			goto alloc_err;
@@ -628,7 +623,7 @@ static int sn_hotplug_slot_register(struct pci_bus *pci_bus)
 		rc = sysfs_create_file(&pci_slot->kobj,
 				       &sn_slot_path_attr.attr);
 		if (rc)
-			goto register_err;
+			goto alloc_err;
 	}
 	pci_dbg(pci_bus->self, "Registered bus with hotplug\n");
 	return rc;
@@ -637,14 +632,11 @@ static int sn_hotplug_slot_register(struct pci_bus *pci_bus)
 	pci_dbg(pci_bus->self, "bus failed to register with err = %d\n",
 		rc);
 
-alloc_err:
-	if (rc == -ENOMEM)
-		pci_dbg(pci_bus->self, "Memory allocation error\n");
-
 	/* destroy THIS element */
-	if (bss_hotplug_slot)
-		sn_release_slot(bss_hotplug_slot);
+	sn_hp_destroy();
+	sn_release_slot(bss_hotplug_slot);
 
+alloc_err:
 	/* destroy anything else on the list */
 	while ((bss_hotplug_slot = sn_hp_destroy())) {
 		pci_hp_deregister(bss_hotplug_slot);
diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index a7bb816e6f25..f7f13ee5d06e 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -73,7 +73,7 @@ struct slot {
 	u8 pwr_save;
 	struct controller *ctrl;
 	const struct hpc_ops *hpc_ops;
-	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot hotplug_slot;
 	struct list_head	slot_list;
 	struct delayed_work work;	/* work for button event */
 	struct mutex lock;
@@ -171,7 +171,7 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev);
 
 static inline const char *slot_name(struct slot *slot)
 {
-	return hotplug_slot_name(slot->hotplug_slot);
+	return hotplug_slot_name(&slot->hotplug_slot);
 }
 
 struct ctrl_reg {
@@ -209,7 +209,7 @@ enum ctrl_offsets {
 
 static inline struct slot *get_slot(struct hotplug_slot *hotplug_slot)
 {
-	return hotplug_slot->private;
+	return container_of(hotplug_slot, struct slot, hotplug_slot);
 }
 
 static inline struct slot *shpchp_find_slot(struct controller *ctrl, u8 device)
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index b7181b7e7b98..81a918d47895 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -76,12 +76,7 @@ static int init_slots(struct controller *ctrl)
 			goto error;
 		}
 
-		hotplug_slot = kzalloc(sizeof(*hotplug_slot), GFP_KERNEL);
-		if (!hotplug_slot) {
-			retval = -ENOMEM;
-			goto error_slot;
-		}
-		slot->hotplug_slot = hotplug_slot;
+		hotplug_slot = &slot->hotplug_slot;
 
 		slot->hp_slot = i;
 		slot->ctrl = ctrl;
@@ -93,14 +88,13 @@ static int init_slots(struct controller *ctrl)
 		slot->wq = alloc_workqueue("shpchp-%d", 0, 0, slot->number);
 		if (!slot->wq) {
 			retval = -ENOMEM;
-			goto error_hpslot;
+			goto error_slot;
 		}
 
 		mutex_init(&slot->lock);
 		INIT_DELAYED_WORK(&slot->work, shpchp_queue_pushbutton_work);
 
 		/* register this slot with the hotplug pci core */
-		hotplug_slot->private = slot;
 		snprintf(name, SLOT_NAME_SIZE, "%d", slot->number);
 		hotplug_slot->ops = &shpchp_hotplug_slot_ops;
 
@@ -108,7 +102,7 @@ static int init_slots(struct controller *ctrl)
 			 pci_domain_nr(ctrl->pci_dev->subordinate),
 			 slot->bus, slot->device, slot->hp_slot, slot->number,
 			 ctrl->slot_device_offset);
-		retval = pci_hp_register(slot->hotplug_slot,
+		retval = pci_hp_register(hotplug_slot,
 				ctrl->pci_dev->subordinate, slot->device, name);
 		if (retval) {
 			ctrl_err(ctrl, "pci_hp_register failed with error %d\n",
@@ -127,8 +121,6 @@ static int init_slots(struct controller *ctrl)
 	return 0;
 error_slotwq:
 	destroy_workqueue(slot->wq);
-error_hpslot:
-	kfree(hotplug_slot);
 error_slot:
 	kfree(slot);
 error:
@@ -143,8 +135,7 @@ void cleanup_slots(struct controller *ctrl)
 		list_del(&slot->slot_list);
 		cancel_delayed_work(&slot->work);
 		destroy_workqueue(slot->wq);
-		pci_hp_deregister(slot->hotplug_slot);
-		kfree(slot->hotplug_slot);
+		pci_hp_deregister(&slot->hotplug_slot);
 		kfree(slot);
 	}
 }
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a2130dd2db3c..5dac33474aea 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -253,7 +253,7 @@ struct asus_wmi {
 	int asus_hwmon_num_fans;
 	int asus_hwmon_pwm;
 
-	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
 	struct mutex wmi_lock;
 	struct workqueue_struct *hotplug_workqueue;
@@ -743,7 +743,7 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
 	if (asus->wlan.rfkill)
 		rfkill_set_sw_state(asus->wlan.rfkill, blocked);
 
-	if (asus->hotplug_slot) {
+	if (asus->hotplug_slot.ops) {
 		bus = pci_find_bus(0, 1);
 		if (!bus) {
 			pr_warn("Unable to find PCI bus 1?\n");
@@ -848,7 +848,8 @@ static void asus_unregister_rfkill_notifier(struct asus_wmi *asus, char *node)
 static int asus_get_adapter_status(struct hotplug_slot *hotplug_slot,
 				   u8 *value)
 {
-	struct asus_wmi *asus = hotplug_slot->private;
+	struct asus_wmi *asus = container_of(hotplug_slot,
+					     struct asus_wmi, hotplug_slot);
 	int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_WLAN);
 
 	if (result < 0)
@@ -888,14 +889,9 @@ static int asus_setup_pci_hotplug(struct asus_wmi *asus)
 
 	INIT_WORK(&asus->hotplug_work, asus_hotplug_work);
 
-	asus->hotplug_slot = kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
-	if (!asus->hotplug_slot)
-		goto error_slot;
+	asus->hotplug_slot.ops = &asus_hotplug_slot_ops;
 
-	asus->hotplug_slot->private = asus;
-	asus->hotplug_slot->ops = &asus_hotplug_slot_ops;
-
-	ret = pci_hp_register(asus->hotplug_slot, bus, 0, "asus-wifi");
+	ret = pci_hp_register(&asus->hotplug_slot, bus, 0, "asus-wifi");
 	if (ret) {
 		pr_err("Unable to register hotplug slot - %d\n", ret);
 		goto error_register;
@@ -904,9 +900,7 @@ static int asus_setup_pci_hotplug(struct asus_wmi *asus)
 	return 0;
 
 error_register:
-	kfree(asus->hotplug_slot);
-	asus->hotplug_slot = NULL;
-error_slot:
+	asus->hotplug_slot.ops = NULL;
 	destroy_workqueue(asus->hotplug_workqueue);
 error_workqueue:
 	return ret;
@@ -1034,10 +1028,8 @@ static void asus_wmi_rfkill_exit(struct asus_wmi *asus)
 	 * asus_unregister_rfkill_notifier()
 	 */
 	asus_rfkill_hotplug(asus);
-	if (asus->hotplug_slot) {
-		pci_hp_deregister(asus->hotplug_slot);
-		kfree(asus->hotplug_slot);
-	}
+	if (asus->hotplug_slot.ops)
+		pci_hp_deregister(&asus->hotplug_slot);
 	if (asus->hotplug_workqueue)
 		destroy_workqueue(asus->hotplug_workqueue);
 
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 028b20f82962..e6946a9beb5a 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -177,7 +177,7 @@ struct eeepc_laptop {
 	struct rfkill *wwan3g_rfkill;
 	struct rfkill *wimax_rfkill;
 
-	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
 
 	struct led_classdev tpd_led;
@@ -582,7 +582,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
 	mutex_lock(&eeepc->hotplug_lock);
 	pci_lock_rescan_remove();
 
-	if (!eeepc->hotplug_slot)
+	if (!eeepc->hotplug_slot.ops)
 		goto out_unlock;
 
 	port = acpi_get_pci_dev(handle);
@@ -715,8 +715,11 @@ static void eeepc_unregister_rfkill_notifier(struct eeepc_laptop *eeepc,
 static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
 				    u8 *value)
 {
-	struct eeepc_laptop *eeepc = hotplug_slot->private;
-	int val = get_acpi(eeepc, CM_ASL_WLAN);
+	struct eeepc_laptop *eeepc;
+	int val;
+
+	eeepc = container_of(hotplug_slot, struct eeepc_laptop, hotplug_slot);
+	val = get_acpi(eeepc, CM_ASL_WLAN);
 
 	if (val == 1 || val == 0)
 		*value = val;
@@ -741,14 +744,9 @@ static int eeepc_setup_pci_hotplug(struct eeepc_laptop *eeepc)
 		return -ENODEV;
 	}
 
-	eeepc->hotplug_slot = kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
-	if (!eeepc->hotplug_slot)
-		goto error_slot;
+	eeepc->hotplug_slot.ops = &eeepc_hotplug_slot_ops;
 
-	eeepc->hotplug_slot->private = eeepc;
-	eeepc->hotplug_slot->ops = &eeepc_hotplug_slot_ops;
-
-	ret = pci_hp_register(eeepc->hotplug_slot, bus, 0, "eeepc-wifi");
+	ret = pci_hp_register(&eeepc->hotplug_slot, bus, 0, "eeepc-wifi");
 	if (ret) {
 		pr_err("Unable to register hotplug slot - %d\n", ret);
 		goto error_register;
@@ -757,9 +755,7 @@ static int eeepc_setup_pci_hotplug(struct eeepc_laptop *eeepc)
 	return 0;
 
 error_register:
-	kfree(eeepc->hotplug_slot);
-	eeepc->hotplug_slot = NULL;
-error_slot:
+	eeepc->hotplug_slot.ops = NULL;
 	return ret;
 }
 
@@ -820,10 +816,8 @@ static void eeepc_rfkill_exit(struct eeepc_laptop *eeepc)
 		eeepc->wlan_rfkill = NULL;
 	}
 
-	if (eeepc->hotplug_slot) {
-		pci_hp_deregister(eeepc->hotplug_slot);
-		kfree(eeepc->hotplug_slot);
-	}
+	if (eeepc->hotplug_slot.ops)
+		pci_hp_deregister(&eeepc->hotplug_slot);
 
 	if (eeepc->bluetooth_rfkill) {
 		rfkill_unregister(eeepc->bluetooth_rfkill);
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 6f07a4e1de8d..7acc9f91e72b 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -50,14 +50,11 @@ struct hotplug_slot_ops {
 /**
  * struct hotplug_slot - used to register a physical slot with the hotplug pci core
  * @ops: pointer to the &struct hotplug_slot_ops to be used for this slot
- * @private: used by the hotplug pci controller driver to store whatever it
- * needs.
  * @owner: The module owner of this structure
  * @mod_name: The module name (KBUILD_MODNAME) of this structure
  */
 struct hotplug_slot {
 	const struct hotplug_slot_ops	*ops;
-	void				*private;
 
 	/* Variables below this are for use only by the hotplug pci core. */
 	struct list_head		slot_list;
-- 
2.18.0
