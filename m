Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2089156C5E
	for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702734; cv=none; b=iyacOG4ke6VfIBdg2HWYO3UDqxA4fySj326V4B21BbJGR0QPGsE500ZmrWv651YGfAiMF42KzlOpYc3Ps2TpS+5Rbct+MEt7mjlVZyrf06o/igV1lEDXgyDPxWflVW2awy2SiFHUZe3S1bb3S5dZGQDogbr5g59Qo5icZU8+C4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702734; c=relaxed/simple;
	bh=V4MXEMKcp5I9XclPQt9HVJ1nbtcnQ61M4kMdjmYxvDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/l3mx3nOLIcptXAqRJ6H3phorgjeJMoEJD8Q9kg/mG7G8Es6meDhr7NfP4N7D+D97Jgeb3ny2D5+7f8jWmy0OcZwa6eNMCgH1+kv1XEsNguJ8YPRbJCpfMjMOMBofjynN/psY7mHgwIpOmX4nK5y326JkeL+l+G1PHNlePo72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWYCzkO2; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWYCzkO2"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6adc63c2ee0so20139566d6.3
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718702732; x=1719307532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4MXEMKcp5I9XclPQt9HVJ1nbtcnQ61M4kMdjmYxvDU=;
        b=iWYCzkO2aQ4jbNDIn8dhx7ku6V/hpVtnIMC/LqSHgHMo4+sylr/jQbVpzFXgelK3Td
         mYmTFx6ETJpfAnVje4CGB+fBJntk/YCA4FjskOR5YyG8EMQFVaa43o9KlXSr5lkq5pYz
         0G8DHtSZHm87gBeQuHxKcsor37yJ4O3IybtfjsDdKj3ZK3cpz2YQBUjjXlaNHszYt82N
         jbQAOZ7SiLhSlYrDTyGjyQBWR173f/A3kzEkWIznn4bjDkzFF3uJhlLRTdASGoR/6pg0
         i83flfrT7vsZwTVpBvwttYpcT3/s8aSMs3yzTIwta8ojhs+YH/zwPXygsnrVdfmykAU8
         iMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718702732; x=1719307532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4MXEMKcp5I9XclPQt9HVJ1nbtcnQ61M4kMdjmYxvDU=;
        b=Yy+ia5jo6iXjLQOMNYD8VmF6/2Qi7M4ZlcOeyljg+s/k8hcXUaKdNwSWsX/A4KtaSC
         5btS/j2nnA26AtlN5vAoJPpYRklcGgeqZt7MxQ/yybkvHpVMzXK+Tc/Ey/qavsLYOle6
         GPdWZHiLTENoLhBkFcHKLJ6MkL5T9fKTiXe/tfVSXT9hQ5ZnrHPOKhYKIGHqHWqkxg26
         sTPjNtrgMuEL7i/duMvpqPeC3ugyzaWeafmeYrUOn2PXiI/+A814RCEXZ9OKV9M/Tb+p
         4xgcnagO6X0i5TCvl/3g4mjEcOz4Xt4v2oGcYvFSCzIIUIrd3n8Q5EL6sC0IdEHFsrIW
         NgLg==
X-Forwarded-Encrypted: i=1; AJvYcCVdO84IzxjDbIjsYTJydcsCgvoHgvbMGv7XzlQvYKd4qda6VC1RN1tlpfKYiRhlbYXH/HABkkY/i2mUkbFUVEp2TR6cOOMiuiJiLA==
X-Gm-Message-State: AOJu0YxIrPxQK+BtaYbfNTJu0QLdTVEdRoU7cyDA1y1SqI1Bm200A7ux
	qlczYgsz1L0dDMSydTNFo7rafoB0aF+Kr4uiJUFiiLDINHDtchmQv3K96scKfpFSfaJI+1oZdz6
	szy+/PCxtAnZUlnloG4Ts+/wXGUNwTNy9F4DX
X-Google-Smtp-Source: AGHT+IFRfUNJYndL8wAjatn8zq6n+Qt93BmmyIN+4VFyPbObVSvS4+erMVXHgpMv+VY+5qiKm1XXOgO0W2m66i2IHQI=
X-Received: by 2002:a0c:c607:0:b0:6b2:9c01:86b7 with SMTP id
 6a1803df08f44-6b2afc76589mr116376566d6.5.1718702731438; Tue, 18 Jun 2024
 02:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-33-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-33-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 11:24:50 +0200
Message-ID: <CAG_fn=X6wHfmGsVgdqwms_Hk1CQAZ6M5623WyatjVp=Uk-z9pQ@mail.gmail.com>
Subject: Re: [PATCH v4 32/35] s390/uaccess: Add KMSAN support to put_user()
 and get_user()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> put_user() uses inline assembly with precise constraints, so Clang is
> in principle capable of instrumenting it automatically. Unfortunately,
> one of the constraints contains a dereferenced user pointer, and Clang
> does not currently distinguish user and kernel pointers. Therefore
> KMSAN attempts to access shadow for user pointers, which is not a right
> thing to do.
>
> An obvious fix to add __no_sanitize_memory to __put_user_fn() does not
> work, since it's __always_inline. And __always_inline cannot be removed
> due to the __put_user_bad() trick.
>
> A different obvious fix of using the "a" instead of the "+Q" constraint
> degrades the code quality, which is very important here, since it's a
> hot path.
>
> Instead, repurpose the __put_user_asm() macro to define
> __put_user_{char,short,int,long}_noinstr() functions and mark them with
> __no_sanitize_memory. For the non-KMSAN builds make them
> __always_inline in order to keep the generated code quality. Also
> define __put_user_{char,short,int,long}() functions, which call the
> aforementioned ones and which *are* instrumented, because they call
> KMSAN hooks, which may be implemented as macros.

I am not really familiar with s390 assembly, but I think you still
need to call kmsan_copy_to_user() and kmsan_copy_from_user() to
properly initialize the copied data and report infoleaks.
Would it be possible to insert calls to linux/instrumented.h hooks
into uaccess functions?
