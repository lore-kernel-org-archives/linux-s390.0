Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF8275844
	for <linux-s390@vger.kernel.org>; Sun, 30 Nov 2025 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764506619; cv=none; b=VW8eG04fG+T57KRUjvarTuNnKLhQP/u/ZmLfTGAUuwhT5iZWxtiFtdmxcjsN+s60pkNP+aRQQCoF+qNutcOyBq39M4Pg/7tYGXl/VLiVpJQSeHbtbE6Zkq5UMB9S7ATrX276qWLKG2A0fZOr9Fbn/NkWOfj2ipr5fZ2cwLfNYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764506619; c=relaxed/simple;
	bh=3eNjw+pPA7bOdESCTn99iE1l6IYo9w6olvIBrN4F95s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tE/wmIsldqE+R9jZ/tQfOAeo1NtKVn4AQT5gyi8pz6W+J9GuMsxz5zDXwuyxxgq2xCF9ptLvnE74a0/aEEsFtNuElhI21kkMpQlWTBZ3uVSYtq364NWFBS8UIe+nSe2799dMyVhEXsNJrU9Ty7uuP17/a5uNORwfpRgZg70LJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRwYcmTf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRwYcmTf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297e239baecso30782355ad.1
        for <linux-s390@vger.kernel.org>; Sun, 30 Nov 2025 04:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764506616; x=1765111416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q24/I9SndBUdDUiodRkHdhfBwRhvK6inDO5OAxEgMow=;
        b=gRwYcmTfWk1FhF39UzHAdscoeR6GuuCq0cDJHpjZxcvuBYWFZueMIGwsyIg+5FxGRA
         8SRKa7ebscQfIXuSr3MqBUDQwV8/mN5KukBl2mM1/TrouVCHSn09Dbcerm4QGgyTYexl
         4vSc5VC3PgarzuxL3l2dQiqILyKd5vaQbtUpBqwGUvKEf6Rps7rpLzUdlNkzjdyA2ssA
         m2+8KWOCPrFUhEIaXgF90uI6rYg2dt3O51IKmIxHfwdsXFcq5yI6fmQpI3nHWYiS0XOS
         wj3DapH42BscyCV4ujggoXQOQQeYR9NL+Xdg2UH8ne/JJiUxp7+7tp/RvKRtgqjEYmYf
         FD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764506616; x=1765111416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q24/I9SndBUdDUiodRkHdhfBwRhvK6inDO5OAxEgMow=;
        b=GYQOjOsj7RX6/vo2+5fHI+W/79ohUlrcrPkwBQ6Rl/1UgXweEVeWhMz6DCDAry0/Ok
         y9ZnYCKflx+NshJt+AkWpqh0xjBmhW0hKR00bxVlrhDws3ra+OFDLsWP/A1eSJqJnRKq
         3FuwCTAVB+nTa9bDzBev2V2qX5u/spoKjuaQGFzR5nJovvj6fz+WH6gGtCkg/QVfdYZb
         gUIzi8G73gbV8BZOqG/kl8pZI1hh7qPDUyBFpsmCnwYpRz5W3aKNBTZG5S4VM8ELIxyt
         JFcGRBCjGj9GfhUEw1iTTLn++6FPcN9pwx1aYNisotJ4Ev9MkNp++6hzUZVSjVMy1Bnl
         oHng==
X-Forwarded-Encrypted: i=1; AJvYcCWNZPSXwqoPvyrqO9JZFzDOkasxv0/AoUU8VkUzghFKCY5RnkM7PeWOA5D7YKj1QiapO5CH4EQbcch0@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVFqc8WApUM1nJfcLwg+I9HXOhg43ceBuPirAaKGlY9vEbKGy
	jAoP6FGPYADEDqaxfbtnZafW5eWgmmwjy476EDFM3vKfpFFCs9yW6K+g
X-Gm-Gg: ASbGnctltdjTWOwuY+Imm9H6SItreu/Nb66gA/D1gT0StCTw9C0SQneesAZKZzbaGtL
	fT+gtiyZgyHmrI+b/4E9lo7qtosK9F1D0SBQYjYgXn9X+i880xxdCWTYAhpqE7uvADVj9S3a14m
	AT/ArYO+xVgVuuMNKl8wqpmDMcFyuV68yQKEz4U1wni6odw/bcIu5EnRsS5u1yMGaW/h62UWkGh
	89J0s0FuQRNHpn5ztBDXTCocZ2+E97/CQNi24oDpVJxuhuCzD78fwvYKE7hF3UGcawg/u7hrS+U
	yb8KT8Vf2LhTzFVoWnm1JKaM+9C+wab91FWikVqSOGQbtvgiwuZC1P2kTfYYd0YowwVTWD8UHHJ
	uCmc6kS/llLW9PIUq8fGz3cLLxyhxHTqvUM+bvy2/sAoMBIhJC+oASMHrVeW2wp4lfCw45G3R1l
	wgMFuHObGrjXv99Oy0UfWQigxkVvEG2ho=
