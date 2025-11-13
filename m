Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B52337BBD
	for <linux-s390@vger.kernel.org>; Thu, 13 Nov 2025 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031793; cv=none; b=LL2QOFTSRAJNqfgYg4KWqZJnenNpnLnM6AlPgW2ccVBTbo7LCS21vjfbSIT41PX2F3KCUwd71qGQKd3G07/cL4CL2f6/IidCYrtyboGduJPOrfnkZ/7+rB+Ff+uNL3AXCeQ0gIYSVlfKVdCEF75ITZMN9Z98OVPyInORFIAF8CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031793; c=relaxed/simple;
	bh=/cKN1EDDwxjht3NnFiE/uLPr7VcrNdhZ1SW6uQPT/kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNUVChMYnh8aq3y0hQ39QqcxK0Rt7RHHYVRbNvvtvmOFhHraCZObERoqI/0Kab2gIe7SPPKKsiMLA6Tl6kUNIar0MY9BgI9liNdFZ4CAHVz1FC3bhdtbcJYa2iLSK/U60266oIqEf8Mxqkn2hGG3WwKSPIUJaVJ2Dl1AHVpNoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS29Apz5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS29Apz5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso584113b3a.2
        for <linux-s390@vger.kernel.org>; Thu, 13 Nov 2025 03:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031791; x=1763636591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cKN1EDDwxjht3NnFiE/uLPr7VcrNdhZ1SW6uQPT/kU=;
        b=JS29Apz5OCvbP9V/BsvGKkvw9kpU9gHQWHtZiMwRVPi9POlCYmXBaignkEAlwHEJz7
         56hqd5yaBfyeKZYkhhZPYgTLSQ/NWNde0ulfzwbNv/tpfeZQI2sCxKQXo2qg/63iMM/q
         OGtTPMRkwbr2Vn353EMJcGeIyaeZXQLX20D1SebmUk/UDsSqgQj2K9I+wEr/uCXrn4NS
         mNOkynCaI3dlOrMeveT4EF3wS4acTbRX9SB84LfUlpHChb+YG5pJ57YxiiNGTqb7M3sz
         dHL3Mf4GANl3rqY8/b725OUTPSv2x7Yr7kbrfnGZEX2IwcFoddY7HiRvpz1sAqqa7JX6
         ghhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031791; x=1763636591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/cKN1EDDwxjht3NnFiE/uLPr7VcrNdhZ1SW6uQPT/kU=;
        b=koyJrrxAmW5oeh1n710ICn0NkdU/a6RyVk/12yTcm6pg+2JBA2Wv8N6SKmtes2oAZZ
         /0VZZNViTI5+0ERSzhtK2P11AaW9V/npnod5LYFL/HJVsLcmjey/I3h/CkxHyQHOu3l1
         /FtFAYcqCa4QNZSWpvgPCfqA56H9Fr7MQhgDjSZ+9xBAUbuAWDyfGnNl4/pNwsjhiaBt
         7zuiMdruvyItwVthR3lzjosmdcjEcDEo7IX2XgSctx6dwidGvHmvq1UOmpz98UuHUt3v
         8mYQaFfsrrMyhOdyO9edseEBpoaSOeCh8z1gW3txN37616TIC8pV+qPVH87porGwphcQ
         DSsA==
X-Forwarded-Encrypted: i=1; AJvYcCXaEJItU8337O9xFzvfWg2PqQfjcC+mIouKibWipp6A3E5P0hu+ApQBpVvNgYNAqNTT3JUOt4GAZNtv@vger.kernel.org
X-Gm-Message-State: AOJu0YxF4diIb9R5iZXS+2fqV+sHHKnadf0/VqP9ne8nGhP48RqZBAgG
	bgUZbCPYY3IItS1kPyqoDPka3O+dGs7p21Yj7dgIu6pJ9r+EVHMRo42A
X-Gm-Gg: ASbGncuEDHZl9cLHy49tmzcr5sW4qUUGlUHqkHVi43UDYwaFk5yXpSYZStp/yAyyluy
	5aBJNoXVeazBLaEEnqos9ipiN7yf40xSfO1FbJq2VEyMXc2P3LeBXqRTYKsy5N7m5xKvvln36K8
	2CKHMbFDfShftecmDiwGepuMModF45YJX3tNAQkRqJyYsDu8u1oihtZQ3DkUqgr2ffBv4kqdIi2
	+x3NqGvnsGO0/atPZE89Z9j39KWgk2MauJNb7m/CMIRSqrHRAFr5HVNxlmY2XPyQw577CFRyepz
	53TMl/yZ/ZQjx9OPi2s4JG+x4nffveCkwD4Pe08hn7N7lYG/yupKoY2c1xa9e7GCy5oPKbEj0se
	jdX3+4BnZ9DjhYO2LYdx0zjWTKCb1PtiU/zuGggrtQKwDf6OCktHXO7wEwYyxG8GUM22qVTS18Y
	+4AXGUNMoP8YFFC1Vbs702lb8j
X-Google-Smtp-Source: AGHT+IGTrsN1hzBjRmhe38pf5EQcIYNA2LTSuiXM2QFdlDo95u5VGbYJOeAKPxxp1waIKqvLyyQ7Tg==
X-Received: by 2002:a17:903:8cc:b0:298:46a9:df01 with SMTP id d9443c01a7336-2984ed23fcemr89013665ad.3.1763031791060;
        Thu, 13 Nov 2025 03:03:11 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c242003sm21657015ad.24.2025.11.13.03.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:03:10 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: qq570070308@gmail.com,
	riel@surriel.com
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
	lkp@intel.com,
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
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sforshee@kernel.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 1/3] Make enter_lazy_tlb inline on x86
Date: Thu, 13 Nov 2025 19:02:46 +0800
Message-ID: <20251113110246.57703-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113105227.57650-2-qq570070308@gmail.com>
References: <20251113105227.57650-2-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Rik van Riel!

I fixed a build error in this patch, could you please review it again?
Link: https://lore.kernel.org/20251113105227.57650-2-qq570070308@gmail.com
Thanks!

Xie Yuanbin
