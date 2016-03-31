Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 31 Mar 2016 14:57:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.6-rc2
Message-ID: <20160331145724.13258ddb@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

* An interface for dasd driver to query if a volume is online to
  another operating system
* A proper fix for the lcu locking issue in the dasd driver
* Add the new preadv2 and pwritev2 system calls
* Define the mark_rodata_ro function and set DEBUG_RODATA=y
* A few more bug fixes.

Anna-Maria Gleixner (2):
      s390/cpum_cf: Fix missing cpu hotplug notifier transition
      s390/cpum_sf: Fix cpu hotplug notifier transitions

Gerald Schaefer (1):
      s390/mm: handle PTE-mapped tail pages in fast gup

Harald Freudenberger (1):
      Provide correct file mode at device register.

Heiko Carstens (2):
      s390: add DEBUG_RODATA support
      s390: wire up preadv2/pwritev2 syscalls

Kees Cook (1):
      s390: disable postinit-readonly for now

Pierre Morel (1):
      clp_query_pci_fn: PCI function group 0 is valid

Stefan Haberland (2):
      s390/dasd: reorder lcu and device lock
      s390/dasd: add query host access to volume support

 arch/s390/Kconfig                   |   3 +
 arch/s390/crypto/prng.c             |   2 +
 arch/s390/include/asm/cache.h       |   3 +
 arch/s390/include/uapi/asm/unistd.h |   4 +-
 arch/s390/kernel/perf_cpum_cf.c     |   1 +
 arch/s390/kernel/perf_cpum_sf.c     |   2 +-
 arch/s390/kernel/syscalls.S         |   2 +
 arch/s390/mm/gup.c                  |   8 +-
 arch/s390/mm/init.c                 |  10 +-
 arch/s390/pci/pci_clp.c             |   3 +-
 drivers/s390/block/dasd.c           |  56 +++++++++
 drivers/s390/block/dasd_alias.c     | 226 +++++++++---------------------------
 drivers/s390/block/dasd_devmap.c    |  27 +++++
 drivers/s390/block/dasd_eckd.c      | 202 ++++++++++++++++++++++++++++++--
 drivers/s390/block/dasd_eckd.h      |  36 +++++-
 drivers/s390/block/dasd_int.h       |   5 +
 16 files changed, 396 insertions(+), 194 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7e3e8a8..f8dea16 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -59,6 +59,9 @@ config PCI_QUIRKS
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
+config DEBUG_RODATA
+	def_bool y
+
 config S390
 	def_bool y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index b8045b9..d750cc0 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -669,11 +669,13 @@ static const struct file_operations prng_tdes_fops = {
 static struct miscdevice prng_sha512_dev = {
 	.name	= "prandom",
 	.minor	= MISC_DYNAMIC_MINOR,
+	.mode	= 0644,
 	.fops	= &prng_sha512_fops,
 };
 static struct miscdevice prng_tdes_dev = {
 	.name	= "prandom",
 	.minor	= MISC_DYNAMIC_MINOR,
+	.mode	= 0644,
 	.fops	= &prng_tdes_fops,
 };
 
diff --git a/arch/s390/include/asm/cache.h b/arch/s390/include/asm/cache.h
index 4d7ccac..22da3b3 100644
--- a/arch/s390/include/asm/cache.h
+++ b/arch/s390/include/asm/cache.h
@@ -15,4 +15,7 @@
 
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
+/* Read-only memory is marked before mark_rodata_ro() is called. */
+#define __ro_after_init __read_mostly
+
 #endif
diff --git a/arch/s390/include/uapi/asm/unistd.h b/arch/s390/include/uapi/asm/unistd.h
index ab3aa68..4384bc7 100644
--- a/arch/s390/include/uapi/asm/unistd.h
+++ b/arch/s390/include/uapi/asm/unistd.h
@@ -311,7 +311,9 @@
 #define __NR_shutdown		373
 #define __NR_mlock2		374
 #define __NR_copy_file_range	375
-#define NR_syscalls 376
+#define __NR_preadv2		376
+#define __NR_pwritev2		377
+#define NR_syscalls 378
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 58bf457..62f066b 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -670,6 +670,7 @@ static int cpumf_pmu_notifier(struct notifier_block *self, unsigned long action,
 
 	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_ONLINE:
+	case CPU_DOWN_FAILED:
 		flags = PMC_INIT;
 		smp_call_function_single(cpu, setup_pmc_cpu, &flags, 1);
 		break;
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 1a43474..eaab9a7 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1521,7 +1521,7 @@ static int cpumf_pmu_notifier(struct notifier_block *self,
 
 	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
+	case CPU_DOWN_FAILED:
 		flags = PMC_INIT;
 		smp_call_function_single(cpu, setup_pmc_cpu, &flags, 1);
 		break;
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 293d8b9..9b59e62 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -384,3 +384,5 @@ SYSCALL(sys_recvmsg,compat_sys_recvmsg)
 SYSCALL(sys_shutdown,sys_shutdown)
 SYSCALL(sys_mlock2,compat_sys_mlock2)
 SYSCALL(sys_copy_file_range,compat_sys_copy_file_range) /* 375 */
+SYSCALL(sys_preadv2,compat_sys_preadv2)
+SYSCALL(sys_pwritev2,compat_sys_pwritev2)
diff --git a/arch/s390/mm/gup.c b/arch/s390/mm/gup.c
index 13dab0c..3776aca 100644
--- a/arch/s390/mm/gup.c
+++ b/arch/s390/mm/gup.c
@@ -20,9 +20,9 @@
 static inline int gup_pte_range(pmd_t *pmdp, pmd_t pmd, unsigned long addr,
 		unsigned long end, int write, struct page **pages, int *nr)
 {
+	struct page *head, *page;
 	unsigned long mask;
 	pte_t *ptep, pte;
-	struct page *page;
 
 	mask = (write ? _PAGE_PROTECT : 0) | _PAGE_INVALID | _PAGE_SPECIAL;
 
@@ -37,12 +37,14 @@ static inline int gup_pte_range(pmd_t *pmdp, pmd_t pmd, unsigned long addr,
 			return 0;
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
-		if (!page_cache_get_speculative(page))
+		head = compound_head(page);
+		if (!page_cache_get_speculative(head))
 			return 0;
 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
-			put_page(page);
+			put_page(head);
 			return 0;
 		}
+		VM_BUG_ON_PAGE(compound_head(page) != head, page);
 		pages[*nr] = page;
 		(*nr)++;
 
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 73e2903..c7b0451 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -108,6 +108,13 @@ void __init paging_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
+void mark_rodata_ro(void)
+{
+	/* Text and rodata are already protected. Nothing to do here. */
+	pr_info("Write protecting the kernel read-only data: %luk\n",
+		((unsigned long)&_eshared - (unsigned long)&_stext) >> 10);
+}
+
 void __init mem_init(void)
 {
 	if (MACHINE_HAS_TLB_LC)
@@ -126,9 +133,6 @@ void __init mem_init(void)
 	setup_zero_pages();	/* Setup zeroed pages. */
 
 	mem_init_print_info(NULL);
-	printk("Write protected kernel read-only data: %#lx - %#lx\n",
-	       (unsigned long)&_stext,
-	       PFN_ALIGN((unsigned long)&_eshared) - 1);
 }
 
 void free_initmem(void)
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 21591dd..1a4512c 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -176,8 +176,7 @@ static int clp_query_pci_fn(struct zpci_dev *zdev, u32 fh)
 		rc = clp_store_query_pci_fn(zdev, &rrb->response);
 		if (rc)
 			goto out;
-		if (rrb->response.pfgid)
-			rc = clp_query_pci_fngrp(zdev, rrb->response.pfgid);
+		rc = clp_query_pci_fngrp(zdev, rrb->response.pfgid);
 	} else {
 		zpci_err("Q PCI FN:\n");
 		zpci_err_clp(rrb->response.hdr.rsp, rc);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index c78db05..4adb6d1 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -75,6 +75,8 @@ static void dasd_block_timeout(unsigned long);
 static void __dasd_process_erp(struct dasd_device *, struct dasd_ccw_req *);
 static void dasd_profile_init(struct dasd_profile *, struct dentry *);
 static void dasd_profile_exit(struct dasd_profile *);
+static void dasd_hosts_init(struct dentry *, struct dasd_device *);
+static void dasd_hosts_exit(struct dasd_device *);
 
 /*
  * SECTION: Operations on the device structure.
@@ -267,6 +269,7 @@ static int dasd_state_known_to_basic(struct dasd_device *device)
 		dasd_debugfs_setup(dev_name(&device->cdev->dev),
 				   dasd_debugfs_root_entry);
 	dasd_profile_init(&device->profile, device->debugfs_dentry);
+	dasd_hosts_init(device->debugfs_dentry, device);
 
 	/* register 'device' debug area, used for all DBF_DEV_XXX calls */
 	device->debug_area = debug_register(dev_name(&device->cdev->dev), 4, 1,
@@ -304,6 +307,7 @@ static int dasd_state_basic_to_known(struct dasd_device *device)
 		return rc;
 	dasd_device_clear_timer(device);
 	dasd_profile_exit(&device->profile);
+	dasd_hosts_exit(device);
 	debugfs_remove(device->debugfs_dentry);
 	DBF_DEV_EVENT(DBF_EMERG, device, "%p debug area deleted", device);
 	if (device->debug_area != NULL) {
@@ -1150,6 +1154,58 @@ int dasd_profile_on(struct dasd_profile *profile)
 
 #endif				/* CONFIG_DASD_PROFILE */
 
+static int dasd_hosts_show(struct seq_file *m, void *v)
+{
+	struct dasd_device *device;
+	int rc = -EOPNOTSUPP;
+
+	device = m->private;
+	dasd_get_device(device);
+
+	if (device->discipline->hosts_print)
+		rc = device->discipline->hosts_print(device, m);
+
+	dasd_put_device(device);
+	return rc;
+}
+
+static int dasd_hosts_open(struct inode *inode, struct file *file)
+{
+	struct dasd_device *device = inode->i_private;
+
+	return single_open(file, dasd_hosts_show, device);
+}
+
+static const struct file_operations dasd_hosts_fops = {
+	.owner		= THIS_MODULE,
+	.open		= dasd_hosts_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void dasd_hosts_exit(struct dasd_device *device)
+{
+	debugfs_remove(device->hosts_dentry);
+	device->hosts_dentry = NULL;
+}
+
+static void dasd_hosts_init(struct dentry *base_dentry,
+			    struct dasd_device *device)
+{
+	struct dentry *pde;
+	umode_t mode;
+
+	if (!base_dentry)
+		return;
+
+	mode = S_IRUSR | S_IFREG;
+	pde = debugfs_create_file("host_access_list", mode, base_dentry,
+				  device, &dasd_hosts_fops);
+	if (pde && !IS_ERR(pde))
+		device->hosts_dentry = pde;
+}
+
 /*
  * Allocate memory for a channel program with 'cplength' channel
  * command words and 'datasize' additional space. There are two
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index 17ad574..1e56018 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -317,17 +317,17 @@ static int _add_device_to_lcu(struct alias_lcu *lcu,
 	struct alias_pav_group *group;
 	struct dasd_uid uid;
 
+	spin_lock(get_ccwdev_lock(device->cdev));
 	private->uid.type = lcu->uac->unit[private->uid.real_unit_addr].ua_type;
 	private->uid.base_unit_addr =
 		lcu->uac->unit[private->uid.real_unit_addr].base_ua;
 	uid = private->uid;
-
+	spin_unlock(get_ccwdev_lock(device->cdev));
 	/* if we have no PAV anyway, we don't need to bother with PAV groups */
 	if (lcu->pav == NO_PAV) {
 		list_move(&device->alias_list, &lcu->active_devices);
 		return 0;
 	}
-
 	group = _find_group(lcu, &uid);
 	if (!group) {
 		group = kzalloc(sizeof(*group), GFP_ATOMIC);
@@ -397,130 +397,6 @@ suborder_not_supported(struct dasd_ccw_req *cqr)
 	return 0;
 }
 
-/*
- * This function tries to lock all devices on an lcu via trylock
- * return NULL on success otherwise return first failed device
- */
-static struct dasd_device *_trylock_all_devices_on_lcu(struct alias_lcu *lcu,
-						      struct dasd_device *pos)
-
-{
-	struct alias_pav_group *pavgroup;
-	struct dasd_device *device;
-
-	list_for_each_entry(device, &lcu->active_devices, alias_list) {
-		if (device == pos)
-			continue;
-		if (!spin_trylock(get_ccwdev_lock(device->cdev)))
-			return device;
-	}
-	list_for_each_entry(device, &lcu->inactive_devices, alias_list) {
-		if (device == pos)
-			continue;
-		if (!spin_trylock(get_ccwdev_lock(device->cdev)))
-			return device;
-	}
-	list_for_each_entry(pavgroup, &lcu->grouplist, group) {
-		list_for_each_entry(device, &pavgroup->baselist, alias_list) {
-			if (device == pos)
-				continue;
-			if (!spin_trylock(get_ccwdev_lock(device->cdev)))
-				return device;
-		}
-		list_for_each_entry(device, &pavgroup->aliaslist, alias_list) {
-			if (device == pos)
-				continue;
-			if (!spin_trylock(get_ccwdev_lock(device->cdev)))
-				return device;
-		}
-	}
-	return NULL;
-}
-
-/*
- * unlock all devices except the one that is specified as pos
- * stop if enddev is specified and reached
- */
-static void _unlock_all_devices_on_lcu(struct alias_lcu *lcu,
-				       struct dasd_device *pos,
-				       struct dasd_device *enddev)
-
-{
-	struct alias_pav_group *pavgroup;
-	struct dasd_device *device;
-
-	list_for_each_entry(device, &lcu->active_devices, alias_list) {
-		if (device == pos)
-			continue;
-		if (device == enddev)
-			return;
-		spin_unlock(get_ccwdev_lock(device->cdev));
-	}
-	list_for_each_entry(device, &lcu->inactive_devices, alias_list) {
-		if (device == pos)
-			continue;
-		if (device == enddev)
-			return;
-		spin_unlock(get_ccwdev_lock(device->cdev));
-	}
-	list_for_each_entry(pavgroup, &lcu->grouplist, group) {
-		list_for_each_entry(device, &pavgroup->baselist, alias_list) {
-			if (device == pos)
-				continue;
-			if (device == enddev)
-				return;
-			spin_unlock(get_ccwdev_lock(device->cdev));
-		}
-		list_for_each_entry(device, &pavgroup->aliaslist, alias_list) {
-			if (device == pos)
-				continue;
-			if (device == enddev)
-				return;
-			spin_unlock(get_ccwdev_lock(device->cdev));
-		}
-	}
-}
-
-/*
- *  this function is needed because the locking order
- *  device lock -> lcu lock
- *  needs to be assured when iterating over devices in an LCU
- *
- *  if a device is specified in pos then the device lock is already hold
- */
-static void _trylock_and_lock_lcu_irqsave(struct alias_lcu *lcu,
-					  struct dasd_device *pos,
-					  unsigned long *flags)
-{
-	struct dasd_device *failed;
-
-	do {
-		spin_lock_irqsave(&lcu->lock, *flags);
-		failed = _trylock_all_devices_on_lcu(lcu, pos);
-		if (failed) {
-			_unlock_all_devices_on_lcu(lcu, pos, failed);
-			spin_unlock_irqrestore(&lcu->lock, *flags);
-			cpu_relax();
-		}
-	} while (failed);
-}
-
-static void _trylock_and_lock_lcu(struct alias_lcu *lcu,
-				  struct dasd_device *pos)
-{
-	struct dasd_device *failed;
-
-	do {
-		spin_lock(&lcu->lock);
-		failed = _trylock_all_devices_on_lcu(lcu, pos);
-		if (failed) {
-			_unlock_all_devices_on_lcu(lcu, pos, failed);
-			spin_unlock(&lcu->lock);
-			cpu_relax();
-		}
-	} while (failed);
-}
-
 static int read_unit_address_configuration(struct dasd_device *device,
 					   struct alias_lcu *lcu)
 {
@@ -615,7 +491,7 @@ static int _lcu_update(struct dasd_device *refdev, struct alias_lcu *lcu)
 	if (rc)
 		return rc;
 
-	_trylock_and_lock_lcu_irqsave(lcu, NULL, &flags);
+	spin_lock_irqsave(&lcu->lock, flags);
 	lcu->pav = NO_PAV;
 	for (i = 0; i < MAX_DEVICES_PER_LCU; ++i) {
 		switch (lcu->uac->unit[i].ua_type) {
@@ -634,7 +510,6 @@ static int _lcu_update(struct dasd_device *refdev, struct alias_lcu *lcu)
 				 alias_list) {
 		_add_device_to_lcu(lcu, device, refdev);
 	}
-	_unlock_all_devices_on_lcu(lcu, NULL, NULL);
 	spin_unlock_irqrestore(&lcu->lock, flags);
 	return 0;
 }
@@ -722,8 +597,7 @@ int dasd_alias_add_device(struct dasd_device *device)
 
 	lcu = private->lcu;
 	rc = 0;
-	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-	spin_lock(&lcu->lock);
+	spin_lock_irqsave(&lcu->lock, flags);
 	if (!(lcu->flags & UPDATE_PENDING)) {
 		rc = _add_device_to_lcu(lcu, device, device);
 		if (rc)
@@ -733,8 +607,7 @@ int dasd_alias_add_device(struct dasd_device *device)
 		list_move(&device->alias_list, &lcu->active_devices);
 		_schedule_lcu_update(lcu, device);
 	}
-	spin_unlock(&lcu->lock);
-	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	spin_unlock_irqrestore(&lcu->lock, flags);
 	return rc;
 }
 
@@ -933,15 +806,27 @@ static void _stop_all_devices_on_lcu(struct alias_lcu *lcu)
 	struct alias_pav_group *pavgroup;
 	struct dasd_device *device;
 
-	list_for_each_entry(device, &lcu->active_devices, alias_list)
+	list_for_each_entry(device, &lcu->active_devices, alias_list) {
+		spin_lock(get_ccwdev_lock(device->cdev));
 		dasd_device_set_stop_bits(device, DASD_STOPPED_SU);
-	list_for_each_entry(device, &lcu->inactive_devices, alias_list)
+		spin_unlock(get_ccwdev_lock(device->cdev));
+	}
+	list_for_each_entry(device, &lcu->inactive_devices, alias_list) {
+		spin_lock(get_ccwdev_lock(device->cdev));
 		dasd_device_set_stop_bits(device, DASD_STOPPED_SU);
+		spin_unlock(get_ccwdev_lock(device->cdev));
+	}
 	list_for_each_entry(pavgroup, &lcu->grouplist, group) {
-		list_for_each_entry(device, &pavgroup->baselist, alias_list)
+		list_for_each_entry(device, &pavgroup->baselist, alias_list) {
+			spin_lock(get_ccwdev_lock(device->cdev));
 			dasd_device_set_stop_bits(device, DASD_STOPPED_SU);
-		list_for_each_entry(device, &pavgroup->aliaslist, alias_list)
+			spin_unlock(get_ccwdev_lock(device->cdev));
+		}
+		list_for_each_entry(device, &pavgroup->aliaslist, alias_list) {
+			spin_lock(get_ccwdev_lock(device->cdev));
 			dasd_device_set_stop_bits(device, DASD_STOPPED_SU);
+			spin_unlock(get_ccwdev_lock(device->cdev));
+		}
 	}
 }
 
@@ -950,15 +835,27 @@ static void _unstop_all_devices_on_lcu(struct alias_lcu *lcu)
 	struct alias_pav_group *pavgroup;
 	struct dasd_device *device;
 
-	list_for_each_entry(device, &lcu->active_devices, alias_list)
+	list_for_each_entry(device, &lcu->active_devices, alias_list) {
+		spin_lock(get_ccwdev_lock(device->cdev));
 		dasd_device_remove_stop_bits(device, DASD_STOPPED_SU);
-	list_for_each_entry(device, &lcu->inactive_devices, alias_list)
+		spin_unlock(get_ccwdev_lock(device->cdev));
+	}
+	list_for_each_entry(device, &lcu->inactive_devices, alias_list) {
+		spin_lock(get_ccwdev_lock(device->cdev));
 		dasd_device_remove_stop_bits(device, DASD_STOPPED_SU);
+		spin_unlock(get_ccwdev_lock(device->cdev));
+	}
 	list_for_each_entry(pavgroup, &lcu->grouplist, group) {
-		list_for_each_entry(device, &pavgroup->baselist, alias_list)
+		list_for_each_entry(device, &pavgroup->baselist, alias_list) {
+			spin_lock(get_ccwdev_lock(device->cdev));
 			dasd_device_remove_stop_bits(device, DASD_STOPPED_SU);
-		list_for_each_entry(device, &pavgroup->aliaslist, alias_list)
+			spin_unlock(get_ccwdev_lock(device->cdev));
+		}
+		list_for_each_entry(device, &pavgroup->aliaslist, alias_list) {
+			spin_lock(get_ccwdev_lock(device->cdev));
 			dasd_device_remove_stop_bits(device, DASD_STOPPED_SU);
+			spin_unlock(get_ccwdev_lock(device->cdev));
+		}
 	}
 }
 
@@ -984,48 +881,32 @@ static void summary_unit_check_handling_work(struct work_struct *work)
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	reset_summary_unit_check(lcu, device, suc_data->reason);
 
-	_trylock_and_lock_lcu_irqsave(lcu, NULL, &flags);
+	spin_lock_irqsave(&lcu->lock, flags);
 	_unstop_all_devices_on_lcu(lcu);
 	_restart_all_base_devices_on_lcu(lcu);
 	/* 3. read new alias configuration */
 	_schedule_lcu_update(lcu, device);
 	lcu->suc_data.device = NULL;
 	dasd_put_device(device);
-	_unlock_all_devices_on_lcu(lcu, NULL, NULL);
 	spin_unlock_irqrestore(&lcu->lock, flags);
 }
 
-/*
- * note: this will be called from int handler context (cdev locked)
- */
-void dasd_alias_handle_summary_unit_check(struct dasd_device *device,
-					  struct irb *irb)
+void dasd_alias_handle_summary_unit_check(struct work_struct *work)
 {
+	struct dasd_device *device = container_of(work, struct dasd_device,
+						  suc_work);
 	struct dasd_eckd_private *private = device->private;
 	struct alias_lcu *lcu;
-	char reason;
-	char *sense;
-
-	sense = dasd_get_sense(irb);
-	if (sense) {
-		reason = sense[8];
-		DBF_DEV_EVENT(DBF_NOTICE, device, "%s %x",
-			    "eckd handle summary unit check: reason", reason);
-	} else {
-		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
-			    "eckd handle summary unit check:"
-			    " no reason code available");
-		return;
-	}
+	unsigned long flags;
 
 	lcu = private->lcu;
 	if (!lcu) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "device not ready to handle summary"
 			    " unit check (no lcu structure)");
-		return;
+		goto out;
 	}
-	_trylock_and_lock_lcu(lcu, device);
+	spin_lock_irqsave(&lcu->lock, flags);
 	/* If this device is about to be removed just return and wait for
 	 * the next interrupt on a different device
 	 */
@@ -1033,27 +914,26 @@ void dasd_alias_handle_summary_unit_check(struct dasd_device *device,
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "device is in offline processing,"
 			    " don't do summary unit check handling");
-		_unlock_all_devices_on_lcu(lcu, device, NULL);
-		spin_unlock(&lcu->lock);
-		return;
+		goto out_unlock;
 	}
 	if (lcu->suc_data.device) {
 		/* already scheduled or running */
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "previous instance of summary unit check worker"
 			    " still pending");
-		_unlock_all_devices_on_lcu(lcu, device, NULL);
-		spin_unlock(&lcu->lock);
-		return ;
+		goto out_unlock;
 	}
 	_stop_all_devices_on_lcu(lcu);
 	/* prepare for lcu_update */
