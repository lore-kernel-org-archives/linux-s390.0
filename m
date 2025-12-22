Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51723D7EA
	for <linux-s390@vger.kernel.org>; Mon, 22 Dec 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422174; cv=none; b=QBpkLRnhmnHMtuXFHawx00djxz+j+CnQF0mjXfzXeI/bOh/CF8qIo0NVwxdld/902qe/FVyh4N0JeAPJ8yPfeVSQXEae1kx6CBe6GWa/r2LYkC6nyXAQ9B2KaCvxt8H84CMsnUpOldtbS6ogziKXb2Q6WEELvUU2wp6idg7PnIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422174; c=relaxed/simple;
	bh=uHCtXyk+QeDYWx6FYrKpt8TBQA4HduB+6BbofOvZbwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHpC0VJAS6jg9JliLmjuTMbpOejq5RapOZVbTTVcoWXjQAq0Xu9dDTZ/jWtg4dd76AdImb3Pcn3O7OcT9Wu2+UT6os7Ll1iR0PsMeWQvSFit5ORQJT7NpJSAtzwZKuNcMntY9MfgPotWRrTEdCurMDMwXNsezfBcA1fJO66rll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrV6MRDr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrV6MRDr"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso6472465b3a.2
        for <linux-s390@vger.kernel.org>; Mon, 22 Dec 2025 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766422172; x=1767026972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHCtXyk+QeDYWx6FYrKpt8TBQA4HduB+6BbofOvZbwo=;
        b=mrV6MRDr2/irkrGoNSm6XOziEiknbptla3oFRUQdvAiSsAUsPshV4309kURfne4zHh
         KIKq8DrrYgHwMCDgZdWOYvrf1TNLFwdkP0Tcy8+NnZGYh/dvEHm85N551TnAxNaXMQWU
         LvasjBkYT4lBavChSDlYuQ+I0paelOvlz9AEszmDFLJOoB/Lli5Wlq9mjf9lrwcWPVY5
         Z4xG0vJNkrGcuvV8DQBwxqC4lG2aEgOuGBQB/bsjUBfAtIXlz6JYlz/wLYisYWLe/ZGt
         jB7PM7QtOh16Jv4gRmAuFhME1AdLGVRPt9KfpEVVwz+BDuoiKJd1LSnIuOQ+9i7dfZsZ
         T6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422173; x=1767026973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHCtXyk+QeDYWx6FYrKpt8TBQA4HduB+6BbofOvZbwo=;
        b=RK7yb+kNxFeXOspcaokyzx2xGu5KbRKLMO8MmdF+8iu2mCKnfATszj9byBr8dADvkC
         HAz5CJt//SODlLFxyW1SwoTh2UJtCum9lIGRAcqc4PTCUclXqnuj0XEM8xTAMN1TEZfN
         zXPnsCs+gZOLGEmuhEwMP6PcXXivgznRd3/fK4/p7SYJvrfL7lc9w45U/zh+3qApMJ+t
         zhFUv+H3fXLsAXMiyemcPAajLA9yAd2qqDtwgO5LxhMrSevjT/r+9uvisYExwlE2F9nM
         jV0FkM4aZXNXto4OAzzVGGw4toBerrdiWD+fUtiBtfCJ4rjGi94lMWWQ8YmAr0ss8nUr
         oPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMFo3djfN7e1FXEDz20qr73Qk5cFmmkvX8Y1QYz4UvPwtMLPirnCGecR8cL1bnesuJ+4uWOyT98I41@vger.kernel.org
X-Gm-Message-State: AOJu0YyVjiGyirsytXNOatEc7NTEFfMbSvLGiFEUM8F2YKrHVTjkARxR
	j2T8E+A8DqhgWU4kuK22+mYGH5W41u9rsXfdqGRDTU8QiC/9XfPWEpFS
X-Gm-Gg: AY/fxX6fZHvkbQOqJ9yjTJSafVk8a+jY56ZmU79iD4dUtr70Dt14uXJk+balAmpDILL
	t8frMDNSSqTK9z9Fkl2hTyOJeDlv6deTtfBnKkciUGtPfCbP4g+BEScFEQZ68sDGyHuBb0PjHo7
	xkFtYh8j+nJV2SaMKv+LlJNeVjONRirCjLNy672062j0Qn6RenhQhesW1gAQfvBFLoUqmABUIPt
	rB8HvhCrpzcP935XJ+Jc9sY71M1BOCKzPAAo267hvKQ46eZdhl/OQgqJIwohWeemNZvX8y1QoBV
	kWYdEz5ogTatosUiBrd1TtC0xnLKj4dtTIGzw9cyh/qixZbKpU+o+a72x6ZCIWf8SrlpJ1mFLI+
	iQGsaY7wK//ElvzAmpoCmgoOAxA2UFvenNTQD+4fIgWPc5R/TEEVYxY+URUtoLqMQy7JSDRuqy0
	mJUQj+W2Fi3ZvDxMkPx5mEBqRj9S7flWxP6wxcuU5Rqg==
X-Google-Smtp-Source: AGHT+IE1kSobyivF21U2b11KGtxcCjvRi7p3rr+R+RS7uDCxpPw8QK+rjeZvOZXB1HHavY3ezNQDyA==
X-Received: by 2002:a05:6a00:600c:b0:7e8:450c:618d with SMTP id d2e1a72fcca58-7ff664806c2mr10273618b3a.36.1766422172494;
        Mon, 22 Dec 2025 08:49:32 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93b441sm10813272b3a.9.2025.12.22.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:49:32 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: peterz@infradead.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
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
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	x86@kernel.org
Subject: Re: [PATCH v5 3/3] sched/core: Make finish_task_switch() and its subfunctions always inline
Date: Tue, 23 Dec 2025 00:48:15 +0800
Message-ID: <20251222164815.485-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214191307.184897-1-qq570070308@gmail.com>
References: <20251214191307.184897-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Peter Zijlstra!

Could you please help review this patch? The content and testing of the
patch should be sufficient now.
Link: https://lore.kernel.org/20251214191307.184897-1-qq570070308@gmail.com

Thanks very much!
