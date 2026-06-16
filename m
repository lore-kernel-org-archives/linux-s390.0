Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F235AC3B
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619756; cv=pass; b=YbMmKiLrmYD4dHGspaMjD629MxXOsCAZaBzVD0aTg8ZZajc7w2/UEAW2Z2g3GtElWqS0inH5GryzIm5BD0ua1WN0OH0TE46/uc1bNGKqSNXbhDXWDCUi4pwXVpm8jQYohMHHI5+bFlNIlenHO5DfTSAXAvMbWFwEDkS8kYf3miY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619756; c=relaxed/simple;
	bh=sQxfseNO9ETctkEpeZjIZ772b+Ekcz/cXtv4i9RpUXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEyJ+bp/g0TGIjrp/5YYynb7UohjwcMKTWpcwiaS1yBhADQzNN11sTJ4/I/vJydSGJZjP9mU2RVZWFVdtnvIvCr0x3w4cBHkad5UMhLNw42BfQKqzY2yMDI81ZQuimlfy3Fe68HrRZhslB9F6s+IM03GPdwOQnI83+aiJ3njb8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIXZPb5K; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIXZPb5K"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304e86ecebfso355345eec.0
        for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 07:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781619754; cv=none;
        d=google.com; s=arc-20240605;
        b=HR9XfBxyRU3WXACab6Eo02+YelGGKvMife7iB+5SIT12e86CX58zBDjsFtUrUmYWNc
         51tzOf+sXlSifU+TZPdf7q5KtIuzQvB6DkV67Ytt7JcM0dIdn2xrAggzcXcjOMZHaBSe
         MuTYU4SU8Ew1UwfYP6NXzRyeQ62BihMi+s4PZhCwM25v5dymg4sZLlBOE7F6wxvTLsHE
         p3dYJ5h1oZC8364wgpBDCyW9y3OWKX2UqGdcIXvp3WMYkl6F+ucEbe+ocQUef8rzbrMh
         zhgMBhIAjc5P1XgBWC4nuSzEb6DHAktzC4L1oV452a2Lbvy5/7WjzSJLYgcpL7/grpq9
         lROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sQxfseNO9ETctkEpeZjIZ772b+Ekcz/cXtv4i9RpUXk=;
        fh=t04iJmxclqA2f5VQE3Nzv1Jt/5EJh12Zax+IwlsR1Vk=;
        b=PiJaFt1ua/qvE8JkHaZLWkqTsY45fXWf8s2ziwmR2sspIYVCONhzgzZMzgrMg7lemc
         34TplR9yHDTETtCJwRhRdjieKrEp6W2i3gk8n84pV3bf5S6yWmuh96q8bnngApZD037e
         r8asv5StMRvcKTpBJ3WBFgCqwqZd2gHBTMRTz6gQNdrjSR8KP0hDx89gnSfgRdVyq5CG
         YYlnKgpenLQf8GwssW/FZ9PXNnUNgIiUfl8ed38BiiNcKMPp/MW5/s8KHrXbK8EmN4a2
         PzjFgUVNgmYAtacTREZvhvzb3H9uve2LqGJNC0PN837Pu0pyxUme6+bvDLcQKBTl2FHS
         E7JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781619754; x=1782224554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQxfseNO9ETctkEpeZjIZ772b+Ekcz/cXtv4i9RpUXk=;
        b=oIXZPb5KiF6a7J4LD8REldFinsJr2qe5qKqQSbcM59Tkqv3n3C5VVKhAe3oI1DveFx
         0eqR4W7bG1DSdn73dzrLngY5uHT0siq6uYXrVqQW1+kNB4sGEM8tQ5SJ6/BHBaS8w2RH
         adC93crz1HyLlN35uzVlnrM+lZ7EchdPmzK1JdfxVfFzbIhgGNtWYTQ7A5V0rAC8QKqU
         Ld9zItVO+rpDLTIqZFThTsYQtknp8QC5NPLOH6e8i1t2UyYoYcFXApPVPaUO9Ys0XgF6
         LxVIwRkK5FxhhWnQmHx/HHJQFPSdO/XNmqGGDbHKcbz5LPU//mpVTw789312vHGA2Dyv
         DIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619754; x=1782224554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQxfseNO9ETctkEpeZjIZ772b+Ekcz/cXtv4i9RpUXk=;
        b=OTkmW6p5EMAvsxCVV6Sd1hcyTQzx1un5HDpvRhqhk0ROaNc0eznsLuNCWIDBcCPBEF
         RtfybVt6klQkQo6cYMMBUJ+5WIiNqLLZl/RnGMRewymiyKWbQedbQOnenI+NHxrD7bKO
         B9eBN3M+IFWi+UFpnapFL9LLYvHIGf0dnW3bPu2jQ+uT0TTJxY88kaMR2f4gkAedqTqo
         9DCJn7IDfwdCfy31hz3PYyCDp/enSVn+m60x3L2dP3FwV+TAjqF+yUNh8SGc7MLSJ1xf
         Hae3eh9mREXlO9xVNeHAUj49YqE218cRFlgi6Ecq/fSwGf5/rqZI/lAgH/1QZevLTtt3
         QrwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ujiuuamr9DZdoetCdCaibh3fOZGlbaV473XvUAf0UP6+UlUb39HTCWa8EBqoDfy236kO9jNPJ3uLm@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7UWbQkIS5MB0G8FZo6L0NdWLaJjEyVsGC5TBSHhvfm1RZElg
	HAr9JZ0cKAR0eKhEU3JPr8L1nrlV0uqT87vvAzs+lhcN1Cz0hNKx/iAcnxbXG5b34omAbdlCyN4
	jRBVhCZ5jsjcjOOg7hyT+Wp5tPxSLLog=
