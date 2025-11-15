Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2041D29CB52
	for <linux-s390@vger.kernel.org>; Sat, 15 Nov 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763215316; cv=none; b=RzI4ie59YuS8b9H3X6/TCYcqnTBEEVcTTfkSPexb2VhvUss6GzM78va5WdvjuVqDfBBcITSgQzM7q5ug6T6mO7/j/nLE95fTR3nJ1M9Jn6nKPKcsTpmCcwYfgFBgSqABWLNtHMm1wLyh5L9CEaOeVu+xjhI+K0H/Uh0V5+5rfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763215316; c=relaxed/simple;
	bh=olQBQzbLF3fdlc7j5Y7W4kleJFMfa0UsHIk6o2GsAbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzxfQvy6KCJ1ixUK42z45/Gmz/Idz+vGQ1/uN/gm1ifH7L+0ZyA8vKUdMCy1rLk0av1OO27yi2urq0wzIgILbUrvaYhPDWOqJj3B3sLufhQWtjBrig+wbWo6v/GGHPBilU8qqjnvxJWcQIidl3SI8YT94PpJSZAwNJVheVBX4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPPlpPN8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPPlpPN8"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so3728539a91.1
        for <linux-s390@vger.kernel.org>; Sat, 15 Nov 2025 06:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763215314; x=1763820114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olQBQzbLF3fdlc7j5Y7W4kleJFMfa0UsHIk6o2GsAbQ=;
        b=WPPlpPN87Ut1s2/7ePShZv+unovnrmjl++p2y0sOrL6ijb2W3eLmkY5dbhUJwBiZoj
         049wrgkwzXlsr6qr//qLRiIh0aplcRrEvxwr367byGGwURdHE32MdNmGt7iISbGnYC/F
         X0MxzIjDTE4Lg/5hVTa8bYpHHbf58X9x0s/09kS8MKBagRfZrcfl4pzWYOGveaukOTNp
         +vZoSdiXBIF0qIzMj+zUhOxFHPHYUvAEBfuGuxKhzERqLfQMGCu4rZJ9QK5+KcUhg6cX
         9uu2+kly+2QoIeRxr6AEcnpDwW+7YVkkv2FfnozxEmHVEBu9eni8+j8ug2gQLRtpKv3f
         FK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763215314; x=1763820114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=olQBQzbLF3fdlc7j5Y7W4kleJFMfa0UsHIk6o2GsAbQ=;
        b=lgKUwF6yHnClj5WQ+/H7C767X8IJj5lescMLQLV8sJG7ZgnGWzmGsoFXcxJYI5Qmmc
         hm6K1nsyqjdOUC8jwBd9/88Kc1J7ifUKAVNCrEKACD71Na6kj+lPFfpAt1IqIrHF+eBa
         9Xybj5bHXZkfYoG4ko1szObjoEkM9s/O4/9k6H1J7G87yzcMJvSsJ43FfG2v9lHkYLF+
         aaPi219I2UdK/qeXRTE+nH7D+r9qbnRhcq1qKSMPdV6ZHmocLQZG3HX7ufMfg7TefUIz
         1e582oGEjTisXiXIrORbUqGE4CtTAvs+JZtGIiBk2qH0ukhsS678AYI+4Mp4eAfC6pS9
         KViQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6kp4M8R0oarSY241zdq5f/PsWfrFnmD5g3Ieuuk9iwZxAbj1a2r9SM2ICJ5laRfU6AbbfdXn7vxiv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3LDt5N+HMp/dl9gRYCiRl3Dl3wNrlaZWVVV+Gm1nw9+EE4R1r
	P5BXNHI/xKfzONXclBGg5QWSufHA3AqLXiNKMCIOFl4PcaAHhktGgsrd
X-Gm-Gg: ASbGncu+AsB9wERf7/RgKq6CadR35tWOX7ii58QqcUdjB/BPOAeY0UNXwafwqsMaFti
	mLoLpJYlkZtXhXHB6N4HZA6hIk1BCTD8jT6B5gAuNU103QGWg6Z6DZQsd149Sm8QSNhiJC6hKV9
	pcyctaJ7PYUJqCqIId/pY9lJbw/b6xd3drs9GWTOaWqUc2BRPMzBNJXkud1F2zHfF/SIRzTydkL
	8+/zvUpIXJd5697Q4/W8qYx18AsunWNU6vbzjQwZ6Q3vwvXkZYtSj7YGepG8vPDCcUtkrmLP2aJ
	ImiuCWZYa0W72ussgZqWFpqAJmUKeGpAZCx2Z+UcfSaSL6MXpMNf0/Deq0/m9sMkHFwo96KdjO7
	TIyBeyZ5ZvmFduYDOGB71NQ/5NTEEdSxDX8a7PdaTfbI0EC2brfsBeKGIr0PxpRsYLSQMMIALty
	88meFWWgi7EclMMYQbwnqly+jma8MTdUpxbXc=
X-Google-Smtp-Source: AGHT+IG/TnOO0qzjxK2iaqcK1w8zb7Sll+uP2m9bSS0pCypnuHepcTcVoR++oPZWg3RSEvlIe1E8yg==
X-Received: by 2002:a17:90b:1dce:b0:33b:d74b:179 with SMTP id 98e67ed59e1d1-343fa74c2f3mr7051205a91.27.1763215313855;
        Sat, 15 Nov 2025 06:01:53 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37526d91fsm7478366a12.22.2025.11.15.06.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 06:01:52 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de
Cc: aalbersh@redhat.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	andrii@kernel.org,
	anna-maria@linutronix.de,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	baolin.wang@linux.alibaba.com,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	brauner@kernel.org,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@kernel.org,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jlayton@kernel.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	llvm@lists.linux.dev,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	oleg@redhat.com,
	osalvador@suse.de,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	qq570070308@gmail.com,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sforshee@kernel.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 2/3] Make raw_spin_rq_unlock inline
Date: Sat, 15 Nov 2025 22:01:08 +0800
Message-ID: <20251115140108.543-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <875xbcbdrm.ffs@tglx>
References: <875xbcbdrm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Nov 2025 20:44:13 +0100, Thomas Gleixner wrote:
> That inline does not guarantee that the compiler actually inlines
> it. clang is obnoxiously bad at that.

Yes, I know it. I modified it to __always_inline in patch 3.
This patch making it as inline to make the context look more harmonious.
Thanks!

Xie Yuanbin
