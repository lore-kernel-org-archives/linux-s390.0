Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046EB2010F7;
	Fri, 18 Oct 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247829; cv=none; b=Scc6RxkGHbGrcFTQTnbFg4mxYJk2ormureG9Jbezs5/u8GuPkE2ZsaTmuEtsHYKpK10i9cscT8TaOUQVZ7nSqS4qbBShRvozmUNJN81g3P+Jciz4YpxoWVRE5edo/jDKWTLUzVEPAfW5DKRZch0wAuvnRn9cLje6QwBxRN69qmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247829; c=relaxed/simple;
	bh=2lL3a4ukv7hE+Tm21Go/buadzbDAVtkTQ8E6SLrrIC8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dWu+TyUERxncp1HH0TSrutb21o7Sd7FOhxi4I9F1ReoA07sjkeKqRONej+oK1yowQ/6hoeAXWcI4u5Mpw/y8V8AVixKAO2wV61l42am6urYatrmw92rXwcJ7MG3AMMout9ZUke2UcE1LHdh00wE3CrE57N41Rrexo0lDuB6LiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PZ/IMDtE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PZ/IMDtE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9Z15s017591;
	Fri, 18 Oct 2024 10:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=tvs5nrteYX9b0NR7QwB2irmwBPXl
	eLoG10Fg7mWdBq0=; b=PZ/IMDtE69UYElzFxYovLbdiGEscl1/zM5fXIMLqWVrE
	Gji5U0bFr4d6U6ii0al52+8955Je0tSp7NsdD0+vvlNkFhBW9kRSqq4/Dk2uoJru
	mI74Xr5B6ZmJXfmjJgi7wdjaEmULorwHNIc0fKEInwKCw8ujjF3EZdcQv0koPy9w
	0jL8y4Oz+Rqgwt+CSFkPzSfZ/POuqFckanSbgSExEWUKPYdE1jTilDcL3x5wyCVh
	lBytgOyniWrM921J002HFME0K8RcwIK7RmIiTGLfqh5seykGlrBFauFOXRBTYu9i
	HosL0+2L5BxCAsxgSXjJprNaStQzPB7CD0dnX+Y14A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u82x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 10:37:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I92G6B007025;
	Fri, 18 Oct 2024 10:37:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xkktjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 10:37:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IAb0Xu34669128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 10:37:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A83E2004F;
	Fri, 18 Oct 2024 10:37:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 147982004B;
	Fri, 18 Oct 2024 10:37:00 +0000 (GMT)
Received: from osiris (unknown [9.171.52.217])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Oct 2024 10:37:00 +0000 (GMT)
Date: Fri, 18 Oct 2024 12:36:58 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.12-rc4
Message-ID: <20241018103658.17670-D-hca@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bcuURlwRleF_QE16zHDRU8DdLGOHxjeI
X-Proofpoint-ORIG-GUID: bcuURlwRleF_QE16zHDRU8DdLGOHxjeI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180067

Hi Linus,

please pull s390 fixes for 6.12-rc4.

Thanks,
Heiko

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.12-3

for you to fetch changes up to b4fa00fd428bf7648d4ac5d0c8b61882902ec516:

  s390: Update defconfigs (2024-10-16 11:32:32 +0200)

----------------------------------------------------------------
s390 fixes for 6.12-rc4

- Fix PCI error recovery by handling error events correctly

- Fix CCA crypto card behavior within protected execution environment

- Two KVM commits which fix virtual vs physical address handling bugs
  in KVM pfault handling

- Fix return code handling in pckmo_key2protkey()

- Deactivate sclp console as late as possible so that outstanding
  messages appear on the console instead of being dropped on reboot

- Convert newlines to CRLF instead of LFCR for the sclp vt220 driver,
  as required by the vt220 specification

- Initialize also psw mask in perf_arch_fetch_caller_regs() to make
  sure that user_mode(regs) will return false

- Update defconfigs

----------------------------------------------------------------
Harald Freudenberger (1):
      s390/ap: Fix CCA crypto card behavior within protected execution environment

Heiko Carstens (2):
      s390: Initialize psw mask in perf_arch_fetch_caller_regs()
      s390: Update defconfigs

Holger Dengler (1):
      s390/pkey_pckmo: Return with success for valid protected key types

