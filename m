From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 7/9] PCI: hotplug: Drop hotplug_slot_info
Date: Sun, 19 Aug 2018 16:29:00 +0200
Message-ID: <a364bcc959e01f2ebab27cefc5b87ff01633275c.1534686485.git.lukas@wunner.de>
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

Ever since the PCI hotplug core was introduced in 2002, drivers had to
allocate and register a struct hotplug_slot_info for every slot:
https://git.kernel.org/tglx/history/c/a8a2069f432c

Apparently the idea was that drivers furnish the hotplug core with an
up-to-date card presence status, power status, latch status and
attention indicator status as well as notify the hotplug core of changes
thereof.  However only 4 out of 12 hotplug drivers bother to notify the
hotplug core with pci_hp_change_slot_info() and the hotplug core never
made any use of the information:  There is just a single macro in
pci_hotplug_core.c, GET_STATUS(), which uses the hotplug_slot_info if
the driver lacks the corresponding callback in hotplug_slot_ops.  The
macro is called when the user reads the attribute via sysfs.

Now, if the callback isn't defined, the attribute isn't exposed in sysfs
in the first place (see e.g. has_power_file()).  There are only two
situations when the hotplug_slot_info would actually be accessed:

* If the driver defines ->enable_slot or ->disable_slot but not
  ->get_power_status.

* If the driver defines ->set_attention_status but not
  ->get_attention_status.

There is no driver doing the former and just a single driver doing the
latter, namely pnv_php.c.  Amend it with a ->get_attention_status
callback.  With that, the hotplug_slot_info becomes completely unused by
the PCI hotplug core.  But a few drivers use it internally as a cache:

cpcihp uses it to cache the latch_status and adapter_status.
cpqhp uses it to cache the adapter_status.
pnv_php and rpaphp use it to cache the attention_status.
shpchp uses it to cache all four values.

Amend these drivers to cache the information in their private slot
struct.  shpchp's slot struct already contains members to cache the
power_status and adapter_status, so additional members are only needed
for the other two values.  In the case of cpqphp, the cached value is
only accessed in a single place, so instead of caching it, read the
current value from the hardware.

