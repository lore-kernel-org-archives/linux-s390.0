Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5B27D77D
	for <linux-s390@vger.kernel.org>; Wed, 26 Nov 2025 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183676; cv=none; b=E0YJPY8PZ8JIF3SqNoEV/Ql4P9bN3jAkeVThoRjmDfaYphBI71qVtWDFQvrKbCY+76L/Vh//gWSyMBWXy7jFmN9lS+eRqf/d2F9UA/Klb740euDAkkhv74BXL/DfPCggqQ1WEDsZqBYI5ImCrqBMRwawN0Dtb/yokgWZqcZWhbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183676; c=relaxed/simple;
	bh=NL34pD8T4V00Vzzl+/Qr2PvsfK2RCcscZu3ICWTHDPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2zgxc/ZcZuy90tu1/toxJKVodVvxn58Mb1H/o/6k2N20BuJKq74bPAU6A7nwlO8KCR0mo2PXxlYH7Sw4e6OuWcFi6uS2GEG+TK+9PuRbzjsAKa1LjxnQ79j4Z50C8sUURVIdB8KXgWOSrqkGanCe9X9xoR2v7FTnkn9QWO1rlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loaQ73Lb; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loaQ73Lb"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2d32b9777so7436785a.2
        for <linux-s390@vger.kernel.org>; Wed, 26 Nov 2025 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764183673; x=1764788473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9olSEKmUg2DoH3BJkC4PHVJmILXcxuZR8suDptjbXkg=;
        b=loaQ73LbPfNDbbyWUhxsWaccrEL98o4Bk9aKPs5BJ/jPYOgYteY51gmmjxYrF1teK3
         qbqTNjjhkgDCQ2iMeR2j9hasQr4J2z6JQ3W86fq/DLQY29WFEmuzUmfOJoEYMUtOxzt5
         lasjsNIH8OVBMNYFJe4ETx6icKZRu9tJWrP81nhxew0HMy7kon9SFz7AJy8njUgzNM01
         jJnzjxD9LpxL1kZgwC1rhoVoVlRL0Gvs5HOzq3+LmHpNitInfjdVPUSZBlql1Hsy7MYS
         izMLHFBDTdZUOkm5sz6Z6L4oZ3EOaaOTqEPsjMHa6QBqflwAW8zpzYv4sMPvOQzoCBOF
         nG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764183673; x=1764788473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9olSEKmUg2DoH3BJkC4PHVJmILXcxuZR8suDptjbXkg=;
        b=Ee6Rh++0uwcMRkdYdzEyqB271npiKjTbnKMudvywt1D7r9BByn7WAnIJx44i0AjkRv
         AZiINYJTMM07SfZ0AN7GQ4VJiPMLiij/tEcSGhLMNuXr8iC97yMRO+y7B9D3iXKyuFwK
         CM+NipYeN1NWWz9lZD2euA5wu+xxgfVULegpqJ2uN1XFX9zg3Q0EXkAm7IbDDhuK7bb9
         UT/r2bLEYDqV47COTp9gRfGr2ys7pR7XoRd1qkhir4JWRa/P7lt/G7jE76LOjyak38vN
         4Ef7VuSX44xrcWSg8ZZIZsgpGbj4QKS6FlKTMR9PBPBkhQDv3ZYivT9LZsEYxnUTr2OA
         b0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAn+S156gAiOo0fmNBWmIzVQJlY/xK39Dj2Fyf6bXicOfLljQ/rZpSxTj+vSum6I8Fvh+aMypNuHcK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3A9bgIPzKl+9wNvCJbOlx8eVlYNbDmQmhBEiXsrkXmaejXk62
	GeJwk0/WxPw13fus5PbemDGGt7/bT7eeC5VsV1lAG2+Z2tOu1qbxw6kEUtwqTVwJKlJ83ctwh1P
	8yEkZsntBiYz3Y1Y5n1Vt0vdXl/sJtlVPuFxY
