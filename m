Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C35B399023
	for <linux-s390@vger.kernel.org>; Tue, 26 May 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803768; cv=pass; b=tKdE3xIx/RywHkGD3p9Op8Y2ebTcizAOyOSgfSGZgcdWoWE9yDBPiGxXUskJo07UZo1LJQEdcz1NwlE2vWep0Lr/YuYWhagL2K6tWlBYRJYUsxbbzWSjwSP9qhRJO6EfgzqmxVwTjfK81lrxX2DNQIxx8GZ513Etw8VJZFM+3OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803768; c=relaxed/simple;
	bh=skJ4pzip99V2f4F3f4qjF4oUEt+LEBVDzI//DWmgKL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyejJy7vBNrpje2gUqJzhg7X1BCpJSF/pW7d3Wlx1Bf4JT0Pv2Y1OuFaUFFK4Xnl1krHTPddxpoZxmU2Lguj1D7A6774gFmx4/Rau7K3njuWn+eoto+jsGeY90gY+GQQRZpS15Aa49f27GRn1j2vIId9RwtBM9xy157IyTi+67k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opLzetOA; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opLzetOA"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a409f3f2dbso563147e87.1
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2026 06:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779803765; cv=none;
        d=google.com; s=arc-20240605;
        b=EZdcqa8XUdFxdw9sKC7GFV29Q91RaBUfrwxrj8cjPrPA00pSKnnWDCo0SapNWBIcLB
         OgsGTH1zXE53FlcUwgjhzfYD0C6rQf0QxOE2LcxHpN4jRa+eyDFEU/oboYyxvG7CbOl1
         JlnSjD/OJoCIR/2IMGYmEYrOESYrYIUDgL77BC1jahX1zByw/KRCKaWNNYVABDU06zkJ
         5jYtuPCy3lzsNg//KDbUxn/G8sS69OExVh6p93ghzY/wZ0C0Wr+sX2+wkxTT21mMlg9G
         ARQvNk+phfhtT1Y44qVhAFp+utBsoi1ibZtRU20yKiQKURnPmEo3QtKHDr4eNLV38jFc
         C2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=skJ4pzip99V2f4F3f4qjF4oUEt+LEBVDzI//DWmgKL0=;
        fh=maWf+dg9X4jnwjGdMTY1VZ4+0YUUKusZhkItIdK33Rw=;
        b=VIX00GBVKmc7cWOU3TH+Sfm0wZaCsRuxB3BRwqCvGDSuCPKIgu7cyvh2NbP/HMWCI/
         IuhL51Py65s/+rhA5Bg1wF02M5JY6zd0XuMRsxZvhsOb0A2+//JLFwrPWBNZ0H8MiGCq
         CadE9IGQnxqXNWELpuV5t2VR2NGTp/viDgaJ5IX/eFgd7RUn5Rey4W0XIxbK6nLqtHJy
         AU9Z14Ftaf4tQAFPATxS40nuHRnbJtZnSby1mI82elkItkrYU8q/R6xK6LQqbxeKEoV+
         xMXl2cAY9Syiz8bNn+ELiMdUyySLfnLZdqTbNd+OkeMpP+VtjErTtUI6RmoSi2s3UO2J
         etrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779803765; x=1780408565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skJ4pzip99V2f4F3f4qjF4oUEt+LEBVDzI//DWmgKL0=;
        b=opLzetOAaJ0JfKZhIqLBkMkF0ptNuUqbiizn4ldt/vCj738j2f9m9ciuMyGIPZl+u4
         BgilFRlKq6r0JuO8yJiklnNYgJgeXufH2xVQIr8PkUaTO7bZs/Kc0D+C0p1dqJMbvOPz
         V7ZtRrFmcfnOgwA2YVTbb5x6u5jmONZE1dPAWT9RAZVNvSjQKyfdOzv6D8RSvk8qY8Sa
         RB8RLB3ZEbhyiv8DegMbD7ApjWmCYuzzrdp/GqgPKtyT5rV/5FHJ+5b6IkUncdsxUgaO
         VSP0lSl2TAdaqEncckeuSlYI7R4MrVRRE+6B7jXBTc8zc/s5wpvesDkaBeIGdPcnJdLr
         cu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803765; x=1780408565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=skJ4pzip99V2f4F3f4qjF4oUEt+LEBVDzI//DWmgKL0=;
        b=B0CwY7gHiHcPsMTi+ntETUabx3Hbp/auzZqaV3uUlVtc1ejnYYVk8gOtX3kYCsW5e7
         eriXSeRiONCHcmvdwGvAMtcmcBRzRa6JYQZvj8p053hJkvCLjE0SuDG+g/fvHpzt6dAY
         wWV7svNEAVqes+/Eq1NhcIHYHMdlSAjuK9LN1jLuCJn2rUtiBCr+zdV2HtIdOWSjCKsK
         uDNUYuuKSy/sjyZrcCOSVvXKNftATyTpfZHMwCLqIlVXxBwqCtGibFd/U/Wte13Rfq0O
         T4fECRKVXoyh6QxmfyJL3lUiCzZjTSHXyNeNU+DzOlODoXE73Wv+bHKnJUXITgoc7i21
         KiUw==
