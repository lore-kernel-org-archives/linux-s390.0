Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67D15DBB3
	for <linux-s390@vger.kernel.org>; Sat, 11 Jan 2025 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736574536; cv=none; b=A1dXVabdh3FlZFyuoP6nx0uccSUDojtBLk8+EjIjwF42ijWlosbpiUlZJMHXalWi67fLWBQVXz3USmnS/IjnRh1hDEBIhDeCxaeCeqquogCwgsF2MImash8aysoGWqFALw0s0sASL+AW9E9ULa4PYCdQKNENmb47Ing4zwSWYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736574536; c=relaxed/simple;
	bh=uM97L3kFdBC0qfkNcXXv1yRdnPDRHSZ02Y91r+QLIKo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DKVoqmFA+OjL7S1wumwfu0OuDRz1vPHdh2kltp662v1xP+s66HkZuGYGpLAxhCRSt65OIlJTtFR81rIS0Alch5d36oad6W5RAOH3ObTzFGwzBW/iMwHKZ7+MXCw5CM/xMOfGfKHO/clkFY9f1lRHE97KTM6axlx17oaSycAuyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=PcPhxeLH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="PcPhxeLH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso3559888a91.0
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 21:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574534; x=1737179334; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3P73rJyuNl3Q0nwSoWVJRyshylUCVEtly88Ev7msAUs=;
        b=PcPhxeLHRNfrrsKnVfazdoi2FDRBrpnbCOv2Q2vA1WiAMaUitgAZuEvReIMr0E/DBU
         +pL9hNB0jNSdeW21OzQ+W5lRSfBGKYdKrLW9ao0gGtGfy0eQSJq4dnKrXPXLCgrUwOJO
         nzSMVeGAijpeUBepYtZ2bz9DSmoEpAbTwS9v2HwcY7mkkmrpvgQx3VVCihyv2PdmT1uu
         0Gaq0YLP32Nc5LsG67mPAuBTamXNLJ4GX71boraBc/k7BZ1/nv9ZRvdtPnmA+hmap8Qh
         RYVqzbld2xOaY9HLByhIPGjprCAzxlE/bspncnSE8sJBKuJXed92DhC2aYwzFL8CcUcX
         gVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574534; x=1737179334;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P73rJyuNl3Q0nwSoWVJRyshylUCVEtly88Ev7msAUs=;
        b=gP76fm7UaTQvnmq9KSZnyLKFBvtehJpKgnA6GTCjynYXWkANj+6RiTIpwO8snKFqm/
         i+3kEzRPEWXScYmKfb9cukcoqEUtIq5omQEyaSShZ8XYQPZOy2/F3b1vIY20WaBtdetH
         cnqCIwfcFcdh3GinTjS6PJgL92IkKTwQVwW7Ae8IEabp3vgWXYj3w4NvOxoMGnBsSEx5
         sh3939B/dvi00f/lRVIYToZmm/+Ze8IavsL2XaMaJs0kyd7gw1kKViYElz2daG/9gwGY
         VjZtj1Zg+ehPb1SLatGT7VCGSEje9CCwaGI8x3yVYjVw0ESLUTa3zi6vqXlUe/MS+oJY
         irkw==
X-Forwarded-Encrypted: i=1; AJvYcCVExXvPmyftt3ZBdGanSRmN+F0LLiBSduXsYRPC33tUmYVdNnALl5Risuq3FZ2hbze4yJzsthocYt9A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fO0D9RduqF/Ma7JPsuNacaa3/XEmdU7z9L0NAmHozI0/StIn
	CTkcrAaZF2EITJR3xVgyGgYpcyxTHCKYRr6IKKOB0NyYbXuoZHcn837PeeLpI9g=
X-Gm-Gg: ASbGncscWOlFCEO3uOQHu86tjg6XSL0J7xQyIRisLHB1dYgS847t9Tt5YGHbbFyvqrm
	XJE2nj+/P0o6t9Y7YI8rXuzP/dru9JpFzfkIH70K2RWsIXKQiVtojYZ8LzYyl8bDz6NizMBCc2Z
	7EDo3dvFxtGJxCVkmQFd+qGG3oHMPUYeJ1kiI7/bm7TSoEkPznTWKnrcCSgS9nzO/2gXuYGOfsd
	Ggw6m80f/6GJGs689/l2W2Jpf3gW8Vr9xyCMaEbhLT16aJa9zvO5P/CFeo=
