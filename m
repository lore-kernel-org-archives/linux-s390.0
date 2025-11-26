Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504871E231E
	for <linux-s390@vger.kernel.org>; Wed, 26 Nov 2025 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177278; cv=none; b=HTexxBWiHr42ptvjWdoMu2PkdgWbbI7Cyqy6OPe6VX6qqGfPOtuLVf0pXb+4qGcIsfSc0GMAP00KrJgZxIhw6YA8WxMaNC9nIgQyxK4jHHHsK2RFYGqfUEHJHmCa4JLT59laZh6FlJqDevMZE84TAW3eZBAbdik8AiSZsXg6Rbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177278; c=relaxed/simple;
	bh=uWVb7imaoBwQd084csoILb6EvrrasnUptYGTVswGUdg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I9ilXQ7ThgTOATEaW+LcvpqPwzfxrbO3vcezlEYbEn/iwZEA7+tVfhxUjW5WSf+tgWg11bh4jGXibnXAZS2t6HxGJvbfWy9wNg2TD9OKvw5Mr7noOv98N3Q/uqM/yxzA2EggK835a4qP3n+25k+27moWdulvclSDxsybdZ2YzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P7R6wbO0; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P7R6wbO0"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4331709968fso84205ab.2
        for <linux-s390@vger.kernel.org>; Wed, 26 Nov 2025 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764177275; x=1764782075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Waaw/w2j2pENd/kSDmzcSGfaP1pnvDn9JVdDG4gqLck=;
        b=P7R6wbO0eEMFlSfHdnGGCLpHJN8Pf+J8hAPffkG6H0Is17JkabMfPoDYftvhFmrGuz
         5CKwXv0jtlYZmoa8O6chWylRb70FOFfb7n3vpQJBshOX2OaayM1xL0PAEWJkoXKCJ8Bh
         119v4cTgvRdRslLxRgzcWlFVpo04IcQsqpTAGDRAEpgpwiw+TszGby8zN4LBSwckGVSl
         rLhfZdu20tSLOVkVy9i0xPvrWglrkipSeYeDpur0iD3tNv9b0MZklPd9nizzkyVCfNEB
         bjRQxMEEXZjApH2cMSs2t5bQpv8uO+5thOs2EeZ06SRmWml3Krpt1kEVQ0hnTbIMQkfX
         9fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764177275; x=1764782075;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Waaw/w2j2pENd/kSDmzcSGfaP1pnvDn9JVdDG4gqLck=;
        b=hMKwthHaSBq0CinpYm7gKfbICFAO+aEoeznUXIDZo0TF11UC+SlGNS7ID4GuekrGGm
         OyIlqA3TTVXEC9xhXjtEDjLHvJ0ZLdPm/OPZl+iFseYw6rsJht0bzKxW8X32fhg3vopN
         Whr4Jp2Iuh/UtNJJ4uXzko2TRYMeUpg3i2kykstxMdSNtG5lY35MDj7ZAgbkOml1xdFj
         U5pw3lgxpuqz9mz9rc0W1+J+pRekJss7bZ2KUQqbzbvFajSr5Y+wF74dmaTHh9G898iK
         rFLNPUzIx4xvXc+gEf7Felc4lpx2xv8FMUB2FVBZLhc6G8ioWwiA87mJNe4aZsnqGAgH
         pqLA==
X-Forwarded-Encrypted: i=1; AJvYcCXOIVi+EIrpitIGzrEZq6fG15uRQgoNDuiELIWQ/JC5M/wZclCtkHgLda1+ZEukOmtiPM+uXtnwfweS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxylf/k/FTNKi/xABFKLXEWVuq41bddn2SJjgXR/V0dEH08qtof
	dddQXQTsDnmilL84QRsVfH0TEce6B0vO9b44yBn6i4ZsgiSpsJ5x2trXlJoQslt47dg=
X-Gm-Gg: ASbGnct6qd/OaKCFP4TccnmqvOSki9heCY3Ko+ylZMWnzBuZXRmFZ0O008ia2ml122x
	yAYuy7syXMWYjbE0OrhlRq4USMHZ1D81+wkrudaECOXKOj0AIRzbzaOLSJgQL1ZRFSyoTiJdxRw
	Z/sd5nc4feqJu+PevMuFC2rhNrBLQ+eyXivf4SSJnqIHnzxOG2CpIeS+CD77X0hpVFIxxWMsJLp
	pdilJOWvdMMEn2Gtd2eybMfyKtgtbgnQ3iZtaYHYYZz6eNxlwlcyM5hZtq9KjPT51fij2QfJh0H
	o3hLx8l5ODWiCfjKig8WHAtMJvBGxSF5aB7vyjQWwWfGxkkPwTqdHgNnTq1LGPOGORO7BlX6bul
	bgbwmeWTNTC8yEffdZkQ6CuSrlrPhtJnOIBM8S63y9OdP07+vBLHQEKFq/DB1TvUPdbI4be4Chq
	I+Qg==
X-Google-Smtp-Source: AGHT+IHwHHDUwlmQFfLs1EZPhOMv9ft82AclYixifNYet0D7/yodkeU+uFnr4uBAVbfHn8ILovtdkw==
X-Received: by 2002:a05:6e02:3e92:b0:433:5e33:d41d with SMTP id e9e14a558f8ab-435b8e7a0dcmr160640095ab.30.1764177275359;
        Wed, 26 Nov 2025 09:14:35 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90dba32sm88409755ab.28.2025.11.26.09.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 09:14:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20251126160634.3446919-1-sth@linux.ibm.com>
References: <20251126160634.3446919-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/4] s390/dasd: Minor cleanups and copy-pair swap fix
Message-Id: <176417727431.85325.2478471808597740699.b4-ty@kernel.dk>
Date: Wed, 26 Nov 2025 10:14:34 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 26 Nov 2025 17:06:30 +0100, Stefan Haberland wrote:
> this small series contains cleanups in the DASD driver
> (string formatting, naming helper refactoring, debugfs simplification)
> as well as a fix for the gendisk parent after a copy-pair swap.
> 
> Please apply.
> 
> Thanks,
> Stefan
> 
> [...]

Applied, thanks!

[1/4] s390/dasd: Fix gendisk parent after copy pair swap
      commit: c943bfc6afb8d0e781b9b7406f36caa8bbf95cb9
[2/4] s390/dasd: Remove unnecessary debugfs_create() return checks
      commit: 764def9e8eaf1b1ccdcd89b8c16db4194ade775f
[3/4] s390/dasd: Move device name formatting into separate function
      commit: 43198756ee8cade0acc17a89f959764cd17776bb
[4/4] s390/dasd: Use scnprintf() instead of sprintf()
      commit: a857d99201cc4eb3cb78b9dcb6f1d027ef3ae699

Best regards,
-- 
Jens Axboe



