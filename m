Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF34187347
	for <linux-s390@vger.kernel.org>; Mon, 12 Aug 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480295; cv=none; b=Ib19Fimf0bC9olkdxl4FVOcUwXhzEfBsVc+rgbo17PALDEC6xmv5QFG4H3fKCrtIuZBhZm7gicS+BwpWTDhsP3UfvZ1LgMW/O2YKNPrzTT5Bg4Hj6qHMHVp+5Zfv/gvtH/gyqxkuzsjDj58evy5DISQIK2i9+m+YsG1dztdREHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480295; c=relaxed/simple;
	bh=vV42uFlNHjRhikigd8R5YeRbBMde/8oSv7wiwK70bMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rarkWiyU+J6CuufHSGeKcI4lb53g6vEhDgb2dSAlG4BzRDpYgaSG8COrLO8J8XBcF87j0EjeDeIPKwqgB+ymQaTRaoDnk+1u60WvSr9kbVGoagpiqw9JMA8ObAh6RgfqXlm+TQbpokD/BwkUoYVaVN1Ubi8tzNOywj8m/9rtuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sMo54D9L; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sMo54D9L"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc5bc8d23cso2880165ad.1
        for <linux-s390@vger.kernel.org>; Mon, 12 Aug 2024 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723480293; x=1724085093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2UAaYeSFYZuqxhC5aYMcc0ucXXN9OuwyKenGborE1k=;
        b=sMo54D9LezfxwMhXmMkc934dYwmemM3zXy4dpYhgJXsg4hagUxlXG0rrs4MSm21XUH
         gW0Sm7eCa2VhnhX02bLPCUmYfHqURxSzENplnEOLQlHzUvssDl7/2ovKc4rb6CRYeO7f
         8JQblXCJsSWVOuTUJloud4pCU2N4mICUn1DKMDxbKjFeaAGN1wREiNgFuU6xpYRk76vF
         Z3bj6LPaD5eEvMvGohuusmH86oHZguoHHA2Jw/h8CuwDMPUfVvexYjSw6byS9z+9zHNA
         7LD26hx9on9Rk3+tk/XgPKrZ/T4wJp58rGDamnjZvBVy+ZrqIoLde4Z825+eOnZHtQtr
         XniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480293; x=1724085093;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2UAaYeSFYZuqxhC5aYMcc0ucXXN9OuwyKenGborE1k=;
        b=qEKqXxLl9CKDf3hMMxcSwrgWUpAuutpL06E7Pn0GXsBOalhuw/bhLQG/4Q9foevlJ3
         dUtJ6dx4Sc4kYdWeeNpgo3CX+IZQWhZZ1/o//NtxfPmgQzhuFHxnyUYbkghTgqMHqiTZ
         j/D75yqkMUV/6024NPHJXBNYIVrdDKIcbiiyt4JdERu5+h2JZ9aEiErtX3VIKh8kXTGa
         kYhfy+F0oZ8g1JJx8F1e189AoJYUE+u8AI00ZJf+08CqGOeXlG3cluYCz51psFQsfW2b
         G7BnGhY17lwVXpz4vwIzJZMe7I/lkkX/NhOj3fFvGlkIFLJX7tZKt1rOPObcn565jGy+
         RAJw==
X-Forwarded-Encrypted: i=1; AJvYcCUp8dO7XxaNdkCaaUoOdempvpAk3pYbrifgS2NoqXORx+U9zNX5F4rZr7A4oCcvwEOt230mS1Ot3ydK9q+OoLBEQwwfD8XfQyxW8Q==
X-Gm-Message-State: AOJu0Yx4pp9PFKtdYi1+wPhe5zZtfQoCtpiO7D7Ez1AZ5KaD+zJaS3HO
	laT+6m2BBbWSFBbAF5z/+5RvzAcVlvzgzayzQz/m2+jvBKd2XdkiWyWzre/v600=
X-Google-Smtp-Source: AGHT+IFItJVuiZ9trvnECd1Rb/2m30tH/qd+ElSTJLje9djjPwf97IPaxfdkD3VW/CI9gEt0KJVK4g==
X-Received: by 2002:a17:902:e748:b0:1fd:a0b9:2be6 with SMTP id d9443c01a7336-201ca120518mr6008725ad.2.1723480292451;
        Mon, 12 Aug 2024 09:31:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7e8bf8sm40070205ad.29.2024.08.12.09.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:31:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240812125733.126431-1-sth@linux.ibm.com>
References: <20240812125733.126431-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: fixes for data corruption and DMA
 alignment
Message-Id: <172348029070.92314.3161917624446152391.b4-ty@kernel.dk>
Date: Mon, 12 Aug 2024 10:31:30 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 12 Aug 2024 14:57:31 +0200, Stefan Haberland wrote:
> please apply the following two patches that fix two rather severe issues.
> The first reverts a DMA alignment patch leading to errors with xfs and 512b
> blocksize DASDs.
> 
> The second patch fixes a possible data corruption for certain storage
> server errors.
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: Remove DMA alignment
      commit: 2a07bb64d80152701d507b1498237ed1b8d83866
[2/2] s390/dasd: fix error recovery leading to data corruption on ESE devices
      commit: 7db4042336580dfd75cb5faa82c12cd51098c90b

Best regards,
-- 
Jens Axboe



