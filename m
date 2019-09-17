Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725922AbfIQO1Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Sep 2019 10:27:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8HEQqp3032066
        for <linux-s390@vger.kernel.org>; Tue, 17 Sep 2019 10:27:23 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v2yw1d3ye-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 17 Sep 2019 10:27:22 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Tue, 17 Sep 2019 15:27:21 +0100
Date: Tue, 17 Sep 2019 16:27:14 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.4 merge window
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01568730434-ext-0126@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 fixes and features for 5.4.

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-1

for you to fetch changes up to 2735913c1079b7dd7ec1d746c13a84ec1b5ea276:

  s390: remove pointless drivers-y in drivers/s390/Makefile (2019-09-16 13:21:51 +0200)

Please note the following easy to resolve merge conflict:

diff --cc arch/s390/configs/debug_defconfig
index 74e78ec5beb6,a08e3dcd3e9d..347f48702edb
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@@ -638,99 -580,6 +638,101 @@@ CONFIG_NLS_ISO8859_1=
  CONFIG_NLS_ISO8859_15=m
  CONFIG_NLS_UTF8=m
  CONFIG_DLM=m
 +CONFIG_UNICODE=y
 +CONFIG_PERSISTENT_KEYRINGS=y
 +CONFIG_BIG_KEYS=y
 +CONFIG_ENCRYPTED_KEYS=m
 +CONFIG_SECURITY=y
 +CONFIG_SECURITY_NETWORK=y
 +CONFIG_FORTIFY_SOURCE=y
 +CONFIG_SECURITY_SELINUX=y
 +CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 +CONFIG_SECURITY_SELINUX_DISABLE=y
 +CONFIG_INTEGRITY_SIGNATURE=y
 +CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
 +CONFIG_IMA=y
 +CONFIG_IMA_DEFAULT_HASH_SHA256=y
 +CONFIG_IMA_WRITE_POLICY=y
 +CONFIG_IMA_APPRAISE=y
 +CONFIG_CRYPTO_USER=m
 +# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
 +CONFIG_CRYPTO_PCRYPT=m
 +CONFIG_CRYPTO_CRYPTD=m
 +CONFIG_CRYPTO_TEST=m
 +CONFIG_CRYPTO_DH=m
 +CONFIG_CRYPTO_ECDH=m
 +CONFIG_CRYPTO_ECRDSA=m
 +CONFIG_CRYPTO_CHACHA20POLY1305=m
 +CONFIG_CRYPTO_AEGIS128=m
 +CONFIG_CRYPTO_AEGIS128L=m
 +CONFIG_CRYPTO_AEGIS256=m
 +CONFIG_CRYPTO_MORUS640=m
 +CONFIG_CRYPTO_MORUS1280=m
 +CONFIG_CRYPTO_CFB=m
 +CONFIG_CRYPTO_LRW=m
 +CONFIG_CRYPTO_PCBC=m
 +CONFIG_CRYPTO_KEYWRAP=m
 +CONFIG_CRYPTO_ADIANTUM=m
 +CONFIG_CRYPTO_XCBC=m
 +CONFIG_CRYPTO_VMAC=m
 +CONFIG_CRYPTO_CRC32=m
 +CONFIG_CRYPTO_XXHASH=m
 +CONFIG_CRYPTO_MICHAEL_MIC=m
 +CONFIG_CRYPTO_RMD128=m
 +CONFIG_CRYPTO_RMD160=m
 +CONFIG_CRYPTO_RMD256=m
 +CONFIG_CRYPTO_RMD320=m
 +CONFIG_CRYPTO_SHA3=m
 +CONFIG_CRYPTO_SM3=m
 +CONFIG_CRYPTO_TGR192=m
 +CONFIG_CRYPTO_WP512=m
 +CONFIG_CRYPTO_AES_TI=m
 +CONFIG_CRYPTO_ANUBIS=m
 +CONFIG_CRYPTO_ARC4=m
 +CONFIG_CRYPTO_BLOWFISH=m
 +CONFIG_CRYPTO_CAMELLIA=m
 +CONFIG_CRYPTO_CAST5=m
 +CONFIG_CRYPTO_CAST6=m
 +CONFIG_CRYPTO_FCRYPT=m
 +CONFIG_CRYPTO_KHAZAD=m
 +CONFIG_CRYPTO_SALSA20=m
 +CONFIG_CRYPTO_SEED=m
 +CONFIG_CRYPTO_SERPENT=m
 +CONFIG_CRYPTO_SM4=m
 +CONFIG_CRYPTO_TEA=m
 +CONFIG_CRYPTO_TWOFISH=m
 +CONFIG_CRYPTO_842=m
 +CONFIG_CRYPTO_LZ4=m
 +CONFIG_CRYPTO_LZ4HC=m
 +CONFIG_CRYPTO_ZSTD=m
 +CONFIG_CRYPTO_ANSI_CPRNG=m
 +CONFIG_CRYPTO_USER_API_HASH=m
 +CONFIG_CRYPTO_USER_API_SKCIPHER=m
 +CONFIG_CRYPTO_USER_API_RNG=m
 +CONFIG_CRYPTO_USER_API_AEAD=m
 +CONFIG_CRYPTO_STATS=y
 +CONFIG_ZCRYPT=m
 +CONFIG_PKEY=m
 +CONFIG_CRYPTO_PAES_S390=m
 +CONFIG_CRYPTO_SHA1_S390=m
 +CONFIG_CRYPTO_SHA256_S390=m
 +CONFIG_CRYPTO_SHA512_S390=m
