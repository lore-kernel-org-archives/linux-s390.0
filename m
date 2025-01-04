Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9414F117
	for <linux-s390@vger.kernel.org>; Sat,  4 Jan 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736001526; cv=none; b=qc1fNRl+FF674U68z+gBaqMkqDU7ifbVf+DsHtcXm0ygGLE794rG5NGkjGPazEOkyb/DPLqQ8ffl4S/A6MqWHFccrkD38NOqr5hMlf4TvJRG4tu8aByMv+SXHNk2GarItU5BnOti958K78mrLPSuRcRVsHG/9SoLnkPGNsWN+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736001526; c=relaxed/simple;
	bh=Gq6ydFgeBl/1zRUwsZHuVT4HBIPZZ6XiTYjCRb4+TC4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hxjOLJwyA2tB2LqDxgUWARNPTMmg+7QournHS906g6HWcchGOHTlcGC8R5fPhaAbR3LRkRhyiBReR60yIpV7ElRmU74QuQq9Ptl/O6xk9Qmy2UWbjOieI6pbvyNuD078fWwDdAku4jjChaxj3PnrDbwK5uy8IEcMSYu2gBnhO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=xoRIyYIj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="xoRIyYIj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2161eb95317so189356905ad.1
        for <linux-s390@vger.kernel.org>; Sat, 04 Jan 2025 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736001523; x=1736606323; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKNiV3QEEiOj1Le3vlBLmpRmhzkmvu5zT7BlJh3wiAc=;
        b=xoRIyYIjl7xCZLZ3P7AMHpyHfEDEEQ/3FtKlCII/Ew0+qYzaXr9D8m0Pg5ItVGr9FK
         oL3bhq2yGQRqyi3ZIv4fr6jZjjk5QbsoQAWEVgOwSAMjB+zgZ06grJXb6CNsc78U0+9f
         qO4AtY6hX4pgsK5s3IXR9D7fhEgdH+LiUJ/lW2KEJU1IXgs9AwfmmQ5KcHi2Z0AvxWGE
         HWHGiHruwBB0iDyqw+Tu4+tp4TGfEJe8CpkS5J0P7YlsfZLvpCnFJK1Fn/HMkgcaXGxv
         /eYoHVUCxz2Ih/7IYpMjNjv7RmjwCGLLwbS4mUDt2MSlAw37qMxJ1WdZ5Zsmy74VTZDx
         N9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736001523; x=1736606323;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKNiV3QEEiOj1Le3vlBLmpRmhzkmvu5zT7BlJh3wiAc=;
        b=UKaVhHQYCUpAqwDXjnsqwl1Spi2aqx3fCM4v252U132E3xq64oAFiKbEQgudqtSq9+
         feclzu9wrJGDbCFz1nNSGx+s+7i9smLG8iIrQOKVG5iLNMURK+tjjMIGY+PQT8laTrtz
         QY/i9DrPi2VDDNzjv94cQQyoy051XJzTPUpeKj8RuIM8rNv4Wx9ooCUmAAb6Mvql8HhX
         LoVcZeoQzh337MC9sUfCS3jpRiYTo1kO1jPdainxk5UAhaVIB1/cVbbTPDYTaNHN0J11
         CzxKd2Mj77S4W6sXauyr0NAgDPBf/l5lZ0HBolKFLvNcwDDBV7Xci0H2+UFwTAqsqzRE
         hsUg==
X-Forwarded-Encrypted: i=1; AJvYcCXPThyr7tiOJhbr8InC6a4eYaSCeX1VbLp38EFB0cYUj1ME8Gvhsss3d3h0pYFjoqbtIwhQZLnChmIZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3z5AsFsCJkn/6BN9gEF4QdKr2alx1geJBE2ngZ2lsQXK1Te0M
	S57wE1HHi4HOlDfJ1cn0RcSLKLKnGYrU3m3DVy3ky1vCqJqSZGnPNrbvwOZvfBA=
X-Gm-Gg: ASbGnctASJChS0WTWw0BymvqQRdkZ1buqLvYMdi179uSLiooN+HPYdV2y3fkSarKVK5
	ebKwnXI109EPRSaXNyAczoTmysv5yyAlHhuTcaQ3zFUA8jgaD517Tlro8XsMVlzQE9zDms04OnU
	tdPjhdudQkMBBaGqfMLbnFGSOhpT4QWmca/ZNZAIt8w5VkvjkeLU+N3m5BHEjHaCX1eH9TctAwt
	PlP2wv9d075h3tqQLiaMEuihvN1K4HJrfxrHeTHOhOzQZIFPRsF65KSowORrEs=
X-Google-Smtp-Source: AGHT+IHMKqIuk9Mp4P+qfjslbof1yC0x6Ct9CbXfed2Znwm+wkFLa5rTAL+cuIXWXtg5bkhTzZKJyg==
X-Received: by 2002:a17:903:2286:b0:215:b087:5d62 with SMTP id d9443c01a7336-219e6f1483fmr809248225ad.36.1736001522852;
        Sat, 04 Jan 2025 06:38:42 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc97182dsm261833855ad.82.2025.01.04.06.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 06:38:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/5] elf: Define note name macros
Date: Sat, 04 Jan 2025 23:38:33 +0900
Message-Id: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOlHeWcC/y2MywrCMBBFf6XM2kieaFz5H9JFTKZ2QFNJJLSU/
 LsxuDyXe84OGRNhhsuwQ8JCmZbYQB4G8LOLD2QUGoPkUgspOMPnxO5njk5Zbb2y0J7vhBOtvXI
 bG8+UP0vaerSI3/r3pel+EUywk0WruTI8GH4Nbou0Hv3ygrHW+gVYO/OllwAAAA==
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, devel@daynix.com, 
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Added a macro definition for each note type instead of trying to
  describe in a comment.
- Link to v1: https://lore.kernel.org/r/20241225-elf-v1-1-79e940350d50@daynix.com

---
Akihiko Odaki (5):
      elf: Define note name macros
      binfmt_elf: Use note name macros
      powwerpc: Use note name macros
      crash: Use note name macros
      crash: Remove KEXEC_CORE_NOTE_NAME

 arch/powerpc/kernel/fadump.c               |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c |  8 +--
 arch/s390/kernel/crash_dump.c              |  2 +-
 fs/binfmt_elf.c                            | 21 ++++----
 fs/binfmt_elf_fdpic.c                      |  8 +--
 fs/proc/kcore.c                            | 12 ++---
 include/linux/kexec.h                      |  2 -
 include/linux/vmcore_info.h                |  3 +-
 include/uapi/linux/elf.h                   | 86 ++++++++++++++++++++++++++++--
 kernel/crash_core.c                        |  2 +-
 10 files changed, 111 insertions(+), 35 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241210-elf-b80ea3949c39

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

