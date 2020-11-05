Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbgKEUMM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Nov 2020 15:12:12 -0500
Date: Thu, 5 Nov 2020 21:12:02 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.10-rc3
Message-ID: <20201105201202.GA7024@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

please pull some small s390 updates for 5.10-rc3.

Thanks,
Heiko

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-3

for you to fetch changes up to 0b2ca2c7d0c9e2731d01b6c862375d44a7e13923:

  s390/pci: fix hot-plug of PCI function missing bus (2020-11-03 15:12:16 +0100)

----------------------------------------------------------------
- fix reference counting for ap devices

- fix paes selftest

- fix pmd_deref()/pud_deref() so they can also handle large pages

- remove unused vdso file and defines

- update defconfigs

- call rcu_cpu_starting() early in smp init code to avoid lockdep warnings

- fix hotplug of PCI function missing bus

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/mm: make pmd/pud_deref() large page aware

Harald Freudenberger (2):
      s390/ap: fix ap devices reference counting
      s390/pkey: fix paes selftest failure with paes and pkey static build

Heiko Carstens (3):
      s390/vdso: remove empty unused file
      s390/vdso: remove unused constants
      s390: update defconfigs

Niklas Schnelle (1):
      s390/pci: fix hot-plug of PCI function missing bus

Qian Cai (1):
      s390/smp: move rcu_cpu_starting() earlier

 arch/s390/configs/debug_defconfig    | 10 ++++---
 arch/s390/configs/defconfig          |  9 ++++---
 arch/s390/configs/zfcpdump_defconfig |  2 +-
 arch/s390/include/asm/pgtable.h      | 52 +++++++++++++++++++++---------------
 arch/s390/include/asm/vdso/vdso.h    |  0
 arch/s390/kernel/asm-offsets.c       |  8 ------
 arch/s390/kernel/smp.c               |  3 ++-
 arch/s390/pci/pci_event.c            |  4 +++
 drivers/s390/crypto/ap_bus.c         | 14 ++++++++--
 drivers/s390/crypto/pkey_api.c       | 30 +++++++++++----------
 drivers/s390/crypto/zcrypt_card.c    | 13 +++++----
 drivers/s390/crypto/zcrypt_queue.c   |  6 +----
 12 files changed, 85 insertions(+), 66 deletions(-)
 delete mode 100644 arch/s390/include/asm/vdso/vdso.h

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 0784bf3caf43..a4d3c578fbd8 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -93,9 +93,10 @@ CONFIG_CLEANCACHE=y
 CONFIG_FRONTSWAP=y
 CONFIG_CMA_DEBUG=y
 CONFIG_CMA_DEBUGFS=y
+CONFIG_CMA_AREAS=7
 CONFIG_MEM_SOFT_DIRTY=y
 CONFIG_ZSWAP=y
-CONFIG_ZSMALLOC=m
+CONFIG_ZSMALLOC=y
 CONFIG_ZSMALLOC_STAT=y
 CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
 CONFIG_IDLE_PAGE_TRACKING=y
@@ -378,7 +379,6 @@ CONFIG_NETLINK_DIAG=m
 CONFIG_CGROUP_NET_PRIO=y
 CONFIG_BPF_JIT=y
 CONFIG_NET_PKTGEN=m
-# CONFIG_NET_DROP_MONITOR is not set
 CONFIG_PCI=y
 # CONFIG_PCIEASPM is not set
 CONFIG_PCI_DEBUG=y
@@ -386,7 +386,7 @@ CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_S390=y
 CONFIG_DEVTMPFS=y
 CONFIG_CONNECTOR=y
-CONFIG_ZRAM=m
+CONFIG_ZRAM=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
@@ -689,6 +689,7 @@ CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECRDSA=m
+CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_CHACHA20POLY1305=m
@@ -709,7 +710,6 @@ CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_RMD256=m
 CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_SM3=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES_TI=m
@@ -753,6 +753,7 @@ CONFIG_CRYPTO_DES_S390=m
 CONFIG_CRYPTO_AES_S390=m
 CONFIG_CRYPTO_GHASH_S390=m
 CONFIG_CRYPTO_CRC32_S390=y
