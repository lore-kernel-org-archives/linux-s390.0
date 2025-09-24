Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F643280A2C
	for <linux-s390@vger.kernel.org>; Wed, 24 Sep 2025 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701525; cv=none; b=D521jvTIwgg4oWVJeT+xKJO+fjkE+elX48a6wrfGcMSJSJKAQDfHMPEzzuoco/G2BjJr496/MMXWx3xTKqIQ8zsJt5zWXJxJKCTgBQwyGiPXSR/5mNqn+z+2xOXPrkQBOv3h8Ve15FsHO03cZEfQdZJnsHZLR5wvAC/IOB5o070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701525; c=relaxed/simple;
	bh=VmkA7XO9iwCF3zoLLDk+sKiWrqkJeeL94QJkshniWFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7dA9PIP6h6+LtzycBoRLTnw2t5FEoLiyZ39Px9CSJGmJ72arefIRzVwI75VmCG6T9JO5/uXJ0qkHnxOzWLccdb5soUAHuwbQeQkOfr+QjahIKgpIIS5JhFbuy9WSnpO+sPwNzZHFohaPDB146NRKwreZiu4yagB7SjaxFU30EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E8VtmVm9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E8VtmVm9"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-36a6a3974fdso37163011fa.0
        for <linux-s390@vger.kernel.org>; Wed, 24 Sep 2025 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758701521; x=1759306321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmkA7XO9iwCF3zoLLDk+sKiWrqkJeeL94QJkshniWFg=;
        b=E8VtmVm9URhqNg+j8xJaQGu+VqOc4Kd2xTVxkG4u5vWblDIRsT6ur5+1X7Bw51RZhE
         oPI7MVpoHRe2Gj8VeDoT4Bsa3wme+LaLrzhUaPXdJ7fjJX0zxG01kNkrotfxRMVrakLF
         ucmHok/GTXYj75TySLC5mnA9RNc02SXrsyX1CXiRvbQ34tkswJlPeViZLBp/rVFMl7SU
         L4U6kYbe2FeWuXPQUr0FBK0G4E4v4yvx0lppttA/6DZBDUDy/mufR+xYVLR1qDw1qm8T
         rfFY4G76e1R6rYtitcLkXvS5yqTIFhzNPkMKWIfuUJHDCEkrD8jtKYGLytFJ6uXtx8wH
         g8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701521; x=1759306321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmkA7XO9iwCF3zoLLDk+sKiWrqkJeeL94QJkshniWFg=;
        b=MPgFqzThUiUuvtGCJo8d8veOyHylfgPwXUQwKdSUUnkgD7ZfV0qU5NnqUCFzd9l/oq
         0DOWkfpbIMSa6MJg853YblpBHLR4k4tkMlctp6dK3k+/ZKLxyF35aMEa9rKTSvGoDaqE
         Ato61u82h8v672qnwO2NzCw74wOXzl+HJpT6sYWAO+qu3VtUH98ZNkT/Ie7J/T9+L4M+
         6aFMqaanFGyPZ0yD9/56zqm7OLd5q8vYQPmrKCvRTAtdtgbTtM+dNl/Nk+wCWLzL2bh3
         RUTu3ULD1Ryh/U8+xbE82BH451BXC+SUjdWfoJWJ9QkeYxhR7g+OcLrnNCR+ddJdhxke
         /y8g==
X-Forwarded-Encrypted: i=1; AJvYcCXmqWwFljkisz2gehL4tcl8Ont45huqr1pW5ntWMLfmFCLzr2ZdfqrIaCTAUePMACOXsMzmT+L4DrCN@vger.kernel.org
X-Gm-Message-State: AOJu0YwFpPwtqIWKrHPxzbQdhaPJjpxFYsZdECPvSdKd7xoOtSSyOUGH
	eO/PbQ0bPa+yeT9wprg9NQpMgNwRFW0VtpAOGvbTOawi03W/x96YzZQHmahQSlOVzcFIPhMPV7n
	oh5LJDFPlXezH5CEP5PmzSK7ewuSoZRQXNgv9+36jFg==
X-Gm-Gg: ASbGncu1ztp7eX1qdonQ43MTxcPkua0s/CJMkfG5MCpMmu/86wN6xQUXwg47KgA1cU/
	7srjUFUB2fZ2ocwNNtGrM+Ezs2q5U9TxFZOznThbnN2WuOBZuGQ5c3ByAjiEBRjmutSBz8cX7FH
	ztKNQ43iGmyAvSHw513xBsgWWuzt2zwfl7B/h/uDjqPNf9OgSDyGijba737dF89hpx9nECRjdZU
	w/XExDcT8r9yqQJOBjKlkS5p+M0gllfxVGWGMOymXA8vNJPwk4=
X-Google-Smtp-Source: AGHT+IHPQ1a0UxwW+MuOyVJBRCeoASaGWNoAoc7NUPlGBb+q7qMkCVHVIzSZMXDix4Vz2Xa6LdPqxoU5tzdwpGZNqd4=
X-Received: by 2002:a2e:bea3:0:b0:36e:4481:9eaf with SMTP id
 38308e7fff4ca-36e4481a41amr6707431fa.15.1758701521434; Wed, 24 Sep 2025
 01:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917153859.363593-1-marco.crivellari@suse.com>
 <20250917153859.363593-4-marco.crivellari@suse.com> <72d10c3f-c036-4813-a256-9d7adba4bfec@linux.ibm.com>
In-Reply-To: <72d10c3f-c036-4813-a256-9d7adba4bfec@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 24 Sep 2025 10:11:50 +0200
X-Gm-Features: AS18NWD24pmUR_DcuMreVDvQhvWrlztpWLqsqSgOJKvqVmAcXh5G04QuDlvKZjU
Message-ID: <CAAofZF5KbMqyrhraMJkuWYwyPtn+W10vMNa0LfPYF7ZEd5evdw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] s390: replace use of system_wq with system_dfl_wq
To: Mete Durlu <meted@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:05=E2=80=AFAM Mete Durlu <meted@linux.ibm.com> w=
rote:
> [...]
> Thank you for making the change from *_percpu_wq to *_dfl_wq.
> I am not sure if its too late but you can have my r-b
>
> Reviewed-by: Mete Durlu <meted@linux.ibm.com>

Many thanks, Mete! :-)

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