Caution:  acpiphp, cpci, cpqhp, shpchp, asus-wmi and eeepc-laptop
populate the hotplug_slot_info with initial values on probe.  That code
is herewith removed.  There is a theoretical chance that the code has
side effects without which the driver fails to function, e.g. if the
ACPI method to read the adapter status needs to be executed at least
once on probe.  That seems unlikely to me, still maintainers should
review the changes carefully for this possibility.

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
 arch/powerpc/include/asm/pnv-pci.h      |  2 +-
 drivers/pci/hotplug/acpiphp.h           |  1 -
 drivers/pci/hotplug/acpiphp_core.c      |  6 ---
 drivers/pci/hotplug/cpci_hotplug.h      |  2 +
 drivers/pci/hotplug/cpci_hotplug_core.c | 72 +++++--------------------
 drivers/pci/hotplug/cpqphp_core.c       | 22 +-------
 drivers/pci/hotplug/cpqphp_ctrl.c       | 31 +----------
 drivers/pci/hotplug/ibmphp_core.c       | 27 +---------
 drivers/pci/hotplug/ibmphp_ebda.c       | 33 ------------
 drivers/pci/hotplug/pci_hotplug_core.c  | 26 +--------
 drivers/pci/hotplug/pciehp_core.c       |  8 ---
 drivers/pci/hotplug/pnv_php.c           | 24 ++++++---
 drivers/pci/hotplug/rpaphp.h            |  1 +
 drivers/pci/hotplug/rpaphp_core.c       |  4 +-
 drivers/pci/hotplug/rpaphp_pci.c        | 11 +---
 drivers/pci/hotplug/rpaphp_slot.c       |  9 +---
 drivers/pci/hotplug/s390_pci_hpc.c      | 12 -----
 drivers/pci/hotplug/sgi_hotplug.c       |  9 ----
 drivers/pci/hotplug/shpchp.h            |  2 +
 drivers/pci/hotplug/shpchp_core.c       | 31 ++++-------
 drivers/pci/hotplug/shpchp_ctrl.c       | 21 ++------
 drivers/platform/x86/asus-wmi.c         | 10 ----
 drivers/platform/x86/eeepc-laptop.c     | 10 ----
 include/linux/pci_hotplug.h             | 30 -----------
 24 files changed, 64 insertions(+), 340 deletions(-)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 7f627e3f4da4..630eb8b1b7ed 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -54,7 +54,6 @@ void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
 
 struct pnv_php_slot {
 	struct hotplug_slot		slot;
-	struct hotplug_slot_info	slot_info;
 	uint64_t			id;
 	char				*name;
 	int				slot_no;
@@ -72,6 +71,7 @@ struct pnv_php_slot {
 	struct pci_dev			*pdev;
 	struct pci_bus			*bus;
 	bool				power_state_check;
+	u8				attention_state;
 	void				*fdt;
 	void				*dt;
 	struct of_changeset		ocs;
diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index e438a2d734f2..8377e736ea69 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -35,7 +35,6 @@ struct acpiphp_slot;
 struct slot {
 	struct hotplug_slot	*hotplug_slot;
 	struct acpiphp_slot	*acpi_slot;
-	struct hotplug_slot_info info;
 	unsigned int sun;	/* ACPI _SUN (Slot User Number) value */
 };
 
diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
index e883cef0f3bc..abd4f8d7e16a 100644
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -270,16 +270,10 @@ int acpiphp_register_hotplug_slot(struct acpiphp_slot *acpiphp_slot,
 	if (!slot->hotplug_slot)
 		goto error_slot;
 
-	slot->hotplug_slot->info = &slot->info;
-
 	slot->hotplug_slot->private = slot;
 	slot->hotplug_slot->ops = &acpi_hotplug_slot_ops;
 
 	slot->acpi_slot = acpiphp_slot;
-	slot->hotplug_slot->info->power_status = acpiphp_get_power_status(slot->acpi_slot);
-	slot->hotplug_slot->info->attention_status = 0;
-	slot->hotplug_slot->info->latch_status = acpiphp_get_latch_status(slot->acpi_slot);
-	slot->hotplug_slot->info->adapter_status = acpiphp_get_adapter_status(slot->acpi_slot);
 
 	acpiphp_slot->slot = slot;
 	slot->sun = sun;
diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
index 4658557be01a..146b06fd12c0 100644
--- a/drivers/pci/hotplug/cpci_hotplug.h
+++ b/drivers/pci/hotplug/cpci_hotplug.h
@@ -32,6 +32,8 @@ struct slot {
 	unsigned int devfn;
 	struct pci_bus *bus;
 	struct pci_dev *dev;
+	bool latch_status;
+	bool adapter_status;
 	unsigned int extracting;
 	struct hotplug_slot *hotplug_slot;
 	struct list_head slot_list;
diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index 97c32e4c74c8..a17fb24c28cd 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -67,26 +67,6 @@ static const struct hotplug_slot_ops cpci_hotplug_slot_ops = {
 	.get_latch_status = get_latch_status,
 };
 
-static int
-update_latch_status(struct hotplug_slot *hotplug_slot, u8 value)
-{
-	struct hotplug_slot_info info;
-
-	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
-	info.latch_status = value;
-	return pci_hp_change_slot_info(hotplug_slot, &info);
-}
-
-static int
-update_adapter_status(struct hotplug_slot *hotplug_slot, u8 value)
-{
-	struct hotplug_slot_info info;
-
-	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
-	info.adapter_status = value;
-	return pci_hp_change_slot_info(hotplug_slot, &info);
-}
-
 static int
 enable_slot(struct hotplug_slot *hotplug_slot)
 {
@@ -135,8 +115,7 @@ disable_slot(struct hotplug_slot *hotplug_slot)
 			goto disable_error;
 	}
 
-	if (update_adapter_status(slot->hotplug_slot, 0))
-		warn("failure to update adapter file");
+	slot->adapter_status = 0;
 
 	if (slot->extracting) {
 		slot->extracting = 0;
@@ -184,20 +163,23 @@ set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 static int
 get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	*value = hotplug_slot->info->adapter_status;
+	struct slot *slot = hotplug_slot->private;
+
+	*value = slot->adapter_status;
 	return 0;
 }
 
 static int
 get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	*value = hotplug_slot->info->latch_status;
+	struct slot *slot = hotplug_slot->private;
+
+	*value = slot->latch_status;
 	return 0;
 }
 
 static void release_slot(struct slot *slot)
 {
-	kfree(slot->hotplug_slot->info);
 	kfree(slot->hotplug_slot);
 	pci_dev_put(slot->dev);
 	kfree(slot);
@@ -210,7 +192,6 @@ cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last)
 {
 	struct slot *slot;
 	struct hotplug_slot *hotplug_slot;
-	struct hotplug_slot_info *info;
 	char name[SLOT_NAME_SIZE];
 	int status;
 	int i;
@@ -237,13 +218,6 @@ cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last)
 		}
 		slot->hotplug_slot = hotplug_slot;
 
-		info = kzalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
-		if (!info) {
-			status = -ENOMEM;
-			goto error_hpslot;
-		}
-		hotplug_slot->info = info;
-
 		slot->bus = bus;
 		slot->number = i;
 		slot->devfn = PCI_DEVFN(i, 0);
@@ -253,19 +227,11 @@ cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last)
 		hotplug_slot->private = slot;
 		hotplug_slot->ops = &cpci_hotplug_slot_ops;
 
-		/*
-		 * Initialize the slot info structure with some known
-		 * good values.
-		 */
-		dbg("initializing slot %s", name);
-		info->power_status = cpci_get_power_status(slot);
-		info->attention_status = cpci_get_attention_status(slot);
-
 		dbg("registering slot %s", name);
 		status = pci_hp_register(slot->hotplug_slot, bus, i, name);
 		if (status) {
 			err("pci_hp_register failed with error %d", status);
-			goto error_info;
+			goto error_hpslot;
 		}
 		dbg("slot registered with name: %s", slot_name(slot));
 
@@ -276,8 +242,6 @@ cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last)
 		up_write(&list_rwsem);
 	}
 	return 0;
-error_info:
-	kfree(info);
 error_hpslot:
 	kfree(hotplug_slot);
 error_slot:
@@ -359,10 +323,8 @@ init_slots(int clear_ins)
 			    __func__, slot_name(slot));
 		dev = pci_get_slot(slot->bus, PCI_DEVFN(slot->number, 0));
 		if (dev) {
-			if (update_adapter_status(slot->hotplug_slot, 1))
-				warn("failure to update adapter file");
-			if (update_latch_status(slot->hotplug_slot, 1))
-				warn("failure to update latch file");
+			slot->adapter_status = 1;
+			slot->latch_status = 1;
 			slot->dev = dev;
 		}
 	}
@@ -424,11 +386,8 @@ check_slots(void)
 			dbg("%s - slot %s HS_CSR (2) = %04x",
 			    __func__, slot_name(slot), hs_csr);
 
-			if (update_latch_status(slot->hotplug_slot, 1))
-				warn("failure to update latch file");
-
-			if (update_adapter_status(slot->hotplug_slot, 1))
-				warn("failure to update adapter file");
+			slot->latch_status = 1;
+			slot->adapter_status = 1;
 
 			cpci_led_off(slot);
 