X-Gm-Gg: Acq92OHFrJofi/hiQKOunw2w5mOjMMw+i2DZ7dWdjl8CEWqN8DaDx+j9jmx62ExIokn
	3gv0b73XItB7xj8FOE8krv0qMEe4/NEBkSJe6ETPu6APmsl8cRXHZd3PxqkXleFZJM+PjGJfvo8
	2cz3SObZf7ldg3fXtqH+EUvVwpYyHUxZ8qvJ5oJ0Gjy1uDSgqwnYy0yaIYdYELWs28kPFcqFHFs
	CApg/J/o9DTV91gUZzAewXju5787fTrvs+QgjJRJq2QeQutH/iBwkvQuql9kw+7s43914nd6UN2
	wW+IrtD8gzwGf3JXTluKRVwqS10WkVqdi3QMYAJPn2Px4dBvCwaRFRYCUCjwRaxds0tOzrWC8Oc
	8mE2i9UPgbIoqteYnucdqHUA=
X-Received: by 2002:a05:7301:4001:b0:304:8361:a8a7 with SMTP id
 5a478bee46e88-308200897cdmr4453459eec.4.1781619754330; Tue, 16 Jun 2026
 07:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608181451.3734956-1-japo@linux.ibm.com> <20260608181451.3734956-7-japo@linux.ibm.com>
 <20260615164013.GA249489@ax162> <CANiq72nkm2YwxcV+vwDj+v0svd6e1dro-W_0ybVms3pG_oJiXg@mail.gmail.com>
 <ajD9uw7MhsisxdzY@google.com> <CANiq72=Dv8wUrMz7jbsHOwAyd2GtgnRxvXzZeER91KvPcULzhQ@mail.gmail.com>
 <ajFYHCZSXC05P7O0@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <ajFYHCZSXC05P7O0@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Jun 2026 16:22:21 +0200
X-Gm-Features: AVVi8CdKQKFaWaAe9gEgRl9GO4611ur5B5x5QBpjbwfvQ4h_bbzvaaJthtLHg9A
Message-ID: <CANiq72kOQQFr54kdxB5DrycWBi8KMi8=RCFvnZdQqXLZXSEVpA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
To: Jan Polensky <japo@linux.ibm.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Nathan Chancellor <nathan@kernel.org>, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, ojeda@kernel.org, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 4:05=E2=80=AFPM Jan Polensky <japo@linux.ibm.com> w=
rote:
>
> thanks for raising this. We discussed the backchain warning today with
> the s390 compiler folks, and the plan is to move the backchain target
> feature into stable so we can support the kernel use case without
> carrying warnings indefinitely.
>
> There is nothing public to point to just yet (no issue or tracking link
> yet), but the work is now owned on the IBM/s390 side. Eduard Stefens will
> take care of driving this forward from there.
>
> So while we do not have a link to add today, the stabilization work is
> expected to happen.

Sounds good, thanks a lot!

Please let me know when you have something and I will update our usual
live lists at https://github.com/Rust-for-Linux/linux/issues/2 etc.

I will mention it to the upstream Rust folks tomorrow in our regular
call too so that they are aware.

Cheers,
Miguel
