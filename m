Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 31 May 2019 13:07:50 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for 5.2-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20190531110750.GA20370@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Linus,

we have to say farewell to Martin Schwidefsky.

This is also my first pull request with a signed tag. My key id is 1B296EC2.
Corresponding fingerprint: 08C3 5F58 4C37 48B9 E688  B919 220E C379 1B29 6EC2

Please also note that Vasily Gorbik and Christian Borntraeger join in
maintaining the s390 architecture.

----------------------------------------------------------------

The following changes since commit 2409207a73cc8e4aff75ceccf6fe5c3ce4d391bc:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2019-05-24 17:30:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.2-3

for you to fetch changes up to 674459be116955e025d6a5e6142e2d500103de8e:

  MAINTAINERS: add Vasily Gorbik and Christian Borntraeger for s390 (2019-05-31 10:14:15 +0200)

----------------------------------------------------------------
s390 updates for 5.2-rc3

 - Farewell Martin Schwidefsky: add Martin to CREDITS and remove him
   from MAINTAINERS

 - Vasily Gorbik and Christian Borntraeger join as maintainers for s390

 - Fix locking bug in ctr(aes) and ctr(des) s390 specific ciphers

 - A rather large patch which fixes gcm-aes-s390 scatter gather handling

 - Fix zcrypt wrong dispatching for control domain CPRBs

 - Fix assignment of bus resources in PCI code

 - Fix structure definition for set PCI function

 - Fix one compile error and one compile warning seen when
   CONFIG_OPTIMIZE_INLINING is enabled

----------------------------------------------------------------
Harald Freudenberger (3):
      s390/zcrypt: Fix wrong dispatching for control domain CPRBs
      s390/crypto: fix gcm-aes-s390 selftest failures
      s390/crypto: fix possible sleep during spinlock aquired

Heiko Carstens (2):
      MAINTAINERS: Farewell Martin Schwidefsky
      MAINTAINERS: add Vasily Gorbik and Christian Borntraeger for s390

Masahiro Yamada (2):
      s390: add unreachable() to dump_fault_info() to fix -Wmaybe-uninitialized
      s390: mark __cpacf_check_opcode() and cpacf_query_func() as __always_inline

Sebastian Ott (2):
      s390/pci: fix struct definition for set PCI function
      s390/pci: fix assignment of bus resources

 CREDITS                          |   8 ++
 MAINTAINERS                      |   6 +-
 arch/s390/crypto/aes_s390.c      | 156 ++++++++++++++++++++++++++++-----------
 arch/s390/crypto/des_s390.c      |   7 +-
 arch/s390/include/asm/ap.h       |   4 +-
 arch/s390/include/asm/cpacf.h    |   4 +-
 arch/s390/include/asm/pci_clp.h  |  25 ++++---
 arch/s390/mm/fault.c             |   4 +-
 arch/s390/pci/pci.c              |   5 +-
 arch/s390/pci/pci_clp.c          |   6 +-
 drivers/s390/crypto/ap_bus.c     |  26 ++++++-
 drivers/s390/crypto/ap_bus.h     |   3 +
 drivers/s390/crypto/zcrypt_api.c |  17 ++++-
 13 files changed, 195 insertions(+), 76 deletions(-)

diff --git a/CREDITS b/CREDITS
index 8e03426..681335f 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3364,6 +3364,14 @@ S: Braunschweiger Strasse 79
 S: 31134 Hildesheim
 S: Germany
 
+N: Martin Schwidefsky
+D: Martin was the most significant contributor to the initial s390
+D: port of the Linux Kernel and later the maintainer of the s390
+D: architecture backend for almost two decades.
+D: He passed away in 2019, and will be greatly missed.
+S: Germany
+W: https://lwn.net/Articles/789028/
+
 N: Marcel Selhorst
 E: tpmdd@selhorst.net
 D: TPM driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 2336dd2..5ce254c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3049,8 +3049,9 @@ S:	Maintained
 F:	arch/riscv/net/
 
 BPF JIT for S390