X-Google-Smtp-Source: AGHT+IHQ1s8urnjdyeSUProWKNYbFdFfSSoKWTRTrBGlC3S9nSYGdG5k/0wJBSlO6lDVv0ToPmYK9Q==
X-Received: by 2002:a17:902:f547:b0:294:8c99:f318 with SMTP id d9443c01a7336-29b6beeda0fmr397752515ad.3.1764506616356;
        Sun, 30 Nov 2025 04:43:36 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb52d14sm94230235ad.82.2025.11.30.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 04:43:35 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anna-maria@linutronix.de,
	anshuman.khandual@arm.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@kernel.org,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
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
	peterz@infradead.org,
	pjw@kernel.org,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
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
Subject: Re: [PATCH v4 0/3] Optimize code generation during context switching
Date: Sun, 30 Nov 2025 20:43:04 +0800
Message-ID: <20251130124304.184107-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123121827.1304-1-qq570070308@gmail.com>
References: <20251123121827.1304-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 23 Nov 2025 20:18:24 +0800, Xie Yuanbin wrote:
> This series of patches primarily make some functions called in context
> switching as always inline to optimize performance. Here is the
> performance test data for these patches:
> Time spent on calling finish_task_switch(), the unit is tsc from x86:
>  | test scenario             | old   | new   | delta          |
>  | gcc 15.2                  | 13.94 | 12.40 | 1.54  (-11.1%) |
>  | gcc 15.2 + spectre_v2     | 24.78 | 13.70 | 11.08 (-44.7%) |
>  | clang 21.1.4              | 13.90 | 12.71 | 1.19  (- 8.6%) |
>  | clang 21.1.4 + spectre_v2 | 29.01 | 18.91 | 10.1  (-34.8%) |

Hi everyone, I also conducted a performance test on raspberry pi 3b. I
hope this will be helpful in merging the patch.
The following is the test data:
Time spent on calling finish_task_switch(), the clocksource and unit is
cntvct_el0 from aarch64:
 | test scenario             | old  | new  | delta         |
 | gcc 15.2                  | 2.00 | 1.68 | 0.32 (-16.0%) |
 | clang 21.1.6              | 2.15 | 1.68 | 0.47 (-23.5%) |

Since raspberry pi 3b use a cortex-a53 processor, it is not affected by
the spectre v2 vulnerability, as is defined in
arch/arm64/kernel/proton-pack.c:
```c
	static const struct midr_range spectre_v2_safe_list[] = {
		MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
		MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
		MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
		MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
		MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_SILVER),
		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
		{ /* sentinel */ }
	};
```
Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/kernel/proton-pack.c?id=7d31f578f3230f3b7b33b0930b08f9afd8429817#n152

Perhaps I can test the performace with spectre_v2 mitigation enabled on
a raspberry pi 4b in the future.

In order to make the test result stable, I fixed the cpu frequency by
setting config.txt as following:
```config
core_freq_fixed=1
arm_freq=800
arm_freq_min=800
gpu_freq=300
core_freq=300
h264_freq=300
isp_freq=300
v3d_freq=300
hevc_freq=300
sdram_freq=400
gpu_freq_min=300
core_freq_min=300
h264_freq_min=300
isp_freq_min=300
v3d_freq_min=300
hevc_freq_min=300
sdram_freq_min=400
```

The test source is commit 7d31f578f323 ("Add linux-next specific files
for 20251128") from liunx-next branch. Using default defconfig config,
and setting:
CONFIG_ARM64_SVE=n
CONFIG_COMPAT=n
CONFIG_COMPAT_32BIT_TIME=n
CONFIG_ARM64_PTR_AUTH=n
CONFIG_ARM64_GCS=n
CONFIG_ARM64_MTE=n
CONFIG_SHADOW_CALL_STACK=y
CONFIG_SCHED_AUTOGROUP=n
CONFIG_CGROUPS=n
CONFIG_KVM=n
CONFIG_HZ_100=y
CONFIG_HZ=100

Thanks very much!

Xie Yuanbin