-	private->lcu->flags |= NEED_UAC_UPDATE | UPDATE_PENDING;
-	lcu->suc_data.reason = reason;
+	lcu->flags |= NEED_UAC_UPDATE | UPDATE_PENDING;
+	lcu->suc_data.reason = private->suc_reason;
 	lcu->suc_data.device = device;
 	dasd_get_device(device);
-	_unlock_all_devices_on_lcu(lcu, device, NULL);
-	spin_unlock(&lcu->lock);
 	if (!schedule_work(&lcu->suc_data.worker))
 		dasd_put_device(device);
+out_unlock:
+	spin_unlock_irqrestore(&lcu->lock, flags);
+out:
+	clear_bit(DASD_FLAG_SUC, &device->flags);
+	dasd_put_device(device);
 };
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 2f18f61..3cdbce4 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -982,6 +982,32 @@ out:
 static DEVICE_ATTR(safe_offline, 0200, NULL, dasd_safe_offline_store);
 
 static ssize_t
+dasd_access_show(struct device *dev, struct device_attribute *attr,
+		 char *buf)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+	struct dasd_device *device;
+	int count;
+
+	device = dasd_device_from_cdev(cdev);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
+
+	if (device->discipline->host_access_count)
+		count = device->discipline->host_access_count(device);
+	else
+		count = -EOPNOTSUPP;
+
+	dasd_put_device(device);
+	if (count < 0)
+		return count;
+
+	return sprintf(buf, "%d\n", count);
+}
+
+static DEVICE_ATTR(host_access_count, 0444, dasd_access_show, NULL);
+
+static ssize_t
 dasd_discipline_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
