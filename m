Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9561F03CF
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254078; cv=none; b=K481tUTqQw9wuovaOSlLavN9LoLpXBMgaCwma13lMTtxTCHkwz2eOcf0Xh0C00LlCvzJdOtkPnt1lGLjUMfpgofRx0UVWICY62AWkvqtJWW6dSXrBaY6wROGeaGhFsY2USu4irK2hfm6uUzm3kh7Vk2LWon9XYA+OWdwAkWKWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254078; c=relaxed/simple;
	bh=Oduf8yJfn6BPnkdQYS3faalrxm2ycKrnWGoNvF+FQtk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ALPRoKPlMlE2g0cknYMHH13lcYubKvimfSDAwKhMk07UPaJ9UrFdNzWXxDH963spmrzx01Te7FUyJOkkca65DLfbLLJU6WSEqLP9fb7jj2JZ14NtIqIzhuG57EgmFe5fo76zgi3h6/QFU1lPmefkZRLjHcwQ+HOzUzloV12wBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=CQTrywj7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="CQTrywj7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so178323765ad.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 04:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254073; x=1736858873; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=opIuyGFUTzWuwcM2pYQXlXkOFxHji1aKoxh7XPTxYrQ=;
        b=CQTrywj7pfsrB6zy2oh/C98ue+ctVi3i8Xn/h6DpHC+vQBzKYDkpUlqGtKPx+9EtJy
         KYGEcDeA15r7V3uurpFft3VnJ/eLmKvbRZA4e2HVDwJRc5kY4+1QsfngNmJi9rXh3iqC
         ha0VAAUkDnm8RO2DktEEMAH1tZb1JLyuOd8kMrquf5PWUPn0mGE8QmCOSZRQTQE9BsQU
         SxArSiLkw39ErzsJoZAZbm9HeM66k8kfLlUJX8jXMDlXBCVgajp7qHug450zqPuu969m
         Fcw6HhN+iGfNzVU5eDh38rCqkG30PKUPmKzeCSwYDjGeSyKPO6kqPnHvILcaODD//qqQ
         CnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254073; x=1736858873;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opIuyGFUTzWuwcM2pYQXlXkOFxHji1aKoxh7XPTxYrQ=;
        b=nKW3x0pZROf3pf7FTfNiwQXqzVhBzAcmuGJsuqAXI1AnjEvlQmdqlYYPJuO8r8TBeF
         v1RhFTH4W2N9LBhvtak7dGkCqnatNuipHcTTeWvu/GPe2kNE+qdigystpWdx6Ol7gaUK
         BiNyDWY7pNKqyT6wRRNFZpogbhXz6yxef3L1b0YrMnaHWWY7k4gxJHihG9iG2f6MtlQb
         ZXSKHC96X7O8cw2Avtc1Ea6Vph4ElRRtSRO20s5nhGHRSj2hqtgQRXjFJ2Am0tyVKfvX
         8wkCw6TwO1yZUbE6ct4y0QnN4sXVoh7BRd6tPvEk9ayGyONT7gw2BlS5mCDfS1Z1zfU3
         7UaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsk9EXY54E9WVBSznRvogJ5baCgWl0G2An/iIFM9TYbuQf9Ep/1AX4Zh2FpL+w1/ujj97JIv0/aVUN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bBctsdKby4ImtGmaOR1sPzfGAIGh/zKpvit1PFA2QAM1mfTG
	9HxMiZKWJdgabvzirMHmAaqC/0sNw09Zp3mEa2+DOSXsOyIDr8k0wC/bF4lQDtI=
X-Gm-Gg: ASbGncuwMBQDpk8vSx4aMQRW96eJG7QDRfx3kGufpsz3mac8fJoecEV/bZshnFiPlwu
	2nEdoxVeqdSkPg4fifjAv3QSVLTOvi+rTOxV4dHsrk21l0QA4YhvpiB+azNJPVNqayYxpr1robm
	AuYG2SFHxzUMsWtFu8AZuS96kgCQ3zI/LIgSwA382VB2q8XXiDqnBP8Bw6Le6603ugx+FkLvQ6K
	YOCt1HGOI8/tKBpHu/iIlajjo/NvblGk5wPo2491ajSZfaqWhXYT9vzTNU=
X-Google-Smtp-Source: AGHT+IH/TI3sUb6l2+b2WaTSh1evq6vZuS5S4szn4UoWwy5hsMxR0UzHoKY9BZVjFfB8co0JCgCCAg==
X-Received: by 2002:a17:903:11d2:b0:216:2f91:92c7 with SMTP id d9443c01a7336-219e6e89278mr972540505ad.12.1736254072686;
        Tue, 07 Jan 2025 04:47:52 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc972b0dsm309970895ad.112.2025.01.07.04.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:47:52 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/6] elf: Define note name macros
Date: Tue, 07 Jan 2025 21:45:51 +0900
Message-Id: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8hfWcC/1WMwQ7CIBAFf6XhLGZZwIon/8N4aGFrSbQYMKRN0
 3+XVj14nJc3M7NE0VNip2pmkbJPPgwF5K5itm+GG3HvCjMEVAIFcLp3vD0CNdIoY6Vh5fmM1Pl
 xq1yuhXufXiFOWzSLdf36qDc/Cy54bcgokBqchrNrpsGPexsebA1k/EkaBKiPhBx4XTuLBAfXK
 vqTlmV5A7A3TXfMAAAA
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
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
      powwerpc: Use note name macros
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

