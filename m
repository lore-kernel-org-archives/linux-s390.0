Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED06139566
	for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2025 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022030; cv=none; b=g5aaq8gqo2qXqjyLMZ9KVahOFEi2slT7q+hUQ65v8S58bFOMUVzLHOzLQW8Uwaitux6WaKSbFuv8UD2VSew/AYtscBJYwpQe9BRqvYe+p1exCvNx8mmipBFvyXDWad3hacwDELiD6mfA/4soXo//oP88ZrtqRva8BrQ5OFThY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022030; c=relaxed/simple;
	bh=WvHkPKfyGXd9AjxOMUhOE94KeSUE1pQLqETm57wxMv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvhbMZkWbCWFfoUaKSqfY48V8khHsMUlI2sIrYB1i/qYZgnn4PzXn5pqJoRdmGjD4wDNe8X6eb7xfQRrNW9KeuziVjuXowS66a3hfNqzGGeV6w4Kx2Ow9q+8uVCU3HeyJ82xIUed09yo9EU3RAQ2S9N90qeGpK8g8JTFeOzHcag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W0p1KzHg; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0p1KzHg"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4679b5c66d0so154691cf.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2025 02:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737022027; x=1737626827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WvHkPKfyGXd9AjxOMUhOE94KeSUE1pQLqETm57wxMv4=;
        b=W0p1KzHgXcmf2U/G7Zm25r2g2ljRQssTM2mRc5YsdEeMYXsRj+yd8dlP1dFrshJpia
         L4hphCUkP2rj4b0JFiBsR4lis4yxARWoemISTsP0mXh/5J756G0fUirAssAw1Gl6swTV
         /u3tPeV0FYUWnH1ms0TcOJR/whpMaB+xqrpTDcn10ibAmHAJiZexXt6KrMcx7B8AEY3b
         34lZtS2BXXYysOJoCZtyV1u0XZw2nX9bCY//Ir5de5PPNJF1qu3/paw4MaoI2YXOE8Pd
         RgeJTWabAJkvfSewU3WffkM6g2LW1diL9H6zIhcYUM9H4/FMUh146NfaYuvBYXnZKc24
         fUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737022027; x=1737626827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvHkPKfyGXd9AjxOMUhOE94KeSUE1pQLqETm57wxMv4=;
        b=rAtN5zBgueXaG6GockLuakJmH14D1NmuXeYfAFgChjCv/J97OjsgYhQEGAghQXd7oH
         zTAyj+kW7i9y0Ps8NkqhRLs0pqX4ENgPagpDBAW4KXBCgercAmRNtc7+R3JU/5sqqJJT
         Oi+qpjxBhzAQU6yo9/ojPScaHGJ7sUnwQ2wreadY0eXRYgM/PEEzJ8ryxjFZr462Igvg
         N+bnC0O0cujwI804dwwVTkicOZzszyw4a9hYHByfQaxHYl95TCvt5fH3/dj8sZjvMP9I
         wAP+C0W6ebm7LWVPQn0Ty/yH2wfM6k7XKUZwONgxV27MRY6yktTDfsevleQejwYhH1/+
         uG+w==
X-Forwarded-Encrypted: i=1; AJvYcCWBA7Jsz8YINZQHo7I0D68RK+3QvZgvqs3K1I/3D37YeXjca/0xPJPT49GoB8mamGxckMtvgHZghfOY@vger.kernel.org
X-Gm-Message-State: AOJu0YwfaRya7NnblhsJ+4QTTu3Gc9McpzxCBhX3E0oc+HrlwnpKPVIX
	JWWW1YlNcBEbK1P/rMBbOyMoaNqa/S6oSSmJGtB77YkUYbPyjk8goRnbmp+/xUExMEPURmEL1B0
	/WZJKpa75bGtwQD5T3Nym5HWI+XjiVktK6/gJ
X-Gm-Gg: ASbGncu60uSgxLc9S9W6x+xpZRonr6CuUWZgvLjGHUJ2GT9uwiv44GMRneYBkDGIaHU
	S2P7JMSVeov7ZC5cvnmothTvvDDbQ4tZeYsBcScPQajo7yrOfDKZGTq800J3PlYspUVU=
X-Google-Smtp-Source: AGHT+IFOMkwJSDq64zLXxSa6dw6mO+3SY/5E1TPwtyTlPAbmBc71F1ay07U9Ys+mXp6/C1CNJDS+iWjfJ88KfeUevR4=
X-Received: by 2002:a05:622a:199e:b0:466:8887:6751 with SMTP id
 d75a77b69052e-46e054eddf4mr2032541cf.23.1737022027218; Thu, 16 Jan 2025
 02:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220-kvm-config-virtiofs-v1-1-4f85019e38dc@google.com> <9c04640c-9739-4d5f-aba0-1c12c4c38497@linux.ibm.com>
In-Reply-To: <9c04640c-9739-4d5f-aba0-1c12c4c38497@linux.ibm.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 16 Jan 2025 11:06:56 +0100
X-Gm-Features: AbW1kvZgJ_xYEHdNMI59zCSV7pIlY_aZBMf_JVoAUx67vx0p-sB2zIfWs7-2Jzw
Message-ID: <CA+i-1C3ncij1HLKGOdTC2FtpBY2Gajp8_3E3UrvNBYhs9Hu0dQ@mail.gmail.com>
Subject: Re: [PATCH] kvm_config: add CONFIG_VIRTIO_FS
To: Christian Borntraeger <borntraeger@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Heiko/Vasily/Alexander,

I don't see any obvious choice for a maintainer who would merge this.

On Thu, 9 Jan 2025 at 13:46, Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Given that Christian acked it, and it's pretty low-stakes and unlikely
to conflict, would you perhaps take it through the S390 tree?

Thanks,
Brendan