X-Gm-Gg: ASbGncsNzySHK8ko9Fsm2QUdZsL7JlC8XHAhltNm+YnCXHLRL2cQkcsSS9K9+yUQjw+
	jZrkitfk0/dNztHksOIamsItFqO9Kn3HE1ReO9nmG5Z03tH0/v6LOSRAGIPzl2YIBK8FK1cbtv2
	k4hIRC1MTJX5lpgVh0Fj8ady5uunHFDWkOjzfL3KYv1+ITxEAUT15EbEp5cGA8sFmGzw9zqoiDA
	ls+ionXuw3KbWliZn9xZxIoT+P0TjvauJH1u7TEZLFfst3+IAxjOGRBTYVbxrklJfyqD9Y=
X-Google-Smtp-Source: AGHT+IG4lMOCibB3xzn94c2hznIJFr1UtmXTtjH3mj3s4ig5rqGWjzJDEXka6fS7dx4D8DrQHjiL2yRwRkQGSbtzW/0=
X-Received: by 2002:a05:620a:28d5:b0:8b3:aa:f61d with SMTP id
 af79cd13be357-8b33d4a77famr2884287285a.49.1764183673026; Wed, 26 Nov 2025
 11:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRvSv03cqarM5dY9@google.com> <d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
 <aRwVifZ_-7puFUVC@google.com> <20251118132451.29a35127@gandalf.local.home>
 <aR1JXlhJ8rC8Ujb3@google.com> <20251119125903.417f595e@gandalf.local.home>
 <aR5mTLRWA-SLAFUM@google.com> <a7a5f95b-25e0-4816-9d0b-04d955c95821@linux.ibm.com>
 <20251126102401.37af98bb@gandalf.local.home> <20251126121229.0638407b@gandalf.local.home>
 <aSdNiF2VZMtjQnUQ@google.com>
In-Reply-To: <aSdNiF2VZMtjQnUQ@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 26 Nov 2025 11:01:02 -0800
X-Gm-Features: AWmQ_blDXna8aYwwz0QjzlA-7bZ22wVZAwET2gWg5CMksczKVoPZReS2q9UbnzA
Message-ID: <CAH0uvoiB4EFu4x_87cdoU5DezKcGXyT8OEhrs0qNYW7aDktgnQ@mail.gmail.com>
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, acme@kernel.org, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi guys,

On Wed, Nov 26, 2025 at 10:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Nov 26, 2025 at 12:12:29PM -0500, Steven Rostedt wrote:
> >
> > Arnaldo,
> >
> > How can I make perf trace not confused by the extra fields in the syste=
m
> > call trace events?
> >
> > Ftrace can now show the contents of the system call user space buffers,=
 but
> > it appears that this breaks perf!!!
> >
> > system: syscalls
> > name: sys_enter_write
> > ID: 791
> > format:
> >       field:unsigned short common_type;       offset:0;       size:2; s=
igned:0;
> >       field:unsigned char common_flags;       offset:2;       size:1; s=
igned:0;
> >       field:unsigned char common_preempt_count;       offset:3;       s=
ize:1; signed:0;
> >       field:int common_pid;   offset:4;       size:4; signed:1;
> >
> >       field:int __syscall_nr; offset:8;       size:4; signed:1;
> >       field:unsigned int fd;  offset:16;      size:8; signed:0;
> >       field:const char * buf; offset:24;      size:8; signed:0;
> >       field:size_t count;     offset:32;      size:8; signed:0;
> >       field:__data_loc char[] __buf_val;      offset:40;      size:4; s=
igned:0;
> >
> > That new __buf_val appears to confuse perf, but I'm having a hell of a =
time
> > trying to figure out where it reads it!
>
> I've discussed with Steven and concluded that we should change perf to
> ignore fields with "__data_loc char[]" type in syscalls.  Let me take a
> look.

Thanks, I'll also give it a look.

Thanks,
Howard

>
> Thanks,
> Namhyung
>
>