+CONFIG_CRYPTO_DEV_VIRTIO=m
 CONFIG_CORDIC=m
 CONFIG_CRC32_SELFTEST=y
 CONFIG_CRC4=m
@@ -829,6 +830,7 @@ CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAILSLAB=y
 CONFIG_FAIL_PAGE_ALLOC=y
+CONFIG_FAULT_INJECTION_USERCOPY=y
 CONFIG_FAIL_MAKE_REQUEST=y
 CONFIG_FAIL_IO_TIMEOUT=y
 CONFIG_FAIL_FUTEX=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 905bc8c4cfaf..17d5df2c1eff 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -87,9 +87,10 @@ CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CLEANCACHE=y
 CONFIG_FRONTSWAP=y
+CONFIG_CMA_AREAS=7
 CONFIG_MEM_SOFT_DIRTY=y
 CONFIG_ZSWAP=y
-CONFIG_ZSMALLOC=m
+CONFIG_ZSMALLOC=y
 CONFIG_ZSMALLOC_STAT=y
 CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
 CONFIG_IDLE_PAGE_TRACKING=y
@@ -371,7 +372,6 @@ CONFIG_NETLINK_DIAG=m
 CONFIG_CGROUP_NET_PRIO=y
 CONFIG_BPF_JIT=y
 CONFIG_NET_PKTGEN=m
-# CONFIG_NET_DROP_MONITOR is not set
 CONFIG_PCI=y
 # CONFIG_PCIEASPM is not set
 CONFIG_HOTPLUG_PCI=y
@@ -379,7 +379,7 @@ CONFIG_HOTPLUG_PCI_S390=y
 CONFIG_UEVENT_HELPER=y
 CONFIG_DEVTMPFS=y
 CONFIG_CONNECTOR=y
-CONFIG_ZRAM=m
+CONFIG_ZRAM=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
@@ -680,6 +680,7 @@ CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECRDSA=m
+CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_CHACHA20POLY1305=m
@@ -701,7 +702,6 @@ CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_RMD256=m
 CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_SM3=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES_TI=m
@@ -745,6 +745,7 @@ CONFIG_CRYPTO_DES_S390=m
 CONFIG_CRYPTO_AES_S390=m
 CONFIG_CRYPTO_GHASH_S390=m
 CONFIG_CRYPTO_CRC32_S390=y
+CONFIG_CRYPTO_DEV_VIRTIO=m
 CONFIG_CORDIC=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC4=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 8f67c55625f9..a302630341ef 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -17,11 +17,11 @@ CONFIG_HZ_100=y
 # CONFIG_CHSC_SCH is not set
 # CONFIG_SCM_BUS is not set
 CONFIG_CRASH_DUMP=y
-# CONFIG_SECCOMP is not set
 # CONFIG_PFAULT is not set
 # CONFIG_S390_HYPFS_FS is not set
 # CONFIG_VIRTUALIZATION is not set
 # CONFIG_S390_GUEST is not set
+# CONFIG_SECCOMP is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_IBM_PARTITION=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 6b8d8c69b1a1..b5dbae78969b 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -692,16 +692,6 @@ static inline int pud_large(pud_t pud)
 	return !!(pud_val(pud) & _REGION3_ENTRY_LARGE);
 }
 
-static inline unsigned long pud_pfn(pud_t pud)
-{
-	unsigned long origin_mask;
-
-	origin_mask = _REGION_ENTRY_ORIGIN;
-	if (pud_large(pud))
-		origin_mask = _REGION3_ENTRY_ORIGIN_LARGE;
-	return (pud_val(pud) & origin_mask) >> PAGE_SHIFT;
-}
-
 #define pmd_leaf	pmd_large
 static inline int pmd_large(pmd_t pmd)
 {
@@ -747,16 +737,6 @@ static inline int pmd_none(pmd_t pmd)
 	return pmd_val(pmd) == _SEGMENT_ENTRY_EMPTY;
 }
 
