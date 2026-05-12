Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5243655C7
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587867; cv=pass; b=RWL5GstmcTCdy5j8EFqQ6Tu0BaPnQ3HINr4jNGWDqrDkyafqHuOgvGbF1LryZKYUHvLQlVX/wOZxFtkeu2bbNHujVRDqAEsL1U05BXCpiBXtdcS4N5U6zlJbcHHeOi3/PS0j5W5ehPQnRerfKTytrbgcB4byCKpwjVSYCY6GyeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587867; c=relaxed/simple;
	bh=PLQSI2THlOQqiY7RD4WJZ/OaMfhEcNpVcgw3SQjFw80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD1BJSoaTyHgjW983H8E0EoxGyJoVZ2D/yA3djMpnflyk2FrZv+Yg5PHKaJXOESZ0eG0fQNpayb1my6mxiLPlWsJiXdBhdWbI32W9UdcalruTKz+/EygYEfJAbaxbOEtwPMgY7SPsOA3D7BqiQ4nwKEXPu1H+SQzPiCAZcoxpMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4azMIn6; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4azMIn6"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c87f1f8c8so436216c88.2
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 05:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778587865; cv=none;
        d=google.com; s=arc-20240605;
        b=IxLUDs3umciBgnlGEiXDKIkf440YkDbzlXNMBFNdUBbgiYJnWYp2VPaTVtoWnQLgw/
         339GfN3evPQDiqtWfiCH7iLuMBp3aVWL5hyhmB7hw3oIn36JqmN9a8frF8wCMYzOaMB/
         AN67liNLohDdaj1GWhMnz7ZMYxWXpLS2Toy7hWwwdJ21hXRIzbO3ukD+Tw+LO/84HtUs
         FBox6RFttifw0VWNJwm2EpJMSMssJYiLOZKtftyUgVByPdDV2WTvK96AVVyDY2T14jMw
         VAG7qE1IMryHM3ogZ7LBJCQne7d/WkOKJBI/vS04IzG+j3RHaOdZSB9LkEy5RuKxnP16
         596g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/1DE4R0T75WB7Frrzm2cork3VfeplgbAHvvAU8r9cGY=;
        fh=1r0K0bu0JwgSqh87+IHMjcYR72jIo5Fu38SlNlGYRjc=;
        b=JpZGHIv27pTwp+TjWvk3XLch+qaMsZEvbvbiidbFONxIN0XgHrvr0dv5oo0DO+bq/H
         38D2b3RbcFAnRQvIg8C5vId0vR38LyAQD/vrhsL4XmaJcvT2EhjYv0wZ3ml9VABN/W32
         Y3ejx+K/6G5ofHdU+TNlzdblRVruvXqsORaHF1II9KdDWZGDm379hVlLbO9gfw3FWtnr
         IyXT6OWjruoiVDsQdh1KLHmnSWmcg0eOS03GiCbmIhDbttebZee2oPDDccbz4n8+xA6z
         aX+DmtJG/vBhcCErmRJzjgQ6Q20SkylLe0DinZ94+2Bv1VtQNGVq1ClSI+Urhi72JAUy
         j/Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778587865; x=1779192665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1DE4R0T75WB7Frrzm2cork3VfeplgbAHvvAU8r9cGY=;
        b=f4azMIn6eLTZLKES5Omd1DARpcgV2BNvalJ5j366PaWM+xwpX3GxGiJ5Q9tlYERiIS
         Wuk5MehNk7Mu7L2k49WdHa5t6P5RAmZOGc8K4kSf7PauohpRHjlI4r9+cA3220fSGxzP
         SIjx44oH2vIjdoa649P+nXy7d016CnV4/C5e5uYZ8AE5IAZKtquHWRNuQSwjeeeYwx0t
         eRE2DdRmGPACMYBiMKWY3GnyqeQmt9fXY9S50XjaC5jxe6MU0lUG1IB/3hQJLfFCWaDZ
         H6hv8XVyOO7s6iujfZ1XqHGEK4GwvBuf+KXzoE+FHgfJZavg3N280AwH9xteky3XP3wM
         oEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778587865; x=1779192665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1DE4R0T75WB7Frrzm2cork3VfeplgbAHvvAU8r9cGY=;
        b=auasgv5SVWyWnO6PuwSnmZxTGsau4IZCKljMSvbmpl4V5CJlnCBqgMXuMhEvqWqfH3
         /bWpsOyEKEbifVim3iwz10SPoWMBKZpvyMrrqBe7qZJiWCi4SW3HpuNqzr37jBOsTYlM
         Eb5I2/CjUj+wLoaArwoqpkXEoC36FhN9Ejyv3/k3QV8eenSiNI11/fRCu23mt2CxhnaZ
         N+5686J141IQsa7cvaeLilvMQdCk6qPT/2Wev6ODipjtenoupEoDsmO6sg+b9Z69V9CI
         Hgl8Ht4vgvzcPoZ5aplPHCTtjLxTnQXKpYY4Nw8aBfTonuKXJ3yAR9eG2GAaEmVh2bSR
         mMHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mdUAkcobIl3m+nUG0bsW7UieBUrg1W/buknmyYoEmpHTkiYZ7rYvJUtQudKSS1Ma6pnoEhbeTHz37@vger.kernel.org
