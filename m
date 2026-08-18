Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02F37C927
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095045; cv=none; b=qghS/eJpNjoFddSsQ6F13IiRG/LdGjkatwB66Vd0UbM53lWa7oQYWwooWO23js08Q6i6zdJ5CUBdPVaXX2UYqketrFyIA/V/4jIgkwnSqILlOJHB309Gmpfd8+pR2lc6MdPOhV4EAWlj8ekiPdGsACNjGRkxIX+zQ/UvDCAmbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095045; c=relaxed/simple;
	bh=uO9nDqAz7YG3W4fAtHpBP/Sey5BPPWi/cU3vDu2WIPM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UcQyof0i/p034kpYuetJuiQoEPy3v6KXigkv3T7h01zTaCbX97QMHsWJHdJOroaxY71EITBLrf5c4xiq4ZWK9CbCr6GxTqdz7FxGdq/myGfWD/I3ZixDm53LBdiACHuunDWg76sglwBPX/qgotE5SU6ebxBLpUgzVZ4veN0ohKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxrNOKy6; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxrNOKy6"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84fb5376cb8so472318b3a.2
        for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787095043; x=1787699843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Us4VG+LG3CItnApG3/Giy5h2nvbYWbtv9395p9c5DHg=;
        b=HxrNOKy6ntxgjC9mBeV3lApm3UKT8XmAjqs7rCSQYvsRVVII/gpUBOAfUi9F21/5eu
         9MfLVDhUSahHhcFqe4QzaG0eYsidAI8nb3e2MK8/aroGZ7hoWw55KZzCV/wRKqtZiMry
         DLrAyRoTSLsehnX1mBqo/VIQPquY/1IUOc6jlOQZWqjeYzTB96itU4iWJopUUmgT2u4W
         GxDbuZDh05OrG9AO6L/UwkWC0uBftf2qxTDbj9l0vEG8nkKC2Awn4acR+aWCaIa/kjx8
         Qn/oAxn8R7uud+s3EAD0Jg3rpKZaKygajXwdXHkpwzO0sqYYUBnT8kIbZwcR/7sKm/F8
         +9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787095043; x=1787699843;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Us4VG+LG3CItnApG3/Giy5h2nvbYWbtv9395p9c5DHg=;
        b=SuWZQHnjjfi1WPuW02S/AFrBUj3mKYGCF8CCT2Wu+8vanMmphnvn6c4huvBlUgx9wH
         9q0Xrm4JdsVmUHaPJvVZ1ekYI4hycJgfqduF1pzQBon/3vcnTOOopmZ1v8Ccu74ruo+j
         OcO9THwPI2bunseyiYgScPLI23HVfAfriUH6KfGboN/xEw7CVd4obwz7LKbP+nJL0kij
         D4JVvSJaAiMN1Il6yYezLBjFD5gPw3w4n9EQUiZrTgrXTGrwRTJn3GbF9PFL4soYF60i
         d4cbL0qXgaXo9bQ6OOu8juQnQ2XGvCYxGGW8iPQQYzEMOTfH7pS7/hVtAM4Pq6SqPnLp
         nWEA==
X-Forwarded-Encrypted: i=1; AHgh+RpURYLuaePmGR2tduBldyGrSgwouh6VBet6mGEqGLngLINyZsG0Win8T61r+ksBX6uT6ag++mXXvQRF@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEPWTDtLTrr0QJm5YXhdwilHqmtnYAVgwQ/2wawGAuSbGt6Wc
	KwfaoNZ8uisp/gv+9UUen4GntqyJqfvNOHNKi+WHiVeB+As/+dq+kCTvCsKFmS+RA71jUzW30el
	x9ALss8aP3g==
X-Received: from pgiz6.prod.google.com ([2002:a63:c046:0:b0:cbe:e4f1:a597])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c8c:b0:84e:2722:5d9e
 with SMTP id d2e1a72fcca58-851d38399cemr351833b3a.1.1787095042948; Tue, 18
 Aug 2026 16:17:22 -0700 (PDT)
Date: Tue, 18 Aug 2026 23:16:31 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260818231646.804507-1-wfelipe@google.com>
Subject: [PATCH v2 0/2] init, arch: make command line size and init arg limit configurable
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-arch@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wilson Felipe Pereira <wfelipe@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch series promotes COMMAND_LINE_SIZE from arch/s390/Kconfig to
init/Kconfig to be generally available to other architectures.

In some use cases, such as netboot kernels, rootfs configurations, larger
initramfs setups, require larger sizes. While for embedded workloads, it
can be reduced to save memory.

Since COMMAND_LINE_SIZE can be larger, it also makes sense to allow
INIT_ENV_ARG_LIMIT to be configured.

v1 -> v2
* Squash the Kconfig promotion and architecture header updates into a
  single atomic commit.
* Replace Originally-by with Signed-off-by for Maciej =C5=BBenczykowski.
* Add architectural range constraints for ARM, M68K, NIOS2, PowerPC,
  SuperH, and Alpha based on hardware, buffer, and stack limits.
* Fix Kconfig symbol for PowerPC from POWERPC to PPC.
* Split pre-existing init/main.c logic bug fixes into a separate series.

v1: https://lore.kernel.org/all/20260806061429.474992-1-wfelipe@google.com/

Wilson Felipe Pereira (2):
  init, arch: make CONFIG_COMMAND_LINE_SIZE globally configurable
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
 init/Kconfig                             | 19 ++++++++++++++++++-
 18 files changed, 78 insertions(+), 17 deletions(-)

--
2.55.0.737.g08866a6d13-goog
