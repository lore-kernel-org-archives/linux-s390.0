Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F94149011;
	Tue, 21 May 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310297; cv=none; b=EVfZU+o0QNi83mUKxP06bdspkjJcqux9Ca30riyh+BQyH/eSyx9jwtTAhrO7XHbof2QSLnpc4xbYrZ/cWt/qqhGVyg+UmVX8GoTTYZqWX0e6AOjK7yQv9w7KuwgkfufDGKP77b/qHMyQ8IZSitJ/1eisYbeLVEwK0etbf9F9UGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310297; c=relaxed/simple;
	bh=MbxIlm1F1CftDArD/fbBDsY/ikx10Bf2AwJ2lPAjTEY=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=o+MNtegoijko6EzYRHaqy9+yMg1lXmm1enTTpeg6KGdbwDbuS/hgVdNILNnsSqMfwHcShegRzUVU7/A3N7eyDkC1eNHhJTVSdWduh/2pAoM1/xiVmrItMabn4HZh1XktkbnBPJ3HdS3Yd4D0QHZrmf74qfPqtIVuhT1VjrcY/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F2mZ4dG9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F2mZ4dG9"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGRJip015326;
	Tue, 21 May 2024 16:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=yJXgAWuTn7T0lxNogq5rVdTLQl7RguyR9RKOIJL+Ktg=;
 b=F2mZ4dG9EhsTCHO4dv+wH/KVFrNFiajT7rFs5dFDK2wFhVXCys6Lwfe9l1UgDN0Y3La2
 I2EskF93XW7YfvfaGlWwSwFuS1TvpYbfn2Wrc+YE1dETNjlFgV0PAMvwRY6L6oOBv5RT
 IL84ESYv7wRuXgj4ZY2tEEWft0JVHp2N7XUBWincj69+qiGLKQ6g4mryNnMyHpint460
 iJYT/DjrrEQwlxgcm1wVZXrzeTrneQiGvZ3BX6m2RX9NfNFhJ6OfQLSIboEDz2ROXeTz
 BxtVbWAPyRbjBVirhB0vXjtU6Fr9vRTo477IcG7uV/tOBaUUQXHv4KnD6a+OkZp4kJ5q 4g== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8xum83nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 16:51:33 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44LFubAO008090;
	Tue, 21 May 2024 16:48:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y79c2xcmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 16:48:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44LGmMoS43647294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 16:48:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C42CD2004B;
	Tue, 21 May 2024 16:48:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 897AA20040;
	Tue, 21 May 2024 16:48:22 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 May 2024 16:48:22 +0000 (GMT)
Date: Tue, 21 May 2024 18:48:21 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.10 merge window
Message-ID: <ZkzQVaKfNZFEnd2j@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5z3GABba3bDFysTz5SFpQyyt_9Iy0Zcm
X-Proofpoint-ORIG-GUID: 5z3GABba3bDFysTz5SFpQyyt_9Iy0Zcm
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=953 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210127

Hi Linus,

please pull more s390 updates for the 6.10 merge window.

Please note a merge conflict in scripts/Makefile.vdsoinst with commit
1c369b6c9492 ("kbuild: simplify generic vdso installation code").

The resolution seems to be straightforward as resolved in next-20240521 commit
1c6d596096c4 ("Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git").

Thanks,
Alexander

The following changes since commit d65e1a0f305ba3e7aabf6261a37bb871790d9f93:

  Merge tag 's390-6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2024-05-13 08:33:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-2

for you to fetch changes up to c1248638f8c35b74400efa7e02e78ecda23373f9:

  s390/zcrypt: Use kvcalloc() instead of kvmalloc_array() (2024-05-17 10:43:43 +0200)

----------------------------------------------------------------
more s390 updates for 6.10 merge window

- Switch read and write software bits for PUDs

- Add missing hardware bits for PUDs and PMDs

- Generate unwind information for C modules to fix GDB unwind
  error for vDSO functions

- Create .build-id links for unstripped vDSO files to enable
  vDSO debugging with symbols

- Use standard stack frame layout for vDSO generated stack frames
  to manually walk stack frames without DWARF information

- Rework perf_callchain_user() and arch_stack_walk_user() functions
  to reduce code duplication

- Skip first stack frame when walking user stack

- Add basic checks to identify invalid instruction pointers when
  walking stack frames

- Introduce and use struct stack_frame_vdso_wrapper within vDSO user
  wrapper code to automatically generate an asm-offset define. Also
  use STACK_FRAME_USER_OVERHEAD instead of STACK_FRAME_OVERHEAD to
  document that the code works with user space stack

