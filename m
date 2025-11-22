Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD42C1589
	for <linux-s390@vger.kernel.org>; Sat, 22 Nov 2025 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775823; cv=none; b=OSy3+j0ePzKKUGfF5MAalt4dw0ipuaH3uO8F6A4hHU22bYqakbFGeThmgu+uJKWYhg72aifozPJW0hTWr+AsLPBkBCG5RqsHo5C4UKjFJIIAnVlVi87LrcdXjWKwZh5QLbqCuoo+A1GXsFWeq+npvQeI7JQklZbH9kOSZ55jB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775823; c=relaxed/simple;
	bh=eK4AUJBiIJz3oZNmu7sUeKDHnLWzFnSMuNw1lB79Qkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cY99CnCYeJCNqoFMqPJOrAxjq6f19t9JAi6hwDO1YWEV8LOEv+fP9XQu6ZNnwWdsZJZynWPwulVy7UWQzLQw+FJpAz1CzeB3UQzSNvFbbE5vKgc/96XP0AIq8nXtv44CqrC+zQ1QPKjJwZj1ZFKFy6fo3SRsCGNnXksp1j0286M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WutWybkh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WutWybkh"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so2299900f8f.1
        for <linux-s390@vger.kernel.org>; Fri, 21 Nov 2025 17:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763775820; x=1764380620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eK4AUJBiIJz3oZNmu7sUeKDHnLWzFnSMuNw1lB79Qkw=;
        b=WutWybkheflJe7WT8onSVGQv/SupCpjptvPTcS9A7xPDAGyArx2o/YX/2Vqe5Y4+k9
         uNlK7jJRqUWLpT0s86CL0Y7SiygCIeL6mwKOPtMVGPqmIAbCu0THl5BC4XLu+xV46+Gn
         FeaDBpS9tYzqiuQsd8aE4NJeyU8kvrFz0ltJI45Le1SUEqz412A+YpDy9Dx+aZ5mkHvK
         tXO5xgcqrF7FCtL5aHJfbQqcpYYMBa5a2UVCs/Sr6FygKJ5b8FHkvCdRGhtPpn8yvrla
         UFBthwA3kFLcpWN/Sevfu6OhhYO/ymkSZHOEKKXqXxdmP4JFWQbMURVxAjdCQk5uRWl3
         6cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763775820; x=1764380620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eK4AUJBiIJz3oZNmu7sUeKDHnLWzFnSMuNw1lB79Qkw=;
        b=pQKPil2vsxIK1Lx2XAnMy64g4lhC86jwz6VXU8I9fVIFHnAc0Ax5deZvVV8svvRqfX
         jGHAXg5vwNU5/5LCO9RelxFCuv9MjdkDp3ZWF6ZyprRjtqbmKuk2SfN+mWqHLbtqvY4L
         4JOTWDe4GXeO6obRujIwft86+oJRjBiz6zzBGkBWRDAEeaMkHFpV0nqfFmbwGkluIFAy
         q7SzQd2E26ktqiYarMsJbQv+yY8nBJD70bmokUr0k6JJOP6BieDkoYndh0WWngMl2MvZ
         DgGcYro1SWaP237GBZ+HXcBoruoT7iYJ0KMhW309nfdb0r1q51DkIZq6zlsYMXQOe8TL
         wNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1KZyvfLaCsUesQD6wr3mPB8p9/UtlvArwfLd07yoHVwIT4vs+KLQOVuSkGhtZ6CTJNe0Zu51RHKpT@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhr9WVRncVZSv+8Nizix+JExJ3OaIPuJd94UNKeehS1SbAYKF
	V0m1J/eeg2/CBJVuTViX00Nrb7p+IREdFldD9IYgzBCZPkVU0JX7eo4ojvFVCByh1LoC8w7riNG
	QuFmQkuHxEN/FeO7aJy6lISzXz5SHkg8=
X-Gm-Gg: ASbGncvZVsZBiHw7mspuCXG6xWdHyIMIUNMGIfBvx6KIWklzmwErGLgOkIk7FBXoSz8
	/wzb3F8C5ROXMbmOBJmXIActlU/TXngf/vwvtr8lJHDLFX3K3yGngugnNkLrtw57v3JZTYi1gqE
	2geJjiMNa3V/fSyg8/PjvjJAbGE+tq0rtiaqO0tqzAqfsffy25o8D+hBsAwYWPiw/eGXbGX2cgz
	TOlycogP8Z9ZKkZ7GLZKfkoAfC9ulZqMqFuSKz4sHqS5yq0NlVUZqITiEd5naBEswe4NkS6DCRV
	FICMUmSdi/DLAxE/lR/T20gwVoWG
X-Google-Smtp-Source: AGHT+IHNIEMsKMuIfgmf4nSIkpkBE7g7sYoDWkVC8xsVj6L3W+IxV7WiDaJ3iYbj6vVbtX2WyqaxCHsUQwVIf+tm5GM=
X-Received: by 2002:a05:6000:26c7:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-42cc137bc77mr5027746f8f.21.1763775819744; Fri, 21 Nov 2025
 17:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118005305.27058-1-jordan@jrife.io>
In-Reply-To: <20251118005305.27058-1-jordan@jrife.io>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 17:43:28 -0800
X-Gm-Features: AWmQ_bmZ4EmkvTNStUUIL16LVXwHaftQKTWLBknsNveweaHyuQUb67hzwSYmSE4
Message-ID: <CAADnVQJ-9JubH5r4oSwQneu3o6U6s8Fa0cjCsi=+6-R+9nkzHw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Implement BPF_LINK_UPDATE for
 tracing links
To: Jordan Rife <jordan@jrife.io>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:53=E2=80=AFPM Jordan Rife <jordan@jrife.io> wrote=
:
>
> Implement update_prog for bpf_tracing_link_lops to enable
> BPF_LINK_UPDATE for fentry, fexit, fmod_ret, freplace, etc. links.
>
> My initial motivation for this was to enable a use case where one
> process creates and owns links pointing to "hooks" within a tc, xdp, ...
> attachment and an external "plugin" loads freplace programs and updates
> links to these hooks. Aside from that though, it seemed like it could
> be useful to be able to atomically swap out the program associated with
> an freplace/fentry/fexit/fmod_ret link more generally.

I don't think we should burden the kernel with link_update for fentry/fexit=
.
bpf trampoline is already complex enough. I don't feel that
additional complexity is justified.
