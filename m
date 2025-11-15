Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59826CE1E
	for <linux-s390@vger.kernel.org>; Sat, 15 Nov 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763214927; cv=none; b=pgz+Le9cFBdWjlONAxiY4IxPZDJekrJnciEnqXDOTcXsE6Ll6SGJd6rt+uPCjf2AV7ZIHuJOFVUEieE1qOxqs874l/QiFvT3s4RmsNxGaDzu0PHLI7p+lQVYM8NzBSxnJYJUH95LB6OzCW6M80PUPgln7/9NhSc27Xxmq2qlag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763214927; c=relaxed/simple;
	bh=y5QUmSKzlS0amBxXurpdk6aXWqflSKro/h9ErGoIjwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRLg7YPbsA7F/NvG+8QpgxSQL5G5dghcWHb+AOxxjrhmYiA3lWfabXrlMkA80GnugYDBwh7LUY4zht+6cqvdI703ENn+MEk47ziuKbVA/5BAUn8iHZGlGr4SNcd0CxbL6/uNUl3BLGzPOzXQ5keYxQ4JofLgtk0ubom0QvZXT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa8TJobG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa8TJobG"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3436d6aa66dso3053931a91.1
        for <linux-s390@vger.kernel.org>; Sat, 15 Nov 2025 05:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763214925; x=1763819725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5QUmSKzlS0amBxXurpdk6aXWqflSKro/h9ErGoIjwQ=;
        b=aa8TJobGxPH82+vgBIFrChINQgzzOnKhw3NHfPU5iJ2zj9EijTXkCIygYShQTy6TGM
         IKu9FNDEG5QfbtiV8CcozcKCMPiIko7haLyWxX6aVTn7xaGH7rwrbUjW1da9667Wt1Lf
         xU2qz2Vhlb1a2N3N/YombDHu23+bBQuiFcMXscdcfLwra2eiOOZG3oNUNeIbZu2qhPIr
         ILQRRyQ0jMjozcidxRhnaYsH24NGGoN9i/blHHKM5+BV5X+bR9vsQdkb+a6t4YkHnLWU
         mF0/sEWhE6e1fHgTGiAT9AHgtKQArUN8U/mV2OA2lCjhvU+AQYL0YvH8wTaz6CYAD9Eu
         ojwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763214925; x=1763819725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5QUmSKzlS0amBxXurpdk6aXWqflSKro/h9ErGoIjwQ=;
        b=k6AgjijL/5Xx6bWMiec7zNJwYwDwpWmFNcF+1mZDGcPbSOaftjPv3k/V3CPAsF209T
         SZQ+1QD46LvtwOhUUtlbV/I211IeegqJxL3bRWcyJXdJ5F5OX04ULUPugzS6LtJekgg+
         bKvi7poB3ylNLaV8wFA30762T2x0OqDb1NGvCDhUn90sSJ/XlrqjU02Zt+n575R+WM6r
         msGojAUu8yvDht8liSCVxAaZoE653Xns5Q7rZQLHlZocF2lMSRPDiELDoEfRU9aTLs8e
         grCNx4U1q6wuJlW8oh/BCG7kVdNGJXkdxz48Li8QvBqWx2U4FE5LAW5abJ3NJjlnhhum
         Hq+w==
X-Forwarded-Encrypted: i=1; AJvYcCWyEL/UKaNEqJ4dc4LN2VAw6D5q4o/9JPFLwF+2Asmvz62Ngu2WD0aIqAzaiPyzzc0nrfRo8ypoNAuQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwaZaZBMQ2lua0LehF6esm0eB1+ytdCym6ZeP4gD+/QbQpxjDEt
	8ggHBaRVJbxyIJDC0PjAMEBT7jT14JxIsNUsJd/r18DfbpnGKaWk9iKw
X-Gm-Gg: ASbGnctl95p0zIyJP705Qq2geAWqndClyD2sX0Pv2OiKhbO8bgXogxPBg5Axgc6qn3v
	zE/QhSt7kwr/8hlaB+sL4Kw/S4z+xyE0Msp6DMkqXCQoaiFPe/CJJ3+SvUl+hIA4xGkO0vbR4Tx
	7IrbIQHP4MVIhqXnNy3u/LNzW3zAMH9mq1bTU0Sm7x7eelMF7qD2a0cynzOI86XAPmQepPdQRpI
	YdyTOV8898NvZb93nbVhAyPwf3JFKdRtQrLNeYCigHcNnjyO0mUAsUKLuaaoKPpR2joy2LsXYED
	HWQ2UnAWR0Q0UwjWvmeLJHcrRa3Ok3fEnf/HBf3dDVHtGHmCAJQCBpAyondcK8tOinJfIx3QbkT
	RbbtDk1oPz3BnMcarstVeQdVkv1tIe1tfPYBYC9CfOm7VGdP9HTh8HkBBD3AWrUTrD9g4imZMmd
	FTdK3Y1qImaJKJP+zzD46XEMQtjTc4FrSgXxM=
X-Google-Smtp-Source: AGHT+IFuTufEP59uKbwpymRKno9yjHG2whmUp7ulswIr3+CxbVVYv/nhc0N014IklbozTKH44HgIGw==
X-Received: by 2002:a17:90b:3503:b0:340:9d78:59 with SMTP id 98e67ed59e1d1-343eab07fc3mr11539361a91.3.1763214925468;
        Sat, 15 Nov 2025 05:55:25 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e071571fsm12590727a91.7.2025.11.15.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 05:55:25 -0800 (PST)
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
Subject: Re: [PATCH v3 1/3] Make enter_lazy_tlb inline on x86
Date: Sat, 15 Nov 2025 21:54:43 +0800
Message-ID: <20251115135443.460-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <878qg8bduc.ffs@tglx>
References: <878qg8bduc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Nov 2025 20:42:35 +0100, Thomas Gleixner wrote:
> Please use the documented way to denote functions in subject and change
> log:
>
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#function-references-in-changelogs
>
> Also you make this __always_inline and not inline.

Thanks for pointing it out, I will improve it in v4 patch.

Xie Yuanbin