-M:	Martin Schwidefsky <schwidefsky@de.ibm.com>
 M:	Heiko Carstens <heiko.carstens@de.ibm.com>
+M:	Vasily Gorbik <gor@linux.ibm.com>
+M:	Christian Borntraeger <borntraeger@de.ibm.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
@@ -13616,8 +13617,9 @@ S:	Maintained
 F:	drivers/video/fbdev/savage/
 
 S390
-M:	Martin Schwidefsky <schwidefsky@de.ibm.com>
 M:	Heiko Carstens <heiko.carstens@de.ibm.com>
+M:	Vasily Gorbik <gor@linux.ibm.com>
+M:	Christian Borntraeger <borntraeger@de.ibm.com>
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index dd45672..d00f84a 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -27,14 +27,14 @@
 #include <linux/module.h>
 #include <linux/cpufeature.h>
 #include <linux/init.h>
-#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/fips.h>
 #include <linux/string.h>
 #include <crypto/xts.h>
 #include <asm/cpacf.h>
 
 static u8 *ctrblk;
-static DEFINE_SPINLOCK(ctrblk_lock);
+static DEFINE_MUTEX(ctrblk_lock);
 
 static cpacf_mask_t km_functions, kmc_functions, kmctr_functions,
 		    kma_functions;
@@ -698,7 +698,7 @@ static int ctr_aes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
 	unsigned int n, nbytes;
 	int ret, locked;
 
-	locked = spin_trylock(&ctrblk_lock);
+	locked = mutex_trylock(&ctrblk_lock);
 
 	ret = blkcipher_walk_virt_block(desc, walk, AES_BLOCK_SIZE);
 	while ((nbytes = walk->nbytes) >= AES_BLOCK_SIZE) {
@@ -716,7 +716,7 @@ static int ctr_aes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
 		ret = blkcipher_walk_done(desc, walk, nbytes - n);
 	}
 	if (locked)
-		spin_unlock(&ctrblk_lock);
+		mutex_unlock(&ctrblk_lock);
 	/*
 	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
 	 */
@@ -826,19 +826,45 @@ static int gcm_aes_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
 	return 0;
 }
 
-static void gcm_sg_walk_start(struct gcm_sg_walk *gw, struct scatterlist *sg,
-			      unsigned int len)
+static void gcm_walk_start(struct gcm_sg_walk *gw, struct scatterlist *sg,
+			   unsigned int len)
 {
 	memset(gw, 0, sizeof(*gw));
 	gw->walk_bytes_remain = len;
 	scatterwalk_start(&gw->walk, sg);
 }
 
