Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896738AC8C
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996880; cv=none; b=G8IVTOO3LXcPCwpjeCXRQnL8zlcRz+2wuPRNxggPwNUFD9p6unJ1Sfd3jHHxKFrsjQRDX1m7sp1hN52nzKVb6NFX6ErRRZLJ+re82f2VxV0x3qbZgAdztvhZwnbsWqQSJLFEBNVg6qh0XORAUe5oMUhbAi608ms71aV+adgqsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996880; c=relaxed/simple;
	bh=5S/lDul1AeWe/zpkVYBcMVyvypfgJpPJqKfEUHDxI7U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nbCbeAyTseRqSKGfhh3rdPl6Z7tUB5q7gycKVXS6SfE/74eEEZA3X/2Cj8G9GX4TvOr+20gIcj+F3aOQ2ylb1LAd1DPgkpW1eYZhLzaeiHtz65WdLeLfK4UH9qqCnKa0o6HuTvTqU1oFv9hEMWrH9/49W/U1XHc79fw1/PhXD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGuZzXE0; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGuZzXE0"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacf17c7e0so26048555ad.0
        for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 23:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785996879; x=1786601679; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vYXnFOSPBEsqMlo6qdtElP2t60AdKc92rixKtDYU8E4=;
        b=FGuZzXE0JC7khRMizw9SmJ8zCGgDrxMnJfHxS3VxJ3ZTj8Bc03zU8AtBsddDWUNzN8
         ZHrClf1R0IrxsHC0mQ261ngii3srHKjPHYVfswZVtZf/bAglH9dkX3/0CN69YlD6sY1a
         6X2o7LWbqXofAD5LkmpRh1G3NdWBY+ZgLheTcMjQKNe0meqWZibsgc4fGhi3V3PuOpRT
         nE+NOncIuPs4kXmu8I5K6CWMy2t+PD2ofZAWUwCw/7BN6sAbSDIwiE6M3tduQOOnJs4o
         YXDXxUzNbx0gNPmnAZNvg+T9Z8BWj2KWE257w0p7s32T708f0Tl/713HjHM9g6Or0cbl
         STeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785996879; x=1786601679;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vYXnFOSPBEsqMlo6qdtElP2t60AdKc92rixKtDYU8E4=;
        b=OCk0ldXY0HEysb2ruCm47yRVfs3jb8akwCfAr6qF8jsrduGfMs4fAbdEk4hSpkH0qi
         eVyWzSeRtYPvswt2yF9SXJMsCQQdpDqVRHPDlkR3Qm7rZ0lSWDk1zK9eO06yzkHdeoCR
         vwpmjyhlDdp7LJWkSgmYP3Mb+4wJAgt0HxaL7Vl74et0LszlHdXrVDDvchGiIKgp457A
         +bqOtvPdnyO788ZLq9YE54Qc4EIIrQOU8JDm2XOwBIIbumfMdMs+E5jMNEDy8opMUeE0
         gVZfnsW8xohEaZvA7nuXzcTEvVakfm5S7h3iTbq3074H4jguWBipsps648f9F0mxadYO
         V08Q==
X-Forwarded-Encrypted: i=1; AHgh+RpkYAPC10oWATfuQr+3/8UfmV+LztNs81IO9Tvesg1+BRxH0ctKt5ApsAskqnu0s2jfLxX0br3W0fIi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmm5BYIGNeTp55RDal5bbUx489i5Dx4pWCyeSCAA+swqyjR4nL
	wupPBOLtFkjT9wK/v8LoNO3lDIdtLMx9KjRXexEBFpFJrYfhPFlqQ2+K8c/+s0mgqwxWR2Jh6Zg
	xispD6JmBUw==
X-Received: from pjbct6.prod.google.com ([2002:a17:90a:f586:b0:383:bb4e:85a5])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d52:b0:38f:23d6:b4ad
 with SMTP id 98e67ed59e1d1-3903c5433damr13479620a91.8.1785996878609; Wed, 05
 Aug 2026 23:14:38 -0700 (PDT)
Date: Thu,  6 Aug 2026 06:14:13 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806061429.474992-1-wfelipe@google.com>
Subject: [PATCH 0/3] init/Kconfig: generalize config COMMAND_LINE_SIZE
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-arch@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Wilson Felipe Pereira <wfelipe@google.com>
Content-Type: text/plain; charset="UTF-8"

[Note: Resending the full series to ensure all patches are delivered with a
 unified recipient and CC list across all mailing lists.]

This patch series promotes COMMAND_LINE_SIZE from arch/s390/Kconfig to
init/Kconfig to be generally available to other architectures.

In some use cases, such as netboot kernels, rootfs configurations, larger
initramfs setups, require larger sizes. While for embedded workloads, it
can be reduced to save memory.

Since COMMAND_LINE_SIZE can be larger, it also makes sense to allow
INIT_ENV_ARG_LIMIT to be configured.

Wilson Felipe Pereira (3):
  init/Kconfig: generalize config COMMAND_LINE_SIZE to all architectures
  arch: use CONFIG_COMMAND_LINE_SIZE across all architectures
  init/Kconfig: make config INIT_ENV_ARG_LIMIT user-configurable

 arch/alpha/include/uapi/asm/setup.h      |  4 ++++
 arch/arc/include/asm/setup.h             |  2 +-
 arch/arm/include/uapi/asm/setup.h        |  6 +++++-
 arch/arm64/include/uapi/asm/setup.h      |  4 ++++
 arch/loongarch/include/uapi/asm/setup.h  |  4 ++++
 arch/m68k/include/uapi/asm/setup.h       |  6 +++++-
 arch/microblaze/include/uapi/asm/setup.h |  4 ++++
 arch/mips/include/uapi/asm/setup.h       |  4 ++++
 arch/parisc/include/uapi/asm/setup.h     |  4 ++++
 arch/powerpc/include/uapi/asm/setup.h    |  4 ++++
 arch/riscv/include/uapi/asm/setup.h      |  4 ++++
 arch/s390/Kconfig                        |  8 --------
 arch/sparc/include/uapi/asm/setup.h      | 10 +++++++---
 arch/um/include/asm/setup.h              |  2 +-
 arch/x86/include/asm/setup.h             |  2 +-
 arch/xtensa/include/uapi/asm/setup.h     |  4 ++++
 include/uapi/asm-generic/setup.h         |  4 ++++
 init/Kconfig                             | 15 ++++++++++++++-
 18 files changed, 74 insertions(+), 17 deletions(-)

--
2.55.0.654.g21b8a5bc05-goog
