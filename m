Return-Path: <linux-kernel-owner+w=401wt.eu-S1031392AbXEDQ66@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Fri, 04 May 2007 18:59:15 +0200
Message-Id: <1178297955.2640.2.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 Documentation/feature-removal-schedule.txt |   17 ++
 arch/s390/crypto/aes_s390.c                |   15 ++-
 arch/s390/kernel/kprobes.c                 |    3 +-
 arch/s390/kernel/setup.c                   |  111 +++++++++++++-
 arch/s390/mm/fault.c                       |   40 ++---
 drivers/s390/block/dasd.c                  |   45 +++++
 drivers/s390/block/dasd_eckd.c             |   81 +++++++++-
 drivers/s390/block/dasd_fba.c              |    2 +-
 drivers/s390/block/dasd_int.h              |    2 +
 drivers/s390/char/tape.h                   |    1 +
 drivers/s390/char/tape_3590.c              |   29 +++-
 drivers/s390/char/tape_3590.h              |    4 +
 drivers/s390/char/tape_core.c              |    3 +-
 drivers/s390/cio/qdio.c                    |  240 ++++++++++++++++------------
 drivers/s390/cio/qdio.h                    |   52 +++++--
 drivers/s390/net/qeth.h                    |    3 +
 drivers/s390/net/qeth_main.c               |   77 +++++++++-
 drivers/s390/net/qeth_mpc.h                |    1 +
 include/asm-s390/ccwdev.h                  |    6 +-
 include/asm-s390/elf.h                     |    7 +-
 include/asm-s390/kdebug.h                  |   18 ++-
 include/asm-s390/kprobes.h                 |   16 +--
 include/asm-s390/lowcore.h                 |   10 +-
 23 files changed, 593 insertions(+), 190 deletions(-)

Christoph Hellwig (1):
      [S390] get rid of kprobes notifier call chain.

Cornelia Huck (3):
      [S390] cio: Deprecate read_dev_chars() and read_conf_data{,_lpm}().
      [S390] dasd: New read device characteristics and read configuration data.
      [S390] qeth: New read configuration data.

Jan Glauber (1):
      [S390] aes-s390 key length.

Martin Schwidefsky (2):
      [S390] Export uaccess as non-gpl symbol.
      [S390] add hardware capability support (ELF_HWCAP).

Michael Holzheu (1):
      [S390] tape: New read configuration data.

Ursula Braun (1):
      [S390] qdio: make qdio statistics SMP-capable

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 5c88ba1..1a9e600 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -314,3 +314,20 @@ Why:	Code was merged, then submitter immediately disappeared leaving
 Who:	David S. Miller <davem@davemloft.net>
 
 ---------------------------
+
+What:	read_dev_chars(), read_conf_data{,_lpm}() (s390 common I/O layer)
+When:	December 2007
+Why:	These functions are a leftover from 2.4 times. They have several
+	problems:
+	- Duplication of checks that are done in the device driver's
+	  interrupt handler
+	- common I/O layer can't do device specific error recovery
+	- device driver can't be notified for conditions happening during
+	  execution of the function
+	Device drivers should issue the read device characteristics and read
+	configuration data ccws and do the appropriate error handling
+	themselves.
+Who:	Cornelia Huck <cornelia.huck@de.ibm.com>
+
+---------------------------
+
diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 9163635..3660ca6 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -119,7 +119,8 @@ static struct crypto_alg aes_alg = {
 	.cra_name		=	"aes",
 	.cra_driver_name	=	"aes-s390",
 	.cra_priority		=	CRYPT_S390_PRIORITY,
-	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER |
+					CRYPTO_ALG_NEED_FALLBACK,
 	.cra_blocksize		=	AES_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct s390_aes_ctx),
 	.cra_module		=	THIS_MODULE,
@@ -206,7 +207,8 @@ static struct crypto_alg ecb_aes_alg = {
 	.cra_name		=	"ecb(aes)",
 	.cra_driver_name	=	"ecb-aes-s390",
 	.cra_priority		=	CRYPT_S390_COMPOSITE_PRIORITY,
-	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER,
+	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER |
+					CRYPTO_ALG_NEED_FALLBACK,
 	.cra_blocksize		=	AES_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct s390_aes_ctx),
 	.cra_type		=	&crypto_blkcipher_type,
@@ -300,7 +302,8 @@ static struct crypto_alg cbc_aes_alg = {
 	.cra_name		=	"cbc(aes)",
 	.cra_driver_name	=	"cbc-aes-s390",
 	.cra_priority		=	CRYPT_S390_COMPOSITE_PRIORITY,
-	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER,
+	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER |
+					CRYPTO_ALG_NEED_FALLBACK,
 	.cra_blocksize		=	AES_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct s390_aes_ctx),
 	.cra_type		=	&crypto_blkcipher_type,
@@ -333,10 +336,14 @@ static int __init aes_init(void)
 		return -EOPNOTSUPP;
 
 	/* z9 109 and z9 BC/EC only support 128 bit key length */
-	if (keylen_flag == AES_KEYLEN_128)
+	if (keylen_flag == AES_KEYLEN_128) {
+		aes_alg.cra_u.cipher.cia_max_keysize = AES_MIN_KEY_SIZE;
+		ecb_aes_alg.cra_u.blkcipher.max_keysize = AES_MIN_KEY_SIZE;
+		cbc_aes_alg.cra_u.blkcipher.max_keysize = AES_MIN_KEY_SIZE;
 		printk(KERN_INFO
 		       "aes_s390: hardware acceleration only available for"
 		       "128 bit keys\n");
+	}
 
 	ret = crypto_register_alg(&aes_alg);
 	if (ret)
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 993f353..23c61f6 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -516,7 +516,7 @@ out:
 	return 1;
 }
 
-static int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
@@ -603,7 +603,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 			ret = NOTIFY_STOP;
 		break;
 	case DIE_TRAP:
-	case DIE_PAGE_FAULT:
 		/* kprobe_running() needs smp_processor_id() */
 		preempt_disable();
 		if (kprobe_running() &&
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 3dfd098..6bfb088 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -65,7 +65,7 @@ long psw_user_bits	= (PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_HOME |
  * User copy operations.
  */
 struct uaccess_ops uaccess;
-EXPORT_SYMBOL_GPL(uaccess);
+EXPORT_SYMBOL(uaccess);
 
 /*
  * Machine setup..
@@ -74,6 +74,8 @@ unsigned int console_mode = 0;
 unsigned int console_devno = -1;
 unsigned int console_irq = -1;
 unsigned long machine_flags = 0;
+unsigned long elf_hwcap = 0;
+char elf_platform[ELF_PLATFORM_SIZE];
 
 struct mem_chunk __initdata memory_chunk[MEMORY_CHUNKS];
 volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
@@ -749,6 +751,98 @@ setup_memory(void)
 #endif
 }
 
+static __init unsigned int stfl(void)
+{
+	asm volatile(
+		"	.insn	s,0xb2b10000,0(0)\n" /* stfl */
+		"0:\n"
+		EX_TABLE(0b,0b));
+	return S390_lowcore.stfl_fac_list;
+}
+
+static __init int stfle(unsigned long long *list, int doublewords)
+{
+	typedef struct { unsigned long long _[doublewords]; } addrtype;
+	register unsigned long __nr asm("0") = doublewords - 1;
+
+	asm volatile(".insn s,0xb2b00000,%0" /* stfle */
+		     : "=m" (*(addrtype *) list), "+d" (__nr) : : "cc");
+	return __nr + 1;
+}
+
+/*
+ * Setup hardware capabilities.
+ */
+static void __init setup_hwcaps(void)
+{
+	static const int stfl_bits[6] = { 0, 2, 7, 17, 19, 21 };
+	struct cpuinfo_S390 *cpuinfo = &S390_lowcore.cpu_data;
+	unsigned long long facility_list_extended;
+	unsigned int facility_list;
+	int i;
+
+	facility_list = stfl();
+	/*
+	 * The store facility list bits numbers as found in the principles
+	 * of operation are numbered with bit 1UL<<31 as number 0 to
+	 * bit 1UL<<0 as number 31.
+	 *   Bit 0: instructions named N3, "backported" to esa-mode
+	 *   Bit 2: z/Architecture mode is active
+	 *   Bit 7: the store-facility-list-extended facility is installed
+	 *   Bit 17: the message-security assist is installed
+	 *   Bit 19: the long-displacement facility is installed
+	 *   Bit 21: the extended-immediate facility is installed
+	 * These get translated to:
+	 *   HWCAP_S390_ESAN3 bit 0, HWCAP_S390_ZARCH bit 1,
+	 *   HWCAP_S390_STFLE bit 2, HWCAP_S390_MSA bit 3,
+	 *   HWCAP_S390_LDISP bit 4, and HWCAP_S390_EIMM bit 5.
+	 */
+	for (i = 0; i < 6; i++)
+		if (facility_list & (1UL << (31 - stfl_bits[i])))
+			elf_hwcap |= 1UL << i;
+
+	/*
+	 * Check for additional facilities with store-facility-list-extended.
+	 * stfle stores doublewords (8 byte) with bit 1ULL<<63 as bit 0
+	 * and 1ULL<<0 as bit 63. Bits 0-31 contain the same information
+	 * as stored by stfl, bits 32-xxx contain additional facilities.
+	 * How many facility words are stored depends on the number of
+	 * doublewords passed to the instruction. The additional facilites
+	 * are:
+	 *   Bit 43: decimal floating point facility is installed
+	 * translated to:
+	 *   HWCAP_S390_DFP bit 6.
+	 */
+	if ((elf_hwcap & (1UL << 2)) &&
+	    stfle(&facility_list_extended, 1) > 0) {
+		if (facility_list_extended & (1ULL << (64 - 43)))
+			elf_hwcap |= 1UL << 6;
+	}
+
+	switch (cpuinfo->cpu_id.machine) {
+	case 0x9672:
+#if !defined(CONFIG_64BIT)
+	default:	/* Use "g5" as default for 31 bit kernels. */
+#endif
+		strcpy(elf_platform, "g5");
+		break;
+	case 0x2064:
+	case 0x2066:
+#if defined(CONFIG_64BIT)
+	default:	/* Use "z900" as default for 64 bit kernels. */
+#endif
+		strcpy(elf_platform, "z900");
+		break;
+	case 0x2084:
+	case 0x2086:
+		strcpy(elf_platform, "z990");
+		break;
+	case 0x2094:
+		strcpy(elf_platform, "z9-109");
+		break;
+	}
+}
+
 /*
  * Setup function called from init/main.c just after the banner
  * was printed.
@@ -805,6 +899,11 @@ setup_arch(char **cmdline_p)
 	smp_setup_cpu_possible_map();
 
 	/*
+	 * Setup capabilities (ELF_HWCAP & ELF_PLATFORM).
+	 */
+	setup_hwcaps();
+
+	/*
 	 * Create kernel page tables and switch to virtual addressing.
 	 */
         paging_init();
@@ -839,8 +938,12 @@ void print_cpu_info(struct cpuinfo_S390 *cpuinfo)
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
+	static const char *hwcap_str[7] = {
+		"esan3", "zarch", "stfle", "msa", "ldisp", "eimm", "dfp"
+	};
         struct cpuinfo_S390 *cpuinfo;
 	unsigned long n = (unsigned long) v - 1;
+	int i;
 
 	s390_adjust_jiffies();
 	preempt_disable();
@@ -850,7 +953,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 			       "bogomips per cpu: %lu.%02lu\n",
 			       num_online_cpus(), loops_per_jiffy/(500000/HZ),
 			       (loops_per_jiffy/(5000/HZ))%100);
+		seq_puts(m, "features\t: ");
+		for (i = 0; i < 7; i++)
+			if (hwcap_str[i] && (elf_hwcap & (1UL << i)))
+				seq_printf(m, "%s ", hwcap_str[i]);
+		seq_puts(m, "\n");
 	}
+
 	if (cpu_online(n)) {
 #ifdef CONFIG_SMP
 		if (smp_processor_id() == n)
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2b76a87..91f705a 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -52,38 +52,24 @@ extern int sysctl_userprocess_debug;
 extern void die(const char *,struct pt_regs *,long);
 
 #ifdef CONFIG_KPROBES
-static ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
-int register_page_fault_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_register(&notify_page_fault_chain, nb);
-}
-
-int unregister_page_fault_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_unregister(&notify_page_fault_chain, nb);
-}
-
-static int __kprobes __notify_page_fault(struct pt_regs *regs, long err)
-{
-	struct die_args args = { .str = "page fault",
-				 .trapnr = 14,
-				 .signr = SIGSEGV };
-	args.regs = regs;
-	args.err = err;
-	return atomic_notifier_call_chain(&notify_page_fault_chain,
-					  DIE_PAGE_FAULT, &args);
-}
-
 static inline int notify_page_fault(struct pt_regs *regs, long err)
 {
-	if (unlikely(kprobe_running()))
-		return __notify_page_fault(regs, err);
-	return NOTIFY_DONE;
+	int ret = 0;
+
+	/* kprobe_running() needs smp_processor_id() */
+	if (!user_mode(regs)) {
+		preempt_disable();
+		if (kprobe_running() && kprobe_fault_handler(regs, 14))
+			ret = 1;
+		preempt_enable();
+	}
+
+	return ret;
 }
 #else
 static inline int notify_page_fault(struct pt_regs *regs, long err)
 {
-	return NOTIFY_DONE;
+	return 0;
 }
 #endif
 
@@ -319,7 +305,7 @@ do_exception(struct pt_regs *regs, unsigned long error_code, int write)
 	int space;
 	int si_code;
 
-	if (notify_page_fault(regs, error_code) == NOTIFY_STOP)
+	if (notify_page_fault(regs, error_code))
 		return;
 
 	tsk = current;
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index e71929d..9775210 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2174,6 +2174,51 @@ dasd_generic_notify(struct ccw_device *cdev, int event)
 	return ret;
 }
 
+struct dasd_ccw_req * dasd_generic_build_rdc(struct dasd_device *device,
+					     void *rdc_buffer,
+					     int rdc_buffer_size, char *magic)
+{
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+
+	cqr = dasd_smalloc_request(magic, 1 /* RDC */, rdc_buffer_size, device);
+
+	if (IS_ERR(cqr)) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			    "Could not allocate RDC request");
+		return cqr;
+	}
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = CCW_CMD_RDC;
+	ccw->cda = (__u32)(addr_t)rdc_buffer;
+	ccw->count = rdc_buffer_size;
+
+	cqr->device = device;
+	cqr->expires = 10*HZ;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	cqr->retries = 2;
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	return cqr;
+}
+
+
+int dasd_generic_read_dev_chars(struct dasd_device *device, char *magic,
+				void **rdc_buffer, int rdc_buffer_size)
+{
+	int ret;
+	struct dasd_ccw_req *cqr;
+
+	cqr = dasd_generic_build_rdc(device, *rdc_buffer, rdc_buffer_size,
+				     magic);
+	if (IS_ERR(cqr))
+		return PTR_ERR(cqr);
+
+	ret = dasd_sleep_on(cqr);
+	dasd_sfree_request(cqr, cqr->device);
+	return ret;
+}
 
 static int __init
 dasd_init(void)
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index cecab22..c9583fb 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -450,6 +450,81 @@ dasd_eckd_generate_uid(struct dasd_device *device, struct dasd_uid *uid)
 	return 0;
 }
 