- Clear the backchain of the extra stack frame added by the vDSO user
  wrapper code. This allows the user stack walker to detect and skip
  the non-standard stack frame. Without this an incorrect instruction
  pointer would be added to stack traces.

- Rewrite psw_idle() function in C to ease maintenance and further
  enhancements

- Remove get_vtimer() function and use get_cpu_timer() instead

- Mark psw variable in __load_psw_mask() as __unitialized to avoid
  superfluous clearing of PSW

- Remove obsolete and superfluous comment about removed TIF_FPU flag

- Replace memzero_explicit() and kfree() with kfree_sensitive() to
  fix warnings reported by Coccinelle

- Wipe sensitive data and all copies of protected- or secure-keys
  from stack when an IOCTL fails

- Both do_airq_interrupt() and do_io_interrupt() functions set
  CIF_NOHZ_DELAY flag. Move it in do_io_irq() to simplify the code

- Provide iucv_alloc_device() and iucv_release_device() helpers,
  which can be used to deduplicate more or less identical IUCV
  device allocation and release code in four different drivers

- Make use of iucv_alloc_device() and iucv_release_device()
  helpers to get rid of quite some code and also remove a
  cast to an incompatible function (clang W=1)

- There is no user of iucv_root outside of the core IUCV code left.
  Therefore remove the EXPORT_SYMBOL

- __apply_alternatives() contains a runtime check which verifies
  that the size of the to be patched code area is even. Convert
  this to a compile time check

- Increase size of buffers for sending z/VM CP DIAGNOSE X'008'
  commands from 128 to 240

- Do not accept z/VM CP DIAGNOSE X'008' commands longer than
  maximally allowed

- Use correct defines IPL_BP_NVME_LEN and IPL_BP0_NVME_LEN instead
  of IPL_BP_FCP_LEN and IPL_BP0_FCP_LEN ones to initialize NVMe
  reIPL block on 'scp_data' sysfs attribute update

- Initialize the correct fields of the NVMe dump block, which
  were confused with FCP fields

- Refactor macros for 'scp_data' (re-)IPL sysfs attribute to
  reduce code duplication

- Introduce 'scp_data' sysfs attribute for dump IPL to allow tools
  such as dumpconf passing additional kernel command line parameters
  to a stand-alone dumper

- Rework the CPACF query functions to use the correct RRE or RRF
  instruction formats and set instruction register fields correctly

- Instead of calling BUG() at runtime force a link error during
  compile when a unsupported opcode is used with __cpacf_query()
  or __cpacf_check_opcode() functions

- Fix a crash in ap_parse_bitmap_str() function on /sys/bus/ap/apmask
  or /sys/bus/ap/aqmask sysfs file update with a relative mask value

- Fix "bindings complete" udev event which should be sent once all AP
  devices have been bound to device drivers and again when unbind/bind
  actions take place and all AP devices are bound again

- Facility list alt_stfle_fac_list is nowhere used in the decompressor,
  therefore remove it there

- Remove custom kprobes insn slot allocator in favour of the standard
  module_alloc() one, since kernel image and module areas are located
  within 4GB

- Use kvcalloc() instead of kvmalloc_array() in zcrypt driver to avoid
  calling memset() with a large byte count and get rid of the sparse
  warning as result

----------------------------------------------------------------
Alexander Egorenkov (6):
      s390/ipl: Fix size of vmcmd buffers for sending z/VM CP diag X'008' cmds
      s390/ipl: Do not accept z/VM CP diag X'008' cmds longer than max length
      s390/ipl: Fix incorrect initialization of len fields in nvme reipl block
      s390/ipl: Fix incorrect initialization of nvme dump block
      s390/ipl: Introduce macros for (re)ipl sysfs attribute 'scp_data'
      s390/ipl: Introduce sysfs attribute 'scp_data' for dump ipl

Claudio Imbrenda (2):
      s390/pgtable: Switch read and write softbits for puds
      s390/pgtable: Add missing hardware bits for puds, pmds

Harald Freudenberger (4):
      s390/cpacf: Split and rework cpacf query functions
      s390/cpacf: Make use of invalid opcode produce a link error
      s390/ap: Fix crash in AP internal function modify_bitmap()
      s390/ap: Fix bind complete udev event sent after each AP bus scan

