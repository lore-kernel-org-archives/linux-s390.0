Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75E3DA7E0
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669968; cv=none; b=VvdnbZzycUng55piUuaoF2ZdPsmIMgttHuk9V5+Bqt3zGxvEwKEPYqq1SInZyg3r1lqdlOxQ/lBaD8XPW+hppEgtAFuweBpgJ+TtJMMXA1Q/v+WoPmsTtzHdHzNR4bNwl/IJHThsIFn30RI4qNMwTlxgz2Z2tImpRUODyv7XmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669968; c=relaxed/simple;
	bh=D9CFIdORg3KDPUuWXmjAR2RsP8Zpq9G9I7JzBgl41j4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ok+z1q863XQkKCE7YD5Si949HBYvPYAWPQaTx6+eLMjfthksL7c5xLWpphnQtmXenVfBAZeDHUzskgNpnWaK7OwegAs2KzUyJvrCD3G1LGcDzg/Q4vLyu4M507RVvKwVhq338GWJgFWJt36Lma36ScI/k9ZcE9ju9cmRkiIZWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejiWIZN6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejiWIZN6"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38511175ad3so635881a91.2
        for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 00:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669967; x=1784274767; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ihT/2aOY8wGTL01WDNL3ZSISpn356Jmov1yxoJ5Q2Is=;
        b=ejiWIZN6XA5SZFKmedWw6IIGdlixVt7BYNZhVsY/HXsflrRXZTTv4OoRq8SuZ6JlwU
         9Sx5a84PXjyPTl0M86Ghsa9yB6RlCtoZWEooRPJT5jgyKuBzJh/yU9L4QmXNRdaywx0m
         Pi3JDLt+T3tqFsisEn1XVVLbatQhwU3MzYY+0+DqIFqjmowQDUIuKrZYca5yk2vhVOoB
         L4Y9Tvq8aQyNrefrbmhvzdZB9J76cqwN77mF5+0TBKfrQjXUYN2esv1nZOPRcqBrXPPW
         ZgCuwg6reqBmQtKUMVJYftoLueHDXEI3y7UHUpAIi7GJV+WiykpHiQ/L4NYCNcn5r4C6
         eJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669967; x=1784274767;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihT/2aOY8wGTL01WDNL3ZSISpn356Jmov1yxoJ5Q2Is=;
        b=FS54/lP95CLj1RHCWJsy7sLwbun4Kc3kMGJYOcq+oNZMqKFFmZymW2pF6eiRRsaS43
         l9EtxJ1nI30PIvDCWAvo1ZQEAMF8fMQQgmXVmJQRj/tPD+QchDCzlX8A3tADzjZ2sZnm
         FJ0J0xrFZuNRHswHLxwCxTBP64BKByTm/b5CL48BwPAEBOjA8w4MUl7SF6xOAIlavKVe
         dPeN1t08daQAQJ+3FjQtuh0RjdOMfo6XTdEgVC1sM+OPozl9I772Qwxc92Tl2D1JKlL9
         jUNprsoE8dBxVzqWqGjc/Uq+xzWw5pEWYK1sf7IU1cJWHyDL1RYUvZ/Frc3y0aiwe5zr
         zQ7Q==
X-Forwarded-Encrypted: i=1; AHgh+RpZvErEcl5Q+aPdIAnx5akWQ2ELgdWPGFxnc9vV2GGnHAa9eBOqIHMGmuQD8mMrtc+FyF7DRrunmxxl@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSudvtrAQ+cbOf9BUnMSF6kecT7A/L/9MGtYz1Y0hGxOrtsL4
	KKhY4aHZ13hrsI8HBlkRKe3Ma0jEzOBMRHUjj6h9woEckTul4PzSAbyc
X-Gm-Gg: AfdE7ck+/3FPHM4zpf5HNNLkawDBqWxMh4xzAWvpFP2wcmbBd1Bcs3iRgOW3MCguF9b
	YO0Vhu4ULpVdryNhuqhJPqeE4bCDEfDZlNkIThx0HXTptTkD/ZKWXdwiGnsPleR9s3FHjIxbs3S
	5u6BA8eNB3Hx7XObnzL/rTBuexkpiCqmYRq4bJ4sLCLlc6jWRqRDiGJ6VLdKszy9fGn//aIn1CU
	eX0v8Gu4kNxS7xNQYSWw6p6d1qNzf3zh2sZizwnySzfpnvOq3mR0SmJAip61uXI5H8MWwUjGk+1
	Zsa03Xeuh1AOSsFP5o2qhHSdc0/BjkV9d8iNKF598kjqy17Wj5b5lwa6l84ucE3+7N8SRQLDWSp
	hcdDJBg625vUk47isYjxtN2ASqw6FWBl0/CwqCJEbpq8NVN3lLQl2AaPPfcmr3Gu3VZPVvec+Hy
	MXhHMLy7LwQpsIPtcv4Ll+yCDSp8XeCFjXDNqXV9DU
X-Received: by 2002:a17:90b:254b:b0:381:e73:3c2e with SMTP id 98e67ed59e1d1-389416e7dd1mr11435912a91.24.1783669966472;
        Fri, 10 Jul 2026 00:52:46 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm38555369eec.10.2026.07.10.00.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 2/8] arm64/runtime-const: Use
 aarch64_insn_patch_text_nosync() for patching
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>
In-Reply-To: <20260630045531.3939-3-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-3-kprateek.nayak@amd.com>
Date: Fri, 10 Jul 2026 00:52:39 -0700
Message-Id: <178366995928.1208691.248201589452077852.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783669964; l=559;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=D9CFIdORg3KDPUuWXmjAR2RsP8Zpq9G9I7JzBgl41j4=;
 b=UkmRaKA4A5laoVQOHeU6g+5KHEhNh4nXv7y+97IHAPLwPizJjZc9yUiwBeTb07rPCZ5L7YjhV
 y/FrmXvAxlqDOKl91ohFaIJIf6Y3Z+PQbXebeX3Uf8dsWUwOiN5UCOq
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Tue, 30 Jun 2026 04:55:25 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> The current scheme to directly patch the kernel text for runtime
> constants runs into the following issue with futex adapted to using
> runtime constants on arm64:
> 
>   Unable to handle kernel write to read-only memory at virtual address ...
> 
> The pc points to the *p assignment in the following call chain:
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

