Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8B3E0080
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669974; cv=none; b=gnQv5dIyqSyyYhwo4bmeUJxsOz8h64DgwOxd3/RoCtMGWOSKklQEP6kQ/Ojds0uk4SGRsO35xn+nJfO8xghUE6FM0OeIkWNXarkO6xZxackfH43QrZAH9smlSmoFOkIYtACbYtGMmmw7pKBgBFlyyK2oWLTVw2k4k2aObkKx0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669974; c=relaxed/simple;
	bh=339QwCmoNdOUhoq07+p5mhlOUQoPA8Y4kjfe9Kj1h/4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=RfI4/fzBnZiBSgOcpyyFv/rMC4yRwdYj9GcWcdpx3y4gYcOvqa9fs6ZldPctITShhaA4vQN3gc0TbIURy1pVoDh/J4gDDEwE8X8v8K3WIzNies7oC6bf9iMUFlLRogwuehXwp4h7Xv4gpIUCGP9oo+PAlJGIXo+DBdrgIcyJkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1iIlHTI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1iIlHTI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc891373e0so5530215ad.2
        for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669971; x=1784274771; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XxVWLkjTDZhg2ZpXoG0uLB6wK5WtCztBheSr28w2OfY=;
        b=N1iIlHTImR6P4mebLCg5vdSX9XtVJlsqGIYYGAfa9xAgUP0E4mBMkaMto1Cl5Ku0Sr
         xRV5GH+GQomieQe21kr3A1PkGsk0qrcMVVF6udpjmjn35wFJ/yqK0OSEBTSuaVOeKx1p
         QD2929oYu+nsKEeDGTH1GbQswjzHOOX5aDMnR+JTdPXksJS9qpyn13SIGPfApu0E6o6e
         gujGVhZ/1quoJhB+yHuC6GnSPeIoyIjIdvOYh+1uuQlmNm/nu0Gub7tOEkjnuBn/YI82
         R+0+qJdEtPYdVwTJL4e9AF1yAJZ5wcUynwL/zcze2HAo4Ks3SYiU/QQ/sHLEvQJQhqdR
         CuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669971; x=1784274771;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxVWLkjTDZhg2ZpXoG0uLB6wK5WtCztBheSr28w2OfY=;
        b=KTBgcTYZOQk36kNw9eYgvkr7ABBBkkno4I0qae13W1iAxS8RKH6dmyBIAZI5GeeHqZ
         LZV0J97iM3MINk+8U+ARD0n6ItwV6HRIRY3lqvwkmWEWFrur/NAmcwIXcSH32xOGYJ4d
         7hKeNY6OnhJm2O91e0zW1+Hly7rl9xoEKFX8/mxyWI802fTIJMNDhTpxega5pqxRccF0
         x4paP/E8kJE/M8EtWzw79tNfmsTpH16aqh81qZKunXMd89ZXUNB38RPrchTXv14sDbxP
         x+WU8PLLvMGZD6vdlen9Si7oov6VKzidXlwhyMIjEzHyS7o8HHIpNMwHZhAuRQEiQk9C
         +MJg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1p6QEWSzm+NI2kuKgL+cv7TJBkuAT1u9zj6KsGr9jzrlC9XXvRBOzHjZloYRaqe8VMtMTzhbUtLFC@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9NWrpHjTifAcWGJ1J8WBACOgCYlEX+eWh23y2nFQ2BsfNzOH
	gH/Nl+eOHoxO5Pw/vLzaZ6DPdM9JaoWG0JGYVlf3sekc/mH67V+Iof7P
X-Gm-Gg: AfdE7cnGkRBzJmGgCKgFdQISvg+u+THHrnauHNtNkMDD+BGqS17MWeapFbXzjTYzkwS
	Q1LTYeVi0tvXQM4DtkAObbRAHgdoavJKWHroK2elxUrD/Tw/W0V9h6YITOZgdH2+lN0vGyD60SF
	zS9Fc0w8ToBp8wt55atX1d3g2pB/ofmnmCi5hu/lme0KQp5lfMUWgvYBOAhcoOe4LGfChHInz8i
	QWXv2asDOB2lyCw+/Rr1VNjOcY8UgFEUvPwS4hltHM2i3+5PSgC+1mvZ5wsX47cc3bAPQa4sk+y
	917kU14y2Z8L0QbcGaYJMIiTIhhSTJTbj0f2SBh3AVHJS2XGoc/c5Mg3ip0ALUnaQfsITcZrQXk
	Q68DarHiR0ki69pLhZmQhuInGZvNk7jLGvVZPZmBfOUzj/seEirp3XmjlYs3k1lP2QYbSZEoSNW
	B01a927SFb+ATg3FL9z9ujHHe6MYvjnqeag0ThU3KD
X-Received: by 2002:a05:6a20:d045:b0:3b3:1b38:d9c3 with SMTP id adf61e73a8af0-3c0bce1ec2amr13936533637.4.1783669971391;
        Fri, 10 Jul 2026 00:52:51 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm38555369eec.10.2026.07.10.00.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 7/8] asm-generic/runtime-const: Add dummy
 runtime_const_mask_32()
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org
In-Reply-To: <20260630045531.3939-8-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-8-kprateek.nayak@amd.com>
Date: Fri, 10 Jul 2026 00:52:39 -0700
Message-Id: <178366995931.1208691.16267083905782992990.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783669964; l=326;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=339QwCmoNdOUhoq07+p5mhlOUQoPA8Y4kjfe9Kj1h/4=;
 b=+du2Hkd0RyMKi/EB9cZncyqJjA+YBHOqCVom2yvmO99t8UG/3SEUftV+TbybYm/IXhHQS2fGb
 d+Eveyk5xyHAx1lucH8A8KAbw7r8Wb+AaVQqOSex2YBgPMjHQHcvXwN
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Tue, 30 Jun 2026 04:55:30 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Add a dummy runtime_const_mask_32() for all the architectures that do
> not support runtime-const.

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

