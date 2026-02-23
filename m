Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5D34D398
	for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836036; cv=none; b=AeqkoiLR9i58z5VWjQo9pO0QAFQGgoS9AmWzbFqRnnXkL/gmdapcleH+sRAt4inuqSvbDX1E3Wsj9uPT6ThSqItK0Q3u1Ku4lY3+Ex6jyB+sLKCfXLh/wAZcbPnkijC6NuZfpn+4MUtd+W/oJOFf7L+7PiLq1nk2D2sA98DzxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836036; c=relaxed/simple;
	bh=dsGJfsX/lCAwZRvqmeMK/TH1AGNiHGT2CsWkKbbh2Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lxou5N2i/Yl6cyKh7porDDkhJDfYMBVN2NWwowh0Cni/SgjLp71UuPaHuC+7RQLrbMlPeobl5hkd+bO4ecQOBMN8Odu2h5F4EpBf3VdCkipngK4DQXSgVgD6gTV/BVBzdOrJFy+ooDV2dnLR2rCIjJoaSM25Mh9kZcSWqwJw/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqnCFg0p; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqnCFg0p"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1363146a12.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 00:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771836035; x=1772440835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pl7yMndGbyVFIY7fGiOCgU/GCIceKT3c7JUljTjpt6Y=;
        b=WqnCFg0ppH8VvtpPnRbwJdj81NVtBvMrb+W8vI5bq5OMPvKkJgyPrIuRm4OBUdABq+
         Az5JpuJOei2RzFChY1pg7nT0JYjj07PX1Bn7ShnWWontK+vyI+R+ljej4dKAZD4Pb0zm
         VEMf9NaqwgbIW+jNOUdqjFnjvSW/dpH1jpbs7KvsDAVG6xyfRfL7QBgaftB25YUCXU5B
         uaM1XI4C60r5P8rHyDp5rFg64xl6kh9dUtrnSpXDTfbAKB7L7Qdt+ew41LPMCU0/yTLn
         sKdwuhg+KFNEFCpM/n+RjzzxfhWdVuvCXTcqoHpQyI6tNErbMQ98wHaO/mL4nrYqq4SP
         F5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836035; x=1772440835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl7yMndGbyVFIY7fGiOCgU/GCIceKT3c7JUljTjpt6Y=;
        b=UPC/R5h2bQLZEOvvWvOXkMV82NUMQheaQ+EIiBGK3Wu8LExoMzIbtURBn6I6jZZDzy
         RHGWrPwrN3Y9gorFMXd2JtsgR6z79WGxRLV4Fm09gCGUPQi5jlgZPNOqjIGTfPwm1M7o
         CxlcRDagC7Lrjt330Pjx29pdt/qhBc/70Et8qybUTlxiPV+6ZrvPArdNKfsIMJAMBU8P
         BgtpNoZ6UWlLmPGBg4L7Y+x3arr5MZT3v1UX1MOgtoMPImGvuXTzliKsey+Xux1G38mQ
         updpF1czW5k3j6s3g95DfbrxN5NZwfVCxQvMjEcMjgsMdJQhnhKaRzVnee4IpH/7c95z
         XCCg==
X-Forwarded-Encrypted: i=1; AJvYcCX5UZPzJ80dpT18qgAL2YLfeXS+kAfkVCi7A+jlr0lvTpwE6w1ixKRH0Ap05KkRKeXoKXKXb4OHmrBE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtu/0GlYExxbUIHN1JGcVV+DeD3PcFv7/OHLQ4SMK+DT6sRrhV
	wqkk88yEN9T9SYYhmq+Y3UQrIjJxet/WSIpLYxCM7gMEJIKJLWCjgiB4
X-Gm-Gg: ATEYQzwgIzS7wxxP38jC6YEtj+7JF4MdwVW6GTv72/Gw8Bf8UKqtb2nhevlF9C3Qp8Q
	R7CegAZvncBhPrD5kAPfvJAGpuSv5GLARAjogDp25YAGcy5qjA1VFj4T01j6LoyIAhEqNcRULRt
	LmnpP7iNzOY1L/7tjfhyH2dumaRAg6QM5tHIhZSmRru/wY8QC2qdDqXY1/GzgrMYDDUrCKeFEq9
	Hvpa7wfyPYF5i+rZQDO6+D0dJdNjPI5or6QjzIYhvIxxTrbQN6ktDt4zA0Y2p/mJcxFBVkZ9m6i
	rrrORZU2Bl8zyfP/h05Up4Pe8PtelAW+0Fwt6ONJroeyWkeZhH53vNZJLkerumUJMUeQ1BiSYht
	a4xQeUUUMnbDUT6SqIbp2c8BCQ0S5bmQEz0TDqgDW3IY3oVtNHZ9MJmaUGlviaUCAbUOBZBL11U
	lwz6U5BSIsg16eKi0e/sAc
X-Received: by 2002:a17:903:191:b0:2aa:ea8d:a0f9 with SMTP id d9443c01a7336-2ad7455ed01mr62685085ad.51.1771836035021;
        Mon, 23 Feb 2026 00:40:35 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750591e2sm65725405ad.91.2026.02.23.00.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:40:34 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	iii@linux.ibm.com
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	bpf@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/3] bpf: fsession support for s390
Date: Mon, 23 Feb 2026 16:40:19 +0800
Message-ID: <20260223084022.653186-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bpf fsession for the s390 architecture.

Menglong Dong (3):
  bpf,s390: introduce emit_store_stack_imm64() for trampoline
  bpf,s390: add fsession support for trampolines
  selftests/bpf: enable fsession_test on s390

 arch/s390/net/bpf_jit_comp.c                  | 97 ++++++++++++++-----
 .../selftests/bpf/progs/get_func_args_test.c  |  2 +-
 .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
 3 files changed, 75 insertions(+), 26 deletions(-)

-- 
2.53.0

