Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03521A94F
	for <linux-s390@vger.kernel.org>; Sat, 25 Oct 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761419939; cv=none; b=PnDOtjiH9+akGUtekfLULYIlssy3DROj5g1tWf0cfc9nuNIPJnydF7DGb8X6kvSUYPIa6Wf0cIVrUighpLQmlq25V2XbovYZVtlcc94R1opwDZ/INQV6iTXsnZ519ww+THuQJzU8ZIDUd8pFZAXoKryZUxiIoWz9z+rtaN6ePcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761419939; c=relaxed/simple;
	bh=b50a9arCrSL/MR93BKO9o7wTWQtm+XsywFPqsAesqkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXQr4PH/Odprz6VLPWCwRYo8Kq/skk6Hjfxq07UD7tyrCVfIy91q6jerx/g5WlTvheKgJWMUodEJmTuG207OKEsN+OkBFiwYLEx+W+8vq0X5sQ9P/3w+REPsOUs3VLsVqgC5aADHPViUYZWCNVUgBX9xP0zGYW+4yMe5zNBEEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAqx+o/z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAqx+o/z"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29292eca5dbso43612795ad.0
        for <linux-s390@vger.kernel.org>; Sat, 25 Oct 2025 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761419938; x=1762024738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b50a9arCrSL/MR93BKO9o7wTWQtm+XsywFPqsAesqkQ=;
        b=gAqx+o/zrW38qe8vTmotvOS8G1BK0a4PPbPHZ+5uhUNrTPl0NW2TqVA1EU6TpCrRGh
         GzuApbZZFeg9EVYXfwWy7qYrWubTWy6BJ7kHjZkrF0kNtyxw+T/eakjNqr0cxpSkN/Qv
         nAw6QtAgDQefdqru9VnlBqrFJHd3RCOH+8AnkHQjNJTOHe4M5aTuzcyKYQMDCvZAcI8Z
         0jOS+mw4XTEKwmU/ll2iTsbuLIAvslDOMRR5zE9wIPbqSjzmFcEZqqDUXfK0LXuM48yD
         ydHJcVDEhcOnxguGJa4DAIB8Iwmt9VspSbWk5Q1aXtDod5j0Rh/g1fQZaDF5Jon3nN92
         7OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761419938; x=1762024738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b50a9arCrSL/MR93BKO9o7wTWQtm+XsywFPqsAesqkQ=;
        b=e1Ur1VLFncgM+jft3NkOIqu0vGLkMqUFws3+GZbEsR0c+d7tXhyRPDsE7UpeQ0GMzt
         0d9n4tPK7gTq6Hv1WVrd23memERHQ7/6YM9udPhHlyCPO3qQ9ijV0azxoPY5hqKSDO9d
         hhe0R1vaqO6LuTdAabzzxMgUKDU7mHa6xCgoTWGOrqDw2wnjm1qUJaUFTVFLhQfCtVG2
         0wM30CvbSUVpmtt2/hWl+ffq8DvCvvSiO45dkEHgzo6eaf9JmUsYN+H1INPVFSmzGUsp
         qOQrLIpwS7Jx3DHAyiaMyibeBDtPnNouKAvujzKYrEki6BKGf+ls7+OitU5BWVonSr8e
         Bk8A==
X-Forwarded-Encrypted: i=1; AJvYcCUqW33SlxWujmoVaw+hxjjkOj4DMtdR7Eikz/x/QqoZOrhB3QSxd+oUdPWuOMkg4z7dsm7PXnZ7w1F7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7nEJCI6okn92yekxDIM/mSMDWRbkE7b6c2M4uozwNndotQK34
	DrCdOmM9+3FTii1v88WvUe/KmA3a45Ijt7IFLo+w4HOZX0vp+9h0++tG
X-Gm-Gg: ASbGnctf4uhkIEdow590b21X65WerkGRG36uHRyXsgJ+wJJlxT24xjrFfd1otW1sBzh
	aQOya0ifPrg8yvsNreuP9eBpCK5gLvJbpHfMB8bJLYqoCXQ6mtVEJabt4v7X2enufpT1j4LhqSh
	5f4ROq31J65BMAShK0JvzfUGe8v38ccZWQj+xm79zwiYeGF18Xs01jyZrsvXqeeCsuZ6teXO/xD
	exHj+9wcRL2WkLHQJT2XnaZ0ODsrJEo3X22sg9Vo+HnxuVYC245vYuUZJhxJxvA917NVUs1DxCG
	dp/B8jIm9Kl5Rur6tGEC9CIMH4kVS+swedU17+bW2G64okoH3rUsbYuBdAdTV1uWBap9FR17OWP
	asU1Lt8nUAh5xpXspTT67+Ir9LrdvQietnoubvWx4WUyo/DT1v6XQbU35aIpkPxBkTrf5JXkkso
	Ylfqi9PChYSAiHWTyC6Hl7D57NQ0SFKfg=
X-Google-Smtp-Source: AGHT+IGB2o/5lEiKd9cWH/x2UTjOp0RZ2ut0VtofYuc7VyGMeDPM/lJA9l37C37EEgCCcQfgsU8H7w==
X-Received: by 2002:a17:902:e889:b0:27d:6f49:febc with SMTP id d9443c01a7336-290c9c93af5mr423757525ad.1.1761419937751;
        Sat, 25 Oct 2025 12:18:57 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm30054435ad.100.2025.10.25.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 12:18:57 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: riel@surriel.com,
	segher@kernel.crashing.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anna-maria@linutronix.de,
	aou@eecs.berkeley.edu,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	namhyung@kernel.org,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	qq570070308@gmail.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 2/3] Provide and use an always inline version of finish_task_switch
Date: Sun, 26 Oct 2025 03:18:39 +0800
Message-ID: <20251025191839.6907-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <18734a4944e47952b7ad3e10a36c902392bdaa91.camel@surriel.com>
References: <18734a4944e47952b7ad3e10a36c902392bdaa91.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Oct 2025 17:36:06 -0400, Rik van Riel wrote:
> Does that actually work, or does the compiler
> still inline some of those "non-inlined" versions,
> anyway?

For the current code, adding a new finish_task_switch_ainline function
and calling it has the same effect as directly changing the
finish_task_switch function attribute to __always_inline. This is because
there are only two references to the finish_task_switch function in
core.c. When one is inlined, the other becomes the only call point and it
must be inlined (unless the no-inline option/attribute is added or the
static attribute is removed). The uninlined finish_task_switch assembly
code will not exist.

However, if the call point of the finish_task_switch function in core.c is
increased in the future, as long as one point is added, a non inline
function will be generated and codesize revenue will be obtained.

Xie Yuanbin