@@ -1471,6 +1497,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_reservation_policy.attr,
 	&dev_attr_last_known_reservation_state.attr,
 	&dev_attr_safe_offline.attr,
+	&dev_attr_host_access_count.attr,
 	&dev_attr_path_masks.attr,
 	NULL,
 };
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 75c032d..3b70d37 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/compat.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/css_chars.h>
 #include <asm/debug.h>
@@ -1682,6 +1683,8 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 
 	/* setup work queue for validate server*/
 	INIT_WORK(&device->kick_validate, dasd_eckd_do_validate_server);
+	/* setup work queue for summary unit check */
+	INIT_WORK(&device->suc_work, dasd_alias_handle_summary_unit_check);
 
 	if (!ccw_device_is_pathgroup(device->cdev)) {
 		dev_warn(&device->cdev->dev,
@@ -2549,14 +2552,6 @@ static void dasd_eckd_check_for_device_change(struct dasd_device *device,
 		    device->state == DASD_STATE_ONLINE &&
 		    !test_bit(DASD_FLAG_OFFLINE, &device->flags) &&
 		    !test_bit(DASD_FLAG_SUSPENDED, &device->flags)) {
-			/*
-			 * the state change could be caused by an alias
-			 * reassignment remove device from alias handling
-			 * to prevent new requests from being scheduled on
-			 * the wrong alias device
-			 */
-			dasd_alias_remove_device(device);
-
 			/* schedule worker to reload device */
 			dasd_reload_device(device);
 		}
@@ -2571,7 +2566,27 @@ static void dasd_eckd_check_for_device_change(struct dasd_device *device,
 	/* summary unit check */
 	if ((sense[27] & DASD_SENSE_BIT_0) && (sense[7] == 0x0D) &&
 	    (scsw_dstat(&irb->scsw) & DEV_STAT_UNIT_CHECK)) {
-		dasd_alias_handle_summary_unit_check(device, irb);
+		if (test_and_set_bit(DASD_FLAG_SUC, &device->flags)) {
+			DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+				      "eckd suc: device already notified");
+			return;
+		}
+		sense = dasd_get_sense(irb);
+		if (!sense) {
+			DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+				      "eckd suc: no reason code available");
+			clear_bit(DASD_FLAG_SUC, &device->flags);
+			return;
+
+		}
+		private->suc_reason = sense[8];
+		DBF_DEV_EVENT(DBF_NOTICE, device, "%s %x",
+			      "eckd handle summary unit check: reason",
+			      private->suc_reason);
+		dasd_get_device(device);
+		if (!schedule_work(&device->suc_work))
+			dasd_put_device(device);
+
 		return;
 	}
 
@@ -4495,6 +4510,12 @@ static int dasd_eckd_reload_device(struct dasd_device *device)
 	struct dasd_uid uid;
 	unsigned long flags;
 
+	/*
+	 * remove device from alias handling to prevent new requests
+	 * from being scheduled on the wrong alias device
+	 */
+	dasd_alias_remove_device(device);
+
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	old_base = private->uid.base_unit_addr;
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
@@ -4607,6 +4628,167 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	return rc;
 }
 