-static int gcm_sg_walk_go(struct gcm_sg_walk *gw, unsigned int minbytesneeded)
+static inline unsigned int _gcm_sg_clamp_and_map(struct gcm_sg_walk *gw)
+{
+	struct scatterlist *nextsg;
+
+	gw->walk_bytes = scatterwalk_clamp(&gw->walk, gw->walk_bytes_remain);
+	while (!gw->walk_bytes) {
+		nextsg = sg_next(gw->walk.sg);
+		if (!nextsg)
+			return 0;
+		scatterwalk_start(&gw->walk, nextsg);
+		gw->walk_bytes = scatterwalk_clamp(&gw->walk,
+						   gw->walk_bytes_remain);
+	}
+	gw->walk_ptr = scatterwalk_map(&gw->walk);
+	return gw->walk_bytes;
+}
+
+static inline void _gcm_sg_unmap_and_advance(struct gcm_sg_walk *gw,
+					     unsigned int nbytes)
+{
+	gw->walk_bytes_remain -= nbytes;
+	scatterwalk_unmap(&gw->walk);
+	scatterwalk_advance(&gw->walk, nbytes);
+	scatterwalk_done(&gw->walk, 0, gw->walk_bytes_remain);
+	gw->walk_ptr = NULL;
+}
+
+static int gcm_in_walk_go(struct gcm_sg_walk *gw, unsigned int minbytesneeded)
 {
 	int n;
 
-	/* minbytesneeded <= AES_BLOCK_SIZE */
 	if (gw->buf_bytes && gw->buf_bytes >= minbytesneeded) {
 		gw->ptr = gw->buf;
 		gw->nbytes = gw->buf_bytes;
@@ -851,13 +877,11 @@ static int gcm_sg_walk_go(struct gcm_sg_walk *gw, unsigned int minbytesneeded)
 		goto out;
 	}
 
-	gw->walk_bytes = scatterwalk_clamp(&gw->walk, gw->walk_bytes_remain);
-	if (!gw->walk_bytes) {
-		scatterwalk_start(&gw->walk, sg_next(gw->walk.sg));
-		gw->walk_bytes = scatterwalk_clamp(&gw->walk,
-						   gw->walk_bytes_remain);
+	if (!_gcm_sg_clamp_and_map(gw)) {
+		gw->ptr = NULL;
+		gw->nbytes = 0;
+		goto out;
 	}
-	gw->walk_ptr = scatterwalk_map(&gw->walk);
 
 	if (!gw->buf_bytes && gw->walk_bytes >= minbytesneeded) {
 		gw->ptr = gw->walk_ptr;
@@ -869,51 +893,90 @@ static int gcm_sg_walk_go(struct gcm_sg_walk *gw, unsigned int minbytesneeded)
 		n = min(gw->walk_bytes, AES_BLOCK_SIZE - gw->buf_bytes);
 		memcpy(gw->buf + gw->buf_bytes, gw->walk_ptr, n);
 		gw->buf_bytes += n;
-		gw->walk_bytes_remain -= n;
-		scatterwalk_unmap(&gw->walk);
-		scatterwalk_advance(&gw->walk, n);
-		scatterwalk_done(&gw->walk, 0, gw->walk_bytes_remain);
-
+		_gcm_sg_unmap_and_advance(gw, n);
 		if (gw->buf_bytes >= minbytesneeded) {
 			gw->ptr = gw->buf;
 			gw->nbytes = gw->buf_bytes;
 			goto out;
 		}
-
-		gw->walk_bytes = scatterwalk_clamp(&gw->walk,
-						   gw->walk_bytes_remain);
-		if (!gw->walk_bytes) {
-			scatterwalk_start(&gw->walk, sg_next(gw->walk.sg));
-			gw->walk_bytes = scatterwalk_clamp(&gw->walk,
-							gw->walk_bytes_remain);
+		if (!_gcm_sg_clamp_and_map(gw)) {
+			gw->ptr = NULL;
+			gw->nbytes = 0;
+			goto out;
 		}
-		gw->walk_ptr = scatterwalk_map(&gw->walk);
 	}
 
 out:
 	return gw->nbytes;
 }
 
-static void gcm_sg_walk_done(struct gcm_sg_walk *gw, unsigned int bytesdone)
+static int gcm_out_walk_go(struct gcm_sg_walk *gw, unsigned int minbytesneeded)
 {
-	int n;
+	if (gw->walk_bytes_remain == 0) {
+		gw->ptr = NULL;
+		gw->nbytes = 0;
+		goto out;
+	}
 
+	if (!_gcm_sg_clamp_and_map(gw)) {
+		gw->ptr = NULL;
+		gw->nbytes = 0;
+		goto out;
+	}
+
+	if (gw->walk_bytes >= minbytesneeded) {
+		gw->ptr = gw->walk_ptr;
+		gw->nbytes = gw->walk_bytes;
+		goto out;
+	}
+
+	scatterwalk_unmap(&gw->walk);
+	gw->walk_ptr = NULL;
+
+	gw->ptr = gw->buf;
+	gw->nbytes = sizeof(gw->buf);
+
+out:
+	return gw->nbytes;
+}
+
+static int gcm_in_walk_done(struct gcm_sg_walk *gw, unsigned int bytesdone)
+{
 	if (gw->ptr == NULL)
-		return;
+		return 0;
 
 	if (gw->ptr == gw->buf) {
-		n = gw->buf_bytes - bytesdone;
+		int n = gw->buf_bytes - bytesdone;
 		if (n > 0) {
 			memmove(gw->buf, gw->buf + bytesdone, n);
-			gw->buf_bytes -= n;
+			gw->buf_bytes = n;
 		} else
 			gw->buf_bytes = 0;
-	} else {
-		gw->walk_bytes_remain -= bytesdone;
-		scatterwalk_unmap(&gw->walk);
-		scatterwalk_advance(&gw->walk, bytesdone);
-		scatterwalk_done(&gw->walk, 0, gw->walk_bytes_remain);
-	}
+	} else
+		_gcm_sg_unmap_and_advance(gw, bytesdone);
+
+	return bytesdone;
+}
+
+static int gcm_out_walk_done(struct gcm_sg_walk *gw, unsigned int bytesdone)
+{
+	int i, n;
+
+	if (gw->ptr == NULL)
+		return 0;
+
+	if (gw->ptr == gw->buf) {
+		for (i = 0; i < bytesdone; i += n) {
+			if (!_gcm_sg_clamp_and_map(gw))
+				return i;
+			n = min(gw->walk_bytes, bytesdone - i);
+			memcpy(gw->walk_ptr, gw->buf + i, n);
+			_gcm_sg_unmap_and_advance(gw, n);
+		}
+	} else
+		_gcm_sg_unmap_and_advance(gw, bytesdone);
+
+	return bytesdone;
 }
 
 static int gcm_aes_crypt(struct aead_request *req, unsigned int flags)
@@ -926,7 +989,7 @@ static int gcm_aes_crypt(struct aead_request *req, unsigned int flags)
 	unsigned int pclen = req->cryptlen;
 	int ret = 0;
 
-	unsigned int len, in_bytes, out_bytes,
+	unsigned int n, len, in_bytes, out_bytes,
 		     min_bytes, bytes, aad_bytes, pc_bytes;
 	struct gcm_sg_walk gw_in, gw_out;
 	u8 tag[GHASH_DIGEST_SIZE];
@@ -963,14 +1026,14 @@ static int gcm_aes_crypt(struct aead_request *req, unsigned int flags)
 	*(u32 *)(param.j0 + ivsize) = 1;
 	memcpy(param.k, ctx->key, ctx->key_len);
 
-	gcm_sg_walk_start(&gw_in, req->src, len);
-	gcm_sg_walk_start(&gw_out, req->dst, len);
+	gcm_walk_start(&gw_in, req->src, len);
+	gcm_walk_start(&gw_out, req->dst, len);
 
 	do {
 		min_bytes = min_t(unsigned int,
 				  aadlen > 0 ? aadlen : pclen, AES_BLOCK_SIZE);
-		in_bytes = gcm_sg_walk_go(&gw_in, min_bytes);
-		out_bytes = gcm_sg_walk_go(&gw_out, min_bytes);
+		in_bytes = gcm_in_walk_go(&gw_in, min_bytes);
+		out_bytes = gcm_out_walk_go(&gw_out, min_bytes);
 		bytes = min(in_bytes, out_bytes);
 
 		if (aadlen + pclen <= bytes) {
@@ -997,8 +1060,11 @@ static int gcm_aes_crypt(struct aead_request *req, unsigned int flags)
 			  gw_in.ptr + aad_bytes, pc_bytes,
 			  gw_in.ptr, aad_bytes);
 
-		gcm_sg_walk_done(&gw_in, aad_bytes + pc_bytes);
-		gcm_sg_walk_done(&gw_out, aad_bytes + pc_bytes);
+		n = aad_bytes + pc_bytes;
+		if (gcm_in_walk_done(&gw_in, n) != n)
+			return -ENOMEM;
+		if (gcm_out_walk_done(&gw_out, n) != n)
+			return -ENOMEM;
 		aadlen -= aad_bytes;
 		pclen -= pc_bytes;
 	} while (aadlen + pclen > 0);
diff --git a/arch/s390/crypto/des_s390.c b/arch/s390/crypto/des_s390.c
index 1f9ab24..374b42f 100644
--- a/arch/s390/crypto/des_s390.c
+++ b/arch/s390/crypto/des_s390.c
@@ -14,6 +14,7 @@
 #include <linux/cpufeature.h>
 #include <linux/crypto.h>
 #include <linux/fips.h>
+#include <linux/mutex.h>
 #include <crypto/algapi.h>
 #include <crypto/des.h>
 #include <asm/cpacf.h>
@@ -21,7 +22,7 @@
 #define DES3_KEY_SIZE	(3 * DES_KEY_SIZE)
 
 static u8 *ctrblk;
-static DEFINE_SPINLOCK(ctrblk_lock);
+static DEFINE_MUTEX(ctrblk_lock);
 
 static cpacf_mask_t km_functions, kmc_functions, kmctr_functions;
 
@@ -374,7 +375,7 @@ static int ctr_desall_crypt(struct blkcipher_desc *desc, unsigned long fc,
 	unsigned int n, nbytes;
 	int ret, locked;
 
-	locked = spin_trylock(&ctrblk_lock);
+	locked = mutex_trylock(&ctrblk_lock);
 
 	ret = blkcipher_walk_virt_block(desc, walk, DES_BLOCK_SIZE);
 	while ((nbytes = walk->nbytes) >= DES_BLOCK_SIZE) {
@@ -391,7 +392,7 @@ static int ctr_desall_crypt(struct blkcipher_desc *desc, unsigned long fc,
 		ret = blkcipher_walk_done(desc, walk, nbytes - n);
 	}
 	if (locked)
-		spin_unlock(&ctrblk_lock);
+		mutex_unlock(&ctrblk_lock);
 	/* final block may be < DES_BLOCK_SIZE, copy only nbytes */
 	if (nbytes) {
 		cpacf_kmctr(fc, ctx->key, buf, walk->src.virt.addr,
diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index e94a0a2..aea32dd 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -160,8 +160,8 @@ struct ap_config_info {
 	unsigned char Nd;		/* max # of Domains - 1 */
 	unsigned char _reserved3[10];
 	unsigned int apm[8];		/* AP ID mask */
-	unsigned int aqm[8];		/* AP queue mask */
-	unsigned int adm[8];		/* AP domain mask */
+	unsigned int aqm[8];		/* AP (usage) queue mask */
+	unsigned int adm[8];		/* AP (control) domain mask */
 	unsigned char _reserved4[16];
 } __aligned(8);
 
diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index 2769675..e3d53eb 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -178,7 +178,7 @@ static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
 		: "cc");
 }
 
-static inline int __cpacf_check_opcode(unsigned int opcode)
+static __always_inline int __cpacf_check_opcode(unsigned int opcode)
 {
 	switch (opcode) {
 	case CPACF_KMAC:
@@ -218,7 +218,7 @@ static inline int cpacf_test_func(cpacf_mask_t *mask, unsigned int func)
 	return (mask->bytes[func >> 3] & (0x80 >> (func & 7))) != 0;
 }
 
-static inline int cpacf_query_func(unsigned int opcode, unsigned int func)
+static __always_inline int cpacf_query_func(unsigned int opcode, unsigned int func)
 {
 	cpacf_mask_t mask;
 
diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
index 3ec52a0..5035917 100644
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -70,6 +70,17 @@ struct clp_rsp_list_pci {
 	struct clp_fh_list_entry fh_list[CLP_FH_LIST_NR_ENTRIES];
 } __packed;
 
+struct mio_info {
+	u32 valid : 6;
+	u32 : 26;
+	u32 : 32;
+	struct {
+		u64 wb;
+		u64 wt;
+	} addr[PCI_BAR_COUNT];
+	u32 reserved[6];
+} __packed;
+
 /* Query PCI function request */
 struct clp_req_query_pci {
 	struct clp_req_hdr hdr;
@@ -100,14 +111,7 @@ struct clp_rsp_query_pci {
 	u32 uid;			/* user defined id */
 	u8 util_str[CLP_UTIL_STR_LEN];	/* utility string */
 	u32 reserved2[16];
-	u32 mio_valid : 6;
-	u32 : 26;
-	u32 : 32;
-	struct {
-		u64 wb;
-		u64 wt;
-	} addr[PCI_BAR_COUNT];
-	u32 reserved3[6];
+	struct mio_info mio;
 } __packed;
 
 /* Query PCI function group request */
@@ -155,8 +159,9 @@ struct clp_req_set_pci {
 struct clp_rsp_set_pci {
 	struct clp_rsp_hdr hdr;
 	u32 fh;				/* function handle */
-	u32 reserved3;
-	u64 reserved4;
+	u32 reserved1;
+	u64 reserved2;
+	struct mio_info mio;
 } __packed;
 
 /* Combined request/response block structures used by clp insn */
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index c220399..91ce03f 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -85,7 +85,7 @@ static inline int notify_page_fault(struct pt_regs *regs)
  * Find out which address space caused the exception.
  * Access register mode is impossible, ignore space == 3.
  */
-static inline enum fault_type get_fault_type(struct pt_regs *regs)
+static enum fault_type get_fault_type(struct pt_regs *regs)
 {
 	unsigned long trans_exc_code;
 
@@ -211,6 +211,8 @@ static void dump_fault_info(struct pt_regs *regs)
 		asce = S390_lowcore.kernel_asce;
 		pr_cont("kernel ");
 		break;
+	default:
+		unreachable();
 	}
 	pr_cont("ASCE.\n");
 	dump_pagetable(asce, regs->int_parm_long & __FAIL_ADDR_MASK);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 0ebb7c4..86ca7f8 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -528,7 +528,10 @@ static int zpci_setup_bus_resources(struct zpci_dev *zdev,
 		if (zdev->bars[i].val & 4)
 			flags |= IORESOURCE_MEM_64;
 
-		addr = ZPCI_ADDR(entry);
+		if (static_branch_likely(&have_mio))
+			addr = (unsigned long) zdev->bars[i].mio_wb;
+		else
+			addr = ZPCI_ADDR(entry);
 		size = 1UL << zdev->bars[i].size;
 
 		res = __alloc_res(zdev, addr, size, flags);
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 3a36b07..d03631d 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -165,11 +165,11 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 	}
 	zdev->mio_capable = response->mio_addr_avail;
 	for (i = 0; i < PCI_BAR_COUNT; i++) {
-		if (!(response->mio_valid & (1 << (PCI_BAR_COUNT - i - 1))))
+		if (!(response->mio.valid & (1 << (PCI_BAR_COUNT - i - 1))))
 			continue;
 
-		zdev->bars[i].mio_wb = (void __iomem *) response->addr[i].wb;
-		zdev->bars[i].mio_wt = (void __iomem *) response->addr[i].wt;
+		zdev->bars[i].mio_wb = (void __iomem *) response->mio.addr[i].wb;
+		zdev->bars[i].mio_wt = (void __iomem *) response->mio.addr[i].wt;
 	}
 	return 0;
 }
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index cc30e4f..b9fc502 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -254,19 +254,37 @@ static inline int ap_test_config_card_id(unsigned int id)
 }
 
 /*
- * ap_test_config_domain(): Test, whether an AP usage domain is configured.
+ * ap_test_config_usage_domain(): Test, whether an AP usage domain
+ * is configured.
  * @domain AP usage domain ID
  *
  * Returns 0 if the usage domain is not configured
  *	   1 if the usage domain is configured or
  *	     if the configuration information is not available
  */
-static inline int ap_test_config_domain(unsigned int domain)
+int ap_test_config_usage_domain(unsigned int domain)
 {
 	if (!ap_configuration)	/* QCI not supported */
 		return domain < 16;
 	return ap_test_config(ap_configuration->aqm, domain);
 }
+EXPORT_SYMBOL(ap_test_config_usage_domain);
+
+/*
+ * ap_test_config_ctrl_domain(): Test, whether an AP control domain
+ * is configured.
+ * @domain AP control domain ID
+ *
+ * Returns 1 if the control domain is configured
+ *	   0 in all other cases
+ */
+int ap_test_config_ctrl_domain(unsigned int domain)
+{
+	if (!ap_configuration)	/* QCI not supported */
+		return 0;
+	return ap_test_config(ap_configuration->adm, domain);
+}
+EXPORT_SYMBOL(ap_test_config_ctrl_domain);
 
 /**
  * ap_query_queue(): Check if an AP queue is available.
@@ -1267,7 +1285,7 @@ static void ap_select_domain(void)
 	best_domain = -1;
 	max_count = 0;
 	for (i = 0; i < AP_DOMAINS; i++) {
-		if (!ap_test_config_domain(i) ||
+		if (!ap_test_config_usage_domain(i) ||
 		    !test_bit_inv(i, ap_perms.aqm))
 			continue;
 		count = 0;
@@ -1442,7 +1460,7 @@ static void _ap_scan_bus_adapter(int id)
 				      (void *)(long) qid,
 				      __match_queue_device_with_qid);
 		aq = dev ? to_ap_queue(dev) : NULL;
-		if (!ap_test_config_domain(dom)) {
+		if (!ap_test_config_usage_domain(dom)) {
 			if (dev) {
 				/* Queue device exists but has been
 				 * removed from configuration.
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 15a98a6..6f3cf37 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -251,6 +251,9 @@ void ap_wait(enum ap_wait wait);
 void ap_request_timeout(struct timer_list *t);
 void ap_bus_force_rescan(void);
 
+int ap_test_config_usage_domain(unsigned int domain);
+int ap_test_config_ctrl_domain(unsigned int domain);
+
 void ap_queue_init_reply(struct ap_queue *aq, struct ap_message *ap_msg);
 struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type);
 void ap_queue_prepare_remove(struct ap_queue *aq);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 852b8c2..1058b4b 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -822,7 +822,7 @@ static long _zcrypt_send_cprb(struct ap_perms *perms,
 	struct ap_message ap_msg;
 	unsigned int weight, pref_weight;
 	unsigned int func_code;
-	unsigned short *domain;
+	unsigned short *domain, tdom;
 	int qid = 0, rc = -ENODEV;
 	struct module *mod;
 
@@ -834,6 +834,17 @@ static long _zcrypt_send_cprb(struct ap_perms *perms,
 	if (rc)
 		goto out;
 
+	/*
+	 * If a valid target domain is set and this domain is NOT a usage
+	 * domain but a control only domain, use the default domain as target.
+	 */
+	tdom = *domain;
+	if (tdom >= 0 && tdom < AP_DOMAINS &&
+	    !ap_test_config_usage_domain(tdom) &&
+	    ap_test_config_ctrl_domain(tdom) &&
+	    ap_domain_index >= 0)
+		tdom = ap_domain_index;
+
 	pref_zc = NULL;
 	pref_zq = NULL;
 	spin_lock(&zcrypt_list_lock);
@@ -856,8 +867,8 @@ static long _zcrypt_send_cprb(struct ap_perms *perms,
 			/* check if device is online and eligible */
 			if (!zq->online ||
 			    !zq->ops->send_cprb ||
-			    ((*domain != (unsigned short) AUTOSELECT) &&
-			     (*domain != AP_QID_QUEUE(zq->queue->qid))))
+			    (tdom != (unsigned short) AUTOSELECT &&
+			     tdom != AP_QID_QUEUE(zq->queue->qid)))
 				continue;
 			/* check if device node has admission for this queue */
 			if (!zcrypt_check_queue(perms,
