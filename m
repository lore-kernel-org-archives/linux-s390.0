Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABCA13665B
	for <linux-s390@vger.kernel.org>; Thu, 15 Feb 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016062; cv=none; b=P7JQyAbCqe03DJ9ltDo4V77gD5Jyl0LHtNsEcbKB95MApwLWOmwoEw20g13+1WRhdhUkvCGVvcALqecQA7IzfxBdeMQARe0Sl9ojgi95fM1nK4zLghJZvgp21Ysz/BZnbSsJzje77gsArFgc+GaEWlUX9ws7M+oxWgvBtaFKVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016062; c=relaxed/simple;
	bh=Qz4PPFUkifJGyaRWPKT8EHaiOM/kn2UbDqOefUgZCmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFOyJ8RVf3Ed22sm3UqoCtcFFphUOtTaUGa8FbTvwzQpO/7dS4RDln3du/3KRNGpwtqO3kYZOtp9dLkh6XgNxXzVPHGYJI45Z3kHS+mmnqXizAJY3s2NCm6LwXa3qQ/DjPwcI1RdGqyC4LNqAMJz19HeTIB5YeMah9H9nj6mScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pre7Mcfz; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pre7Mcfz"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607eefeea90so1845997b3.1
        for <linux-s390@vger.kernel.org>; Thu, 15 Feb 2024 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708016059; x=1708620859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEQiCmvhKfS0/A0znECfTzFjRTV/dZsqotvM6rEKanU=;
        b=pre7McfzotVVLA5sRjwMy2EQnVCLSkXeRtOFWwJdhon6KseboIF957xeL8jvjEQbuC
         83P48RFGgvSLKtcvW8Faxk/3+hpwiNc2E26f2oM4oWWVgW3yqy3FzsPRqi8rklqZ8il5
         sJIBJmfC476mwH3QuRT2sx6zo8YzUeqiHTOsz+EczCsA++VJX3CWBTFTNfWnLJlK49X+
         vyfS4aEYNO5eYd4NGkBL1YEHDiCJW1LdR4RR/xaWNpFHmvQXIwH0x6bC0wB2Wnu5NgvM
         MXu9+6r6mlPvmIBWs9oNpChgrhT0C0Xmob4klZmQRrjjNdemKJNRieQFabOeTfbbhU/v
         yyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708016059; x=1708620859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEQiCmvhKfS0/A0znECfTzFjRTV/dZsqotvM6rEKanU=;
        b=fw5PozmAxk5X+QrP8NIYw6QWVYT4DMi2AYTr9u+SZWZJrHEmm3zKAEK5nECnPUDXnc
         kzB/jYBrqsh/QgY5IL2sXy6KF5Uu8vsKmA0Ue7V1VvI2nDyQu/fZni8fZYres+pJSten
         HDh4nQcMK+XvCpEt97pvzpeqcIuwCvyOc9Qy8WvFR5nbvVkfxPyIU65RH0fKjFmLiX51
         5nI50Pt9pRJ7bKa9SQZQqJE9zmQab0j6/cakBSF/G++p5gMEi/h1U64FiC31zO/tp2Rj
         mW5e4hg2TK1Oe6eRvpjRId1XPSOJmwp0aZwdR9ZTq5pqP+eVpQMnM7PHIHEu5d8Q+cdW
         IGBA==
X-Forwarded-Encrypted: i=1; AJvYcCUSOot0alnMM8jMuqQXWNjDT5+wWgiMJrWDenOv636odwTRO7xCiXrSz0EAulHc1BjGD91Q2kkrb6SYmHD7kfZIOq1/Bw51dZBnoQ==
X-Gm-Message-State: AOJu0YzMNqMVI4LPx8ym7JkdKoYsAXG3zJC/RuCFiX+42pyHRRfgPOyv
	O1GPiM7i+wIrhTNtDqKwb/zGVABa5XjGMaB6RRLDx8BRHg4qoBimpJ45G8WOXEZwJxWAjvWlH1r
	bLTfszG0ynQ3lER/RZNzrIznHmYz27I+L11ueSA==
X-Google-Smtp-Source: AGHT+IF28WiAUAxb9BXDQ9j656YBYmKEubg2qRwCcoIKEiRoMN+j/rX1+ioqB8yOfGTSrxa8mYZDRwHKLR7BN/dl2kA=
X-Received: by 2002:a81:b717:0:b0:607:c65a:ba02 with SMTP id
 v23-20020a81b717000000b00607c65aba02mr1752372ywh.17.1708016059449; Thu, 15
 Feb 2024 08:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215070300.2200308-1-hch@lst.de> <20240215070300.2200308-18-hch@lst.de>
 <CAPDyKFqPnC9jwWnoVz+UVJJ_SGYnB4CrB8jmJOSxCnT7AYQrKg@mail.gmail.com> <20240215164942.GA19722@lst.de>
In-Reply-To: <20240215164942.GA19722@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Feb 2024 17:53:43 +0100
Message-ID: <CAPDyKFpSNL28sWqNMY9Y2+tP9VMd_Wabnw1hVjQ-g0RfKCUVgQ@mail.gmail.com>
Subject: Re: [PATCH 17/17] mmc: pass queue_limits to blk_mq_alloc_disk
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Justin Sanders <justin@coraid.com>, Denis Efremov <efremov@linux.com>, 
	Josef Bacik <josef@toxicpanda.com>, Geoff Levand <geoff@infradead.org>, 
	Ilya Dryomov <idryomov@gmail.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jack Wang <jinpu.wang@ionos.com>, Ming Lei <ming.lei@redhat.com>, 
	Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	ceph-devel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 17:49, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Feb 15, 2024 at 05:40:37PM +0100, Ulf Hansson wrote:
> > Looks like $subject patch, patch11 and patch12  have already been
> > queued up as they are cooking linux-next. Normally I prefer to funnel
> > these via my mmc tree, to avoid potential conflicts (mostly for mmc,
> > where more active developments are ongoing).
>
> None of this is in my fresh linux-next pull, which would be rather
> surprising anyway as I've just sent them out and Jens isn't that
> quick to merge unreviewed series :)

Weird. :-)

>
> That being said it depends on prep patches in the block tree and thus
> I'd prefer merging this entire series through that tree.

Okay, in that case, np! Next time, it would be nice to get that
information upfront in a cover-letter or similar.

If not too late, feel free to add my acks on the three patches for mmc
and memstick.

Kind regards
Uffe
