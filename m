Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B545883F
	for <linux-s390@vger.kernel.org>; Sun,  9 Nov 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707873; cv=none; b=eGcXM2PXMnsnhxy4PHvr2U7Z6qda92u0ctOIh4UbAESMNXP/I3danNUh1D1/Z+fFoTZdmnQBc1cw15UnYIhnKKmqhHTdObqwhATh048IJP1Fum4GT1yOLvFQTxrTZDV6OJTai/lO87t+l55dcva/S7C1yL3qkXUe0DRaodIBM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707873; c=relaxed/simple;
	bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kkzd7z5gbjr/D4ylY2fOMPszDe0f292T00jxtpPlzs+b5RkHSM4Gxi5ctICpg15k4LKhXdGOK964v2/Htw6NZkFnQkY9/L5AEEEY6CeRJizC8GpkoIJN6lz4EsIlXg4GCXUrDD0IBVphMwIoWHYW2P5H6qkC27Mtcnx1zg02tB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUWscdTu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUWscdTu"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1264059a12.3
        for <linux-s390@vger.kernel.org>; Sun, 09 Nov 2025 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762707872; x=1763312672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
        b=SUWscdTuz6E8COB4RFi3ARO92QxTVYh+eM1xKZGjF6toaMhbiUpmk8leK7DKEWdVmL
         T1n7eWLAgZR17BgtucZln5haaFIwIlzBsalpycpO9AxPOEgjT11nWQKYzgTk0Z9K30Kr
         rFye/XM/FEOlo1TZuOg1+8wKc4EhvaPGuuwf7bsd2id6U4ZThUmIyUTSgvVorWd3erHW
         mGWG0yFvj5HsGIavX1MJ6qyQVNruD0wj8Ku4SWPkAODcbDrsuB4gTHSFD73zHzYvw9Xh
         Z/AAbxMNYwNciKd7J61O/9qa17+e9u5qDL/ZsKQWqs+i2yi7vmHiqCc3mSXqFsLZjskb
         DLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762707872; x=1763312672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
        b=rcy5qwTdJUDGfvo9KlhyIshn25RHuIlcOaHIIVF+Ihxj2bteCpa1a1raa52ZLIh64n
         Zps4cZ5uJDhrmAwT/7w6QNP9Q83g8OA0HBHSkqlVgDNq3n0dNrUq5kic8fY+tZ7Y3YhM
         7QI11HlHPlju0rleGNWFO9bvgPaulZ7Fwlqon1Q+QF51W7hYK/ANsErA+PxBeuV7GB53
         yf9kA6uGpnG3/aXjeH5DUKySAtMlygsfE62FfipQvL3+ziVZf6AkKzu9t1KCRq9WMXG2
         N2fGOdzgrqJEdRcbltcTuMG37bwEF+kTjvP3Cliep3vpcaOTtxUXHVTb114QwmeuBX6P
         XKrg==
X-Forwarded-Encrypted: i=1; AJvYcCWcwGXMqV3IOYopKMrkwwiP/vwSOgSMqDoVTzBHyotMfX797SYeLGqwKyPnb2ptfYHeLD+WvA09qIlG@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4a2k9Qg8ZPrGfy0dqWb3q6npz7B2hE4gBTvF9wW9IE27V7BR
	+G3XhacsunopHDQEA4bW7CyTmwS/6M+uX/SJCJ9wxD2faG9BoY+imE2c
X-Gm-Gg: ASbGncsW0d//iPUJxqC3QxUbnn2NkQfaaWHDqhiSQN2WLdjcwdX79PueW/zeK9QX3Tu
	VBQwSqhwsgcxeYa5vNQvLghDEks6Um0BThuwq7/ce9z2KJnn3BkZ5aOsXBAVinXwZ23Dwiitflv
	Snlp0Gn7yJAHR+ujvwBJNwLqE9irZLOb3jkJNbuM3U7BJl0YnQPT6/bXa4++zSMR+zzpc3U+45G
	cUQ9JCy3ozaJXAwtUvqHsMis5+N4j7qrd81yO6Vpc27ToZu7hEvxF11rgQf/UGZqr0NoVqU/VsX
	RPxic0oXPSeaOYL7TP/d7kDKg7Cfm1Spcf5EMkDZnrlxDVNK5BMIQycd358FE1nEic6tHn0R/O/
	y7ZSNdK5TLU4doXxbVl/lgL6m8KNgFiGcEM6ZXA3o2mUDdtkaHBKIUx5X+bAeV3A6wTg+uRXEpT
	SYe6lqLeM60GJs+H3SIB6ThvwwekIyLXArz8M=
X-Google-Smtp-Source: AGHT+IEO5xU3ShKvIQJG0EYcsf90e1JVTbxU34yk/YUYIZqWcpmJ8G9BchXReIw1drUaTkP5NUMmRg==
X-Received: by 2002:a17:903:2f86:b0:297:c71d:851c with SMTP id d9443c01a7336-297e56be50emr71705165ad.36.1762707871570;
        Sun, 09 Nov 2025 09:04:31 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968253sm117879105ad.20.2025.11.09.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:04:29 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: peterz@infradead.org,
	david@redhat.com,
	tglx@linutronix.de,
	segher@kernel.crashing.org,
	riel@surriel.com,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	arnd@arndb.de,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: Re: [PATCH v2 3/4] Provide the always inline version of some functions
Date: Mon, 10 Nov 2025 01:04:02 +0800
Message-ID: <20251109170402.145012-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109113152.GA2545891@noisy.programming.kicks-ass.net>
References: <20251109113152.GA2545891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 9 Nov 2025 12:31:52 +0100, Peter Zijlstra wrote:
> There isn't a single function in the entire kernel with an _ainline
> suffix, while there are a ton of _inline suffixed functions.
>
> On top of that, this function was already marked inline, and your
> compiler just chose to not inline them for raisins. Just make the thing
> __always_inline and forget, dont make thing extra ugly for no reason.

Simple test: "Make the original functions as __always_inline" VS
"Add the always inline version of these functions (with _ainline suffix)"

compile as OPTIMIZE_FOR_SIZE: the size of bzImage is same
compile as OPTIMIZE_FOR_PERFORMANCE: disassembly of vmlinux is same

Adding the always-inline version of these functions can provide better
guidance for compiler optimization, but it does indeed lead to more
complex code.
The best solution may be to prompt the compiler to always inline at a
specific calling point through some keyword.
I noticed that there are also people discussing this issue on stackerflow
, but it seems that the current compiler does not have such a feature.
Link: https://stackoverflow.com/questions/14571593

I have no objection to either option; it depends on the opinion of the
community maintainers.

Xie Yuanbin
