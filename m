Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC922F01;
	Sat,  7 Feb 2026 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770486677; cv=none; b=OeO8zN1gf4MH6kEniB1ZRh60a7URLoAeu0TmxkEjKG8dU9faGH3VbJcXk60K68Iz7EA8/q6wGSq3bLzZkSDAb3ZPC4piGY3wOsDpTHSiFFHq+gh3OIdeXYl259PLBt2T2chBM6CKoH0lhTwd36zqQJ9ND/MLV203eieitMuDtNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770486677; c=relaxed/simple;
	bh=KVU05AMjnDLE3vMf4UUQhxhTzTy+6Rj3kAf9Mk99xdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ecM0PlyOy+6p2kncPYZW5SLo+zl6YtFfjqpfEcy7zCEYrGIcDLZlY4zRSsbN6qhvfE5GEHClq08BUn53diqnOnntziVQYAb4hD1AxHdVH+4S8jBwwm3DNh+ChnYSS8Te7McVpaIh4ICbYHVjsB+GiiI/o3U20LcUJsCgwDREy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sUsQ3u5X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sUsQ3u5X"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 617GsHma1136416;
	Sat, 7 Feb 2026 17:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=WFyXrwlLpo81UNJwwpTPWSAqthXI
	w1uKHrtxwiLqFGE=; b=sUsQ3u5XYdKA8jVjkDArf3xiCVUk1jg9PACMn991/f2B
	4hIQ0CP+aCDCw9iqyk83rSYlwRXPVxtbQk+1e/OzHq3OvSi2l7ypshvfaNtNABxL
	3lreMCuP8NDLBtl7XNQsty4JXucVTqg+u3LQGBsNkM+s0D/AfpD661brNKZFQirQ
	u68QDzfD6QFy7VsHjPFoivPLVeJNhhzb0vYYEYlvPwlrm207zjvcKCmjg8Qi5u7X
	sj/EMmNQmJtkZoKXKRf22ybG3Qgha6YaBB3saos5iYMNM9iaEryK9zTEtk4TvAee
	S/arPjLBlFKdjby4OBwHBCNom+9jfMj92qnHnGpUHQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696vr5nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Feb 2026 17:51:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 617EeF8a009147;
	Sat, 7 Feb 2026 17:51:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1veyjvbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Feb 2026 17:51:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 617Hp7nX56623364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 7 Feb 2026 17:51:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01AA620043;
	Sat,  7 Feb 2026 17:51:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8C3920040;
	Sat,  7 Feb 2026 17:51:06 +0000 (GMT)
Received: from osiris (unknown [9.111.82.148])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  7 Feb 2026 17:51:06 +0000 (GMT)
Date: Sat, 7 Feb 2026 18:51:05 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.0 merge window
Message-ID: <20260207175105.10023Acc-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=69877b90 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=TzKxZSFDOFyUdlQFDzAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: PJbgg_fjB313fyCYADl2x9BwCJJBxprb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDE0NiBTYWx0ZWRfX+PR+Y2Rbry8X
 snTGmnfocZuVjxb6CFSBIAUrd4mh96vjZTh9Sdk1oG+ZaMqgcsjF5z12nBevufZUpvcp+PcDPnD
 TnJtzhcBQRfj/r5k//eu1IWswQmq+RUkvUPJ5jWU9DEuZQNWGUenTNmlNcJgYCSm65wurUG0sHv
 Y656tAH5P3CIsd2MrTZWU/oKmXf8iSnB4Zh5sLgfdXRjcZElb5d6cU7p0JP6mFsYznR9rSRuB6P
 I7abElwCHmQPq4QPA5V7zV97hvq7jxTtPSRIIgr32bs1aXV/RUs6/4wqMQY8IM3EtOfCeHCptqr
 c9Xvs+bpNKoEV6PAtGLj0wTc41uyb50UMA47j2hFCQd/yWkuxJ6n0TsAGwRh5/ljiRn8nXpQlFv
 KJfzkMPvgFsoYQf0k1UO0jXz3SRpQ62DfG1BK8hj15LQzcVlNfW45uWqk3nLL8HHCmgNB9CRHPO
 jwysoGAIQu9C5fowWcg==
X-Proofpoint-ORIG-GUID: PJbgg_fjB313fyCYADl2x9BwCJJBxprb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602070146

Hi Linus,

please pull s390 updates for the 7.0 merge window.

Thanks,
Heiko

The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c9578:

  Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-1

for you to fetch changes up to 5ae76830c76cf38708399245606e4e07a33fe51c:

  s390/tape: Consolidate tape config options and modules (2026-02-05 13:02:48 +0100)

----------------------------------------------------------------
s390 updates for 7.0 merge window

- Drop support for outdated 3590/3592 and 3480 tape devices, and limit
  support to virtualized 3490E types devices

- Implement exception based WARN() and WARN_ONCE() similar to x86

- Slightly optimize preempt primitives like __preempt_count_add() and
  __preempt_count_dec_and_test()

- A couple of small fixes and improvements

----------------------------------------------------------------
Gerd Bayer (1):
      s390/Kconfig: Define non-zero ILLEGAL_POINTER_VALUE

Halil Pasic (1):
      s390/configs: Enable BLK_DEV_NULL_BLK as module

