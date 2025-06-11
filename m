Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CED27FD6D
	for <linux-s390@vger.kernel.org>; Wed, 11 Jun 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650459; cv=none; b=ENLDuSGkYQB/CcbwyhJpgKn6PpjlDfFUnjl2xrQ294AxL/l1G3+vEO9tLjtmk/Pf03xY0vl6oXf0gkXU90dI9DnqV+/rxL+iqkeCsiiuSbRQJ7B1Fd6pU4EtMrcEhvYcNABwfUlf38SU6j9agIt2PqV/VucppA5QftLu/B11R0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650459; c=relaxed/simple;
	bh=nejhplaTdZiZHy884m0uhwlQuR16fa6uwH+vc9Zu6Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O1KS8eJuz6m9eqeP0hl72UeqYve0V6zUK4+CtqHu2ABmymGd5Jbe2K6rZ6UA4P3vM+7QLIuzI0nfRC6gDHyXxi5DhcFS1Zy+0NMzNzxtRar5I59gjrAOJpQWNW8BjHwu/1Wh0V88zBjODMqPqGoI/REwjQ/1uRhrUSTj+cIAGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCg50/vD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCg50/vD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749650456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=86lAKUaugisxsJw6kbp8uE6ypEOe0T34rLT2Yvon/sg=;
	b=CCg50/vDgHDL6zWQ3Od/TxdZamXyZyojkCZ43MedUavzOZljrub61vp3IDlJu13paVK66Z
	nE54x2Z5fHIQ2baNIcWZ1nPaDoydVBk+qlsH0xT5DIhQcHgT+ebVBVqkrnJsBNlkcu7b1e
	S9qBv00HakVYdtKCawyvk58mLUX0hcs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-L0ZW-uAtPsKRTCZM2Z2CVw-1; Wed,
 11 Jun 2025 10:00:53 -0400
X-MC-Unique: L0ZW-uAtPsKRTCZM2Z2CVw-1
X-Mimecast-MFC-AGG-ID: L0ZW-uAtPsKRTCZM2Z2CVw_1749650452
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8C921800366;
	Wed, 11 Jun 2025 14:00:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21D43180045C;
	Wed, 11 Jun 2025 14:00:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 0/2] s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Wed, 11 Jun 2025 16:00:44 +0200
Message-ID: <20250611140046.137739-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The kernel Makefiles define the __ASSEMBLY__ macro to provide
a way to use headers in both, assembler and C source code.
However, all the supported versions of the GCC and Clang compilers
also define the macro __ASSEMBLER__ automatically already when compiling
assembly code, so some kernel headers are using __ASSEMBLER__ instead.
With regards to userspace code, this seems also to be constant source
of confusion, see for example these links here:

 https://lore.kernel.org/kvm/20250222014526.2302653-1-seanjc@google.com/
 https://stackoverflow.com/questions/28924355/gcc-assembler-preprocessor-not-compatible-with-standard-headers
 https://forums.raspberrypi.com/viewtopic.php?p=1652944#p1653834
 https://github.com/riscv-software-src/opensbi/issues/199

To avoid confusion in the future, it would make sense to standardize
on the macro that gets defined by the compiler, so this patch series
changes all occurances of __ASSEMBLY__ into __ASSEMBLER__.

I split the patches per architecture to ease the review, and I also
split the uapi headers from the normal ones in case we decide that
uapi needs to be treated differently from the normal headers here.

The x86, parisc and sh patches already got merged via their specific
architecture tree:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24a295e4ef1ca8
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a141be3233af7
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cccaea1d66e94b
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e2b6a188625a2b
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9cc646950eefda

So I assume the s390 patches should go via the s390 tree.

v3:
- Split the s390 patches from the global series
  (see https://lore.kernel.org/all/20250314071013.1575167-1-thuth@redhat.com/)
- Rebased the patches on linux-next and fixed the conflicts
  and new occurances of __ASSEMBLY__

Thomas Huth (2):
  s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers

 arch/s390/boot/boot.h                  | 4 ++--
 arch/s390/include/asm/alternative.h    | 6 +++---
 arch/s390/include/asm/asm-const.h      | 2 +-
 arch/s390/include/asm/cpu.h            | 4 ++--
 arch/s390/include/asm/cpu_mf-insn.h    | 4 ++--
 arch/s390/include/asm/ctlreg.h         | 4 ++--
 arch/s390/include/asm/dwarf.h          | 4 ++--
 arch/s390/include/asm/extmem.h         | 2 +-
 arch/s390/include/asm/fpu-insn-asm.h   | 4 ++--
 arch/s390/include/asm/fpu-insn.h       | 4 ++--
 arch/s390/include/asm/ftrace.h         | 4 ++--
 arch/s390/include/asm/irq.h            | 4 ++--
 arch/s390/include/asm/jump_label.h     | 4 ++--
 arch/s390/include/asm/lowcore.h        | 6 +++---
 arch/s390/include/asm/machine.h        | 4 ++--
 arch/s390/include/asm/mem_encrypt.h    | 4 ++--
 arch/s390/include/asm/nmi.h            | 4 ++--
 arch/s390/include/asm/nospec-branch.h  | 4 ++--
 arch/s390/include/asm/nospec-insn.h    | 4 ++--
 arch/s390/include/asm/page.h           | 4 ++--
 arch/s390/include/asm/processor.h      | 4 ++--
 arch/s390/include/asm/ptrace.h         | 4 ++--
 arch/s390/include/asm/purgatory.h      | 4 ++--
 arch/s390/include/asm/sclp.h           | 4 ++--
 arch/s390/include/asm/setup.h          | 4 ++--
 arch/s390/include/asm/sigp.h           | 4 ++--
 arch/s390/include/asm/thread_info.h    | 2 +-
 arch/s390/include/asm/tpi.h            | 4 ++--
 arch/s390/include/asm/types.h          | 4 ++--
 arch/s390/include/asm/vdso.h           | 4 ++--
 arch/s390/include/asm/vdso/getrandom.h | 4 ++--
 arch/s390/include/asm/vdso/vsyscall.h  | 4 ++--
 arch/s390/include/uapi/asm/ptrace.h    | 5 +++--
 arch/s390/include/uapi/asm/schid.h     | 4 ++--
 arch/s390/include/uapi/asm/types.h     | 4 ++--
 arch/s390/net/bpf_jit.h                | 4 ++--
 36 files changed, 72 insertions(+), 71 deletions(-)

-- 
2.49.0