Heiko Carstens (15):
      s390/vdso: Use standard stack frame layout
      s390/stacktrace: Merge perf_callchain_user() and arch_stack_walk_user()
      s390/stacktrace: Skip first user stack frame
      s390/stacktrace: Improve detection of invalid instruction pointers
      s390/vdso: Introduce and use struct stack_frame_vdso_wrapper
      s390/stackstrace: Detect vdso stack frames
      s390/iucv: Provide iucv_alloc_device() / iucv_release_device()
      s390/vmlogrdr: Make use of iucv_alloc_device()
      s390/netiucv: Make use of iucv_alloc_device()
      s390/smsgiucv_app: Make use of iucv_alloc_device()
      tty: hvc-iucv: Make use of iucv_alloc_device()
      s390/iucv: Unexport iucv_root
      s390/alternatives: Convert runtime sanity check into compile time check
      s390/kprobes: Remove custom insn slot allocator
      s390/zcrypt: Use kvcalloc() instead of kvmalloc_array()

Holger Dengler (3):
      s390/pkey: Wipe sensitive data on failure
      s390/pkey: Wipe copies of clear-key structures on failure
      s390/pkey: Wipe copies of protected- and secure-keys

Jens Remus (2):
      s390/vdso: Generate unwind information for C modules
      s390/vdso: Create .build-id links for unstripped vdso files

Jules Irenge (1):
      s390/pkey: Use kfree_sensitive() to fix Coccinelle warnings

Sven Schnelle (5):
      s390/idle: Rewrite psw_idle() in C
      s390/vtime: Use get_cpu_timer()
      s390: Mark psw in __load_psw_mask() as __unitialized
      s390/irq: Set CIF_NOHZ_DELAY in do_io_irq()
      s390/boot: Remove alt_stfle_fac_list from decompressor

Thomas Huth (1):
      s390/fpu: Remove comment about TIF_FPU

 arch/s390/boot/startup.c                    |   1 -
 arch/s390/include/asm/alternative-asm.h     |   1 +
 arch/s390/include/asm/alternative.h         |   1 +
 arch/s390/include/asm/cpacf.h               | 109 ++++++++--
 arch/s390/include/asm/pgtable.h             |  12 +-
 arch/s390/include/asm/processor.h           |  17 +-
 arch/s390/include/asm/stacktrace.h          |  12 ++
 arch/s390/kernel/Makefile                   |   1 -
 arch/s390/kernel/alternative.c              |   7 -
 arch/s390/kernel/asm-offsets.c              |   9 +-
 arch/s390/kernel/entry.S                    |  23 --
 arch/s390/kernel/idle.c                     |  10 +-
 arch/s390/kernel/ipl.c                      | 319 ++++++++++++----------------
 arch/s390/kernel/irq.c                      |   1 +
 arch/s390/kernel/kprobes.c                  |  67 +-----
 arch/s390/kernel/kprobes.h                  |   9 -
 arch/s390/kernel/kprobes_insn_page.S        |  22 --
 arch/s390/kernel/perf_event.c               |  34 +--
 arch/s390/kernel/process.c                  |   5 -
 arch/s390/kernel/setup.c                    |   2 +-
 arch/s390/kernel/stacktrace.c               |  89 ++++++--
 arch/s390/kernel/vdso.c                     |  13 +-
 arch/s390/kernel/vdso32/Makefile            |   4 +-
 arch/s390/kernel/vdso64/Makefile            |   4 +-
 arch/s390/kernel/vdso64/vdso_user_wrapper.S |  19 +-
 arch/s390/kernel/vtime.c                    |  10 +-
 drivers/s390/char/vmlogrdr.c                |  20 +-
 drivers/s390/cio/airq.c                     |   1 -
 drivers/s390/cio/cio.c                      |   1 -
 drivers/s390/crypto/ap_bus.c                |  10 +-
 drivers/s390/crypto/pkey_api.c              | 109 +++++-----
 drivers/s390/crypto/zcrypt_api.c            |   9 +-
 drivers/s390/crypto/zcrypt_ccamisc.c        |  12 +-
 drivers/s390/crypto/zcrypt_ep11misc.c       |   6 +-
 drivers/s390/net/netiucv.c                  |  20 +-
 drivers/s390/net/smsgiucv_app.c             |  21 +-
 drivers/tty/hvc/hvc_iucv.c                  |  15 +-
 include/net/iucv/iucv.h                     |   7 +-
 net/iucv/iucv.c                             |  38 +++-
 scripts/Makefile.vdsoinst                   |   2 +-
 40 files changed, 517 insertions(+), 555 deletions(-)
 delete mode 100644 arch/s390/kernel/kprobes.h
 delete mode 100644 arch/s390/kernel/kprobes_insn_page.S