Michael Mueller (1):
      KVM: s390: Change virtual to physical address access in diag 0x258 handler

Nico Boehr (1):
      KVM: s390: gaccess: Check if guest address is in memslot

Niklas Schnelle (1):
      s390/pci: Handle PCI error codes other than 0x3a

Thomas Wei?schuh (2):
      s390/sclp: Deactivate sclp after all its users
      s390/sclp_vt220: Convert newlines to CRLF instead of LFCR

 arch/s390/configs/debug_defconfig    | 13 +++++++++++--
 arch/s390/configs/defconfig          | 14 ++++++++++++--
 arch/s390/configs/zfcpdump_defconfig |  1 +
 arch/s390/include/asm/perf_event.h   |  1 +
 arch/s390/kvm/diag.c                 |  2 +-
 arch/s390/kvm/gaccess.c              |  4 ++++
 arch/s390/kvm/gaccess.h              | 14 ++++++++------
 arch/s390/pci/pci_event.c            | 17 +++++++++--------
 drivers/s390/char/sclp.c             |  3 ++-
 drivers/s390/char/sclp_vt220.c       |  4 ++--
 drivers/s390/crypto/ap_bus.c         |  3 +--
 drivers/s390/crypto/ap_bus.h         |  2 +-
 drivers/s390/crypto/ap_queue.c       | 28 ++++++++++++++++++++--------
 drivers/s390/crypto/pkey_pckmo.c     |  1 +
 14 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 9b57add02cd5..fb0e9a1d9be2 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -50,7 +50,6 @@ CONFIG_NUMA=y
 CONFIG_HZ_100=y
 CONFIG_CERT_STORE=y
 CONFIG_EXPOLINE=y
-# CONFIG_EXPOLINE_EXTERN is not set
 CONFIG_EXPOLINE_AUTO=y
 CONFIG_CHSC_SCH=y
 CONFIG_VFIO_CCW=m
@@ -95,6 +94,7 @@ CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
 CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
 CONFIG_ZSMALLOC_STAT=y
+CONFIG_SLAB_BUCKETS=y
 CONFIG_SLUB_STATS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MEMORY_HOTPLUG=y
@@ -426,6 +426,13 @@ CONFIG_DEVTMPFS_SAFE=y
 # CONFIG_FW_LOADER is not set
 CONFIG_CONNECTOR=y
 CONFIG_ZRAM=y
+CONFIG_ZRAM_BACKEND_LZ4=y
+CONFIG_ZRAM_BACKEND_LZ4HC=y
+CONFIG_ZRAM_BACKEND_ZSTD=y
+CONFIG_ZRAM_BACKEND_DEFLATE=y
+CONFIG_ZRAM_BACKEND_842=y
+CONFIG_ZRAM_BACKEND_LZO=y
+CONFIG_ZRAM_DEF_COMP_DEFLATE=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
@@ -486,6 +493,7 @@ CONFIG_DM_UEVENT=y
 CONFIG_DM_FLAKEY=m
 CONFIG_DM_VERITY=m
 CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
+CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING=y
 CONFIG_DM_SWITCH=m
 CONFIG_DM_INTEGRITY=m
 CONFIG_DM_VDO=m
@@ -535,6 +543,7 @@ CONFIG_NLMON=m
 CONFIG_MLX4_EN=m
 CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
+# CONFIG_NET_VENDOR_META is not set
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROCHIP is not set
 # CONFIG_NET_VENDOR_MICROSEMI is not set
@@ -695,6 +704,7 @@ CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_NFSD_V4_SECURITY_LABEL=y
+# CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set
 CONFIG_CIFS=m
 CONFIG_CIFS_UPCALL=y
 CONFIG_CIFS_XATTR=y
@@ -740,7 +750,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES_TI=m
 CONFIG_CRYPTO_ANUBIS=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index df4addd1834a..88be0a734b60 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -48,7 +48,6 @@ CONFIG_NUMA=y
 CONFIG_HZ_100=y
 CONFIG_CERT_STORE=y
 CONFIG_EXPOLINE=y
-# CONFIG_EXPOLINE_EXTERN is not set
 CONFIG_EXPOLINE_AUTO=y
 CONFIG_CHSC_SCH=y
 CONFIG_VFIO_CCW=m
@@ -89,6 +88,7 @@ CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
 CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
 CONFIG_ZSMALLOC_STAT=y