@@ -449,9 +408,7 @@ check_slots(void)
 			    __func__, slot_name(slot), hs_csr);
 
 			if (!slot->extracting) {
-				if (update_latch_status(slot->hotplug_slot, 0))
-					warn("failure to update latch file");
-
+				slot->latch_status = 0;
 				slot->extracting = 1;
 				atomic_inc(&extracting);
 			}
@@ -465,8 +422,7 @@ check_slots(void)
 				 */
 				err("card in slot %s was improperly removed",
 				    slot_name(slot));
-				if (update_adapter_status(slot->hotplug_slot, 0))
-					warn("failure to update adapter file");
+				slot->adapter_status = 0;
 				slot->extracting = 0;
 				atomic_dec(&extracting);
 			}
diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index 3409b62fceac..bb354a7fc112 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -276,7 +276,6 @@ static int ctrl_slot_cleanup(struct controller *ctrl)
 	while (old_slot) {
 		next_slot = old_slot->next;
 		pci_hp_deregister(old_slot->hotplug_slot);
-		kfree(old_slot->hotplug_slot->info);
 		kfree(old_slot->hotplug_slot);
 		kfree(old_slot);
 		old_slot = next_slot;
@@ -579,7 +578,6 @@ static int ctrl_slot_setup(struct controller *ctrl,
 {
 	struct slot *slot;
 	struct hotplug_slot *hotplug_slot;
-	struct hotplug_slot_info *hotplug_slot_info;
 	struct pci_bus *bus = ctrl->pci_bus;
 	u8 number_of_slots;
 	u8 slot_device;
@@ -613,14 +611,6 @@ static int ctrl_slot_setup(struct controller *ctrl,
 		}
 		hotplug_slot = slot->hotplug_slot;
 
-		hotplug_slot->info = kzalloc(sizeof(*(hotplug_slot->info)),
-							GFP_KERNEL);
-		if (!hotplug_slot->info) {
-			result = -ENOMEM;
-			goto error_hpslot;
-		}
-		hotplug_slot_info = hotplug_slot->info;
-
 		slot->ctrl = ctrl;
 		slot->bus = ctrl->bus;
 		slot->device = slot_device;
@@ -673,14 +663,6 @@ static int ctrl_slot_setup(struct controller *ctrl,
 		snprintf(name, SLOT_NAME_SIZE, "%u", slot->number);
 		hotplug_slot->ops = &cpqphp_hotplug_slot_ops;
 
-		hotplug_slot_info->power_status = get_slot_enabled(ctrl, slot);
-		hotplug_slot_info->attention_status =
-			cpq_get_attention_status(ctrl, slot);
-		hotplug_slot_info->latch_status =
-			cpq_get_latch_status(ctrl, slot);
-		hotplug_slot_info->adapter_status =
-			get_presence_status(ctrl, slot);
-
 		dbg("registering bus %d, dev %d, number %d, ctrl->slot_device_offset %d, slot %d\n",
 				slot->bus, slot->device,
 				slot->number, ctrl->slot_device_offset,
@@ -691,7 +673,7 @@ static int ctrl_slot_setup(struct controller *ctrl,
 					 name);
 		if (result) {
 			err("pci_hp_register failed with error %d\n", result);
-			goto error_info;
+			goto error_hpslot;
 		}
 
 		slot->next = ctrl->slot;
@@ -703,8 +685,6 @@ static int ctrl_slot_setup(struct controller *ctrl,
 	}
 
 	return 0;
-error_info:
-	kfree(hotplug_slot_info);
 error_hpslot:
 	kfree(hotplug_slot);
 error_slot:
diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index 616df442520b..9c4826ac6a4f 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -1130,9 +1130,9 @@ static u8 set_controller_speed(struct controller *ctrl, u8 adapter_speed, u8 hp_
 	for (slot = ctrl->slot; slot; slot = slot->next) {
 		if (slot->device == (hp_slot + ctrl->slot_device_offset))
 			continue;
-		if (!slot->hotplug_slot || !slot->hotplug_slot->info)
+		if (!slot->hotplug_slot)
 			continue;
-		if (slot->hotplug_slot->info->adapter_status == 0)
+		if (get_presence_status(ctrl, slot) == 0)
 			continue;
 		/* If another adapter is running on the same segment but at a
 		 * lower speed/mode, we allow the new adapter to function at
@@ -1767,24 +1767,6 @@ void cpqhp_event_stop_thread(void)
 }
 
 
-static int update_slot_info(struct controller *ctrl, struct slot *slot)
-{
-	struct hotplug_slot_info *info;
-	int result;
-
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	info->power_status = get_slot_enabled(ctrl, slot);
-	info->attention_status = cpq_get_attention_status(ctrl, slot);
-	info->latch_status = cpq_get_latch_status(ctrl, slot);
-	info->adapter_status = get_presence_status(ctrl, slot);
-	result = pci_hp_change_slot_info(slot->hotplug_slot, info);
-	kfree(info);
-	return result;
-}
-
 static void interrupt_event_handler(struct controller *ctrl)
 {
 	int loop = 0;
@@ -1884,9 +1866,6 @@ static void interrupt_event_handler(struct controller *ctrl)
 				/***********POWER FAULT */
 				else if (ctrl->event_queue[loop].event_type == INT_POWER_FAULT) {
 					dbg("power fault\n");
-				} else {
-					/* refresh notification */
-					update_slot_info(ctrl, p_slot);
 				}
 
 				ctrl->event_queue[loop].event_type = 0;
@@ -2057,9 +2036,6 @@ int cpqhp_process_SI(struct controller *ctrl, struct pci_func *func)
 	if (rc)
 		dbg("%s: rc = %d\n", __func__, rc);
 
-	if (p_slot)
-		update_slot_info(ctrl, p_slot);
-
 	return rc;
 }
 
@@ -2125,9 +2101,6 @@ int cpqhp_process_SS(struct controller *ctrl, struct pci_func *func)
 		rc = 1;
 	}
 
-	if (p_slot)
-		update_slot_info(ctrl, p_slot);
-
 	return rc;
 }
 
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index b82fdc17040d..96e5b1f544ac 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -582,29 +582,10 @@ static int validate(struct slot *slot_cur, int opn)
  ****************************************************************************/
 int ibmphp_update_slot_info(struct slot *slot_cur)
 {
-	struct hotplug_slot_info *info;
 	struct pci_bus *bus = slot_cur->hotplug_slot->pci_slot->bus;
-	int rc;
 	u8 bus_speed;
 	u8 mode;
 
-	info = kmalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	info->power_status = SLOT_PWRGD(slot_cur->status);
-	info->attention_status = SLOT_ATTN(slot_cur->status,
-						slot_cur->ext_status);
-	info->latch_status = SLOT_LATCH(slot_cur->status);
-	if (!SLOT_PRESENT(slot_cur->status)) {
-		info->adapter_status = 0;
-/*		info->max_adapter_speed_status = MAX_ADAPTER_NONE; */
-	} else {
-		info->adapter_status = 1;
-/*		get_max_adapter_speed_1(slot_cur->hotplug_slot,
-					&info->max_adapter_speed_status, 0); */
-	}
-
 	bus_speed = slot_cur->bus_on->current_speed;
 	mode = slot_cur->bus_on->current_bus_mode;
 
@@ -630,9 +611,7 @@ int ibmphp_update_slot_info(struct slot *slot_cur)
 	bus->cur_bus_speed = bus_speed;
 	// To do: bus_names
 
-	rc = pci_hp_change_slot_info(slot_cur->hotplug_slot, info);
-	kfree(info);
-	return rc;
+	return 0;
 }
 
 
@@ -684,7 +663,6 @@ static void free_slots(void)
 		ibmphp_unconfigure_card(&slot_cur, -1);
 
 		pci_hp_destroy(slot_cur->hotplug_slot);
-		kfree(slot_cur->hotplug_slot->info);
 		kfree(slot_cur->hotplug_slot);
 		kfree(slot_cur);
 	}
@@ -1095,8 +1073,7 @@ static int enable_slot(struct hotplug_slot *hs)
 
 	slot_cur->func = kzalloc(sizeof(struct pci_func), GFP_KERNEL);
 	if (!slot_cur->func) {
-		/* We cannot do update_slot_info here, since no memory for
-		 * kmalloc n.e.ways, and update_slot_info allocates some */
+		/* do update_slot_info here? */
 		rc = -ENOMEM;
 		goto error_power;
 	}
diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index 6f8e90e3ec08..c05d066ab0d5 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -671,31 +671,6 @@ static int fillslotinfo(struct hotplug_slot *hotplug_slot)
 
 	slot = hotplug_slot->private;
 	rc = ibmphp_hpc_readslot(slot, READ_ALLSTAT, NULL);
-	if (rc)
-		return rc;
-
-	// power - enabled:1  not:0
-	hotplug_slot->info->power_status = SLOT_POWER(slot->status);
-
-	// attention - off:0, on:1, blinking:2
-	hotplug_slot->info->attention_status = SLOT_ATTN(slot->status, slot->ext_status);
-
-	// latch - open:1 closed:0
-	hotplug_slot->info->latch_status = SLOT_LATCH(slot->status);
-
-	// pci board - present:1 not:0
-	if (SLOT_PRESENT(slot->status))
-		hotplug_slot->info->adapter_status = 1;
-	else
-		hotplug_slot->info->adapter_status = 0;
-/*
-	if (slot->bus_on->supported_bus_mode
-		&& (slot->bus_on->supported_speed == BUS_SPEED_66))
-		hotplug_slot->info->max_bus_speed_status = BUS_SPEED_66PCIX;
-	else
-		hotplug_slot->info->max_bus_speed_status = slot->bus_on->supported_speed;
-*/
-
 	return rc;
 }
 
@@ -877,12 +852,6 @@ static int __init ebda_rsrc_controller(void)
 				goto error_no_hp_slot;
 			}
 
-			hp_slot_ptr->info = kzalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
-			if (!hp_slot_ptr->info) {
-				rc = -ENOMEM;
-				goto error_no_hp_info;
-			}
-
 			tmp_slot = kzalloc(sizeof(*tmp_slot), GFP_KERNEL);
 			if (!tmp_slot) {
 				rc = -ENOMEM;
@@ -955,8 +924,6 @@ static int __init ebda_rsrc_controller(void)
 error:
 	kfree(hp_slot_ptr->private);
 error_no_slot:
-	kfree(hp_slot_ptr->info);
-error_no_hp_info:
 	kfree(hp_slot_ptr);
 error_no_hp_slot:
 	free_ebda_hpc(hpc_ptr);
diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index ede2ed6f4ce0..5ac31f683b85 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -55,8 +55,6 @@ static int get_##name(struct hotplug_slot *slot, type *value)		\
 		return -ENODEV;						\
 	if (ops->get_##name)						\
 		retval = ops->get_##name(slot, value);			\
-	else								\
-		*value = slot->info->name;				\
 	module_put(slot->owner);					\
 	return retval;							\
 }
@@ -445,7 +443,7 @@ int __pci_hp_initialize(struct hotplug_slot *slot, struct pci_bus *bus,
 
 	if (slot == NULL)
 		return -ENODEV;
-	if ((slot->info == NULL) || (slot->ops == NULL))
+	if (slot->ops == NULL)
 		return -EINVAL;
 
 	slot->owner = owner;
@@ -560,28 +558,6 @@ void pci_hp_destroy(struct hotplug_slot *slot)
 }
 EXPORT_SYMBOL_GPL(pci_hp_destroy);
 
-/**
- * pci_hp_change_slot_info - changes the slot's information structure in the core
- * @slot: pointer to the slot whose info has changed
- * @info: pointer to the info copy into the slot's info structure
- *
- * @slot must have been registered with the pci
- * hotplug subsystem previously with a call to pci_hp_register().
- *
- * Returns 0 if successful, anything else for an error.
- */
-int pci_hp_change_slot_info(struct hotplug_slot *slot,
-			    struct hotplug_slot_info *info)
-{
-	if (!slot || !info)
-		return -ENODEV;
-
-	memcpy(slot->info, info, sizeof(struct hotplug_slot_info));
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pci_hp_change_slot_info);
-
 static int __init pci_hotplug_init(void)
 {
 	int result;
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 2c9fa5263634..dda90030005d 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -52,7 +52,6 @@ static int get_adapter_status(struct hotplug_slot *slot, u8 *value);
 static int init_slot(struct controller *ctrl)
 {
 	struct hotplug_slot *hotplug = NULL;
-	struct hotplug_slot_info *info = NULL;
 	struct hotplug_slot_ops *ops = NULL;
 	char name[SLOT_NAME_SIZE];
 	int retval = -ENOMEM;
@@ -61,10 +60,6 @@ static int init_slot(struct controller *ctrl)
 	if (!hotplug)
 		goto out;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		goto out;
-
 	/* Setup hotplug slot ops */
 	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 	if (!ops)
@@ -86,7 +81,6 @@ static int init_slot(struct controller *ctrl)
 	}
 
 	/* register this slot with the hotplug pci core */
-	hotplug->info = info;
 	hotplug->private = ctrl;
 	hotplug->ops = ops;
 	ctrl->hotplug_slot = hotplug;
@@ -99,7 +93,6 @@ static int init_slot(struct controller *ctrl)
 out:
 	if (retval) {
 		kfree(ops);
-		kfree(info);
 		kfree(hotplug);
 	}
 	return retval;
@@ -111,7 +104,6 @@ static void cleanup_slot(struct controller *ctrl)
 
 	pci_hp_destroy(hotplug_slot);
 	kfree(hotplug_slot->ops);
-	kfree(hotplug_slot->info);
 	kfree(hotplug_slot);
 }
 
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 12b92a0ff688..5bb63430262e 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -328,6 +328,11 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	return ret;
 }
 
+static inline struct pnv_php_slot *to_pnv_php_slot(struct hotplug_slot *slot)
+{
+	return container_of(slot, struct pnv_php_slot, slot);
+}
+
 int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 				 uint8_t state)
 {
@@ -378,7 +383,6 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 			 ret);
 	} else {
 		*state = power_state;
-		slot->info->power_status = power_state;
 	}
 
 	return 0;
