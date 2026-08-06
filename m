Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07117288D0
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025675; cv=none; b=U55DzMp7bNyleE4onw2M8dcRnJ2nih7fyKqjh5YOKyEjyKQVQwoKb9NYW5SW8Ls3hSFglHYEYEBVYU7Y4QEisopEfuy33BQfMc+AGRd6pWc3QR2kqRzvnuxOcMza1gqUHjhr7buBDO8fxpUPSb3oOPff0uHKSSMZjKE2gB5i/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025675; c=relaxed/simple;
	bh=k89shtWZG3PmZqgVkzNtFWdlVRYC43lom7EmtnfML1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fb2Mh3mba0T3zpY7xOAnHu5WHMRrkHy9mfldLkxFHtYKS6zdeUJKTFaEh45MIJgIgONT2E9trqBB82IErrW42R6LEjyOuiwszsjkBVQazyvHvAtjuEenn/ZPBlu4LwqBpzD0Jj/JYuJ3kh+QAM5ZomItotPsdqAHB3SyOD0N0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Z/L0+Ofd; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Z/L0+Ofd"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0a81d286so6096821cf.1
        for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786025671; x=1786630471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lz/ain/HwZmKc61xBLitsuffKEvoWYLNaeOuRF6K5Gs=;
        b=Z/L0+Ofdnm9QnMlqDZ0lySSbbHvwpLVuFUrEwPeNjz9JhHSKC5fYMXX437HODQOp8S
         UK2FTshxVXkFUWTCcUz88If7ikNi57FfdlLi6d3g1GiWEMdwslCQ2kSg+Uiy8t6wVJgH
         +6+DL6PlcKuRFjEdopQlrhC4ctk9AgHNhe8bl64WTNuNX2bopg9DaWzhMSVFAwjgVetI
         0dDvN1wtx6unXC/G28QFA7kSQ82SbdYUbVUpFJh80hS3U0So0xEH/56xQ4IDiDw2jjvW
         n7DjH81h0PLnOfTSiU4AjrqWTwnKiO98EpKXt06yUi3/+WqVMxntGOJFg45Md/eULa/8
         H+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025671; x=1786630471;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lz/ain/HwZmKc61xBLitsuffKEvoWYLNaeOuRF6K5Gs=;
        b=Lsv6rdkDotKjFdUDA8G3vPzaiv00OoZ/zhsHhKXfdIK9d6HWSxn3smbl6rjZJAtaFL
         LUgvuQFEW293ktxwRmF1OaT1/l+asmKYhYIBQTp1XzveTdWxrwAPXVOYhOHenIN9Zawi
         dBrjMZw2TvdHV8wumI2NpbpuZRVvYTh12f9kO+6IcKYQa7HtcNRiL5H89XNYa/TzKK/u
         Kd8Rxxl387e4HBGW4wxrfujB/YINIAaUlu8PCF7sMuoy1izIK0zA5N8FPohs5Y4e5L35
         viYSHNvpp4d5bAcRkkAqryGs927SFgTOYCJUrBM+uy7l20p8rVHdBzjkeIRvvUWv8wbN
         viwg==
X-Gm-Message-State: AOJu0Yx/9Ng2KxTE3/M3U0X6pVYbQ23hDRBGWeyPtUh8H3yjL9bBIBcX
	tp8QKD1P7/UhFm30+OmwbKVXT7QDlQbsE5hYvswFitVlm8tOYyrGzyVNARE5JPWKuD8=
X-Gm-Gg: AR+sD11NjLURHliDHjDq68Jr7/BPJRerCmSVkAo9U/aB8N9e+Jl9oM319MaCh9r2fuf
	DSSCRkn7pkc2bOQOSa0J8URnPjUSQO7/WJu8ECIL6o8PbctaLcs2saKKO5WnBIYk1M7oa2KyO0U
	5KM4MhrLxJuBM6laHRocOHt7vgNIRjhVaM8e3odmBxu4m8rLt7vka6Bz0McY/EkXFFflLEP5Nyh
	dbfhd9VVhiG1r5wDK7JETY3RgmKPd+pcXvRQQIzAJRzf86MUkIK/fRS3j6yNaVpyikmvx2mV1CH
	rMyLPFqTXmo+CdhLF0bBC7mun29GFaUhhzcJ+Ve7WvoPikKdZGvslgT3PhoF7Ajgtd/rATXhAbS
	lLvKB3KwQ5ZlkzuB0/XtJkQR6ycX41I1zTvuD/CRdID80ZOJUKlihVb+99CCpv4gJ9vgFOzIy0v
	P/bkx/Plp+QIT3idN6RZIGMKPrGhb9MGYUxsCl3zCgvJXAE+1IqG6CM+PZhwsj2i06A/yiA8WZT
	1kFgW0Zh52eVdNlnUH+Y/0TdKRhRWTEESiHh/kr8koeb1U=
X-Received: by 2002:a05:622a:11c7:b0:51c:4f35:81b8 with SMTP id d75a77b69052e-52d0039fafcmr38878621cf.7.1786025670556;
        Thu, 06 Aug 2026 07:14:30 -0700 (PDT)
Received: from [127.0.0.1] ([2605:59ca:42bb:f910:6d9f:8dfb:ae1:441b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce8972e90sm38317191cf.27.2026.08.06.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:14:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>, 
 =?utf-8?q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20260806130050.2057443-1-hca@linux.ibm.com>
References: <20260806130050.2057443-1-hca@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/block: Enable CONTEXT_ANALYSIS
Message-Id: <178602566921.2156166.6463069299091775817.b4-ty@b4>
Date: Thu, 06 Aug 2026 08:14:29 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 06 Aug 2026 15:00:48 +0200, Heiko Carstens wrote:
> Enable CONTEXT_ANALYSYS for drivers/s390/block.
> 
> Static code checking for acquiring and releasing locks used to be done
> with sparse. That was removed with [1] and replaced with a clang based
> approach [2]. The new approach requires that each subsystem needs to be
> explicitly enabled for checking.
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: Add __context_unsafe() attribute to various functions
      commit: 11d4f5e69fe25bc76e27eca75b4ef6f7aae53214
[2/2] s390/block: Enable CONTEXT_ANALYSIS
      commit: 30df3ab3c92d0e7854c54df6ae66f4aa6eb5b3d2

Best regards,
-- 
Jens Axboe