+CONFIG_SLAB_BUCKETS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
@@ -416,6 +416,13 @@ CONFIG_DEVTMPFS_SAFE=y
 # CONFIG_FW_LOADER is not set
 CONFIG_CONNECTOR=y
 CONFIG_ZRAM=y
+CONFIG_ZRAM_BACKEND_LZ4=y
+CONFIG_ZRAM_BACKEND_LZ4HC=y
+CONFIG_ZRAM_BACKEND_ZSTD=y
+CONFIG_ZRAM_BACKEND_DEFLATE=y
+CONFIG_ZRAM_BACKEND_842=y
+CONFIG_ZRAM_BACKEND_LZO=y
+CONFIG_ZRAM_DEF_COMP_DEFLATE=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
@@ -476,6 +483,7 @@ CONFIG_DM_UEVENT=y
 CONFIG_DM_FLAKEY=m
 CONFIG_DM_VERITY=m
 CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
+CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING=y
 CONFIG_DM_SWITCH=m
 CONFIG_DM_INTEGRITY=m
 CONFIG_DM_VDO=m
@@ -525,6 +533,7 @@ CONFIG_NLMON=m
 CONFIG_MLX4_EN=m
 CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
+# CONFIG_NET_VENDOR_META is not set
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROCHIP is not set
 # CONFIG_NET_VENDOR_MICROSEMI is not set
@@ -682,6 +691,7 @@ CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_NFSD_V4_SECURITY_LABEL=y
+# CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set
 CONFIG_CIFS=m
 CONFIG_CIFS_UPCALL=y
 CONFIG_CIFS_XATTR=y
@@ -726,7 +736,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES_TI=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -767,6 +776,7 @@ CONFIG_CRYPTO_LZ4=m
 CONFIG_CRYPTO_LZ4HC=m
 CONFIG_CRYPTO_ZSTD=m
 CONFIG_CRYPTO_ANSI_CPRNG=m
+CONFIG_CRYPTO_JITTERENTROPY_OSR=1
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 8c2b61363bab..bcbaa069de96 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -49,6 +49,7 @@ CONFIG_ZFCP=y
 # CONFIG_HVC_IUCV is not set
 # CONFIG_HW_RANDOM_S390 is not set
 # CONFIG_HMC_DRV is not set
+# CONFIG_S390_UV_UAPI is not set
 # CONFIG_S390_TAPE is not set
 # CONFIG_VMCP is not set
 # CONFIG_MONWRITER is not set
diff --git a/arch/s390/include/asm/perf_event.h b/arch/s390/include/asm/perf_event.h
index 66200d4a2134..29ee289108c5 100644
--- a/arch/s390/include/asm/perf_event.h
+++ b/arch/s390/include/asm/perf_event.h
@@ -49,6 +49,7 @@ struct perf_sf_sde_regs {
 };
 
 #define perf_arch_fetch_caller_regs(regs, __ip) do {			\