@@ -397,7 +401,6 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 	if (ret >= 0) {
 		*state = presence;
-		slot->info->adapter_status = presence;
 		ret = 0;
 	} else {
 		pci_warn(php_slot->pdev, "Error %d getting presence\n", ret);
@@ -406,10 +409,20 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	return ret;
 }
 
+static int pnv_php_get_attention_state(struct hotplug_slot *slot, u8 *state)
+{
+	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
+
+	*state = php_slot->attention_state;
+	return 0;
+}
+
 static int pnv_php_set_attention_state(struct hotplug_slot *slot, u8 state)
 {
+	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
+
 	/* FIXME: Make it real once firmware supports it */
-	slot->info->attention_status = state;
+	php_slot->attention_state = state;
 
 	return 0;
 }
@@ -501,8 +514,7 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 
 static int pnv_php_enable_slot(struct hotplug_slot *slot)
 {
-	struct pnv_php_slot *php_slot = container_of(slot,
-						     struct pnv_php_slot, slot);
+	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
 
 	return pnv_php_enable(php_slot, true);
 }
@@ -533,6 +545,7 @@ static int pnv_php_disable_slot(struct hotplug_slot *slot)
 static const struct hotplug_slot_ops php_slot_ops = {
 	.get_power_status	= pnv_php_get_power_state,
 	.get_adapter_status	= pnv_php_get_adapter_state,
+	.get_attention_status	= pnv_php_get_attention_state,
 	.set_attention_status	= pnv_php_set_attention_state,
 	.enable_slot		= pnv_php_enable_slot,
 	.disable_slot		= pnv_php_disable_slot,
@@ -594,7 +607,6 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	php_slot->id	                = id;
 	php_slot->power_state_check     = false;
 	php_slot->slot.ops              = &php_slot_ops;
-	php_slot->slot.info             = &php_slot->slot_info;
 	php_slot->slot.private          = php_slot;
 
 	INIT_LIST_HEAD(&php_slot->children);
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index f83347819f7b..26a3dd731b5e 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -63,6 +63,7 @@ struct slot {
 	u32 index;
 	u32 type;
 	u32 power_domain;
+	u8 attention_status;
 	char *name;
 	struct device_node *dn;
 	struct pci_bus *bus;
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 8620a3f8c987..898e78dcd311 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -66,7 +66,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 
 	rc = rtas_set_indicator(DR_INDICATOR, slot->index, value);
 	if (!rc)
-		hotplug_slot->info->attention_status = value;
+		slot->attention_status = value;
 
 	return rc;
 }
@@ -95,7 +95,7 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = (struct slot *)hotplug_slot->private;
-	*value = slot->hotplug_slot->info->attention_status;
+	*value = slot->attention_status;
 	return 0;
 }
 
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index 0aac33e15dab..beca61badeea 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -54,25 +54,21 @@ int rpaphp_get_sensor_state(struct slot *slot, int *state)
  * rpaphp_enable_slot - record slot state, config pci device
  * @slot: target &slot
  *