+static int dasd_eckd_query_host_access(struct dasd_device *device,
+				       struct dasd_psf_query_host_access *data)
+{
+	struct dasd_eckd_private *private = device->private;
+	struct dasd_psf_query_host_access *host_access;
+	struct dasd_psf_prssd_data *prssdp;
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+	int rc;
+
+	/* not available for HYPER PAV alias devices */
+	if (!device->block && private->lcu->pav == HYPER_PAV)
+		return -EOPNOTSUPP;
+
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
+				   sizeof(struct dasd_psf_prssd_data) + 1,
+				   device);
+	if (IS_ERR(cqr)) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+				"Could not allocate read message buffer request");
+		return PTR_ERR(cqr);
+	}
+	host_access = kzalloc(sizeof(*host_access), GFP_KERNEL | GFP_DMA);
+	if (!host_access) {
+		dasd_sfree_request(cqr, device);
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+				"Could not allocate host_access buffer");
+		return -ENOMEM;
+	}
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->block = NULL;
+	cqr->retries = 256;
+	cqr->expires = 10 * HZ;
+
+	/* Prepare for Read Subsystem Data */
+	prssdp = (struct dasd_psf_prssd_data *) cqr->data;
+	memset(prssdp, 0, sizeof(struct dasd_psf_prssd_data));
+	prssdp->order = PSF_ORDER_PRSSD;
+	prssdp->suborder = PSF_SUBORDER_QHA;	/* query host access */
+	/* LSS and Volume that will be queried */
+	prssdp->lss = private->ned->ID;
+	prssdp->volume = private->ned->unit_addr;
+	/* all other bytes of prssdp must be zero */
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_PSF;
+	ccw->count = sizeof(struct dasd_psf_prssd_data);
+	ccw->flags |= CCW_FLAG_CC;
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->cda = (__u32)(addr_t) prssdp;
+
+	/* Read Subsystem Data - query host access */
+	ccw++;
+	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
+	ccw->count = sizeof(struct dasd_psf_query_host_access);
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->cda = (__u32)(addr_t) host_access;
+
+	cqr->buildclk = get_tod_clock();
+	cqr->status = DASD_CQR_FILLED;
+	rc = dasd_sleep_on(cqr);
+	if (rc == 0) {
+		*data = *host_access;
+	} else {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"Reading host access data failed with rc=%d\n",
+				rc);
+		rc = -EOPNOTSUPP;
+	}
+
+	dasd_sfree_request(cqr, cqr->memdev);
+	kfree(host_access);
+	return rc;
+}
+/*
+ * return number of grouped devices
+ */
+static int dasd_eckd_host_access_count(struct dasd_device *device)
+{
+	struct dasd_psf_query_host_access *access;
+	struct dasd_ckd_path_group_entry *entry;
+	struct dasd_ckd_host_information *info;
+	int count = 0;
+	int rc, i;
+
+	access = kzalloc(sizeof(*access), GFP_NOIO);
+	if (!access) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+				"Could not allocate access buffer");
+		return -ENOMEM;
+	}
+	rc = dasd_eckd_query_host_access(device, access);
+	if (rc) {
+		kfree(access);
+		return rc;
+	}
+
+	info = (struct dasd_ckd_host_information *)
+		access->host_access_information;
+	for (i = 0; i < info->entry_count; i++) {
+		entry = (struct dasd_ckd_path_group_entry *)
+			(info->entry + i * info->entry_size);
+		if (entry->status_flags & DASD_ECKD_PG_GROUPED)
+			count++;
+	}
+
+	kfree(access);
+	return count;
+}
+
+/*
+ * write host access information to a sequential file
+ */
+static int dasd_hosts_print(struct dasd_device *device, struct seq_file *m)
+{
+	struct dasd_psf_query_host_access *access;
+	struct dasd_ckd_path_group_entry *entry;
+	struct dasd_ckd_host_information *info;
+	char sysplex[9] = "";
+	int rc, i, j;
+
+	access = kzalloc(sizeof(*access), GFP_NOIO);
+	if (!access) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+				"Could not allocate access buffer");
+		return -ENOMEM;
+	}
+	rc = dasd_eckd_query_host_access(device, access);
+	if (rc) {
+		kfree(access);
+		return rc;
+	}
+
+	info = (struct dasd_ckd_host_information *)
+		access->host_access_information;
+	for (i = 0; i < info->entry_count; i++) {
+		entry = (struct dasd_ckd_path_group_entry *)
+			(info->entry + i * info->entry_size);
+		/* PGID */
+		seq_puts(m, "pgid ");
+		for (j = 0; j < 11; j++)
+			seq_printf(m, "%02x", entry->pgid[j]);
+		seq_putc(m, '\n');
+		/* FLAGS */
+		seq_printf(m, "status_flags %02x\n", entry->status_flags);
+		/* SYSPLEX NAME */
+		memcpy(&sysplex, &entry->sysplex_name, sizeof(sysplex) - 1);
+		EBCASC(sysplex, sizeof(sysplex));
+		seq_printf(m, "sysplex_name %8s\n", sysplex);
+		/* SUPPORTED CYLINDER */
+		seq_printf(m, "supported_cylinder %d\n", entry->cylinder);
+		/* TIMESTAMP */
+		seq_printf(m, "timestamp %lu\n", (unsigned long)
+			   entry->timestamp);
+	}
+	kfree(access);
+
+	return 0;
+}
+
 /*
  * Perform Subsystem Function - CUIR response
  */
