Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACEF1CE9E6
	for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702828; cv=none; b=q7wl98a9bcC2giZbVKjXbna+Hf6yV6/8jwBa+BcAVyH1xrfpsdJmwrCRbrKJB2G2+G2pH6WLW2l7x6bsHn0hHfB/fonWiNfFeRhmnGBLbSXCWnv70mcliA2iPgIJ5n1dL/j6KG23GI5A2OLHzyaRANw6s6XHTUW972V+CILwqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702828; c=relaxed/simple;
	bh=HgjCqFVtKavNFxLDu8aE6OS/1nGbyLOwVqAAdquKtbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfauTZTpHfH/JppjSfzt/TxC0Y3jOjkA5n6pXzXLT7Niro8Tb3/iR5X/i1HJVkIo7IgGtKIwBUqAfhPxylGOuGry8Kb6PZR+14Mf4BBDNf2D+el1667ydXV14/Cx/ovu5+2oVqXyl1FuXGZPC1o9sicYjCUgm7JTx8V8Dua/kr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huOg/vor; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huOg/vor"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b060f0f48aso24363966d6.1
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718702826; x=1719307626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgjCqFVtKavNFxLDu8aE6OS/1nGbyLOwVqAAdquKtbU=;
        b=huOg/vorR3YTqG+1X95HfNzG5wPbQpgY4knV5mwPbe1kboc6s+AHfXSs1xlxg2W83E
         FpMEpHhkgNDyzT32O6VQ5gpZBD0aKxREqcdEAct/EZjYR5nE5UljBprPHp25Yi3tTrTW
         vnT/WVX3E85rA0vD9A6Tg/5DWr7bNFmOaNDEOWR9gTdi8yOb0VQrLJYS5auDv2XmRRBF
         mjxeMe9IJm6uDBNq++N8DyqTArzbcT96DzV9dYoHiU/ilp8jEauFnPd0WCr0S0k7LZBC
         3Nt5kgY2pdkk//VimcM3MAiMIYz91h+6kqk0838u8yrJnijEAvYq3gqbAigOH40iRwXu
         w8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718702826; x=1719307626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgjCqFVtKavNFxLDu8aE6OS/1nGbyLOwVqAAdquKtbU=;
        b=nMOawt2yHpZXLH5NcPkxguetLwV7hRqydD6gWEip7ydPcbXIvfKLk8RECCFPd4PAJv
         Mc505hoyERU947uSxuH9q3yMeS47nOcYXuU38bvD4ThKstpYmQoorokRtNCSiFlWgWIv
         3B+3wd0Cl103OHXc/UQ+Suhjt9GPd9QH1hbf6kWslAnLqGggkgWY8Tdsq6/S6w+XVcHX
         pnQvsN7v1x3cb+5sUaNRBDvOa0GMxZs1quljX6GH71xKIBBZtaVrGB5K6Yu3Hgb3dYfZ
         3alEaO6uwrKVsJhxXZ2/MD5yIb8ylsAvVFJSND1jIDA8+WO9JL8yTk0r6nhSQCq3vPX9
         GqiA==
X-Forwarded-Encrypted: i=1; AJvYcCV9fiMCcjBIKEVjQGgxyrEVgDwRY7Y9YBvU8MpNkIDJHJcaH/gDp90gGjm1OmgkrkyyZlLmbcxmZhhhottZn9FLZECT0t83Na0z9A==
X-Gm-Message-State: AOJu0Yylsh26AWBir9R5AV4QyJQaA3OB7B4ZDUqQAYowUxc9glf3xl16
	dq1bZzM00XzDJ06hO2k8qThUCVR4/lBU3v+mXbAZCqwHJXyfBU8FNdPKQSmAkhbRBixdAlK1CfM
	7iSwPzFcfg9U7U5zsTzvrfm3etB58srQz1h/z
X-Google-Smtp-Source: AGHT+IE/yIrzcpOv3eiTPoXN3cwGJ3TQnnFMvA5d279z/tiAN3Xspn0UhsEikZvmg+vlTu/xFiTY3m/3H4pxUpWqwP4=
X-Received: by 2002:a05:6214:1249:b0:6b2:cf8b:21db with SMTP id
 6a1803df08f44-6b2cf8b2252mr79472176d6.53.1718702825469; Tue, 18 Jun 2024
 02:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-27-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-27-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 11:26:29 +0200
Message-ID: <CAG_fn=VVGwxBUH=3HrVHhNs6AQFMqFgw7JDLqUFBTv13FOd5cQ@mail.gmail.com>
Subject: Re: [PATCH v4 26/35] s390/diag: Unpoison diag224() output buffer
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

On Thu, Jun 13, 2024 at 5:40=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Diagnose 224 stores 4k bytes, which currently cannot be deduced from
> the inline assembly constraints. This leads to KMSAN false positives.
>
> Fix the constraints by using a 4k-sized struct instead of a raw
> pointer. While at it, prettify them too.
>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