- * Initialize values in the slot, and the hotplug_slot info
- * structures to indicate if there is a pci card plugged into
- * the slot. If the slot is not empty, run the pcibios routine
+ * Initialize values in the slot structure to indicate if there is a pci card
+ * plugged into the slot. If the slot is not empty, run the pcibios routine
  * to get pcibios stuff correctly set up.
  */
 int rpaphp_enable_slot(struct slot *slot)
 {
 	int rc, level, state;
 	struct pci_bus *bus;
-	struct hotplug_slot_info *info = slot->hotplug_slot->info;
 
-	info->adapter_status = NOT_VALID;
 	slot->state = EMPTY;
 
 	/* Find out if the power is turned on for the slot */
 	rc = rtas_get_power_level(slot->power_domain, &level);
 	if (rc)
 		return rc;
-	info->power_status = level;
 
 	/* Figure out if there is an adapter in the slot */
 	rc = rpaphp_get_sensor_state(slot, &state);
@@ -85,13 +81,11 @@ int rpaphp_enable_slot(struct slot *slot)
 		return -EINVAL;
 	}
 
-	info->adapter_status = EMPTY;
 	slot->bus = bus;
 	slot->pci_devs = &bus->devices;
 
 	/* if there's an adapter in the slot, go add the pci devices */
 	if (state == PRESENT) {
-		info->adapter_status = NOT_CONFIGURED;
 		slot->state = NOT_CONFIGURED;
 
 		/* non-empty slot has to have child */
@@ -105,7 +99,6 @@ int rpaphp_enable_slot(struct slot *slot)
 			pci_hp_add_devices(bus);
 
 		if (!list_empty(&bus->devices)) {
-			info->adapter_status = CONFIGURED;
 			slot->state = CONFIGURED;
 		}
 
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index b916c8e4372d..6e2658ce300b 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -21,7 +21,6 @@
 /* free up the memory used by a slot */
 void dealloc_slot_struct(struct slot *slot)
 {
-	kfree(slot->hotplug_slot->info);
 	kfree(slot->name);
 	kfree(slot->hotplug_slot);
 	kfree(slot);
@@ -38,13 +37,9 @@ struct slot *alloc_slot_struct(struct device_node *dn,
 	slot->hotplug_slot = kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
 	if (!slot->hotplug_slot)
 		goto error_slot;
-	slot->hotplug_slot->info = kzalloc(sizeof(struct hotplug_slot_info),
-					   GFP_KERNEL);
-	if (!slot->hotplug_slot->info)
-		goto error_hpslot;
 	slot->name = kstrdup(drc_name, GFP_KERNEL);
 	if (!slot->name)
-		goto error_info;
+		goto error_hpslot;
 	slot->dn = dn;
 	slot->index = drc_index;
 	slot->power_domain = power_domain;
@@ -53,8 +48,6 @@ struct slot *alloc_slot_struct(struct device_node *dn,
 
 	return (slot);
 
-error_info:
-	kfree(slot->hotplug_slot->info);
 error_hpslot:
 	kfree(slot->hotplug_slot);
 error_slot:
diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index 5bd45fd4a92a..d04634b0defe 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -140,7 +140,6 @@ static const struct hotplug_slot_ops s390_hotplug_slot_ops = {
 int zpci_init_slot(struct zpci_dev *zdev)
 {
 	struct hotplug_slot *hotplug_slot;
-	struct hotplug_slot_info *info;
 	char name[SLOT_NAME_SIZE];
 	struct slot *slot;
 	int rc;
@@ -160,16 +159,8 @@ int zpci_init_slot(struct zpci_dev *zdev)
 	slot->hotplug_slot = hotplug_slot;
 	slot->zdev = zdev;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		goto error_info;
-	hotplug_slot->info = info;
-
 	hotplug_slot->ops = &s390_hotplug_slot_ops;
 
-	get_power_status(hotplug_slot, &info->power_status);
-	get_adapter_status(hotplug_slot, &info->adapter_status);
-
 	snprintf(name, SLOT_NAME_SIZE, "%08x", zdev->fid);
 	rc = pci_hp_register(slot->hotplug_slot, zdev->bus,
 			     ZPCI_DEVFN, name);
@@ -180,8 +171,6 @@ int zpci_init_slot(struct zpci_dev *zdev)
 	return 0;
 
 error_reg:
-	kfree(info);
-error_info:
 	kfree(hotplug_slot);
 error_hp:
 	kfree(slot);
@@ -199,7 +188,6 @@ void zpci_exit_slot(struct zpci_dev *zdev)
 			continue;
 		list_del(&slot->slot_list);
 		pci_hp_deregister(slot->hotplug_slot);
-		kfree(slot->hotplug_slot->info);
 		kfree(slot->hotplug_slot);
 		kfree(slot);
 	}
diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index af4c28c574dd..e103826c83e3 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -585,7 +585,6 @@ static inline int get_power_status(struct hotplug_slot *bss_hotplug_slot,
 
 static void sn_release_slot(struct hotplug_slot *bss_hotplug_slot)
 {
-	kfree(bss_hotplug_slot->info);
 	kfree(bss_hotplug_slot->private);
 	kfree(bss_hotplug_slot);
 }
@@ -614,14 +613,6 @@ static int sn_hotplug_slot_register(struct pci_bus *pci_bus)
 			goto alloc_err;
 		}
 
-		bss_hotplug_slot->info =
-			kzalloc(sizeof(struct hotplug_slot_info),
-				GFP_KERNEL);
-		if (!bss_hotplug_slot->info) {
-			rc = -ENOMEM;
-			goto alloc_err;
-		}
-
 		if (sn_hp_slot_private_alloc(bss_hotplug_slot,
 					     pci_bus, device, name)) {
 			rc = -ENOMEM;
diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index 516e4835019c..a7bb816e6f25 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -67,7 +67,9 @@ struct slot {
 	u32 number;
 	u8 is_a_board;
 	u8 state;
+	u8 attention_save;
 	u8 presence_save;
+	u8 latch_save;
 	u8 pwr_save;
 	struct controller *ctrl;
 	const struct hpc_ops *hpc_ops;
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 26cbea04237c..b7181b7e7b98 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -65,7 +65,6 @@ static int init_slots(struct controller *ctrl)
 {
 	struct slot *slot;
 	struct hotplug_slot *hotplug_slot;
-	struct hotplug_slot_info *info;
 	char name[SLOT_NAME_SIZE];
 	int retval;
 	int i;
@@ -84,13 +83,6 @@ static int init_slots(struct controller *ctrl)
 		}
 		slot->hotplug_slot = hotplug_slot;
 
-		info = kzalloc(sizeof(*info), GFP_KERNEL);
-		if (!info) {
-			retval = -ENOMEM;
-			goto error_hpslot;
-		}
-		hotplug_slot->info = info;
-
 		slot->hp_slot = i;
 		slot->ctrl = ctrl;
 		slot->bus = ctrl->pci_dev->subordinate->number;
@@ -101,7 +93,7 @@ static int init_slots(struct controller *ctrl)
 		slot->wq = alloc_workqueue("shpchp-%d", 0, 0, slot->number);
 		if (!slot->wq) {
 			retval = -ENOMEM;
-			goto error_info;
+			goto error_hpslot;
 		}
 
 		mutex_init(&slot->lock);
@@ -124,10 +116,10 @@ static int init_slots(struct controller *ctrl)
 			goto error_slotwq;
 		}
 
-		get_power_status(hotplug_slot, &info->power_status);
-		get_attention_status(hotplug_slot, &info->attention_status);
-		get_latch_status(hotplug_slot, &info->latch_status);
-		get_adapter_status(hotplug_slot, &info->adapter_status);
+		get_power_status(hotplug_slot, &slot->pwr_save);
+		get_attention_status(hotplug_slot, &slot->attention_save);
+		get_latch_status(hotplug_slot, &slot->latch_save);
+		get_adapter_status(hotplug_slot, &slot->presence_save);
 
 		list_add(&slot->slot_list, &ctrl->slot_list);
 	}
@@ -135,8 +127,6 @@ static int init_slots(struct controller *ctrl)
 	return 0;
 error_slotwq:
 	destroy_workqueue(slot->wq);
-error_info:
-	kfree(info);
 error_hpslot:
 	kfree(hotplug_slot);
 error_slot:
@@ -154,7 +144,6 @@ void cleanup_slots(struct controller *ctrl)
 		cancel_delayed_work(&slot->work);
 		destroy_workqueue(slot->wq);
 		pci_hp_deregister(slot->hotplug_slot);
-		kfree(slot->hotplug_slot->info);
 		kfree(slot->hotplug_slot);
 		kfree(slot);
 	}
@@ -170,7 +159,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
 		 __func__, slot_name(slot));
 
-	hotplug_slot->info->attention_status = status;
+	slot->attention_save = status;
 	slot->hpc_ops->set_attention_status(slot, status);
 
 	return 0;
@@ -206,7 +195,7 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 	retval = slot->hpc_ops->get_power_status(slot, value);
 	if (retval < 0)
-		*value = hotplug_slot->info->power_status;
+		*value = slot->pwr_save;
 
 	return 0;
 }
@@ -221,7 +210,7 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 	retval = slot->hpc_ops->get_attention_status(slot, value);
 	if (retval < 0)
-		*value = hotplug_slot->info->attention_status;
+		*value = slot->attention_save;
 
 	return 0;
 }
@@ -236,7 +225,7 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 	retval = slot->hpc_ops->get_latch_status(slot, value);
 	if (retval < 0)
-		*value = hotplug_slot->info->latch_status;
+		*value = slot->latch_save;
 
 	return 0;
 }