@@ -5079,6 +5261,8 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.get_uid = dasd_eckd_get_uid,
 	.kick_validate = dasd_eckd_kick_validate_server,
 	.check_attention = dasd_eckd_check_attention,
+	.host_access_count = dasd_eckd_host_access_count,
+	.hosts_print = dasd_hosts_print,
 };
 
 static int __init
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index f8f91ee..862ee42 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -53,6 +53,7 @@
  */
 #define PSF_ORDER_PRSSD			 0x18
 #define PSF_ORDER_CUIR_RESPONSE		 0x1A
+#define PSF_SUBORDER_QHA		 0x1C
 #define PSF_ORDER_SSC			 0x1D
 
 /*
@@ -81,6 +82,8 @@
 #define ATTENTION_LENGTH_CUIR		 0x0e
 #define ATTENTION_FORMAT_CUIR		 0x01
 
+#define DASD_ECKD_PG_GROUPED		 0x10
+
 /*
  * Size that is reportet for large volumes in the old 16-bit no_cyl field
  */
@@ -403,13 +406,41 @@ struct dasd_psf_cuir_response {
 	__u8 ssid;
 } __packed;
 
+struct dasd_ckd_path_group_entry {
+	__u8 status_flags;
+	__u8 pgid[11];
+	__u8 sysplex_name[8];
+	__u32 timestamp;
+	__u32 cylinder;
+	__u8 reserved[4];
+} __packed;
+
+struct dasd_ckd_host_information {
+	__u8 access_flags;
+	__u8 entry_size;
+	__u16 entry_count;
+	__u8 entry[16390];
+} __packed;
+
+struct dasd_psf_query_host_access {
+	__u8 access_flag;
+	__u8 version;
+	__u16 CKD_length;
+	__u16 SCSI_length;
+	__u8 unused[10];
+	__u8 host_access_information[16394];
+} __packed;
+
 /*
  * Perform Subsystem Function - Prepare for Read Subsystem Data
  */
 struct dasd_psf_prssd_data {
 	unsigned char order;
 	unsigned char flags;
-	unsigned char reserved[4];
+	unsigned char reserved1;
+	unsigned char reserved2;
+	unsigned char lss;
+	unsigned char volume;
 	unsigned char suborder;
 	unsigned char varies[5];
 } __attribute__ ((packed));
