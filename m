Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E9422F831
	for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2025 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920118; cv=none; b=W3tX328ZeXbIexZYa9xGodTVcy6quoaIt/ywL2+7QbbFTELjoH1pZRDqP734BsDtRyTazM+YzIy7WjslkLBg9ySV50CdTBXfMG4lQ7lVtMDLxmPzR3MyjlV6xMC4MQpVtXfAEYJ9D+2Sta468pv/pWeIDpBAefYM0/nwU1zFCuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920118; c=relaxed/simple;
	bh=xnkO8PQjNpwy4PDi1l9g+TNSCpCBd6V2r9VCEB7db0I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f6TnVpDYB9ePeKYTwpnFPJTO9FJ2K3ZLaz+gHE6XIvyLxc5fC66MpihOe56ICCxohIyUwD1kVDjHLFDs5hvXVFp1KoRtl4Q2scFO3WRd1F9qtFGSFC/DhZrrBVtVgDu9j0mPfgiUNQvV8dy9HKtcSjitzMsDxyPYyNsm3ggr00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=vEk1C+PR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="vEk1C+PR"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso8337725a91.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 21:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920116; x=1737524916; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Akn62yShjkzTVW+wH6ehtLyqM9iw3YLFKJEmmviG+rI=;
        b=vEk1C+PROexGgq8LQMWb2tCn6sPR+OLrX0XQZ8HcJyl7BXdzQdHoQci6fzpm6/8F3A
         6jXwFEg6/uEFYd4KzlaVooV7UhWS7y8h0AtRMpsrtMxvdhUHpexqCG1retlgIcPtVG0i
         XLezrWJRePODywIFzFvBQ5ecH27oT6dqFspkMvfb5Ghdb0hB67gPTzX52aGA63V/tHEL
         hHmWtfGfR+SZuao7/JA9yjPx5v12T0pfeeeMPJMUr5+4ppows0N9QO43z3FpRIg+SIM9
         l37YJFGNRuiyc+v+LFf23LQr5ihfkSsxrw5sx7IfBn8969JcIyLhYHmlxqU4yTB/eMs1
         0Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920116; x=1737524916;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Akn62yShjkzTVW+wH6ehtLyqM9iw3YLFKJEmmviG+rI=;
        b=wuvznmQMeUY996JJRu0AjktVCJVJJRbQ5xpLZisSQM2czS4vATeUtpuuOorZJFWAVw
         6+Qle2yyuh8rb6jjQiDx90DowL4Lj7aSUrc0jfZzJXFCWWRBWP33uanZVDQOfXpyJCbi
         3kSrt0H/zl2JtHiRgMIPc5gk394/SY9ggqxnaStICni5gVi+SLkwmnJAkK2wTcKKvQJ3
         4SutFt+x4wa6sfOiOUZxiZVH/JMY1H0Zw1eBilrhBQqvRAejkd64LwwT94+7bcetObQ7
         nJQ5oZAKFLOjmKDw/GfX1sMIgRCuzrl5GwJChmxKKoRWI0isLf9J1SKz/rbtqNGACs5U
         ChEg==
X-Forwarded-Encrypted: i=1; AJvYcCUJXaH2Mj6lHvOpUXtmBDLox0gzCCuL6XAet/VlIIRPTSQvEcPJWkbSgXlE0zhqL7AJOlUdT3L4n6mr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DcKbNx0Na7tBIiSEVISNfTt0LCMWe/QspQLSZSmXmEUoeq0j
	0zyaqptkDNDibuPCOkB5C7sY3PTDyIr4owFsxpDXMkkt3g3UP3q1YEXjUHgzh+4=
X-Gm-Gg: ASbGncsYF5cJZF3Wu9xB6ufaRsREGwTyiLacoLw17SSyXqfqEsmYe9IbSGYVbeU7cIu
	mWzUOQ6P/Ba7ddcALPQ8ypNKYDxHwxsBeUxysi6o9r6usU7Uxzy+/JM2iXnZHcfiqxjfadmCfxx
	qocX1GrAv5flax/ViExLYocgHeUlvYYwmrCg8zOL3b1J2dXExMpWcO8u7+xH7Fhp3evRI0VP6XY
	1hznQESab76EXnuhfoXl5dDuHavo5onSbuo0o0yUtx2wkkTUQVpG/vDhmM=
X-Google-Smtp-Source: AGHT+IGTAFr6fQ9a6YArcK/8amGmkIoCg+M7qyB/EhAZVK1D/0q1h57yniAmS1nzzXQhV2aOnFsX2A==
X-Received: by 2002:a17:90b:3bc3:b0:2ee:bbd8:2b9d with SMTP id 98e67ed59e1d1-2f548f75de6mr34075229a91.34.1736920116365;
        Tue, 14 Jan 2025 21:48:36 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f72c1cb28csm504577a91.21.2025.01.14.21.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:48:35 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 0/6] elf: Define note name macros
Date: Wed, 15 Jan 2025 14:47:57 +0900
Message-Id: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1Mh2cC/2XMyw6CMBCF4VchXVsz04tYV76HcdHLoE0UDBgCI
 by7BTTBsDyT+f6BNVRHatgpG1hNbWxiVaahdxnzd1veiMeQNhMgFAoETo+CuyOQlUYZLw1Ln6+
 aitjNlcs17Xts3lXdz9EWp+vXCz37Fjny3JBRIDUEDedg+zJ2e1892RRoxQ9pQFALEhx4ngcvC
 A7BKdoguUb5gmRCxninQTu0TmyQWiHEBamEnDwqLCwEH8wfGsfxA3RS27E2AQAA
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
Changes in v5:
- Noted that patch "elf: Define note name macros" allows removing
  duplicate definitions of note names.
- Reordered NT_GNU_PROPERTY_TYPE_0 to precede notes used in ET_CORE to
  show its not specific to ET_CORE.
- Link to v4: https://lore.kernel.org/r/20250111-elf-v4-0-b3841fa0dcd9@daynix.com

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
 fs/binfmt_elf.c                            | 21 ++++---
 fs/binfmt_elf_fdpic.c                      |  8 +--
 fs/proc/kcore.c                            | 12 ++--
 include/linux/kexec.h                      |  2 -
 include/linux/vmcore_info.h                |  3 +-
 include/uapi/linux/elf.h                   | 89 ++++++++++++++++++++++++++++--
 kernel/crash_core.c                        |  2 +-
 10 files changed, 134 insertions(+), 75 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241210-elf-b80ea3949c39

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