@@ -251,7 +240,7 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 	retval = slot->hpc_ops->get_adapter_status(slot, value);
 	if (retval < 0)
-		*value = hotplug_slot->info->adapter_status;
+		*value = slot->presence_save;
 
 	return 0;
 }
diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index 1267dcc5a531..078003dcde5b 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -446,23 +446,12 @@ void shpchp_queue_pushbutton_work(struct work_struct *work)
 	mutex_unlock(&p_slot->lock);
 }
 
-static int update_slot_info (struct slot *slot)
+static void update_slot_info(struct slot *slot)
 {
-	struct hotplug_slot_info *info;
-	int result;
-
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	slot->hpc_ops->get_power_status(slot, &(info->power_status));
-	slot->hpc_ops->get_attention_status(slot, &(info->attention_status));
-	slot->hpc_ops->get_latch_status(slot, &(info->latch_status));
-	slot->hpc_ops->get_adapter_status(slot, &(info->adapter_status));
-
-	result = pci_hp_change_slot_info(slot->hotplug_slot, info);
-	kfree (info);
-	return result;
+	slot->hpc_ops->get_power_status(slot, &slot->pwr_save);
+	slot->hpc_ops->get_attention_status(slot, &slot->attention_save);
+	slot->hpc_ops->get_latch_status(slot, &slot->latch_save);
+	slot->hpc_ops->get_adapter_status(slot, &slot->presence_save);
 }
 
 /*
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index d05ac442e4ec..a2130dd2db3c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -892,15 +892,8 @@ static int asus_setup_pci_hotplug(struct asus_wmi *asus)
 	if (!asus->hotplug_slot)
 		goto error_slot;
 
-	asus->hotplug_slot->info = kzalloc(sizeof(struct hotplug_slot_info),
-					   GFP_KERNEL);
-	if (!asus->hotplug_slot->info)
-		goto error_info;
-
 	asus->hotplug_slot->private = asus;
 	asus->hotplug_slot->ops = &asus_hotplug_slot_ops;
-	asus_get_adapter_status(asus->hotplug_slot,
-				&asus->hotplug_slot->info->adapter_status);
 
 	ret = pci_hp_register(asus->hotplug_slot, bus, 0, "asus-wifi");
 	if (ret) {
@@ -911,8 +904,6 @@ static int asus_setup_pci_hotplug(struct asus_wmi *asus)
 	return 0;
 
 error_register:
-	kfree(asus->hotplug_slot->info);
-error_info:
 	kfree(asus->hotplug_slot);
 	asus->hotplug_slot = NULL;
 error_slot:
@@ -1045,7 +1036,6 @@ static void asus_wmi_rfkill_exit(struct asus_wmi *asus)
 	asus_rfkill_hotplug(asus);
 	if (asus->hotplug_slot) {
 		pci_hp_deregister(asus->hotplug_slot);
-		kfree(asus->hotplug_slot->info);
 		kfree(asus->hotplug_slot);
 	}
 	if (asus->hotplug_workqueue)
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 41a364376e91..028b20f82962 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -745,15 +745,8 @@ static int eeepc_setup_pci_hotplug(struct eeepc_laptop *eeepc)
 	if (!eeepc->hotplug_slot)
 		goto error_slot;
 
-	eeepc->hotplug_slot->info = kzalloc(sizeof(struct hotplug_slot_info),
-					    GFP_KERNEL);
-	if (!eeepc->hotplug_slot->info)
-		goto error_info;
-
 	eeepc->hotplug_slot->private = eeepc;
 	eeepc->hotplug_slot->ops = &eeepc_hotplug_slot_ops;
-	eeepc_get_adapter_status(eeepc->hotplug_slot,
-				 &eeepc->hotplug_slot->info->adapter_status);
 
 	ret = pci_hp_register(eeepc->hotplug_slot, bus, 0, "eeepc-wifi");
 	if (ret) {
@@ -764,8 +757,6 @@ static int eeepc_setup_pci_hotplug(struct eeepc_laptop *eeepc)
 	return 0;
 
 error_register:
-	kfree(eeepc->hotplug_slot->info);
-error_info:
 	kfree(eeepc->hotplug_slot);
 	eeepc->hotplug_slot = NULL;
 error_slot:
@@ -831,7 +822,6 @@ static void eeepc_rfkill_exit(struct eeepc_laptop *eeepc)
 
 	if (eeepc->hotplug_slot) {
 		pci_hp_deregister(eeepc->hotplug_slot);
-		kfree(eeepc->hotplug_slot->info);
 		kfree(eeepc->hotplug_slot);
 	}
 
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 372dbe95c207..6f07a4e1de8d 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -23,17 +23,9 @@
  * @hardware_test: Called to run a specified hardware test on the specified
  * slot.
  * @get_power_status: Called to get the current power status of a slot.
- *	If this field is NULL, the value passed in the struct hotplug_slot_info
- *	will be used when this value is requested by a user.
  * @get_attention_status: Called to get the current attention status of a slot.
- *	If this field is NULL, the value passed in the struct hotplug_slot_info
- *	will be used when this value is requested by a user.
  * @get_latch_status: Called to get the current latch status of a slot.
- *	If this field is NULL, the value passed in the struct hotplug_slot_info
- *	will be used when this value is requested by a user.
  * @get_adapter_status: Called to get see if an adapter is present in the slot or not.
- *	If this field is NULL, the value passed in the struct hotplug_slot_info
- *	will be used when this value is requested by a user.
  * @reset_slot: Optional interface to allow override of a bus reset for the
  *	slot for cases where a secondary bus reset can result in spurious
  *	hotplug events or where a slot can be reset independent of the bus.
@@ -55,27 +47,9 @@ struct hotplug_slot_ops {
 	int (*reset_slot)		(struct hotplug_slot *slot, int probe);
 };
 
-/**
- * struct hotplug_slot_info - used to notify the hotplug pci core of the state of the slot
- * @power_status: if power is enabled or not (1/0)
- * @attention_status: if the attention light is enabled or not (1/0)
- * @latch_status: if the latch (if any) is open or closed (1/0)
- * @adapter_status: if there is a pci board present in the slot or not (1/0)
- *
- * Used to notify the hotplug pci core of the status of a specific slot.
- */
-struct hotplug_slot_info {
-	u8	power_status;
-	u8	attention_status;
-	u8	latch_status;
-	u8	adapter_status;
-};
-
 /**
  * struct hotplug_slot - used to register a physical slot with the hotplug pci core
  * @ops: pointer to the &struct hotplug_slot_ops to be used for this slot
- * @info: pointer to the &struct hotplug_slot_info for the initial values for
- * this slot.
  * @private: used by the hotplug pci controller driver to store whatever it
  * needs.
  * @owner: The module owner of this structure
@@ -83,7 +57,6 @@ struct hotplug_slot_info {
  */
 struct hotplug_slot {
 	const struct hotplug_slot_ops	*ops;
-	struct hotplug_slot_info	*info;
 	void				*private;
 
 	/* Variables below this are for use only by the hotplug pci core. */
@@ -110,9 +83,6 @@ void pci_hp_del(struct hotplug_slot *slot);
 void pci_hp_destroy(struct hotplug_slot *slot);
 void pci_hp_deregister(struct hotplug_slot *slot);
 
-int __must_check pci_hp_change_slot_info(struct hotplug_slot *slot,
-					 struct hotplug_slot_info *info);
-
 /* use a define to avoid include chaining to get THIS_MODULE & friends */
 #define pci_hp_register(slot, pbus, devnr, name) \
 	__pci_hp_register(slot, pbus, devnr, name, THIS_MODULE, KBUILD_MODNAME)
-- 
2.18.0
