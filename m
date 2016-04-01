Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 1 Apr 2016 08:54:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for 4.6-rc2
Message-ID: <20160401085446.2aa8d1a1@mschwide>
In-Reply-To: <CA+55aFy8DuvwBfg5PcpTZYvXYeA7Vxq+w9XoOMErwQB7nq93wg@mail.gmail.com>
References: <20160331145724.13258ddb@mschwide>
	<CA+55aFyEDjfDd_Ni3ZUcf4jkwBYvuLZOdmWP-FnRgchW1hj5OQ@mail.gmail.com>
	<20160331152651.650e334a@mschwide>
	<CA+55aFy8DuvwBfg5PcpTZYvXYeA7Vxq+w9XoOMErwQB7nq93wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 31 Mar 2016 14:29:09 -0500
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Mar 31, 2016 at 8:26 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > I really would like to see the "s390/dasd: reorder lcu and device lock" go
> > into 4.6 as the current solution is really ugly. But I'll remove the patch
> > with the new attribute. Would that be acceptable?
> 
> That sounds better, yes.

Ok, here we go:

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

* A proper fix for the locking issue in the dasd driver
* Wire up the new preadv2 nad pwritev2 system calls
* Add the mark_rodata_ro function and set DEBUG_RODATA=y
* A few more bug fixes.

Anna-Maria Gleixner (2):
      s390/cpum_cf: Fix missing cpu hotplug notifier transition
      s390/cpum_sf: Fix cpu hotplug notifier transitions

Gerald Schaefer (1):
      s390/mm: handle PTE-mapped tail pages in fast gup

Harald Freudenberger (1):
      s390/crypto: provide correct file mode at device register.

Heiko Carstens (2):
      s390: add DEBUG_RODATA support
      s390: wire up preadv2/pwritev2 syscalls

Kees Cook (1):
      s390: disable postinit-readonly for now

Pierre Morel (1):
      s390/pci: PCI function group 0 is valid for clp_query_pci_fn

Stefan Haberland (1):
      s390/dasd: reorder lcu and device lock

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
 drivers/s390/block/dasd_alias.c     | 226 +++++++++---------------------------
 drivers/s390/block/dasd_eckd.c      |  38 ++++--
 drivers/s390/block/dasd_eckd.h      |   3 +-
 drivers/s390/block/dasd_int.h       |   2 +
 14 files changed, 114 insertions(+), 193 deletions(-)

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
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 75c032d..c1b4ae5 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1682,6 +1682,8 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 
 	/* setup work queue for validate server*/
 	INIT_WORK(&device->kick_validate, dasd_eckd_do_validate_server);
+	/* setup work queue for summary unit check */
+	INIT_WORK(&device->suc_work, dasd_alias_handle_summary_unit_check);
 
 	if (!ccw_device_is_pathgroup(device->cdev)) {
 		dev_warn(&device->cdev->dev,
@@ -2549,14 +2551,6 @@ static void dasd_eckd_check_for_device_change(struct dasd_device *device,
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
@@ -2571,7 +2565,27 @@ static void dasd_eckd_check_for_device_change(struct dasd_device *device,
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
 
@@ -4495,6 +4509,12 @@ static int dasd_eckd_reload_device(struct dasd_device *device)
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
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index f8f91ee..6d9a6d3 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -525,6 +525,7 @@ struct dasd_eckd_private {
 	int count;
 
 	u32 fcx_max_data;
+	char suc_reason;
 };
 
 
@@ -534,7 +535,7 @@ void dasd_alias_disconnect_device_from_lcu(struct dasd_device *);
 int dasd_alias_add_device(struct dasd_device *);
 int dasd_alias_remove_device(struct dasd_device *);
 struct dasd_device *dasd_alias_get_start_dev(struct dasd_device *);
-void dasd_alias_handle_summary_unit_check(struct dasd_device *, struct irb *);
+void dasd_alias_handle_summary_unit_check(struct work_struct *);
 void dasd_eckd_reset_ccw_to_base_io(struct dasd_ccw_req *);
 void dasd_alias_lcu_setup_complete(struct dasd_device *);
 void dasd_alias_wait_for_lcu_setup(struct dasd_device *);
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 8de29be..0f0add9 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -470,6 +470,7 @@ struct dasd_device {
 	struct work_struct restore_device;
 	struct work_struct reload_device;
 	struct work_struct kick_validate;
+	struct work_struct suc_work;
 	struct timer_list timer;
 
 	debug_info_t *debug_area;
@@ -542,6 +543,7 @@ struct dasd_attention_data {
 #define DASD_FLAG_SAFE_OFFLINE_RUNNING	11	/* safe offline running */
 #define DASD_FLAG_ABORTALL	12	/* Abort all noretry requests */
 #define DASD_FLAG_PATH_VERIFY	13	/* Path verification worker running */
+#define DASD_FLAG_SUC		14	/* unhandled summary unit check */
 
 #define DASD_SLEEPON_START_TAG	((void *) 1)
 #define DASD_SLEEPON_END_TAG	((void *) 2)