Harald Freudenberger (1):
      s390/ap/zcrypt: Revisit module param permissions

Heiko Carstens (19):
      s390/boot: Add -Wno-default-const-init-unsafe to KBUILD_CFLAGS
      s390/purgatory: Add -Wno-default-const-init-unsafe to KBUILD_CFLAGS
      s390/preempt: Optimize preempt_count()
      s390/preempt: Optimize __preemp_count_add()/__preempt_count_sub()
      s390/asm: Let __HAVE_ASM_FLAG_OUTPUTS__ define 1
      s390/preempt: Optimize __preempt_count_dec_and_test()
      Merge branch 'preempt'
      s390: Add CC_HAS_ASM_IMMEDIATE_STRINGS
      s390/bug: Convert to inline assembly with input operands
      s390/bug: Use BUG_FORMAT for DEBUG_BUGVERBOSE_DETAILED
      s390/bug: Introduce and use monitor code macro
      s390/traps: Copy monitor code to pt_regs
      s390/bug: Implement __WARN_printf()
      s390/bug: Implement WARN_ONCE()
      s390/bug: Skip __WARN_trap() in call traces
      s390/bug: Prevent tail-call optimization
      Merge branch 'warn-exception'
      s390: Document s390 stackprotector support
      Merge branch 'tape-devices'

Jan Höppner (8):
      s390/tape: Remove support for 3590/3592 models
      s390/tape: Remove tape load display support
      s390/tape: Remove special block id handling
      s390/tape: Remove unused command definitions
      s390/tape: Remove 3480 tape device type
      s390/tape: Cleanup sense data analysis and error handling
      s390/tape: Rename tape_34xx.c to tape_3490.c
      s390/tape: Consolidate tape config options and modules

Jens Remus (1):
      s390/ptrace: Convert function macros to inline functions

Julia Lawall (1):
      s390/ap: Fix typo in function name reference

Niklas Schnelle (2):
      s390/pci: Handle futile config accesses of disabled devices directly
      s390/pci: Use PCIBIOS return values in pci_read()/pci_write()

Salah Triki (1):
      s390/cio: Fix device lifecycle handling in css_alloc_subchannel()

Thomas Richter (1):
      s390/perf: Disable register readout on sampling events

Thomas Weißschuh (1):
      s390: Implement ARCH_HAS_CC_CAN_LINK

Vasily Gorbik (1):
      s390/kexec: Emit an error message when cmdline is too long

 Documentation/arch/s390/mm.rst                     |    4 +
 .../features/debug/stackprotector/arch-support.txt |    2 +-
 arch/s390/Kconfig                                  |   19 +
 arch/s390/boot/Makefile                            |    1 +
 arch/s390/boot/startup.c                           |    1 +
 arch/s390/configs/debug_defconfig                  |    1 +
 arch/s390/configs/defconfig                        |    1 +
 arch/s390/include/asm/ap.h                         |    2 +-
 arch/s390/include/asm/asm-prototypes.h             |    1 +
 arch/s390/include/asm/asm.h                        |    2 +-
 arch/s390/include/asm/bug.h                        |  145 +-
 arch/s390/include/asm/pci_io.h                     |    1 +
 arch/s390/include/asm/preempt.h                    |   47 +-
 arch/s390/include/asm/ptrace.h                     |   42 +-
 arch/s390/include/uapi/asm/tape390.h               |  103 --
 arch/s390/kernel/entry.S                           |   11 +
 arch/s390/kernel/machine_kexec_file.c              |    4 +-
 arch/s390/kernel/perf_cpum_sf.c                    |    2 +-
 arch/s390/kernel/traps.c                           |   46 +-
 arch/s390/pci/pci.c                                |   35 +-
 arch/s390/purgatory/Makefile                       |    1 +
 drivers/s390/char/Kconfig                          |   33 +-
 drivers/s390/char/Makefile                         |    6 +-
 drivers/s390/char/tape.h                           |   13 +-
 drivers/s390/char/tape_3490.c                      |  825 ++++++++++
 drivers/s390/char/tape_34xx.c                      | 1204 ---------------
 drivers/s390/char/tape_3590.c                      | 1612 --------------------
 drivers/s390/char/tape_3590.h                      |  175 ---
 drivers/s390/char/tape_char.c                      |    5 +-
 drivers/s390/char/tape_class.c                     |   15 +-
 drivers/s390/char/tape_class.h                     |    2 +
 drivers/s390/char/tape_core.c                      |   14 +-
 drivers/s390/char/tape_std.c                       |   32 -
 drivers/s390/char/tape_std.h                       |   45 +-
 drivers/s390/cio/css.c                             |    2 +-
 drivers/s390/crypto/ap_bus.c                       |   12 +-
 drivers/s390/crypto/zcrypt_api.c                   |    2 +-
 37 files changed, 1158 insertions(+), 3310 deletions(-)
 delete mode 100644 arch/s390/include/uapi/asm/tape390.h
 create mode 100644 drivers/s390/char/tape_3490.c
 delete mode 100644 drivers/s390/char/tape_34xx.c
 delete mode 100644 drivers/s390/char/tape_3590.c
 delete mode 100644 drivers/s390/char/tape_3590.h