X-Forwarded-Encrypted: i=1; AFNElJ85QkpXzh+bZZL6L57wa1c4lOFNj44RMBqtklGzL7XJwsmuVUFweOkBmNqzNa5pmjhBINsLxuzbcZSo@vger.kernel.org
X-Gm-Message-State: AOJu0YxIh1wBpBbE1HCm1d2DXNRPJlIDg+wjiP7p3FUsTXwo7cPTjK1X
	R8AMnGSL0OS/KR4+JWoLmlaEvahj6Jt1jz7/zKuuTJLcL8sCSgV9OW4sSzGhax3TfLaGgAqE2nO
	QttPxYeuMFzEYFzUixe+CQu6L/sQjCV8=
X-Gm-Gg: Acq92OFqS/rGhM3I7/eqk5aYLx0Sil5hvpvytu7Ohm9eybgK9ikhcwynLg/k01Gtb+p
	8fiXqM43YttVCkxxBzVeLjGxPxXna7tbY8w9TbgXgfyQjB7f4dhSZg8lA4DSPbGLlGfTc9drX6c
	vYWjj4xl1xMi6Y5PTk8KEWnbzVhpot5p4BXToJqW9O9CHyOcWcsi3IqGuEf2aDV8S1tEhEZeBRJ
	4KceJGj79DiM0aZAjvM2iwDqgtOCbUAdMWRbvTXCGax9VSsyjjG0P7jrwihjOIhKKsTeJPLnRki
	psiWZeGZfCMQNDw9R2fWr43p8eRHIsPuYwpkrFjOH86uCwnYR4PUhUSYEm6JNW6lXgtQNO6IGSQ
	i8wahSEFTWFJWlpyDEr/y6MhCTjd7gKLlFA==
X-Received: by 2002:a05:6512:63c7:20b0:5a8:63e1:aeea with SMTP id
 2adb3069b0e04-5aa32393df3mr1527774e87.7.1779803765118; Tue, 26 May 2026
 06:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521165622.279953-1-japo@linux.ibm.com>
In-Reply-To: <20260521165622.279953-1-japo@linux.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 15:55:49 +0200
X-Gm-Features: AVHnY4KTi4rsKV-gEnMi6c_xkqIBwExwCWdp00m13FmmrbjP8q7P2eHjw4934fc
Message-ID: <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch glue
To: Jan Polensky <japo@linux.ibm.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 7:03=E2=80=AFPM Jan Polensky <japo@linux.ibm.com> w=
rote:
>
> s390 currently requires a rustc due to -Zpacked-stack, and the
> minimum tool version gating is adjusted accordingly.

This doesn't matter unless the maintainer applying this uses a merge
commit for the cover letter, but there is a missing word, and if the
word was meant to be "nightly", then the paragraph is likely outdated
anyway :)

Cheers,
Miguel