-static inline unsigned long pmd_pfn(pmd_t pmd)
-{
-	unsigned long origin_mask;
-
-	origin_mask = _SEGMENT_ENTRY_ORIGIN;
-	if (pmd_large(pmd))
-		origin_mask = _SEGMENT_ENTRY_ORIGIN_LARGE;
-	return (pmd_val(pmd) & origin_mask) >> PAGE_SHIFT;
-}
-
 #define pmd_write pmd_write
 static inline int pmd_write(pmd_t pmd)
 {
@@ -1238,11 +1218,39 @@ static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 #define pud_index(address) (((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 #define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 
-#define pmd_deref(pmd) (pmd_val(pmd) & _SEGMENT_ENTRY_ORIGIN)
-#define pud_deref(pud) (pud_val(pud) & _REGION_ENTRY_ORIGIN)
 #define p4d_deref(pud) (p4d_val(pud) & _REGION_ENTRY_ORIGIN)
 #define pgd_deref(pgd) (pgd_val(pgd) & _REGION_ENTRY_ORIGIN)
 
+static inline unsigned long pmd_deref(pmd_t pmd)
+{
+	unsigned long origin_mask;
+
+	origin_mask = _SEGMENT_ENTRY_ORIGIN;
+	if (pmd_large(pmd))
+		origin_mask = _SEGMENT_ENTRY_ORIGIN_LARGE;
+	return pmd_val(pmd) & origin_mask;
+}
+
+static inline unsigned long pmd_pfn(pmd_t pmd)
+{
+	return pmd_deref(pmd) >> PAGE_SHIFT;
+}
+
+static inline unsigned long pud_deref(pud_t pud)
+{
+	unsigned long origin_mask;
+
+	origin_mask = _REGION_ENTRY_ORIGIN;
+	if (pud_large(pud))
+		origin_mask = _REGION3_ENTRY_ORIGIN_LARGE;
+	return pud_val(pud) & origin_mask;
+}
+
+static inline unsigned long pud_pfn(pud_t pud)
+{
+	return pud_deref(pud) >> PAGE_SHIFT;
+}
+
 /*
  * The pgd_offset function *always* adds the index for the top-level
  * region/segment table. This is done to get a sequence like the
diff --git a/arch/s390/include/asm/vdso/vdso.h b/arch/s390/include/asm/vdso/vdso.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index ece58f2217cb..2012c1cf0853 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -61,14 +61,6 @@ int main(void)
 	BLANK();
 	OFFSET(__VDSO_GETCPU_VAL, vdso_per_cpu_data, getcpu_val);
 	BLANK();
-	/* constants used by the vdso */
-	DEFINE(__CLOCK_REALTIME, CLOCK_REALTIME);
-	DEFINE(__CLOCK_MONOTONIC, CLOCK_MONOTONIC);
-	DEFINE(__CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
-	DEFINE(__CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
-	DEFINE(__CLOCK_THREAD_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID);
-	DEFINE(__CLOCK_COARSE_RES, LOW_RES_NSEC);
-	BLANK();
 	/* idle data offsets */
 	OFFSET(__CLOCK_IDLE_ENTER, s390_idle_data, clock_idle_enter);
 	OFFSET(__CLOCK_IDLE_EXIT, s390_idle_data, clock_idle_exit);
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index ebfe86d097f0..390d97daa2b3 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -855,13 +855,14 @@ void __init smp_detect_cpus(void)
 
 static void smp_init_secondary(void)
 {
-	int cpu = smp_processor_id();
+	int cpu = raw_smp_processor_id();
 
 	S390_lowcore.last_update_clock = get_tod_clock();
 	restore_access_regs(S390_lowcore.access_regs_save_area);
 	set_cpu_flag(CIF_ASCE_PRIMARY);
 	set_cpu_flag(CIF_ASCE_SECONDARY);
 	cpu_init();
+	rcu_cpu_starting(cpu);
 	preempt_disable();
 	init_cpu_timer();
 	vtime_init();
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index d33f21545dfd..9a6bae503fe6 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -101,6 +101,10 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 		if (ret)
 			break;
 
+		/* the PCI function will be scanned once function 0 appears */
+		if (!zdev->zbus->bus)
+			break;
+
 		pdev = pci_scan_single_device(zdev->zbus->bus, zdev->devfn);
 		if (!pdev)
 			break;
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 485cbfcbf06e..ef738b42a092 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -680,7 +680,10 @@ static int ap_device_probe(struct device *dev)
 {
 	struct ap_device *ap_dev = to_ap_dev(dev);
 	struct ap_driver *ap_drv = to_ap_drv(dev->driver);
-	int card, queue, devres, drvres, rc;
+	int card, queue, devres, drvres, rc = -ENODEV;
+
+	if (!get_device(dev))
+		return rc;
 
 	if (is_queue_dev(dev)) {
 		/*
@@ -697,7 +700,7 @@ static int ap_device_probe(struct device *dev)
 		mutex_unlock(&ap_perms_mutex);
 		drvres = ap_drv->flags & AP_DRIVER_FLAG_DEFAULT;
 		if (!!devres != !!drvres)
-			return -ENODEV;
+			goto out;
 	}
 
 	/* Add queue/card to list of active queues/cards */
@@ -718,6 +721,9 @@ static int ap_device_probe(struct device *dev)
 		ap_dev->drv = NULL;
 	}
 
+out:
+	if (rc)
+		put_device(dev);
 	return rc;
 }
 
@@ -744,6 +750,8 @@ static int ap_device_remove(struct device *dev)
 		hash_del(&to_ap_queue(dev)->hnode);
 	spin_unlock_bh(&ap_queues_lock);
 
+	put_device(dev);
+
 	return 0;
 }
 
@@ -1371,6 +1379,8 @@ static inline void ap_scan_domains(struct ap_card *ac)
 					    __func__, ac->id, dom);
 				goto put_dev_and_continue;
 			}
+			/* get it and thus adjust reference counter */
+			get_device(dev);
 			if (decfg)
 				AP_DBF_INFO("%s(%d,%d) new (decfg) queue device created\n",
 					    __func__, ac->id, dom);
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 99cb60ea663d..dd84995049b9 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -35,9 +35,6 @@ MODULE_DESCRIPTION("s390 protected key interface");
 #define PROTKEYBLOBBUFSIZE 256	/* protected key buffer size used internal */
 #define MAXAPQNSINLIST 64	/* max 64 apqns within a apqn list */
 
-/* mask of available pckmo subfunctions, fetched once at module init */
-static cpacf_mask_t pckmo_functions;
-
 /*
  * debug feature data and functions
  */
@@ -91,6 +88,9 @@ static int pkey_clr2protkey(u32 keytype,
 			    const struct pkey_clrkey *clrkey,
 			    struct pkey_protkey *protkey)
 {
+	/* mask of available pckmo subfunctions */
+	static cpacf_mask_t pckmo_functions;
+
 	long fc;
 	int keysize;
 	u8 paramblock[64];
@@ -114,11 +114,13 @@ static int pkey_clr2protkey(u32 keytype,
 		return -EINVAL;
 	}
 
-	/*
-	 * Check if the needed pckmo subfunction is available.
-	 * These subfunctions can be enabled/disabled by customers
-	 * in the LPAR profile or may even change on the fly.
-	 */
+	/* Did we already check for PCKMO ? */
+	if (!pckmo_functions.bytes[0]) {
+		/* no, so check now */
+		if (!cpacf_query(CPACF_PCKMO, &pckmo_functions))
+			return -ENODEV;
+	}
+	/* check for the pckmo subfunction we need now */
 	if (!cpacf_test_func(&pckmo_functions, fc)) {
 		DEBUG_ERR("%s pckmo functions not available\n", __func__);
 		return -ENODEV;
@@ -2058,7 +2060,7 @@ static struct miscdevice pkey_dev = {
  */
 static int __init pkey_init(void)
 {
-	cpacf_mask_t kmc_functions;
+	cpacf_mask_t func_mask;
 
 	/*
 	 * The pckmo instruction should be available - even if we don't
@@ -2066,15 +2068,15 @@ static int __init pkey_init(void)
 	 * is also the minimum level for the kmc instructions which
 	 * are able to work with protected keys.
 	 */
-	if (!cpacf_query(CPACF_PCKMO, &pckmo_functions))
+	if (!cpacf_query(CPACF_PCKMO, &func_mask))
 		return -ENODEV;
 
 	/* check for kmc instructions available */
-	if (!cpacf_query(CPACF_KMC, &kmc_functions))
+	if (!cpacf_query(CPACF_KMC, &func_mask))
 		return -ENODEV;
-	if (!cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_128) ||
-	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_192) ||
-	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_256))
+	if (!cpacf_test_func(&func_mask, CPACF_KMC_PAES_128) ||
+	    !cpacf_test_func(&func_mask, CPACF_KMC_PAES_192) ||
+	    !cpacf_test_func(&func_mask, CPACF_KMC_PAES_256))
 		return -ENODEV;
 
 	pkey_debug_init();
diff --git a/drivers/s390/crypto/zcrypt_card.c b/drivers/s390/crypto/zcrypt_card.c
index e342eb86acd1..33b23884b133 100644
--- a/drivers/s390/crypto/zcrypt_card.c
+++ b/drivers/s390/crypto/zcrypt_card.c
@@ -157,11 +157,6 @@ int zcrypt_card_register(struct zcrypt_card *zc)
 {
 	int rc;
 
-	rc = sysfs_create_group(&zc->card->ap_dev.device.kobj,
-				&zcrypt_card_attr_group);
-	if (rc)
-		return rc;
-
 	spin_lock(&zcrypt_list_lock);
 	list_add_tail(&zc->list, &zcrypt_card_list);
 	spin_unlock(&zcrypt_list_lock);
@@ -170,6 +165,14 @@ int zcrypt_card_register(struct zcrypt_card *zc)
 
 	ZCRYPT_DBF(DBF_INFO, "card=%02x register online=1\n", zc->card->id);
 
+	rc = sysfs_create_group(&zc->card->ap_dev.device.kobj,
+				&zcrypt_card_attr_group);
+	if (rc) {
+		spin_lock(&zcrypt_list_lock);
+		list_del_init(&zc->list);
+		spin_unlock(&zcrypt_list_lock);
+	}
+
 	return rc;
 }
 EXPORT_SYMBOL(zcrypt_card_register);
diff --git a/drivers/s390/crypto/zcrypt_queue.c b/drivers/s390/crypto/zcrypt_queue.c
index 3c207066313c..5062eae73d4a 100644
--- a/drivers/s390/crypto/zcrypt_queue.c
+++ b/drivers/s390/crypto/zcrypt_queue.c
@@ -180,7 +180,6 @@ int zcrypt_queue_register(struct zcrypt_queue *zq)
 				&zcrypt_queue_attr_group);
 	if (rc)
 		goto out;
-	get_device(&zq->queue->ap_dev.device);
 
 	if (zq->ops->rng) {
 		rc = zcrypt_rng_device_add();
@@ -192,7 +191,6 @@ int zcrypt_queue_register(struct zcrypt_queue *zq)
 out_unregister:
 	sysfs_remove_group(&zq->queue->ap_dev.device.kobj,
 			   &zcrypt_queue_attr_group);
-	put_device(&zq->queue->ap_dev.device);
 out:
 	spin_lock(&zcrypt_list_lock);
 	list_del_init(&zq->list);
@@ -220,12 +218,10 @@ void zcrypt_queue_unregister(struct zcrypt_queue *zq)
 	list_del_init(&zq->list);
 	zcrypt_device_count--;
 	spin_unlock(&zcrypt_list_lock);
-	zcrypt_card_put(zc);
 	if (zq->ops->rng)
 		zcrypt_rng_device_remove();
 	sysfs_remove_group(&zq->queue->ap_dev.device.kobj,
 			   &zcrypt_queue_attr_group);
-	put_device(&zq->queue->ap_dev.device);
-	zcrypt_queue_put(zq);
+	zcrypt_card_put(zc);
 }
 EXPORT_SYMBOL(zcrypt_queue_unregister);
