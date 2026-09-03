Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A29E4FB9C0
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456934; cv=none; b=TxLN1YI6O2bxMTszw2Ecyvq3TP030aBuSXVvefOj1+GVuPfWyhLXSdOF6ewJRxA8vYwrRK1JGAPzLT3l7mNh7YDom917Vj7q1OQIK7KX96YryB9Vy2We6fgyedI4Kk6iqvA211gXB++vvxzhnnuXw1/tnxsE5aDBehB+pPZEWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456934; c=relaxed/simple;
	bh=4dpHZZIXlMGDgZ+1Ohw99veY4O7xbZj7iH41Dd9LmjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/8fUy/DoZxjxgnjpHsanWf7S0BmmHNulCNbd+TNVWcbzuXqIB3N2WdJBShqU4TVGsCWY2YltQAwAtue5mWs9jB0nH22iljLoLkip9BNqjgCem9zlf/KSLYpF/UhNmDOV4B5YB/b5RS2vZmN5J+TsAjb3zypDlqZKLFYKKf9VlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dFAygRP7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dFAygRP7"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2531f453eeso5644366b.3
        for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1788456930; x=1789061730; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7b6E63blAP5xnsdva8mT3bQ5wWcWdQ5+H2n507fnLTI=;
        b=dFAygRP7y0LGDC6HN4bMaXjsE/q5s0TmRRsSGO+cci3NBtUM0+1cSkfwlBMl+a75MK
         LyeXDc/XB9MwOUdaUsU+AfM8Xpbi7jfqlNYREhfw+jOrQIbt0d3r/a7mLS82b7HCcZ0/
         jZN3UjJvKamZDccEvI4JxUhMhALOPY7TIzpQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788456930; x=1789061730;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7b6E63blAP5xnsdva8mT3bQ5wWcWdQ5+H2n507fnLTI=;
        b=AJYnAE9xvHlEmJOArbJ1+dEqu81JrIa7We8CWFkewTR99eeFP8cZL+O1F8qtooSlJz
         iLuuy69R37D8epLYaVmtyyhJ3X9fAHxhFrstRkJnT6xTCOJ13ka3v4r2haqe/Y4Ld8dN
         zQFuxY1i+uEoZMNkNvL77VM1SLvGTCX6FaPDZ1kI90yzdZMe9UTJ9iFU9Jti+uwRQIwJ
         8GUX298xu0qFBpgXtHRjhJtCiGESNaE4vMszjrxS7pVn8rpYg90ddj0+PfNrH8m+KHvi
         fbQNPq48tqY2nz1A/wHdxkb2p360iDPw4ix0h6NSPM8jc8tB857BTUZxZnUAL4zHqMu7
         nVpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaSH3jBwXUuD+ZP6Q1/9CIp3dGi5qFhyzqyFIOwpWC2fluhdY8SioTMdHtNx0xBJ+I/2+GIWICclne@vger.kernel.org
X-Gm-Message-State: AFuF++mDnyQCafEekM2q+hGhgBLvgbdxfbTe6g8g3WZrN9fGchwyGPaS
	fkkRAk+RkY25dqT7Lw0QOo3+0s84ykJiG3TCfpToWGrTSOuJJiWsFS72QMH3GMSYffNsw7wZgZH
	Q6jVCPVo=
X-Gm-Gg: AYBFou1NzW/yFaHM6x23hBRmfSElppxkj9UYhM2aZvz8iUxIJMQBky9znUXylt6pAY9
	3fpiOPt/43jTH3gmQAF37YnC/vKIOY69vS5zYgr1q1v7gFsgImoiXltjYxPtdIXu3Abe4g/Tg19
	sKsVeTXVojdrC357x9HE+A9KMbcS/mIduepjfjv6kCZwDklY5NnAcw8mCS4l8bJ0f1Z/cnFxeRR
	sAZ3aEmqm82cJIn3S3alGasPMZTJCbcwE6d2zdDEaWsVirMiADB1o7xnnMTxEcIfDVaQlmIeXFJ
	Jum58P41AgPo8hTgyYU57BwbDazJuywuSC8xMqgneshMAdzgY91aKSQxgoFExM9JynmIBAOi1Pa
	2SBCM8ec0gqmROWcwxsHsM89uBQ/l19nq2AFxFkmeuhWfV+o4zBiqiI5zmr6/FQXKDfM6vGZeOU
	SxPxv0fHEO5wDXt9gqhHDrFEcoiR1ZVoDQwNKDU0pkCMB8MS2hGO1AczWFtsRdW7Wp+XBvlGTuG
	AS20ThljVOv1xspbj+VXtRbzJcFheQIz04z/PfUy/ZdgHzy
X-Received: by 2002:a17:906:7308:b0:c20:9447:bd5e with SMTP id a640c23a62f3a-c260c8e77fcmr23193266b.9.1788456930059;
        Thu, 03 Sep 2026 10:35:30 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d036652sm2737366b.2.2026.09.03.10.35.29
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 10:35:29 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c160420289bso9332966b.0
        for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 10:35:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxoF2ZqxVEelinDQb/+eN+COflpBGC9KU1rQ6PHhkkCfQqwNzoYWYoM7OBjOMeXG3maCCBrvpRhZWs9@vger.kernel.org
X-Received: by 2002:a17:907:d93:b0:c25:2a78:15ed with SMTP id
 a640c23a62f3a-c260c8b4c36mr21478166b.6.1788456929113; Thu, 03 Sep 2026
 10:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903171054.12158A58-hca@linux.ibm.com>
In-Reply-To: <20260903171054.12158A58-hca@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Sep 2026 10:35:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmQsV=5PEkazqEJcV529Y9jLry9XL2u+XJLHrkMYd7Gw@mail.gmail.com>
X-Gm-Features: AcwNN1Xdw4-Usv463WhkZMP9y3XuNRoReBatSAOiiqD-FTNXu0MZMY5Ezb6E1vw
Message-ID: <CAHk-=wgmQsV=5PEkazqEJcV529Y9jLry9XL2u+XJLHrkMYd7Gw@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 7.3-rc2
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sept 2026 at 10:11, Heiko Carstens <hca@linux.ibm.com> wrote:
>
> - Use jiffies instead of jiffies_64 to address a data-race reported by
>   KCSAN

I went all "Whaa?" on this - that makes no sense. Isn't s390 now all
64-bit, and there should be no data-race..

This seems to be entirely due to the fact that 'jiffies_64' isn't
marked volatile, so KCSAN complains about lack of locking. There's no
real data race as far as I can tell.

I can't recall why jiffies_64 isn't marked volatile. It may be just an
oversight. And it may be a "it caused gcc to generate crap code on
32-bit architectures". Or it may be something else.

But I think we should probably just fix jiffies_64, instead of having
bogus "make KCSAN happy" commits.

I have pulled your tree - it's not like any of this is *important*, it
was just confusing to me.

              Linus