++CONFIG_CRYPTO_SHA3_256_S390=m
++CONFIG_CRYPTO_SHA3_512_S390=m
 +CONFIG_CRYPTO_DES_S390=m
 +CONFIG_CRYPTO_AES_S390=m
 +CONFIG_CRYPTO_GHASH_S390=m
 +CONFIG_CRYPTO_CRC32_S390=y
 +CONFIG_CORDIC=m
 +CONFIG_CRC32_SELFTEST=y
 +CONFIG_CRC4=m
 +CONFIG_CRC7=m
 +CONFIG_CRC8=m
 +CONFIG_RANDOM32_SELFTEST=y
 +CONFIG_DMA_CMA=y
 +CONFIG_CMA_SIZE_MBYTES=0
 +CONFIG_DMA_API_DEBUG=y
 +CONFIG_STRING_SELFTEST=y
  CONFIG_PRINTK_TIME=y
  CONFIG_DYNAMIC_DEBUG=y
  CONFIG_DEBUG_INFO=y

And another one with the crypto tree if you pull it first:

diff --cc arch/s390/crypto/aes_s390.c
index d4f6fd42a105,6d2dbb5089d5..9803e96d2924
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@@ -586,7 -586,10 +586,10 @@@ static int xts_aes_encrypt(struct blkci
  	struct s390_xts_ctx *xts_ctx = crypto_blkcipher_ctx(desc->tfm);
  	struct blkcipher_walk walk;
  
+ 	if (!nbytes)
+ 		return -EINVAL;
+ 
 -	if (unlikely(!xts_ctx->fc))
 +	if (unlikely(!xts_ctx->fc || (nbytes % XTS_BLOCK_SIZE) != 0))
  		return xts_fallback_encrypt(desc, dst, src, nbytes);
  
  	blkcipher_walk_init(&walk, dst, src, nbytes);
@@@ -600,7 -603,10 +603,10 @@@ static int xts_aes_decrypt(struct blkci
  	struct s390_xts_ctx *xts_ctx = crypto_blkcipher_ctx(desc->tfm);
  	struct blkcipher_walk walk;
  
+ 	if (!nbytes)
+ 		return -EINVAL;
+ 
 -	if (unlikely(!xts_ctx->fc))
 +	if (unlikely(!xts_ctx->fc || (nbytes % XTS_BLOCK_SIZE) != 0))
  		return xts_fallback_decrypt(desc, dst, src, nbytes);
  
  	blkcipher_walk_init(&walk, dst, src, nbytes);

Thank you,
Vasily
----------------------------------------------------------------
s390 updates for the 5.4 merge window

- Add support for IBM z15 machines.

- Add SHA3 and CCA AES cipher key support in zcrypt and pkey refactoring.

- Move to arch_stack_walk infrastructure for the stack unwinder.

- Various kasan fixes and improvements.

- Various command line parsing fixes.

- Improve decompressor phase debuggability.

- Lift no bss usage restriction for the early code.

- Use refcount_t for reference counters for couple of places in
  mm code.

- Logging improvements and return code fix in vfio-ccw code.

- Couple of zpci fixes and minor refactoring.

- Remove some outdated documentation.

- Fix secure boot detection.

- Other various minor code clean ups.

----------------------------------------------------------------
Chuhong Yuan (2):
      s390/extmem: use refcount_t for refcount
      s390/mm: use refcount_t for refcount

Cornelia Huck (1):
      vfio-ccw: add some logging

Denis Efremov (1):
      s390/pci: PCI_IOV_RESOURCES loop refactoring in zpci_map_resources

Halil Pasic (1):
      s390: vfio-ap: fix warning reset not completed

Harald Freudenberger (10):
      s390/zcrypt: move cca misc functions to new code file
      s390/zcrypt: add base code for cca crypto card info support
      s390/zcrypt: new sysfs attributes serialnr and mkvps
      s390/pkey: pkey cleanup: narrow in-kernel API, fix some variable types
      s390/zcrypt: extend cca_findcard function and helper
      s390/zcrypt: Add low level functions for CCA AES cipher keys
      s390/pkey: add CCA AES cipher key support
      s390/paes: Prepare paes functions for large key blobs
      s390/zcrypt: fix wrong handling of cca cipher keygenflags
      s390/crypto: xts-aes-s390 fix extra run-time crypto self tests finding

Heiko Carstens (2):
      Documentation/s390: remove outdated dasd documentation
      Documentation/s390: remove outdated debugging390 documentation

Joerg Schmidbauer (1):
      s390/crypto: Support for SHA3 via CPACF (MSA6)

Martin Schwidefsky (1):
      s390: add support for IBM z15 machines

Masahiro Yamada (1):
      s390: remove pointless drivers-y in drivers/s390/Makefile

Philipp Rudo (1):
      s390/sclp: Fix bit checked for has_sipl

Sebastian Ott (1):
      s390/pci: fix MSI message data

Thomas Richter (1):
      s390/cpum_sf: Fix line length and format string

Vasily Gorbik (25):
      s390: move vmalloc option parsing to startup code
      s390/startup: add initial pgm check handler
      s390/startup: purge obsolete .gitignore patterns
      s390: clean .bss before running uncompressed kernel
      s390/kasan: provide uninstrumented __strlen
      s390/process: avoid potential reading of freed stack
      s390/kasan: avoid report in get_wchan
      s390/stacktrace: use common arch_stack_walk infrastructure
      s390/startup: adjust _sdma and _edma to page boundaries
      s390/startup: round down "mem" option to page boundary
      s390/numa: correct early_param handling
      s390/vmcp: correct early_param handling
      s390/startup: correct command line options parsing
      s390/vdso: reuse kstrtobool for option value parsing
      s390/cmma: reuse kstrtobool for option value parsing
      s390/mem_detect: provide single get_mem_detect_end
      s390/kaslr: reserve memory for kasan usage
      s390/pci: avoid using strncmp with hardcoded length
      s390/module: avoid using strncmp with hardcoded length
      s390/sclp: avoid using strncmp with hardcoded length
      s390/setup: avoid using strncmp with hardcoded length
      s390/kasan: add kdump support
      Merge tag 'vfio-ccw-20190828' of https://git.kernel.org/.../kvms390/vfio-ccw into features
      s390/base: remove unused s390_base_mcck_handler
      s390/startup: add pgm check info printing

Wei Yongjun (1):
      vfio-ccw: fix error return code in vfio_ccw_sch_init()

 Documentation/s390/dasd.rst             |   84 -
 Documentation/s390/debugging390.rst     | 2613 -------------------------------
 Documentation/s390/index.rst            |    2 -
 arch/s390/Kconfig                       |   19 +
 arch/s390/Makefile                      |    2 +
 arch/s390/boot/Makefile                 |    2 +-
 arch/s390/boot/boot.h                   |    1 +
 arch/s390/boot/compressed/.gitignore    |    3 -
 arch/s390/boot/compressed/vmlinux.lds.S |    3 +-
 arch/s390/boot/head.S                   |   32 +-
 arch/s390/boot/ipl_parm.c               |   11 +-
 arch/s390/boot/kaslr.c                  |   41 +-
 arch/s390/boot/mem_detect.c             |    7 -
 arch/s390/boot/pgm_check_info.c         |   90 ++
 arch/s390/boot/startup.c                |    6 +
 arch/s390/configs/debug_defconfig       |    2 +
 arch/s390/configs/defconfig             |    2 +
 arch/s390/crypto/Makefile               |    2 +
 arch/s390/crypto/aes_s390.c             |    6 +
 arch/s390/crypto/paes_s390.c            |  184 ++-
 arch/s390/crypto/sha.h                  |   12 +-
 arch/s390/crypto/sha3_256_s390.c        |  147 ++
 arch/s390/crypto/sha3_512_s390.c        |  155 ++
 arch/s390/crypto/sha_common.c           |   75 +-
 arch/s390/include/asm/cpacf.h           |    8 +
 arch/s390/include/asm/gmap.h            |    4 +-
 arch/s390/include/asm/mem_detect.h      |   12 +
 arch/s390/include/asm/pgtable.h         |    1 +
 arch/s390/include/asm/pkey.h            |  114 +-
 arch/s390/include/asm/processor.h       |    2 -
 arch/s390/include/asm/setup.h           |    1 +
 arch/s390/include/asm/string.h          |    9 +-
 arch/s390/include/uapi/asm/pkey.h       |  257 ++-
 arch/s390/kernel/Makefile               |   13 +-
 arch/s390/kernel/base.S                 |   21 -
 arch/s390/kernel/early.c                |   16 +
 arch/s390/kernel/early_nobss.c          |   45 -
 arch/s390/kernel/early_printk.c         |    2 +-
 arch/s390/kernel/head64.S               |    8 +-
 arch/s390/kernel/module.c               |    4 +-
 arch/s390/kernel/perf_cpum_sf.c         |   20 +-
 arch/s390/kernel/process.c              |   26 +-
 arch/s390/kernel/setup.c                |   27 +-
 arch/s390/kernel/stacktrace.c           |   50 +-
 arch/s390/kernel/vdso.c                 |   18 +-
 arch/s390/lib/Makefile                  |    3 -
 arch/s390/mm/extmem.c                   |   11 +-
 arch/s390/mm/gmap.c                     |   10 +-
 arch/s390/mm/kasan_init.c               |   14 +-
 arch/s390/mm/page-states.c              |   14 +-
 arch/s390/numa/mode_emu.c               |    7 +-
 arch/s390/numa/numa.c                   |    2 +
 arch/s390/pci/pci.c                     |    8 +-
 arch/s390/pci/pci_dma.c                 |    4 +-
 arch/s390/pci/pci_irq.c                 |    2 +-
 arch/s390/tools/gen_facilities.c        |    3 +
 drivers/crypto/Kconfig                  |   20 +
 drivers/s390/Makefile                   |    3 -
 drivers/s390/char/Makefile              |    3 -
 drivers/s390/char/sclp_early.c          |    2 +-
 drivers/s390/char/vmcp.c                |    2 +
 drivers/s390/cio/vfio_ccw_drv.c         |   58 +-
 drivers/s390/cio/vfio_ccw_fsm.c         |   51 +-
 drivers/s390/cio/vfio_ccw_ops.c         |   10 +
 drivers/s390/cio/vfio_ccw_private.h     |   17 +
 drivers/s390/crypto/Makefile            |    2 +-
 drivers/s390/crypto/pkey_api.c          | 1638 ++++++++-----------
 drivers/s390/crypto/vfio_ap_ops.c       |    2 +-
 drivers/s390/crypto/zcrypt_api.c        |   30 +
 drivers/s390/crypto/zcrypt_api.h        |    7 +-
 drivers/s390/crypto/zcrypt_ccamisc.c    | 1765 +++++++++++++++++++++
 drivers/s390/crypto/zcrypt_ccamisc.h    |  217 +++
 drivers/s390/crypto/zcrypt_cex4.c       |  106 +-
 73 files changed, 4047 insertions(+), 4123 deletions(-)
 delete mode 100644 Documentation/s390/dasd.rst
 delete mode 100644 Documentation/s390/debugging390.rst
 create mode 100644 arch/s390/boot/pgm_check_info.c
 create mode 100644 arch/s390/crypto/sha3_256_s390.c
 create mode 100644 arch/s390/crypto/sha3_512_s390.c
 delete mode 100644 arch/s390/kernel/early_nobss.c
 create mode 100644 drivers/s390/crypto/zcrypt_ccamisc.c
 create mode 100644 drivers/s390/crypto/zcrypt_ccamisc.h