+	(regs)->psw.mask = 0;						\
 	(regs)->psw.addr = (__ip);					\
 	(regs)->gprs[15] = (unsigned long)__builtin_frame_address(0) -	\
 		offsetof(struct stack_frame, back_chain);		\
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 2a32438e09ce..74f73141f9b9 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -77,7 +77,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 	vcpu->stat.instruction_diagnose_258++;
 	if (vcpu->run->s.regs.gprs[rx] & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	rc = read_guest(vcpu, vcpu->run->s.regs.gprs[rx], rx, &parm, sizeof(parm));
+	rc = read_guest_real(vcpu, vcpu->run->s.regs.gprs[rx], &parm, sizeof(parm));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	if (parm.parm_version != 2 || parm.parm_len < 5 || parm.code != 0x258)
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index e65f597e3044..a688351f4ab5 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -828,6 +828,8 @@ static int access_guest_page(struct kvm *kvm, enum gacc_mode mode, gpa_t gpa,
 	const gfn_t gfn = gpa_to_gfn(gpa);
 	int rc;
 
+	if (!gfn_to_memslot(kvm, gfn))
+		return PGM_ADDRESSING;
 	if (mode == GACC_STORE)
 		rc = kvm_write_guest_page(kvm, gfn, data, offset, len);
 	else
@@ -985,6 +987,8 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 		gra += fragment_len;
 		data += fragment_len;
 	}
+	if (rc > 0)
+		vcpu->arch.pgm.code = rc;
 	return rc;
 }
 
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index b320d12aa049..3fde45a151f2 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -405,11 +405,12 @@ int read_guest_abs(struct kvm_vcpu *vcpu, unsigned long gpa, void *data,
  * @len: number of bytes to copy
  *
  * Copy @len bytes from @data (kernel space) to @gra (guest real address).
- * It is up to the caller to ensure that the entire guest memory range is
- * valid memory before calling this function.
  * Guest low address and key protection are not checked.
  *
- * Returns zero on success or -EFAULT on error.
+ * Returns zero on success, -EFAULT when copying from @data failed, or
+ * PGM_ADRESSING in case @gra is outside a memslot. In this case, pgm check info
+ * is also stored to allow injecting into the guest (if applicable) using
+ * kvm_s390_inject_prog_cond().
  *
  * If an error occurs data may have been copied partially to guest memory.
  */
@@ -428,11 +429,12 @@ int write_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
  * @len: number of bytes to copy
  *
  * Copy @len bytes from @gra (guest real address) to @data (kernel space).
- * It is up to the caller to ensure that the entire guest memory range is
- * valid memory before calling this function.
  * Guest key protection is not checked.
  *
- * Returns zero on success or -EFAULT on error.
+ * Returns zero on success, -EFAULT when copying to @data failed, or
+ * PGM_ADRESSING in case @gra is outside a memslot. In this case, pgm check info
+ * is also stored to allow injecting into the guest (if applicable) using
+ * kvm_s390_inject_prog_cond().
  *
  * If an error occurs data may have been copied partially to kernel space.
  */
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index dbe95ec5917e..d4f19d33914c 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -280,18 +280,19 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 		goto no_pdev;
 
 	switch (ccdf->pec) {
-	case 0x003a: /* Service Action or Error Recovery Successful */
+	case 0x002a: /* Error event concerns FMB */
+	case 0x002b:
+	case 0x002c:
+		break;
+	case 0x0040: /* Service Action or Error Recovery Failed */
+	case 0x003b:
+		zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
+		break;
+	default: /* PCI function left in the error state attempt to recover */
 		ers_res = zpci_event_attempt_error_recovery(pdev);
 		if (ers_res != PCI_ERS_RESULT_RECOVERED)
 			zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
 		break;
-	default:
-		/*
-		 * Mark as frozen not permanently failed because the device
-		 * could be subsequently recovered by the platform.
-		 */
-		zpci_event_io_failure(pdev, pci_channel_io_frozen);
-		break;
 	}
 	pci_dev_put(pdev);
 no_pdev:
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index f3621adbd5de..fbffd451031f 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -1195,7 +1195,8 @@ sclp_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
 }
 
 static struct notifier_block sclp_reboot_notifier = {
-	.notifier_call = sclp_reboot_event
+	.notifier_call = sclp_reboot_event,
+	.priority      = INT_MIN,
 };
 
 static ssize_t con_pages_show(struct device_driver *dev, char *buf)
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 218ae604f737..33b9c968dbcb 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -319,7 +319,7 @@ sclp_vt220_add_msg(struct sclp_vt220_request *request,
 	buffer = (void *) ((addr_t) sccb + sccb->header.length);
 
 	if (convertlf) {
-		/* Perform Linefeed conversion (0x0a -> 0x0a 0x0d)*/
+		/* Perform Linefeed conversion (0x0a -> 0x0d 0x0a)*/
 		for (from=0, to=0;
 		     (from < count) && (to < sclp_vt220_space_left(request));
 		     from++) {
@@ -328,8 +328,8 @@ sclp_vt220_add_msg(struct sclp_vt220_request *request,
 			/* Perform conversion */
 			if (c == 0x0a) {
 				if (to + 1 < sclp_vt220_space_left(request)) {
-					((unsigned char *) buffer)[to++] = c;
 					((unsigned char *) buffer)[to++] = 0x0d;
+					((unsigned char *) buffer)[to++] = c;
 				} else
 					break;
 
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 60cea6c24349..e14638936de6 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1864,13 +1864,12 @@ static inline void ap_scan_domains(struct ap_card *ac)
 		}
 		/* if no queue device exists, create a new one */
 		if (!aq) {
-			aq = ap_queue_create(qid, ac->ap_dev.device_type);
+			aq = ap_queue_create(qid, ac);
 			if (!aq) {
 				AP_DBF_WARN("%s(%d,%d) ap_queue_create() failed\n",
 					    __func__, ac->id, dom);
 				continue;
 			}
-			aq->card = ac;
 			aq->config = !decfg;
 			aq->chkstop = chkstop;
 			aq->se_bstate = hwinfo.bs;
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 0b275c719319..f4622ee4d894 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -272,7 +272,7 @@ int ap_test_config_usage_domain(unsigned int domain);
 int ap_test_config_ctrl_domain(unsigned int domain);
 
 void ap_queue_init_reply(struct ap_queue *aq, struct ap_message *ap_msg);
-struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type);
+struct ap_queue *ap_queue_create(ap_qid_t qid, struct ap_card *ac);
 void ap_queue_prepare_remove(struct ap_queue *aq);
 void ap_queue_remove(struct ap_queue *aq);
 void ap_queue_init_state(struct ap_queue *aq);
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 8c878c5aa31f..9a0e6e4d8a5e 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -22,6 +22,11 @@ static void __ap_flush_queue(struct ap_queue *aq);
  * some AP queue helper functions
  */
 
+static inline bool ap_q_supported_in_se(struct ap_queue *aq)
+{
+	return aq->card->hwinfo.ep11 || aq->card->hwinfo.accel;
+}
+
 static inline bool ap_q_supports_bind(struct ap_queue *aq)
 {
 	return aq->card->hwinfo.ep11 || aq->card->hwinfo.accel;
@@ -1104,18 +1109,19 @@ static void ap_queue_device_release(struct device *dev)
 	kfree(aq);
 }
 
-struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type)
+struct ap_queue *ap_queue_create(ap_qid_t qid, struct ap_card *ac)
 {
 	struct ap_queue *aq;
 
 	aq = kzalloc(sizeof(*aq), GFP_KERNEL);
 	if (!aq)
 		return NULL;
+	aq->card = ac;
 	aq->ap_dev.device.release = ap_queue_device_release;
 	aq->ap_dev.device.type = &ap_queue_type;
-	aq->ap_dev.device_type = device_type;
-	// add optional SE secure binding attributes group
-	if (ap_sb_available() && is_prot_virt_guest())
+	aq->ap_dev.device_type = ac->ap_dev.device_type;
+	/* in SE environment add bind/associate attributes group */
+	if (ap_is_se_guest() && ap_q_supported_in_se(aq))
 		aq->ap_dev.device.groups = ap_queue_dev_sb_attr_groups;
 	aq->qid = qid;
 	spin_lock_init(&aq->lock);
@@ -1196,10 +1202,16 @@ bool ap_queue_usable(struct ap_queue *aq)
 	}
 
 	/* SE guest's queues additionally need to be bound */
-	if (ap_q_needs_bind(aq) &&
-	    !(aq->se_bstate == AP_BS_Q_USABLE ||
-	      aq->se_bstate == AP_BS_Q_USABLE_NO_SECURE_KEY))
-		rc = false;
+	if (ap_is_se_guest()) {
+		if (!ap_q_supported_in_se(aq)) {
+			rc = false;
+			goto unlock_and_out;
+		}
+		if (ap_q_needs_bind(aq) &&
+		    !(aq->se_bstate == AP_BS_Q_USABLE ||
+		      aq->se_bstate == AP_BS_Q_USABLE_NO_SECURE_KEY))
+			rc = false;
+	}
 
 unlock_and_out:
 	spin_unlock_bh(&aq->lock);
diff --git a/drivers/s390/crypto/pkey_pckmo.c b/drivers/s390/crypto/pkey_pckmo.c
index 98079b1ed6db..beeca8827c46 100644
--- a/drivers/s390/crypto/pkey_pckmo.c
+++ b/drivers/s390/crypto/pkey_pckmo.c
@@ -324,6 +324,7 @@ static int pckmo_key2protkey(const u8 *key, u32 keylen,
 		memcpy(protkey, t->protkey, t->len);
 		*protkeylen = t->len;
 		*protkeytype = t->keytype;
+		rc = 0;
 		break;
 	}
 	case TOKVER_CLEAR_KEY: {