+struct dasd_ccw_req * dasd_eckd_build_rcd_lpm(struct dasd_device *device,
+					      void *rcd_buffer,
+					      struct ciw *ciw, __u8 lpm)
+{
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+
+	cqr = dasd_smalloc_request("ECKD", 1 /* RCD */, ciw->count, device);
+
+	if (IS_ERR(cqr)) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			    "Could not allocate RCD request");
+		return cqr;
+	}
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = ciw->cmd;
+	ccw->cda = (__u32)(addr_t)rcd_buffer;
+	ccw->count = ciw->count;
+
+	cqr->device = device;
+	cqr->expires = 10*HZ;
+	cqr->lpm = lpm;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	cqr->retries = 2;
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	return cqr;
+}
+
+static int dasd_eckd_read_conf_lpm(struct dasd_device *device,
+				   void **rcd_buffer,
+				   int *rcd_buffer_size, __u8 lpm)
+{
+	struct ciw *ciw;
+	char *rcd_buf = NULL;
+	int ret;
+	struct dasd_ccw_req *cqr;
+
+	/*
+	 * scan for RCD command in extended SenseID data
+	 */
+	ciw = ccw_device_get_ciw(device->cdev, CIW_TYPE_RCD);
+	if (!ciw || ciw->cmd == 0) {
+		ret = -EOPNOTSUPP;
+		goto out_error;
+	}
+	rcd_buf = kzalloc(ciw->count, GFP_KERNEL | GFP_DMA);
+	if (!rcd_buf) {
+		ret = -ENOMEM;
+		goto out_error;
+	}
+	cqr = dasd_eckd_build_rcd_lpm(device, rcd_buf, ciw, lpm);
+	if (IS_ERR(cqr)) {
+		ret =  PTR_ERR(cqr);
+		goto out_error;
+	}
+	ret = dasd_sleep_on(cqr);
+	/*
+	 * on success we update the user input parms
+	 */
+	dasd_sfree_request(cqr, cqr->device);
+	if (ret)
+		goto out_error;
+
+	*rcd_buffer_size = ciw->count;
+	*rcd_buffer = rcd_buf;
+	return 0;
+out_error:
+	kfree(rcd_buf);
+	*rcd_buffer = NULL;
+	*rcd_buffer_size = 0;
+	return ret;
+}
+
 static int
 dasd_eckd_read_conf(struct dasd_device *device)
 {
@@ -469,8 +544,8 @@ dasd_eckd_read_conf(struct dasd_device *device)
 	/* get configuration data per operational path */
 	for (lpm = 0x80; lpm; lpm>>= 1) {
 		if (lpm & path_data->opm){
-			rc = read_conf_data_lpm(device->cdev, &conf_data,
-						&conf_len, lpm);
+			rc = dasd_eckd_read_conf_lpm(device, &conf_data,
+						     &conf_len, lpm);
 			if (rc && rc != -EOPNOTSUPP) {	/* -EOPNOTSUPP is ok */
 				MESSAGE(KERN_WARNING,
 					"Read configuration data returned "
@@ -639,7 +714,7 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
 	memset(rdc_data, 0, sizeof(rdc_data));
-	rc = read_dev_chars(device->cdev, &rdc_data, 64);
+	rc = dasd_generic_read_dev_chars(device, "ECKD", &rdc_data, 64);
 	if (rc)
 		DEV_MESSAGE(KERN_WARNING, device,
 			    "Read device characteristics returned "
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index be0909e..da16ead 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -135,7 +135,7 @@ dasd_fba_check_characteristics(struct dasd_device *device)
 	}
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
-	rc = read_dev_chars(device->cdev, &rdc_data, 32);
+	rc = dasd_generic_read_dev_chars(device, "FBA ", &rdc_data, 32);
 	if (rc) {
 		DEV_MESSAGE(KERN_WARNING, device,
 			    "Read device characteristics returned error %d",
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index a2cc69e..241294c 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -509,6 +509,8 @@ int dasd_generic_set_online(struct ccw_device *, struct dasd_discipline *);
 int dasd_generic_set_offline (struct ccw_device *cdev);
 int dasd_generic_notify(struct ccw_device *, int);
 
+int dasd_generic_read_dev_chars(struct dasd_device *, char *, void **, int);
+
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
 extern int dasd_probeonly;
diff --git a/drivers/s390/char/tape.h b/drivers/s390/char/tape.h
index bb4ff53..3b52f5c 100644
--- a/drivers/s390/char/tape.h
+++ b/drivers/s390/char/tape.h
@@ -103,6 +103,7 @@ enum tape_op {
 	TO_CRYPT_OFF,	/* Disable encrpytion */
 	TO_KEKL_SET,	/* Set KEK label */
 	TO_KEKL_QUERY,	/* Query KEK label */
+	TO_RDC,		/* Read device characteristics */
 	TO_SIZE,	/* #entries in tape_op_t */
 };
 
diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index 50f5eda..7e2b2ab 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -788,6 +788,7 @@ tape_3590_done(struct tape_device *device, struct tape_request *request)
 	case TO_SIZE:
 	case TO_KEKL_SET:
 	case TO_KEKL_QUERY:
+	case TO_RDC:
 		break;
 	}
 	return TAPE_IO_SUCCESS;
@@ -1549,6 +1550,26 @@ tape_3590_irq(struct tape_device *device, struct tape_request *request,
 	return TAPE_IO_STOP;
 }
 
+
+static int tape_3590_read_dev_chars(struct tape_device *device,
+				    struct tape_3590_rdc_data *rdc_data)
+{
+	int rc;
+	struct tape_request *request;
+
+	request = tape_alloc_request(1, sizeof(*rdc_data));
+	if (IS_ERR(request))
+		return PTR_ERR(request);
+	request->op = TO_RDC;
+	tape_ccw_end(request->cpaddr, CCW_CMD_RDC, sizeof(*rdc_data),
+		     request->cpdata);
+	rc = tape_do_io(device, request);
+	if (rc == 0)
+		memcpy(rdc_data, request->cpdata, sizeof(*rdc_data));
+	tape_free_request(request);
+	return rc;
+}
+
 /*
  * Setup device function
  */
@@ -1557,7 +1578,7 @@ tape_3590_setup_device(struct tape_device *device)
 {
 	int rc;
 	struct tape_3590_disc_data *data;
-	char *rdc_data;
+	struct tape_3590_rdc_data *rdc_data;
 
 	DBF_EVENT(6, "3590 device setup\n");
 	data = kzalloc(sizeof(struct tape_3590_disc_data), GFP_KERNEL | GFP_DMA);
@@ -1566,12 +1587,12 @@ tape_3590_setup_device(struct tape_device *device)
 	data->read_back_op = READ_PREVIOUS;
 	device->discdata = data;
 
-	rdc_data = kmalloc(64, GFP_KERNEL | GFP_DMA);
+	rdc_data = kmalloc(sizeof(*rdc_data), GFP_KERNEL | GFP_DMA);
 	if (!rdc_data) {
 		rc = -ENOMEM;
 		goto fail_kmalloc;
 	}
-	rc = read_dev_chars(device->cdev, (void**)&rdc_data, 64);
+	rc = tape_3590_read_dev_chars(device, rdc_data);
 	if (rc) {
 		DBF_LH(3, "Read device characteristics failed!\n");
 		goto fail_kmalloc;
@@ -1579,7 +1600,7 @@ tape_3590_setup_device(struct tape_device *device)
 	rc = tape_std_assign(device);
 	if (rc)
 		goto fail_rdc_data;
-	if (rdc_data[31] == 0x13) {
+	if (rdc_data->data[31] == 0x13) {
 		PRINT_INFO("Device has crypto support\n");
 		data->crypt_info.capability |= TAPE390_CRYPT_SUPPORTED_MASK;
 		tape_3592_disable_crypt(device);
diff --git a/drivers/s390/char/tape_3590.h b/drivers/s390/char/tape_3590.h
index aa51388..4534055 100644
--- a/drivers/s390/char/tape_3590.h
+++ b/drivers/s390/char/tape_3590.h
@@ -129,6 +129,10 @@ struct tape_3590_med_sense {
 	char pad2[116];
 } __attribute__ ((packed));
 
+struct tape_3590_rdc_data {
+	char data[64];
+} __attribute__ ((packed));
+
 /* Datastructures for 3592 encryption support */
 
 struct tape3592_kekl {
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index e2a8a1a..2fae633 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -73,7 +73,7 @@ const char *tape_op_verbose[TO_SIZE] =
 	[TO_DIS] = "DIS",	[TO_ASSIGN] = "ASS",
 	[TO_UNASSIGN] = "UAS",  [TO_CRYPT_ON] = "CON",
 	[TO_CRYPT_OFF] = "COF",	[TO_KEKL_SET] = "KLS",
-	[TO_KEKL_QUERY] = "KLQ",
+	[TO_KEKL_QUERY] = "KLQ",[TO_RDC] = "RDC",
 };
 
 static int
@@ -911,6 +911,7 @@ __tape_start_request(struct tape_device *device, struct tape_request *request)
 		case TO_ASSIGN:
 		case TO_UNASSIGN:
 		case TO_READ_ATTMSG:
+		case TO_RDC:
 			if (device->tape_state == TS_INIT)
 				break;
 			if (device->tape_state == TS_UNUSED)
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index 05fac07..cba64e4 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -69,7 +69,6 @@ static const char version[] = "QDIO base support version 2";
 
 static int qdio_performance_stats = 0;
 static int proc_perf_file_registration;
-static unsigned long i_p_c, i_p_nc, o_p_c, o_p_nc, ii_p_c, ii_p_nc;
 static struct qdio_perf_stats perf_stats;
 
 static int hydra_thinints;
@@ -111,6 +110,31 @@ qdio_min(int a,int b)
 }
 
 /***************** SCRUBBER HELPER ROUTINES **********************/
+#ifdef CONFIG_64BIT
+static inline void qdio_perf_stat_inc(atomic64_t *count)
+{
+	if (qdio_performance_stats)
+		atomic64_inc(count);
+}
+
+static inline void qdio_perf_stat_dec(atomic64_t *count)
+{
+	if (qdio_performance_stats)
+		atomic64_dec(count);
+}
+#else /* CONFIG_64BIT */
+static inline void qdio_perf_stat_inc(atomic_t *count)
+{
+	if (qdio_performance_stats)
+		atomic_inc(count);
+}
+
+static inline void qdio_perf_stat_dec(atomic_t *count)
+{
+	if (qdio_performance_stats)
+		atomic_dec(count);
+}
+#endif /* CONFIG_64BIT */
 
 static inline __u64 
 qdio_get_micros(void)
@@ -277,8 +301,7 @@ qdio_siga_sync(struct qdio_q *q, unsigned int gpr2,
 	QDIO_DBF_TEXT4(0,trace,"sigasync");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
-	if (qdio_performance_stats)
-		perf_stats.siga_syncs++;
+	qdio_perf_stat_inc(&perf_stats.siga_syncs);
 
 	cc = do_siga_sync(q->schid, gpr2, gpr3);
 	if (cc)
@@ -323,8 +346,7 @@ qdio_siga_output(struct qdio_q *q)
 	__u32 busy_bit;
 	__u64 start_time=0;
 
-	if (qdio_performance_stats)
-		perf_stats.siga_outs++;
+	qdio_perf_stat_inc(&perf_stats.siga_outs);
 
 	QDIO_DBF_TEXT4(0,trace,"sigaout");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
@@ -358,8 +380,7 @@ qdio_siga_input(struct qdio_q *q)
 	QDIO_DBF_TEXT4(0,trace,"sigain");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
-	if (qdio_performance_stats)
-		perf_stats.siga_ins++;
+	qdio_perf_stat_inc(&perf_stats.siga_ins);
 
 	cc = do_siga_input(q->schid, q->mask);
 	
@@ -953,8 +974,7 @@ __qdio_outbound_processing(struct qdio_q *q)
 
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-		if (qdio_performance_stats)
-			o_p_c++;
+		qdio_perf_stat_inc(&perf_stats.outbound_tl_runs_resched);
 		/* as we're sissies, we'll check next time */
 		if (likely(!atomic_read(&q->is_in_shutdown))) {
 			qdio_mark_q(q);
@@ -962,10 +982,8 @@ __qdio_outbound_processing(struct qdio_q *q)
 		}
 		return;
 	}
-	if (qdio_performance_stats) {
-		o_p_nc++;
-		perf_stats.tl_runs++;
-	}
+	qdio_perf_stat_inc(&perf_stats.outbound_tl_runs);
+	qdio_perf_stat_inc(&perf_stats.tl_runs);
 
 	/* see comment in qdio_kick_outbound_q */
 	siga_attempts=atomic_read(&q->busy_siga_counter);
@@ -1139,17 +1157,6 @@ qdio_has_inbound_q_moved(struct qdio_q *q)
 {
 	int i;
 
-	static int old_pcis=0;
-	static int old_thinints=0;
-
-	if (qdio_performance_stats) {
-		if ((old_pcis==perf_stats.pcis)&&
-		    (old_thinints==perf_stats.thinints))
-			perf_stats.start_time_inbound=NOW;
-		else
-			old_pcis=perf_stats.pcis;
-	}
-
 	i=qdio_get_inbound_buffer_frontier(q);
 	if ( (i!=GET_SAVED_FRONTIER(q)) ||
 	     (q->error_status_flags&QDIO_STATUS_LOOK_FOR_ERROR) ) {
@@ -1337,10 +1344,7 @@ qdio_kick_inbound_handler(struct qdio_q *q)
 	q->siga_error=0;
 	q->error_status_flags=0;
 
-	if (qdio_performance_stats) {
-		perf_stats.inbound_time+=NOW-perf_stats.start_time_inbound;
-		perf_stats.inbound_cnt++;
-	}
+	qdio_perf_stat_inc(&perf_stats.inbound_cnt);
 }
 
 static void
@@ -1360,8 +1364,7 @@ __tiqdio_inbound_processing(struct qdio_q *q, int spare_ind_was_set)
 	 */
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-		if (qdio_performance_stats)
-			ii_p_c++;
+		qdio_perf_stat_inc(&perf_stats.inbound_thin_tl_runs_resched);
 		/* 
 		 * as we might just be about to stop polling, we make
 		 * sure that we check again at least once more 
@@ -1369,8 +1372,7 @@ __tiqdio_inbound_processing(struct qdio_q *q, int spare_ind_was_set)
 		tiqdio_sched_tl();
 		return;
 	}
-	if (qdio_performance_stats)
-		ii_p_nc++;
+	qdio_perf_stat_inc(&perf_stats.inbound_thin_tl_runs);
 	if (unlikely(atomic_read(&q->is_in_shutdown))) {
 		qdio_unmark_q(q);
 		goto out;
@@ -1412,8 +1414,7 @@ __tiqdio_inbound_processing(struct qdio_q *q, int spare_ind_was_set)
 		for (i=0;i<irq_ptr->no_output_qs;i++) {
 			oq = irq_ptr->output_qs[i];
 			if (!qdio_is_outbound_q_done(oq)) {
-				if (qdio_performance_stats)
-					perf_stats.tl_runs--;
+				qdio_perf_stat_dec(&perf_stats.tl_runs);
 				__qdio_outbound_processing(oq);
 			}
 		}
@@ -1452,8 +1453,7 @@ __qdio_inbound_processing(struct qdio_q *q)
 
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-		if (qdio_performance_stats)
-			i_p_c++;
+		qdio_perf_stat_inc(&perf_stats.inbound_tl_runs_resched);
 		/* as we're sissies, we'll check next time */
 		if (likely(!atomic_read(&q->is_in_shutdown))) {
 			qdio_mark_q(q);
@@ -1461,10 +1461,8 @@ __qdio_inbound_processing(struct qdio_q *q)
 		}
 		return;
 	}
-	if (qdio_performance_stats) {
-		i_p_nc++;
-		perf_stats.tl_runs++;
-	}
+	qdio_perf_stat_inc(&perf_stats.inbound_tl_runs);
+	qdio_perf_stat_inc(&perf_stats.tl_runs);
 
 again:
 	if (qdio_has_inbound_q_moved(q)) {
@@ -1510,8 +1508,7 @@ tiqdio_reset_processing_state(struct qdio_q *q, int q_laps)
 
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-		if (qdio_performance_stats)
-			ii_p_c++;
+		qdio_perf_stat_inc(&perf_stats.inbound_thin_tl_runs_resched);
 		/* 
 		 * as we might just be about to stop polling, we make
 		 * sure that we check again at least once more 
@@ -1602,8 +1599,7 @@ tiqdio_tl(unsigned long data)
 {
 	QDIO_DBF_TEXT4(0,trace,"iqdio_tl");
 
-	if (qdio_performance_stats)
-		perf_stats.tl_runs++;
+	qdio_perf_stat_inc(&perf_stats.tl_runs);
 
 	tiqdio_inbound_checks();
 }
@@ -1914,10 +1910,7 @@ tiqdio_thinint_handler(void)
 {
 	QDIO_DBF_TEXT4(0,trace,"thin_int");
 
-	if (qdio_performance_stats) {
-		perf_stats.thinints++;
-		perf_stats.start_time_inbound=NOW;
-	}
+	qdio_perf_stat_inc(&perf_stats.thinints);
 
 	/* SVS only when needed:
 	 * issue SVS to benefit from iqdio interrupt avoidance
@@ -1972,17 +1965,12 @@ qdio_handle_pci(struct qdio_irq *irq_ptr)
 	int i;
 	struct qdio_q *q;
 
-	if (qdio_performance_stats) {
-		perf_stats.pcis++;
-		perf_stats.start_time_inbound=NOW;
-	}
+	qdio_perf_stat_inc(&perf_stats.pcis);
 	for (i=0;i<irq_ptr->no_input_qs;i++) {
 		q=irq_ptr->input_qs[i];
 		if (q->is_input_q&QDIO_FLAG_NO_INPUT_INTERRUPT_CONTEXT)
 			qdio_mark_q(q);
 		else {
-			if (qdio_performance_stats)
-				perf_stats.tl_runs--;
 			__qdio_inbound_processing(q);
 		}
 	}
@@ -1992,8 +1980,7 @@ qdio_handle_pci(struct qdio_irq *irq_ptr)
 		q=irq_ptr->output_qs[i];
 		if (qdio_is_outbound_q_done(q))
 			continue;
-		if (qdio_performance_stats)
-			perf_stats.tl_runs--;
+		qdio_perf_stat_dec(&perf_stats.tl_runs);
 		if (!irq_ptr->sync_done_on_outb_pcis)
 			SYNC_MEMORY;
 		__qdio_outbound_processing(q);
@@ -3463,18 +3450,12 @@ do_qdio_handle_outbound(struct qdio_q *q, unsigned int callflags,
 	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
 
 	/* This is the outbound handling of queues */
-	if (qdio_performance_stats)
-		perf_stats.start_time_outbound=NOW;
-
 	qdio_do_qdio_fill_output(q,qidx,count,buffers);
 
 	used_elements=atomic_add_return(count, &q->number_of_buffers_used) - count;
 
 	if (callflags&QDIO_FLAG_DONT_SIGA) {
-		if (qdio_performance_stats) {
-			perf_stats.outbound_time+=NOW-perf_stats.start_time_outbound;
-			perf_stats.outbound_cnt++;
-		}
+		qdio_perf_stat_inc(&perf_stats.outbound_cnt);
 		return;
 	}
 	if (q->is_iqdio_q) {
@@ -3504,8 +3485,7 @@ do_qdio_handle_outbound(struct qdio_q *q, unsigned int callflags,
 				qdio_kick_outbound_q(q);
 			} else {
 				QDIO_DBF_TEXT3(0,trace, "fast-req");
-				if (qdio_performance_stats)
-					perf_stats.fast_reqs++;
+				qdio_perf_stat_inc(&perf_stats.fast_reqs);
 			}
 		}
 		/* 
@@ -3516,10 +3496,7 @@ do_qdio_handle_outbound(struct qdio_q *q, unsigned int callflags,
 		__qdio_outbound_processing(q);
 	}
 
-	if (qdio_performance_stats) {
-		perf_stats.outbound_time+=NOW-perf_stats.start_time_outbound;
-		perf_stats.outbound_cnt++;
-	}
+	qdio_perf_stat_inc(&perf_stats.outbound_cnt);
 }
 
 /* count must be 1 in iqdio */
@@ -3589,33 +3566,67 @@ qdio_perf_procfile_read(char *buffer, char **buffer_location, off_t offset,
 		return 0;
 
 #define _OUTP_IT(x...) c+=sprintf(buffer+c,x)
-	_OUTP_IT("i_p_nc/c=%lu/%lu\n",i_p_nc,i_p_c);
-	_OUTP_IT("ii_p_nc/c=%lu/%lu\n",ii_p_nc,ii_p_c);
-	_OUTP_IT("o_p_nc/c=%lu/%lu\n",o_p_nc,o_p_c);
-	_OUTP_IT("Number of tasklet runs (total)                  : %lu\n",
-		 perf_stats.tl_runs);
+#ifdef CONFIG_64BIT
+	_OUTP_IT("Number of tasklet runs (total)                  : %li\n",
+		 (long)atomic64_read(&perf_stats.tl_runs));
+	_OUTP_IT("Inbound tasklet runs      tried/retried         : %li/%li\n",
+		 (long)atomic64_read(&perf_stats.inbound_tl_runs),
+		 (long)atomic64_read(&perf_stats.inbound_tl_runs_resched));
+	_OUTP_IT("Inbound-thin tasklet runs tried/retried         : %li/%li\n",
+		 (long)atomic64_read(&perf_stats.inbound_thin_tl_runs),
+		 (long)atomic64_read(&perf_stats.inbound_thin_tl_runs_resched));
+	_OUTP_IT("Outbound tasklet runs     tried/retried         : %li/%li\n",
+		 (long)atomic64_read(&perf_stats.outbound_tl_runs),
+		 (long)atomic64_read(&perf_stats.outbound_tl_runs_resched));
 	_OUTP_IT("\n");
-	_OUTP_IT("Number of SIGA sync's issued                    : %lu\n",
-		 perf_stats.siga_syncs);
-	_OUTP_IT("Number of SIGA in's issued                      : %lu\n",
-		 perf_stats.siga_ins);
-	_OUTP_IT("Number of SIGA out's issued                     : %lu\n",
-		 perf_stats.siga_outs);
-	_OUTP_IT("Number of PCIs caught                           : %lu\n",
-		 perf_stats.pcis);
-	_OUTP_IT("Number of adapter interrupts caught             : %lu\n",
-		 perf_stats.thinints);
-	_OUTP_IT("Number of fast requeues (outg. SBALs w/o SIGA)  : %lu\n",
-		 perf_stats.fast_reqs);
+	_OUTP_IT("Number of SIGA sync's issued                    : %li\n",
+		 (long)atomic64_read(&perf_stats.siga_syncs));
+	_OUTP_IT("Number of SIGA in's issued                      : %li\n",
+		 (long)atomic64_read(&perf_stats.siga_ins));
+	_OUTP_IT("Number of SIGA out's issued                     : %li\n",
+		 (long)atomic64_read(&perf_stats.siga_outs));
+	_OUTP_IT("Number of PCIs caught                           : %li\n",
+		 (long)atomic64_read(&perf_stats.pcis));
+	_OUTP_IT("Number of adapter interrupts caught             : %li\n",
+		 (long)atomic64_read(&perf_stats.thinints));
+	_OUTP_IT("Number of fast requeues (outg. SBALs w/o SIGA)  : %li\n",
+		 (long)atomic64_read(&perf_stats.fast_reqs));
 	_OUTP_IT("\n");
-	_OUTP_IT("Total time of all inbound actions (us) incl. UL : %lu\n",
-		 perf_stats.inbound_time);
-	_OUTP_IT("Number of inbound transfers                     : %lu\n",
-		 perf_stats.inbound_cnt);
-	_OUTP_IT("Total time of all outbound do_QDIOs (us)        : %lu\n",
-		 perf_stats.outbound_time);
-	_OUTP_IT("Number of do_QDIOs outbound                     : %lu\n",
-		 perf_stats.outbound_cnt);
+	_OUTP_IT("Number of inbound transfers                     : %li\n",
+		 (long)atomic64_read(&perf_stats.inbound_cnt));
+	_OUTP_IT("Number of do_QDIOs outbound                     : %li\n",
+		 (long)atomic64_read(&perf_stats.outbound_cnt));
+#else /* CONFIG_64BIT */
+	_OUTP_IT("Number of tasklet runs (total)                  : %i\n",
+		 atomic_read(&perf_stats.tl_runs));
+	_OUTP_IT("Inbound tasklet runs      tried/retried         : %i/%i\n",
+		 atomic_read(&perf_stats.inbound_tl_runs),
+		 atomic_read(&perf_stats.inbound_tl_runs_resched));
+	_OUTP_IT("Inbound-thin tasklet runs tried/retried         : %i/%i\n",
+		 atomic_read(&perf_stats.inbound_thin_tl_runs),
+		 atomic_read(&perf_stats.inbound_thin_tl_runs_resched));
+	_OUTP_IT("Outbound tasklet runs     tried/retried         : %i/%i\n",
+		 atomic_read(&perf_stats.outbound_tl_runs),
+		 atomic_read(&perf_stats.outbound_tl_runs_resched));
+	_OUTP_IT("\n");
+	_OUTP_IT("Number of SIGA sync's issued                    : %i\n",
+		 atomic_read(&perf_stats.siga_syncs));
+	_OUTP_IT("Number of SIGA in's issued                      : %i\n",
+		 atomic_read(&perf_stats.siga_ins));
+	_OUTP_IT("Number of SIGA out's issued                     : %i\n",
+		 atomic_read(&perf_stats.siga_outs));
+	_OUTP_IT("Number of PCIs caught                           : %i\n",
+		 atomic_read(&perf_stats.pcis));
+	_OUTP_IT("Number of adapter interrupts caught             : %i\n",
+		 atomic_read(&perf_stats.thinints));
+	_OUTP_IT("Number of fast requeues (outg. SBALs w/o SIGA)  : %i\n",
+		 atomic_read(&perf_stats.fast_reqs));
+	_OUTP_IT("\n");
+	_OUTP_IT("Number of inbound transfers                     : %i\n",
+		 atomic_read(&perf_stats.inbound_cnt));
+	_OUTP_IT("Number of do_QDIOs outbound                     : %i\n",
+		 atomic_read(&perf_stats.outbound_cnt));
+#endif /* CONFIG_64BIT */
 	_OUTP_IT("\n");
 
         return c;
@@ -3642,8 +3653,6 @@ qdio_add_procfs_entry(void)
 static void
 qdio_remove_procfs_entry(void)
 {
-	perf_stats.tl_runs=0;
-
         if (!proc_perf_file_registration) /* means if it went ok earlier */
 		remove_proc_entry(QDIO_PERF,&proc_root);
 }
@@ -3671,13 +3680,38 @@ qdio_performance_stats_store(struct bus_type *bus, const char *buf, size_t count
 		qdio_performance_stats = i;
 		if (i==0) {
 			/* reset perf. stat. info */
-			i_p_nc = 0;
-			i_p_c = 0;
-			ii_p_nc = 0;
-			ii_p_c = 0;
-			o_p_nc = 0;
-			o_p_c = 0;
-			memset(&perf_stats, 0, sizeof(struct qdio_perf_stats));
+#ifdef CONFIG_64BIT
+			atomic64_set(&perf_stats.tl_runs, 0);
+			atomic64_set(&perf_stats.outbound_tl_runs, 0);
+			atomic64_set(&perf_stats.inbound_tl_runs, 0);
+			atomic64_set(&perf_stats.inbound_tl_runs_resched, 0);
+			atomic64_set(&perf_stats.inbound_thin_tl_runs, 0);
+			atomic64_set(&perf_stats.inbound_thin_tl_runs_resched,
+				     0);
+			atomic64_set(&perf_stats.siga_outs, 0);
+			atomic64_set(&perf_stats.siga_ins, 0);
+			atomic64_set(&perf_stats.siga_syncs, 0);
+			atomic64_set(&perf_stats.pcis, 0);
+			atomic64_set(&perf_stats.thinints, 0);
+			atomic64_set(&perf_stats.fast_reqs, 0);
+			atomic64_set(&perf_stats.outbound_cnt, 0);
+			atomic64_set(&perf_stats.inbound_cnt, 0);
+#else /* CONFIG_64BIT */
+			atomic_set(&perf_stats.tl_runs, 0);
+			atomic_set(&perf_stats.outbound_tl_runs, 0);
+			atomic_set(&perf_stats.inbound_tl_runs, 0);
+			atomic_set(&perf_stats.inbound_tl_runs_resched, 0);
+			atomic_set(&perf_stats.inbound_thin_tl_runs, 0);
+			atomic_set(&perf_stats.inbound_thin_tl_runs_resched, 0);
+			atomic_set(&perf_stats.siga_outs, 0);
+			atomic_set(&perf_stats.siga_ins, 0);
+			atomic_set(&perf_stats.siga_syncs, 0);
+			atomic_set(&perf_stats.pcis, 0);
+			atomic_set(&perf_stats.thinints, 0);
+			atomic_set(&perf_stats.fast_reqs, 0);
+			atomic_set(&perf_stats.outbound_cnt, 0);
+			atomic_set(&perf_stats.inbound_cnt, 0);
+#endif /* CONFIG_64BIT */
 		}
 	} else {
 		QDIO_PRINT_WARN("QDIO performance_stats: write 0 or 1 to this file!\n");
diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index ec9af72..2895392 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -406,21 +406,43 @@ do_clear_global_summary(void)
 #define CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS 0x04
 
 struct qdio_perf_stats {
-	unsigned long tl_runs;
-
-	unsigned long siga_outs;
-	unsigned long siga_ins;
-	unsigned long siga_syncs;
-	unsigned long pcis;
-	unsigned long thinints;
-	unsigned long fast_reqs;
-
-	__u64 start_time_outbound;
-	unsigned long outbound_cnt;
-	unsigned long outbound_time;
-	__u64 start_time_inbound;
-	unsigned long inbound_cnt;
-	unsigned long inbound_time;
+#ifdef CONFIG_64BIT
+	atomic64_t tl_runs;
+	atomic64_t outbound_tl_runs;
+	atomic64_t outbound_tl_runs_resched;
+	atomic64_t inbound_tl_runs;
+	atomic64_t inbound_tl_runs_resched;
+	atomic64_t inbound_thin_tl_runs;
+	atomic64_t inbound_thin_tl_runs_resched;
+
+	atomic64_t siga_outs;
+	atomic64_t siga_ins;
+	atomic64_t siga_syncs;
+	atomic64_t pcis;
+	atomic64_t thinints;
+	atomic64_t fast_reqs;
+
+	atomic64_t outbound_cnt;
+	atomic64_t inbound_cnt;
+#else /* CONFIG_64BIT */
+	atomic_t tl_runs;
+	atomic_t outbound_tl_runs;
+	atomic_t outbound_tl_runs_resched;
+	atomic_t inbound_tl_runs;
+	atomic_t inbound_tl_runs_resched;
+	atomic_t inbound_thin_tl_runs;
+	atomic_t inbound_thin_tl_runs_resched;
+
+	atomic_t siga_outs;
+	atomic_t siga_ins;
+	atomic_t siga_syncs;
+	atomic_t pcis;
+	atomic_t thinints;
+	atomic_t fast_reqs;
+
+	atomic_t outbound_cnt;
+	atomic_t inbound_cnt;
+#endif /* CONFIG_64BIT */
 };
 
 /* unlikely as the later the better */
diff --git a/drivers/s390/net/qeth.h b/drivers/s390/net/qeth.h
index 84b108d..b34eb82 100644
--- a/drivers/s390/net/qeth.h
+++ b/drivers/s390/net/qeth.h
@@ -288,6 +288,7 @@ qeth_is_ipa_enabled(struct qeth_ipa_info *ipa, enum qeth_ipa_funcs func)
  */
 #define IF_NAME_LEN	 	16
 #define QETH_TX_TIMEOUT		100 * HZ
+#define QETH_RCD_TIMEOUT	60 * HZ
 #define QETH_HEADER_SIZE	32
 #define MAX_PORTNO 		15
 #define QETH_FAKE_LL_LEN_ETH	ETH_HLEN
@@ -582,6 +583,8 @@ enum qeth_channel_states {
 	CH_STATE_ACTIVATING,
 	CH_STATE_HALTED,
 	CH_STATE_STOPPED,
+	CH_STATE_RCD,
+	CH_STATE_RCD_DONE,
 };
 /**
  * card state machine
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index ad7792d..6fd8870 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -315,7 +315,8 @@ qeth_alloc_card(void)
 }
 
 static long
-__qeth_check_irb_error(struct ccw_device *cdev, struct irb *irb)
+__qeth_check_irb_error(struct ccw_device *cdev, unsigned long intparm,
+		       struct irb *irb)
 {
 	if (!IS_ERR(irb))
 		return 0;
@@ -330,6 +331,14 @@ __qeth_check_irb_error(struct ccw_device *cdev, struct irb *irb)
 		PRINT_WARN("timeout on device %s\n", cdev->dev.bus_id);
 		QETH_DBF_TEXT(trace, 2, "ckirberr");
 		QETH_DBF_TEXT_(trace, 2, "  rc%d", -ETIMEDOUT);
+		if (intparm == QETH_RCD_PARM) {
+			struct qeth_card *card = CARD_FROM_CDEV(cdev);
+
+			if (card && (card->data.ccwdev == cdev)) {
+				card->data.state = CH_STATE_DOWN;
+				wake_up(&card->wait_q);
+			}
+		}
 		break;
 	default:
 		PRINT_WARN("unknown error %ld on device %s\n", PTR_ERR(irb),
@@ -401,7 +410,7 @@ qeth_irq(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 
 	QETH_DBF_TEXT(trace,5,"irq");
 
-	if (__qeth_check_irb_error(cdev, irb))
+	if (__qeth_check_irb_error(cdev, intparm, irb))
 		return;
 	cstat = irb->scsw.cstat;
 	dstat = irb->scsw.dstat;
@@ -429,7 +438,8 @@ qeth_irq(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 		channel->state = CH_STATE_HALTED;
 
 	/*let's wake up immediately on data channel*/
-	if ((channel == &card->data) && (intparm != 0))
+	if ((channel == &card->data) && (intparm != 0) &&
+	    (intparm != QETH_RCD_PARM))
 		goto out;
 
 	if (intparm == QETH_CLEAR_CHANNEL_PARM) {
@@ -453,6 +463,10 @@ qeth_irq(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 			HEXDUMP16(WARN,"irb: ",irb);
 			HEXDUMP16(WARN,"sense data: ",irb->ecw);
 		}
+		if (intparm == QETH_RCD_PARM) {
+			channel->state = CH_STATE_DOWN;
+			goto out;
+		}
 		rc = qeth_get_problem(cdev,irb);
 		if (rc) {
 			qeth_schedule_recovery(card);
@@ -460,6 +474,10 @@ qeth_irq(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 		}
 	}
 
+	if (intparm == QETH_RCD_PARM) {
+		channel->state = CH_STATE_RCD_DONE;
+		goto out;
+	}
 	if (intparm) {
 		buffer = (struct qeth_cmd_buffer *) __va((addr_t)intparm);
 		buffer->state = BUF_STATE_PROCESSED;
@@ -1204,6 +1222,54 @@ qeth_probe_device(struct ccwgroup_device *gdev)
 }
 
 
+static int qeth_read_conf_data(struct qeth_card *card, void **buffer,
+			       int *length)
+{
+	struct ciw *ciw;
+	char *rcd_buf;
+	int ret;
+	struct qeth_channel *channel = &card->data;
+	unsigned long flags;
+
+	/*
+	 * scan for RCD command in extended SenseID data
+	 */
+	ciw = ccw_device_get_ciw(channel->ccwdev, CIW_TYPE_RCD);
+	if (!ciw || ciw->cmd == 0)
+		return -EOPNOTSUPP;
+	rcd_buf = kzalloc(ciw->count, GFP_KERNEL | GFP_DMA);
+	if (!rcd_buf)
+		return -ENOMEM;
+
+	channel->ccw.cmd_code = ciw->cmd;
+	channel->ccw.cda = (__u32) __pa (rcd_buf);
+	channel->ccw.count = ciw->count;
+	channel->ccw.flags = CCW_FLAG_SLI;
+	channel->state = CH_STATE_RCD;
+	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	ret = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
+				       QETH_RCD_PARM, LPM_ANYPATH, 0,
+				       QETH_RCD_TIMEOUT);
+	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
+	if (!ret)
+		wait_event(card->wait_q,
+			   (channel->state == CH_STATE_RCD_DONE ||
+			    channel->state == CH_STATE_DOWN));
+	if (channel->state == CH_STATE_DOWN)
+		ret = -EIO;
+	else
+		channel->state = CH_STATE_DOWN;
+	if (ret) {
+		kfree(rcd_buf);
+		*buffer = NULL;
+		*length = 0;
+	} else {
+		*length = ciw->count;
+		*buffer = rcd_buf;
+	}
+	return ret;
+}
+
 static int
 qeth_get_unitaddr(struct qeth_card *card)
 {
@@ -1212,9 +1278,9 @@ qeth_get_unitaddr(struct qeth_card *card)
 	int rc;
 
 	QETH_DBF_TEXT(setup, 2, "getunit");
-	rc = read_conf_data(CARD_DDEV(card), (void **) &prcd, &length);
+	rc = qeth_read_conf_data(card, (void **) &prcd, &length);
 	if (rc) {
-		PRINT_ERR("read_conf_data for device %s returned %i\n",
+		PRINT_ERR("qeth_read_conf_data for device %s returned %i\n",
 			  CARD_DDEV_ID(card), rc);
 		return rc;
 	}
@@ -1223,6 +1289,7 @@ qeth_get_unitaddr(struct qeth_card *card)
 	card->info.cula = prcd[63];
 	card->info.guestlan = ((prcd[0x10] == _ascebc['V']) &&
 			       (prcd[0x11] == _ascebc['M']));
+	kfree(prcd);
 	return 0;
 }
 
diff --git a/drivers/s390/net/qeth_mpc.h b/drivers/s390/net/qeth_mpc.h
index 0477c47..d74bc43 100644
--- a/drivers/s390/net/qeth_mpc.h
+++ b/drivers/s390/net/qeth_mpc.h
@@ -37,6 +37,7 @@ extern unsigned char IPA_PDU_HEADER[];
 
 #define QETH_CLEAR_CHANNEL_PARM	-10
 #define QETH_HALT_CHANNEL_PARM	-11
+#define QETH_RCD_PARM -12
 
 /*****************************************************************************/
 /* IP Assist related definitions                                             */
diff --git a/include/asm-s390/ccwdev.h b/include/asm-s390/ccwdev.h
index cfc8153..6795ece 100644
--- a/include/asm-s390/ccwdev.h
+++ b/include/asm-s390/ccwdev.h
@@ -164,9 +164,9 @@ extern int ccw_device_resume(struct ccw_device *);
 extern int ccw_device_halt(struct ccw_device *, unsigned long);
 extern int ccw_device_clear(struct ccw_device *, unsigned long);
 
-extern int read_dev_chars(struct ccw_device *cdev, void **buffer, int length);
-extern int read_conf_data(struct ccw_device *cdev, void **buffer, int *length);
-extern int read_conf_data_lpm(struct ccw_device *cdev, void **buffer,
+extern int __deprecated read_dev_chars(struct ccw_device *cdev, void **buffer, int length);
+extern int __deprecated read_conf_data(struct ccw_device *cdev, void **buffer, int *length);
+extern int __deprecated read_conf_data_lpm(struct ccw_device *cdev, void **buffer,
 			      int *length, __u8 lpm);
 
 extern int ccw_device_set_online(struct ccw_device *cdev);
diff --git a/include/asm-s390/elf.h b/include/asm-s390/elf.h
index c0d629d..91d0632 100644
--- a/include/asm-s390/elf.h
+++ b/include/asm-s390/elf.h
@@ -188,7 +188,8 @@ static inline int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
 
-#define ELF_HWCAP (0)
+extern unsigned long elf_hwcap;
+#define ELF_HWCAP (elf_hwcap)
 
 /* This yields a string that ld.so will use to load implementation
    specific libraries for optimization.  This is more specific in
@@ -197,7 +198,9 @@ static inline int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
    For the moment, we have only optimizations for the Intel generations,
    but that could change... */
 
-#define ELF_PLATFORM (NULL)
+#define ELF_PLATFORM_SIZE 8
+extern char elf_platform[];
+#define ELF_PLATFORM (elf_platform)
 
 #ifndef __s390x__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
diff --git a/include/asm-s390/kdebug.h b/include/asm-s390/kdebug.h
index 1b50f89..d2d7ad2 100644
--- a/include/asm-s390/kdebug.h
+++ b/include/asm-s390/kdebug.h
@@ -22,8 +22,21 @@ struct die_args {
  */
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
-extern int register_page_fault_notifier(struct notifier_block *);
-extern int unregister_page_fault_notifier(struct notifier_block *);
+
+/*
+ * These are only here because kprobes.c wants them to implement a
+ * blatant layering violation. Will hopefully go away soon once all
+ * architectures are updated.
+ */
+static inline int register_page_fault_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+static inline int unregister_page_fault_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
 extern struct atomic_notifier_head s390die_chain;
 
 enum die_val {
@@ -39,7 +52,6 @@ enum die_val {
 	DIE_GPF,
 	DIE_CALL,
 	DIE_NMI_IPI,
-	DIE_PAGE_FAULT,
 };
 
 static inline int notify_die(enum die_val val, const char *str,
diff --git a/include/asm-s390/kprobes.h b/include/asm-s390/kprobes.h
index b847ff0..830fe4c 100644
--- a/include/asm-s390/kprobes.h
+++ b/include/asm-s390/kprobes.h
@@ -97,18 +97,10 @@ void kretprobe_trampoline(void);
 int  is_prohibited_opcode(kprobe_opcode_t *instruction);
 void get_instruction_type(struct arch_specific_insn *ainsn);
 
+int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+int kprobe_exceptions_notify(struct notifier_block *self,
+	unsigned long val, void *data);
+
 #define flush_insn_slot(p)	do { } while (0)
 
 #endif	/* _ASM_S390_KPROBES_H */
-
-#ifdef CONFIG_KPROBES
-
-extern int kprobe_exceptions_notify(struct notifier_block *self,
-					unsigned long val, void *data);
-#else	/* !CONFIG_KPROBES */
-static inline int kprobe_exceptions_notify(struct notifier_block *self,
-						unsigned long val, void *data)
-{
-	return 0;
-}
-#endif
diff --git a/include/asm-s390/lowcore.h b/include/asm-s390/lowcore.h
index ffc9788..801a6fd 100644
--- a/include/asm-s390/lowcore.h
+++ b/include/asm-s390/lowcore.h
@@ -229,17 +229,19 @@ struct _lowcore
 	__u16        subchannel_nr;            /* 0x0ba */
 	__u32        io_int_parm;              /* 0x0bc */
 	__u32        io_int_word;              /* 0x0c0 */
-        __u8         pad3[0xD4-0xC4];          /* 0x0c4 */
+	__u8	     pad3[0xc8-0xc4];	       /* 0x0c4 */
+	__u32	     stfl_fac_list;	       /* 0x0c8 */
+	__u8	     pad4[0xd4-0xcc];	       /* 0x0cc */
 	__u32        extended_save_area_addr;  /* 0x0d4 */
 	__u32        cpu_timer_save_area[2];   /* 0x0d8 */
 	__u32        clock_comp_save_area[2];  /* 0x0e0 */
 	__u32        mcck_interruption_code[2]; /* 0x0e8 */
-	__u8         pad4[0xf4-0xf0];          /* 0x0f0 */
+	__u8	     pad5[0xf4-0xf0];	       /* 0x0f0 */
 	__u32        external_damage_code;     /* 0x0f4 */
 	__u32        failing_storage_address;  /* 0x0f8 */
-	__u8         pad5[0x100-0xfc];         /* 0x0fc */
+	__u8	     pad6[0x100-0xfc];	       /* 0x0fc */
 	__u32        st_status_fixed_logout[4];/* 0x100 */
-	__u8         pad6[0x120-0x110];        /* 0x110 */
+	__u8	     pad7[0x120-0x110];        /* 0x110 */
 	__u32        access_regs_save_area[16];/* 0x120 */
 	__u32        floating_pt_save_area[8]; /* 0x160 */
 	__u32        gpregs_save_area[16];     /* 0x180 */