X-Gm-Message-State: AOJu0YzWzFaYClMEBYAehYwcQIduPaNHhoLv2uINXDxqCHwf0GeCzbzK
	jsA3gAc+m4ZhJDn4X3agKa6ZUp8Zwx4IUIVLBX8kycWYM4pDvbDtQo6r7E97AC6K+5vhJ/O0FVI
	Kgs0Uix5TIjsl/8mcUjb8TFsaISVtuFg=
X-Gm-Gg: Acq92OHjoYSqIUTALH6niIDaCBMo70eX0dQ0Dki2/VIqBS7n25b35HZzoPNBN5/VzYs
	M6wjbaG4lz8M8J/9Z0IeN7lhX157OSud9OGS4W4Ystdb1MPZAtgoxfTpBiSbMAWfM+Ud5sYKI4Z
	FxWLnVE5rZtaS1f7zQaXhp1heK/yPW+uWJ0nT874s9n5auYZuunP62LfhuXZWbPidwbzaLlgB7N
	SP6yN0TpddqIcLTIb3P05IwouqW3AmSgvHBWf0jiu2oU3FKiWBucLNTtosyK1nBdVModRlptDYz
	dCZ3zc87GI+8nb5sXmkW+12o5UxRDypqMgRuM/An39tNZsHh98Jztpvme3pSJ/ydq0PoGvWCuMX
	S/96Cxqc54KUXPvMmGzIoEc8=
X-Received: by 2002:a05:7301:4184:b0:2c1:7ca:cec2 with SMTP id
 5a478bee46e88-2f56b41d828mr6700782eec.8.1778587865340; Tue, 12 May 2026
 05:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512105920.2426293-1-japo@linux.ibm.com> <20260512105920.2426293-5-japo@linux.ibm.com>
In-Reply-To: <20260512105920.2426293-5-japo@linux.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 12 May 2026 14:10:52 +0200
X-Gm-Features: AVHnY4JA66zDTee-Y0W8SMQMil_3cXuAkrCNoATQReGDAID2X6wPfI3OU52LmT0
Message-ID: <CANiq72=dD5fw6XmLJ=zSq_k_ZQy8sLLMs3m1xjX=UTpO7tLisw@mail.gmail.com>
Subject: Re: [PATCH 4/4] s390: enable Rust support
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

On Tue, May 12, 2026 at 1:00=E2=80=AFPM Jan Polensky <japo@linux.ibm.com> w=
rote:
>
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>

Closes: https://github.com/Rust-for-Linux/linux/issues/106

I am happy to see IBM getting involved and being able to close a 5
year issue! :)

I backlinked there this thread.

> +KBUILD_RUSTFLAGS +=3D --target=3Ds390x-unknown-none-softfloat -Zpacked-s=
tack -Ctarget-feature=3D+backchain

I added `-Zpacked-stack` and a bunch of related links to:

  https://github.com/Rust-for-Linux/linux/issues/2

Is there a tracking issue for it? I linked
https://github.com/rust-lang/rust/issues/150259 for the backchain
feature.

> +       if [ "$SRCARCH" =3D "s390" ]; then
> +               echo 1.97.0-nightly

`-Zpacked-stack` landed for 1.96. Is there something queued for 1.97?
If not, does the beta work?

Either way, I would prefer waiting until we know the actual version
number, i.e. without `-nightly`. It is just a few weeks away anyway.

Thanks!

Cheers,
Miguel
