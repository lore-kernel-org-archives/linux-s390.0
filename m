Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A913D276
	for <linux-s390@vger.kernel.org>; Sun, 10 Nov 2024 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731208074; cv=none; b=DxRoCnKY0YjiMUMzeOHg5S9cSFdFTf5kfPBhlFTYo9GqtzzrhfELjFC0l36Y4sX2wSctjUD85bE4Qon5tdaJz2sWUSI165HcvlYrgOkxbynuikbQn/YJH6OPfer8Rd6gLIjD6IbdE/M3AKWZ1EQZsmd1jtmaUL6DxM4Ftnct+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731208074; c=relaxed/simple;
	bh=OCFJoqH40RftCQJFTbYFqpy1/g4d3fW685ZhDC9RQ3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iVQwtVfzsI9o8ResXnIb49APs3/TnSX+NIPeq3YJxSCR0nNiuf9NFKUlk3pauQLPMzuIabJfh7/Zgx6Z+KjSkuPy0U2If4lzba9pHwgp80KixfJRRPRmAdBKrtJEjelS0vra21XEj6mc/UixY8F5iKjcjq0RpcvbmvZKeaLbKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KXCYxJe2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KXCYxJe2"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e5130832aso2676819b3a.0
        for <linux-s390@vger.kernel.org>; Sat, 09 Nov 2024 19:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731208071; x=1731812871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FAzdCf/HNEoNh59QMJJJI8bEqnd5uDCzyuSXCTRwcw=;
        b=KXCYxJe2UL5V2HE7DIhERWadiEWBHL+9K5q/VqapDMdMdLBwHdOuc3fGYdGqJPPVDD
         0e6BRfozPYgbw+Ss3U7X5mZ95YYZFhHVcdGpz1F6QC395+eeUGS9C+XnOLeZBpI873R2
         6Baul/VmKdc8u+vXH1GZoOyvj0YRIsjg1V/6db/AZ68DE6aYv7QGocrLLRj4crweNMRB
         twkSRsaPllNpVD457jiYI8RWC8QVWU6xLGnJDrHIjh7unC26DHQmTsVsQ2AX01E/Q4Fy
         3utohEW24L6l//ml2V93mJCuyKtl2toBt9EcS+LW5ehfPoVVu3L2j4ZSyY1kYMLR6Bfi
         0Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731208071; x=1731812871;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FAzdCf/HNEoNh59QMJJJI8bEqnd5uDCzyuSXCTRwcw=;
        b=vlUp2w3EQhztSZY6t+/7jDctfrmuBJTkX1544/RRWe/+X5dk+ilsx2POMRZDBkf1W1
         nTgyjTTdTg693NHBpvimhTMf7SNfrxcKy65kMonWDDKm6lDEcShZELNJsuNjZtKIyXY2
         IUaXYnMqcWHQrkb8FPB+TDeXCjI/mcIMpj2hnrz39goJAs0sArG3USgMoZhRhdVLxCPi
         42ZHdMYFy8CDf2olxYDVy/UF5L16xDqS2+eWaSX2OUkrnv3Sx6ZfCoa0w4gUa02JEtl6
         a60RdFC8cWlSZRbQBhOfbLbJQerv5/9iNTvXp15yUgmLZNfP2xsJxIbAvjiVFSm8+IS1
         J1EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT1B9HYM3rhajoX9oksTojer6W5FcpsbJdh6i7bBetEcVj/TJAAZIiDqNWecuco6deDPsqbcV/NM0T@vger.kernel.org
X-Gm-Message-State: AOJu0YyLl8M78tlZooyvFaYXVm+5rfbsWUut9+2jbgOt9V+M+BkeQnoL
	7jqPpfdcSPbPT0LIk4dWJz95Tj7HQfP8EuNoX/zYOuvaqwXtnw+O1NULYK5AZno=
X-Google-Smtp-Source: AGHT+IFAd9banqTw/M1TxrFu6m2qrtV1H85lccBcNkC6O/v/1nMfNb8UZquo2qHANxSGKSKuRcJkIQ==
X-Received: by 2002:a05:6a21:32a9:b0:1d8:fdf8:973c with SMTP id adf61e73a8af0-1dc22b1b124mr11273303637.29.1731208071523;
        Sat, 09 Nov 2024 19:07:51 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65ba92sm5922982a12.80.2024.11.09.19.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 19:07:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Miroslav Franc <mfranc@suse.cz>, 
 Yu Jiaoliang <yujiaoliang@vivo.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20241108133913.3068782-1-sth@linux.ibm.com>
References: <20241108133913.3068782-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: two small fixes
Message-Id: <173120807017.1615597.17743802351873148295.b4-ty@kernel.dk>
Date: Sat, 09 Nov 2024 20:07:50 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 08 Nov 2024 14:39:11 +0100, Stefan Haberland wrote:
> please apply the following two small fixes for the upcoming merge window.
> Thanks.
> 
> Miroslav Franc (1):
>   s390/dasd: fix redundant /proc/dasd* entries removal
> 
> Yu Jiaoliang (1):
>   s390/dasd: Fix typo in comment
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: fix redundant /proc/dasd* entries removal
      commit: 7f5435b2a5ce6de8f53b65900a0e57a158e2e027
[2/2] s390/dasd: Fix typo in comment
      commit: b2113edaa9afa1c405609b3dca18a9434d28b6c5

Best regards,
-- 
Jens Axboe



