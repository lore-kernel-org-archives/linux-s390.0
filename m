Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB32FDC30
	for <linux-s390@vger.kernel.org>; Mon,  8 Sep 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334433; cv=none; b=JDu6gortXNnwyEqIU2lW7wN4YEwZWh5idmtJnJkaiQ1W+mIIXY4SGHQ5U4QsP5qsszThDQTbR8yjuDTYvIOq2+GRUyDGs4EH6Gg5QEMl0m3s02G8C1ISvNxfPj6RwBd8YJ1YKL5iNClM3jMIW4P4QtabddN1Ioykz/M4qr1uou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334433; c=relaxed/simple;
	bh=ferqKjXFtqGeb7sFdzv7UE52DVVJqiUPYvwdn/1ZU4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBkBnZamzU0MUGI9y65ATy+vbv7pT1iLi65Qr8DxVrFDbSGK3jiOMShyq5Hw8JZdYuWLni+vC/IaHx1ujoznSgoDC9gQ78cHnZfDWmddyOmHNhvKg2nLcpcZmjseDYNTeJelHd55QELm1KJdv6KNh7tfCVUyhkSVuPSXOQXp0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=got50yaj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="got50yaj"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f98e7782bso4991900e87.0
        for <linux-s390@vger.kernel.org>; Mon, 08 Sep 2025 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757334430; x=1757939230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ferqKjXFtqGeb7sFdzv7UE52DVVJqiUPYvwdn/1ZU4Q=;
        b=got50yajiIp71VHYbQ7EldZDzjLtNfDG5NgHWQ2+qG+Uz+iQONuQZyPepwKiqpxQMZ
         NS8AvRObW00TBrkA5si/lZCduA5n8zX9S9j2xX/RWvYwLDaF2I++Q0hpCWAlW7KFjvja
         DQS/LoEcAsN59c58It0RxsLsvDWWwR3uTO/8S8fS6OPvH/HMPp80LUgpO1usgDYOdviI
         gHGWdLCAfAxk82HyH+EBWtEsEJ7UsFIkTA/kpnBhL8/mv6fCG7Z/WJNoFMpmgLrCqz0U
         xe8c70K36HFaXDXRzeyG0CK5pAqZ16DVj57PXad4yWOGtLQQnuqD7wix/2L7UWmTCdrf
         eQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757334430; x=1757939230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ferqKjXFtqGeb7sFdzv7UE52DVVJqiUPYvwdn/1ZU4Q=;
        b=Qcjja3glMdGPu3lfqVxTyb2YbUjMebhAzDUMllFBVDQUTCTNaP06BkWOFrQXjgYgIJ
         7g032rEX6Ve+BEl/rPEnoQwrQKbqiwoANMSptQONkmD54nOY2co7B95Ow+THQqH943S1
         vQlJgMnzCmzRUVNZrt2LDqa/VLoKC6U9HKxFVAHmv1hVzgGapHJAAa6zRVgM7w5wONiw
         I19skPmAlQimtI8B2YI/XgLoLURCm8XsmovrQo4LhccHdmzKfE7JDPIdlubPKQWavvF2
         cedT3Vf1dNugQtyLupnY7FiMoOk3k6IVM86ALcDakKoviuT31Sy56t7QSYOw80/Qq3ZN
         lybA==
X-Forwarded-Encrypted: i=1; AJvYcCWgdmgolG6Bxu1YhrjnA6N52AwHLeskMah4bLwDlCLFrxY/F5c49hTtnzT5tIhXbpbwS9OkfJx2iAf0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Gfz/dzev3xkr3od8Ky+6qTQrDopxzllsjvDsl0BgeI//PJSt
	1+qGsgXXtR9g9pKS7dijqoRGEW8zgSKor2KCkEP0C1wUW5ay0kKicR1V9MiyUEZxdWAU5r4g/Q5
	PMIZtenu0l/91OQ+isvbbTzynb76OHzsO4NSSIiZ7hw==
X-Gm-Gg: ASbGncsux5wCmDX4zchnqMRPjMyM+4xlPD0Nj5Do/Gp1h59u9RkI/1KCUwcfhsF4bej
	mEYLNv2rdShKXL8QmS9Prxr8bLMwPsucJYYtp2y9wRIARDF7cWU1l/+J/BS5ZXc2lsoyNfbaVS7
	lYNPH859fafPNP5u+mWQ1XvKLdFOBOQ3Osq3KEMd3cWVrob4v4J75jLlJr8DCwQ3IByA9ZMQ9tV
	oZyJzbPGTkfF7t5G7E4XtVySj9iIO8GqDOR5Ykuo4lgNITx6vM=
X-Google-Smtp-Source: AGHT+IFrVYcRJkJidkEmKsfcO0oDpqsP4H/zygbfQx0jx6wBEnrg8xIY6th1peRb5x5em5L/xmD++ZGP83XbRY1pAmg=
X-Received: by 2002:ac2:57c7:0:b0:55f:5c1d:6cc4 with SMTP id
 2adb3069b0e04-560995d6aaamr2726817e87.20.1757334429706; Mon, 08 Sep 2025
 05:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090857.108240-1-marco.crivellari@suse.com>
 <20250905090857.108240-2-marco.crivellari@suse.com> <1f2a16a0-9c14-4403-9c39-35f8b8138188-agordeev@linux.ibm.com>
In-Reply-To: <1f2a16a0-9c14-4403-9c39-35f8b8138188-agordeev@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 8 Sep 2025 14:26:57 +0200
X-Gm-Features: Ac12FXxAIlK7zn-tspBWXA8RzSIF6QGQXIp8HUKs624vrIFiTe0KEM4TXyIvB2c
Message-ID: <CAAofZF4GJbL4wmjxDTQYJg7Mp_GjLVrR9trek7DqoH0EniX2uA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/s390: WQ_PERCPU added to alloc_workqueue users
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:38=E2=80=AFPM Alexander Gordeev <agordeev@linux.ib=
m.com> wrote:
> > This default is suboptimal: most workloads benefit from unbound queues,
> > allowing the scheduler to place worker threads where they=E2=80=99re ne=
eded and
> > reducing noise when CPUs are isolated.
>
> A duplicate paragraph.
>

> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thank you, Alexander!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com
