Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567432D2488
	for <linux-s390@vger.kernel.org>; Mon, 15 Dec 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804225; cv=none; b=FVmyWnCLB0RTfRkhaqV/puqPfGohT+iUdwReyIgGyDHMEY2aWVX/GBglv3ksTWmVP6na+oxxaJyK9Kx8ybycu7AAWeoNXh53xsPoEtAL0sd28uAbpa71DLGPIhTTwWMRLHjwKP0E26hMjggQWrsDgXcIsjTkbsSKzikZIswUG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804225; c=relaxed/simple;
	bh=BM/PVPr4BUoxQ98yubiOVvCOB+UxL8diHIpcrjRnF1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnePyMDe99WqvjIx8pYKWMxags0Bx49ZZLO0V0WdpDTnDIL606QozoovyNbdg7LidOImGmt+9GOMbqUZfsmuK1excYunccwRgl3kx6ICaiB4prdC9XX/dr2TgFfjC08vhNqzYsEUKozjXJpQDc0WiV4ADsoJj+QfEICfwUqHwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loCxvn4p; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loCxvn4p"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso5191864b3a.2
        for <linux-s390@vger.kernel.org>; Mon, 15 Dec 2025 05:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765804224; x=1766409024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM/PVPr4BUoxQ98yubiOVvCOB+UxL8diHIpcrjRnF1s=;
        b=loCxvn4pp1giegHZGB8fCdyZonBe6RjK89pU1bnxQ6C2Dg3U2MZ8QEBBuUXr6fuGVP
         O8ysMPDkY6cIgArWwKqjvO8OhyLB+myMY7TaiSSujqdOETR2q02gAxg5AFZOnKQhqPri
         z52wlgpRd74s14zGeJUjFCbgib5kV4bZTlJxawaDmpJiVn0/MWNRAGArN4H/OmYwh2ZD
         TxBVUB4ie643IZnMsU2ypXWuA8+urx3QzgF/Tkq/lAlwojVMImCBu2G4GPfOE/ISY1nz
         q+HoEE8GhzvfSd/rM+42L4Q3QRNexxVo6Q7zNKpG6H0CzCDXqfgqz8ZDsjk8w7rnNoLH
         5vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765804224; x=1766409024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BM/PVPr4BUoxQ98yubiOVvCOB+UxL8diHIpcrjRnF1s=;
        b=mU6qmdi1uH2BE8UMsAkh2ol6vA45yglgCNVNFsU2SsJ7Gf9d3ngEZtI8RcyIrit6yq
         vo4LCXqmd7UDVstvoMWxsnR0A+oa2Xn3SYoDhHfTHG1V9QWapaYmGDCZuIgyi0TYQcHF
         eCdV0xI5LNEKg5PqQQ6/Kafl0CLAtv7hZjOiOj0E0dC6pAVglcDGA5g66KK4//w6GjAx
         lebxcsk1yQKMJQxbiXHqfLX386rA2qqUosln9xQYQvlUyCon/Pt+k69y9DWKAg2DigqK
         VDjjmOPSsFV93AYYpPhzxARli5hiSB3DoeQuhC+Ol9qpi4f3oA5SFfQ4YWt8EuYdM5vw
         2f5w==
X-Forwarded-Encrypted: i=1; AJvYcCUWyBUsTAWMT+C/EDAX+X2QXsfsU/30w9D9oMtlR6IvtSZuibOavQlEkdzQm3fmbLAKsL0KYpYbspc8@vger.kernel.org
X-Gm-Message-State: AOJu0YzauQyGDOHxCDDdWgiIPK57Nj+fNssTg12rIIdcqbmNhn/yaqfB
	xzl7mMB8ITYP9/6dE33Y4LuSk8TpC2yoxFCy7eFqCJZdvBCGE5ggsUrG
X-Gm-Gg: AY/fxX40GZY0yGL8liks0aOtO8/Pujy92nysA5WvlW6yCE9pD+Xq53buwOoLsp36ft0
	h/W431Fh84xl46i/XlkiMPT7fAHaOXdCbW5kNWZPfeGThqjAveiM0hEI9z5serjIF0Di7/UtxAU
	KuGbqE27ZcbSkU/ECiiQXdYywlXHEXI0cyfvaq7Hg8+phAFsxzfFOQXjX6uiTBhpk0KOHyyKaAu
	DRq+NV/pAQORJ6fK0VEc94o/CQPQMcsszZ4W64X4XVME+PH0jYxLWuiRYe7KTD7WGdVtMFWIxYY
	DDxPSdErlhrLT9XQ6ZbBZdJ5tDEyf8B9umD+7/ACb9wQF5sM5mwatmIQYyX2hth78R0mnFxK+eB
	N3guSeuem1hx1iLy/fOFiw6627IJkOzGocN/YGwwe8LBRSrZD2zPIMeqnQlQcOq6eSNEeeKNzNH
	BzVp7WrSpXvZKGDIgKobyWjs/d0XycgHg=
X-Google-Smtp-Source: AGHT+IG3VwDpkA1WmQaMbo19+RTJgzIpgUIvYpPpKARDCY4wBFScDx5yKp0n9nH8m2HxqssodBKlAQ==
X-Received: by 2002:a05:6a00:b904:b0:7b9:d7c2:fdf6 with SMTP id d2e1a72fcca58-7f6679326b4mr10674588b3a.24.1765804223544;
        Mon, 15 Dec 2025 05:10:23 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c22848a7sm12761222b3a.3.2025.12.15.05.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 05:10:22 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	peterz@infradead.org,
	riel@surriel.com,
	segher@kernel.crashing.org,
	david@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anshuman.khandual@arm.com,
	aou@eecs.berkeley.edu,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v5 0/3] Optimize code generation during context switching
Date: Mon, 15 Dec 2025 21:10:01 +0800
Message-ID: <20251215131001.1021-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214190907.184793-1-qq570070308@gmail.com>
References: <20251214190907.184793-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is some additional testing information that needs to be
supplemented:
1.
On Mon, 15 Dec 2025 03:09:04 +0800, Xie Yuanbin Wrote:
> 2. Testing config:
> x86-64: `make x86_64_defconfig` first, then menuconfig setting:
> CONFIG_HZ=100
> CONFIG_DEBUG_ENTRY=n
> CONFIG_X86_DEBUG_FPU=n
> CONFIG_EXPERT=y
> CONFIG_MODIFY_LDT_SYSCALL=n
> CONFIG_STACKPROTECTOR=n
> CONFIG_BLK_DEV_NVME=y (just for boot)
>
> arm64: `make defconfig` first, then menuconfig setting:
> CONFIG_KVM=n
> CONFIG_HZ=100
> CONFIG_SHADOW_CALL_STACK=y
>
> arm32: `make multi_v7_defconfig` first, then menuconfig setting:
> CONFIG_ARCH_OMAP2PLUS_TYPICAL=n
> CONFIG_HIGHMEM=n

The above is the config for performance test, when testing for size, the
config is: `make x86_64_defconfig` first, then menuconfig setting:
CONFIG_SCHED_CORE=y
CONFIG_NO_HZ_FULL=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y (optional)

Enable CONFIG_SCHED_CORE and CONFIG_NO_HZ_FULL to test the modified code.

2. When testing with Raspberry Pi 3b, in order to make the test result
stable, the CPU frequency should be fixed. In detail, setting in
config.txt:
```config.txt
arm_boost=0
core_freq_fixed=1
arm_freq=1200
gpu_freq=250
sdram_freq=400
arm_freq_min=1200
gpu_freq_min=250
sdram_freq_min=400
```

Thanks!
