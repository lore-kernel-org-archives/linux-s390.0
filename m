Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9B288C26
	for <linux-s390@vger.kernel.org>; Thu, 25 Sep 2025 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818146; cv=none; b=Vyz2kplAebxtPCWjeuAXeetGu5kkIO7TkwIZT0L9bhBjLtyCl7FhHc27me1y3XgcXTFTfhc3IOWjLCsMHfQ8U+fpuoJelpV2Zx3uOCRmBlzZ9+9eRsntp/IqP8PRk9DG1Oda2jXtFe2BLxiF0VV4HVomOCjXdmuY8ClK8fy6JC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818146; c=relaxed/simple;
	bh=Fmn7IjoQIv9FRmzL/xrdDgXANZVPEe3JHVjyckWd2C0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YTUhDgnEBAoK1RdNfZDZoQO3Nw1e1zyMOz/iIzBE1zR1exm7Y/vL91geYF+llr59aPIBpbmdCZK6jcAsgo3lSayOfjVADNpqymSLmjDFVj+xxQdhjJSkm8JS8utt34QirqWIAVuqzOtPC8s3YHGKEjyGJYPGbWlIQugOojmist8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Y+vnPSkB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Y+vnPSkB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso7634585e9.3
        for <linux-s390@vger.kernel.org>; Thu, 25 Sep 2025 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758818142; x=1759422942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj7JjVSC0RoD6Ozw5QK0MUosTSL+RlkeKmfamN53FeY=;
        b=Y+vnPSkBDEJ5E92f7KWxtO04eJqCLnGFh5EPDLepola92OE9ulwnXfQT9KpAGpgICZ
         rU7WAXv86dW6Q8afefT6jFr4rDX9fkWdgzsBoq+U5dMSg+/YLIBlcHAZQRI08+JdlWN4
         Qe1vx/87IiS4/Dy+xEL8U5HwlCzUfqGF7ULk371lA51vv4jghJkkfGTYEjTuAshOrlRH
         gcU3LMB9XUSYJpzj+3MheENzKaw9vkv5fKUaUlyEzSaySm4yIzgGBIENls3Q1m3K7C5O
         r5aB6ICg3/uatruJMdIp/A6J38joFw0vEVZsBNueeyeOn+l009qBw57YPjZsoUo9aFjH
         Oe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758818142; x=1759422942;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj7JjVSC0RoD6Ozw5QK0MUosTSL+RlkeKmfamN53FeY=;
        b=MB4vTLp/rXE0lbM1nKvCB+jPr1N7e51vBvQkPT6W68LnQ9zgJQjyy7itDATPdo6C0x
         A4IwItBo6YoG1i5dkeqAgTMghJ04J8iCVsRbizPusDxaftq9rc5iCNfT63HB5URshX0U
         CqduYftasymJqXASSbk1J8d8uGHYxyM/JU43Duo1GAsIsYVIvEkkstrWmXKfxXYHTDdt
         YGztAw3gS6JeQIYpyiPxV3VRPiIw0xbFmV2vJY6Am43FhAsgoYtv1AEMcCp725yMWCgd
         UdKKEAVjI06CrJ8rMuboZMCGQVA+O9hLrHFJP/g70XeipRtk2eDspHyZlFVToJtcFgwP
         WOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+nmQ/E7yukVfZfjjinVN70DFsgzhn6RKKQ/Ty431i+ZoxJ4TuNDf8xdmYiWvLX/C05vg8gLoHSx5O@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7e68oo8cWrG0P3sjb24uaV50bJwZEBkAkNC4Ryq+IWIfCYR6l
	QthL8ImWKYPudtxPvHRqazH86GNAsgb+JQrU9d/H4313MQ4fc9M04v4OIuZ9SO9l+ps=
X-Gm-Gg: ASbGncuMdY4eNaOhsHmBGaQlQX3ZyoTznIV9RXSSJWs037BNR1QiQbQ8nCVpFtifS5b
	VbS1Akl/HxwPLXU/czD0/AEx93Uyxzen6ITX5gVeLTjIuSDm8i7rN3TaMpAzNTt6q9WbqsCyzzf
	E+37lOX5++JkU8763F67QRTrtFr75AxBAGiinn6mi/bwDNUZOmdnAt63er6RBL++KAt8sdTVq5Z
	sltCFJ5ZI/YHccRVeCJ9BOl+m5eR/PAn3pxnXh2TK6XvKilmh7IIUu9hAGldSh/CAvbx7tobyyF
	7zx8XzwAE4NZLyckP84emOEBORzKscfZji5NsyWEiCn6/jSRt35ojBb99jHjQcZePYoJr31UBuD
	HWQAGspd7X6GI4ekz7A==
X-Google-Smtp-Source: AGHT+IHrhV7zj5vdcJDKTvHq5JEepKwIgmKJXmrvq3j23cyzlH3maYczJFkCYtf1TXqWG8vlrXeEtQ==
X-Received: by 2002:a05:600c:1c86:b0:46d:5846:df0c with SMTP id 5b1f17b1804b1-46e32a14839mr45102805e9.34.1758818142018;
        Thu, 25 Sep 2025 09:35:42 -0700 (PDT)
Received: from [127.0.0.1] ([213.174.118.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e330fbcc5sm20664745e9.4.2025.09.25.09.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:35:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Jaehoon Kim <jhkim@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20250925154708.644575-1-sth@linux.ibm.com>
References: <20250925154708.644575-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: fix buffer alignment validation
Message-Id: <175881814049.459270.12889297398972326270.b4-ty@kernel.dk>
Date: Thu, 25 Sep 2025 10:35:40 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 25 Sep 2025 17:47:06 +0200, Stefan Haberland wrote:
> please apply the following two patches that fix buffer alignment
> handling in the DASD driver.
> The first patch corrects the error mapping for misaligned requests,
> and the second enforces proper alignment validation in the block layer.
> 
> 
> Jaehoon Kim (2):
>   s390/dasd: Return BLK_STS_INVAL for EINVAL from do_dasd_request
>   s390/dasd: enforce dma_alignment to ensure proper buffer validation
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: Return BLK_STS_INVAL for EINVAL from do_dasd_request
      (no commit info)
[2/2] s390/dasd: enforce dma_alignment to ensure proper buffer validation
      (no commit info)

Best regards,
-- 
Jens Axboe