X-Google-Smtp-Source: AGHT+IHnxhywBj4CVIR5TvzIlJFphpilQTNTWugzFhTp+kcciB5abGLTfjWrtU8KJEUcfzvGCQC8ng==
X-Received: by 2002:a17:90b:538e:b0:2ee:3cc1:793a with SMTP id 98e67ed59e1d1-2f548f580femr19629798a91.29.1736574534006;
        Fri, 10 Jan 2025 21:48:54 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f1372e7sm21407345ad.83.2025.01.10.21.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:48:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/6] elf: Define note name macros
Date: Sat, 11 Jan 2025 14:48:43 +0900
Message-Id: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADwGgmcC/2XMywrCMBCF4VcpWRuZ3Kxx5XuIi1xGG9BWEgktp
 e9u2iooLs8w3z+ShDFgIodqJBFzSKFry5CbirjGtFekwZdNOHDJOAOKtwu1e0AjtNROaFI+HxE
 voV8qp3PZTUjPLg5LNLP5+vZcLT4zymitUUsQCryCozdDG/qt6+5kDmT+QQoYyBVxCrSuveMIO
 28l/iHxjeoViYK0dlaBssxY/oOmaXoB8zVRagEBAAA=
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Heiko Carstens <hca@linux.ibm.com>
X-Mailer: b4 0.14-dev-fd6e3

elf.h had a comment saying:
> Notes used in ET_CORE. Architectures export some of the arch register
> sets using the corresponding note types via the PTRACE_GETREGSET and
> PTRACE_SETREGSET requests.
> The note name for these types is "LINUX", except NT_PRFPREG that is
> named "CORE".

However, NT_PRSTATUS is also named "CORE". It is also unclear what
"these types" refers to.

To fix these problems, define a name for each note type. The added
definitions are macros so the kernel and userspace can directly refer to
them.

For userspace program developers
---------------------------------------------------
While the main purpose of new macros is documentation, they are also
hoped to be useful for userspace programs. Please check patch
"elf: Define note name macros" and if you have a suggestion to make it
more convenient for you, please share.

I added the Binutils mailing list to the CC as it contains code to parse
dumps. I'm also planning to share this series on LLVM Discourse.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- s/powwerpc/powerpc/
- s/NT_INIT/nt_init/g s/NT_SIZE/nt_size/g
- Removed parentheses that have little value.
- Fixed the code alignment in get_cpu_elf_notes_size().
- Link to v3: https://lore.kernel.org/r/20250107-elf-v3-0-99cb505b1ab2@daynix.com

Changes in v3:
- Added patch "s390/crash: Use note name macros".
- Changed to interleave note name and type macros.
- Described NN_ and NT_ macros.
- Link to v2: https://lore.kernel.org/r/20250104-elf-v2-0-77dc2e06db4e@daynix.com

Changes in v2:
- Added a macro definition for each note type instead of trying to
  describe in a comment.
- Link to v1: https://lore.kernel.org/r/20241225-elf-v1-1-79e940350d50@daynix.com

---
Akihiko Odaki (6):
      elf: Define note name macros
      binfmt_elf: Use note name macros
      powerpc: Use note name macros
      crash: Use note name macros
      s390/crash: Use note name macros
      crash: Remove KEXEC_CORE_NOTE_NAME

 arch/powerpc/kernel/fadump.c               |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c |  8 +--
 arch/s390/kernel/crash_dump.c              | 62 ++++++++-------------
 fs/binfmt_elf.c                            | 21 ++++----
 fs/binfmt_elf_fdpic.c                      |  8 +--
 fs/proc/kcore.c                            | 12 ++---
 include/linux/kexec.h                      |  2 -
 include/linux/vmcore_info.h                |  3 +-
 include/uapi/linux/elf.h                   | 86 ++++++++++++++++++++++++++++--
 kernel/crash_core.c                        |  2 +-
 10 files changed, 133 insertions(+), 73 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241210-elf-b80ea3949c39

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