@@ -525,6 +556,7 @@ struct dasd_eckd_private {
 	int count;
 
 	u32 fcx_max_data;
+	char suc_reason;
 };
 
 
@@ -534,7 +566,7 @@ void dasd_alias_disconnect_device_from_lcu(struct dasd_device *);
 int dasd_alias_add_device(struct dasd_device *);
 int dasd_alias_remove_device(struct dasd_device *);
 struct dasd_device *dasd_alias_get_start_dev(struct dasd_device *);
-void dasd_alias_handle_summary_unit_check(struct dasd_device *, struct irb *);
+void dasd_alias_handle_summary_unit_check(struct work_struct *);
 void dasd_eckd_reset_ccw_to_base_io(struct dasd_ccw_req *);
 void dasd_alias_lcu_setup_complete(struct dasd_device *);
 void dasd_alias_wait_for_lcu_setup(struct dasd_device *);
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 8de29be..6132733 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -365,6 +365,8 @@ struct dasd_discipline {
 	int (*get_uid) (struct dasd_device *, struct dasd_uid *);
 	void (*kick_validate) (struct dasd_device *);
 	int (*check_attention)(struct dasd_device *, __u8);
+	int (*host_access_count)(struct dasd_device *);
+	int (*hosts_print)(struct dasd_device *, struct seq_file *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
@@ -470,6 +472,7 @@ struct dasd_device {
 	struct work_struct restore_device;
 	struct work_struct reload_device;
 	struct work_struct kick_validate;
+	struct work_struct suc_work;
 	struct timer_list timer;
 
 	debug_info_t *debug_area;
@@ -486,6 +489,7 @@ struct dasd_device {
 	unsigned long blk_timeout;
 
 	struct dentry *debugfs_dentry;
+	struct dentry *hosts_dentry;
 	struct dasd_profile profile;
 };
 
@@ -542,6 +546,7 @@ struct dasd_attention_data {
 #define DASD_FLAG_SAFE_OFFLINE_RUNNING	11	/* safe offline running */
 #define DASD_FLAG_ABORTALL	12	/* Abort all noretry requests */
 #define DASD_FLAG_PATH_VERIFY	13	/* Path verification worker running */
+#define DASD_FLAG_SUC		14	/* unhandled summary unit check */
 
 #define DASD_SLEEPON_START_TAG	((void *) 1)
 #define DASD_SLEEPON_END_TAG	((void *) 2)
