Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796121DEFCD
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743192340; cv=none; b=o/+SdPybrqZXzNeUBiSlNYfkiLr79jwexQOMx0Eojd06DyHLEbpeM5lrywxhLyqrUlzUm6BzAO9O/yIZUC+u6XduD3towEAqGXTdt+gxG+dS39PHPhAayBHpEGIRn5fm0OpzgER3Zc5CqzG+USzEtN5hklNdrAiGk6AHwqa/LMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743192340; c=relaxed/simple;
	bh=fZ3Pf+DoM9iEVqsujQTttx6bjnT/PN/295/nQ+aSoNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnFZ5k5h0MsdHgToFFMZ0vrgyOTUGWOvqmQ+Jn/CuN2L4GIEbbDntfQqX70Iwdcgz7ORiE/ePx7Zdcu7479SwO3GGQmQUFACsi9vZl1LnFZpDFZsVKQTRJ7RHU1zqlSO5IIw1XyVx74EbBECiQ8GYXiPJAsN3LqTtawE+QPU7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAAv99hK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAAv99hK"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47666573242so97091cf.0
        for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743192337; x=1743797137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ3Pf+DoM9iEVqsujQTttx6bjnT/PN/295/nQ+aSoNg=;
        b=sAAv99hKGqkWpyFD7dY3JRxpSQlar446opEHO0pWqBsaaa1EQ6eHSxP2d0UnGYlh+s
         +rLH+w3J2MxcefsK2AYD93E2QCcbE03JICOUzK6PvkwMZbf02K/hyPHqCPSbSodj4qos
         idTO+ox0ksfQ6X7ivCjFOwsUtNK+UM5/H45KD50cix9fQSpQv5fF2C+aeLoBwCA8gevz
         OPOEI2C0waRK/VNVzlhkeCqlqkMrDMnOhLBuNQk4aDowqKSMMhMe2QTZUvWlrlei5eky
         QfLdD8PgyvMN/kq4dbWZsS5NkXZCGPPlBhlq128/RgRYTyFmQuLPdY/GsV1IL+h0XZ9p
         dpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743192337; x=1743797137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ3Pf+DoM9iEVqsujQTttx6bjnT/PN/295/nQ+aSoNg=;
        b=DpM8DU0yU0ohl/j+z+3gtOdXQQSWbR4mw2qlkPKCh6qQvvHlnDaDkqCkuNCmtdNEcP
         UzPjhwSNuZvoGggR+k2quQ0AeT9kbMmcu/sHsiKcq855RLNQ++5FyhOCT3JQn3C+v7Xj
         W+YlXHEZSPP8aJ59rnl7NAGBFBVTlxiRVslJ+0e8Ljm4Vocj5wGVqGDGbwb+BBtuLNjA
         lOLpsP4WCMfOpqQ/FteTCbXUOlgtiUyxVbWUDSeqkg0SYdxpMxmdacEnRF17LJWpHrUu
         eCb3rw3rZwVvnSv2KlwbHFPx3Ay0EbZS3nx4HSeCRYbyjEVXCEbBR5zKMX/q/AJaSIiX
         SYKA==
X-Forwarded-Encrypted: i=1; AJvYcCWwT0kxD8lNTajY2E56m91lWD1P3OEex2WZWimTlNr68OcZIotLPYzctRa3N+QdD2OmprS8fcReCmYQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOarGdRpTe5URAe+IEa7Og9UiZiyn4ZJ2juNHiaSA4GA75HmO
	lWhqzAgSUSyloOnOPuKqu/N7ANJYU1gp/tboijN0b+xoV1X31u2SvJI2aPEcc7RpMHLeKdEbzmS
	TZz5XDqnl1gbfbFo/z0v8Qi7z8Uh2+shpiq5P
X-Gm-Gg: ASbGncvZAw9luoOMGAAPre1Boti/96P5t9sbfX6M/ZN9HpyL3litwpZs3SdgYQLwpIc
	ndqaL2PNEvGGvpsQCaAlfQpgcOBpwsmnOIBJVDjzKsmtYDwwexN8o1XNa/sJF73xqMnEojD3FcM
	x5Gp3PxiF12xxkEjbaSFKPnZk0aS7a2A0S2nuJWKj8+kEvXGlFctRoYQ1Ffg==
X-Google-Smtp-Source: AGHT+IGrxZNNiHvYHqH2odQT34847aiPbk5DRohCJ1jq0PV6GxQy2MURsax6DFZvPXwGATnS+7s0LvXvnQi6ttbMc90=
X-Received: by 2002:a05:622a:4cf:b0:466:8887:6751 with SMTP id
 d75a77b69052e-4780b1a4647mr416171cf.23.1743192335400; Fri, 28 Mar 2025
 13:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <815e95e9-5a2d-4ef7-96bf-321fb57f42e7@linux.ibm.com> <20250328182752.769662-1-ctshao@google.com>
In-Reply-To: <20250328182752.769662-1-ctshao@google.com>
From: Stephane Eranian <eranian@google.com>
Date: Fri, 28 Mar 2025 13:05:23 -0700
X-Gm-Features: AQ5f1JrNUjBcJAke7k1ikFexUQiFHRNjn5nN4ZlvMROniw1uFYbevMqQFKoLSf0
Message-ID: <CABPqkBQzCMNS_PfLZBWVuX9o8Z55PovwJvpVWMWzyeExFJ5R4Q@mail.gmail.com>
Subject: Re: [PATCH] perf/test: Skip leader sampling for s390
To: Chun-Tse Shao <ctshao@google.com>
Cc: tmricht@linux.ibm.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, irogers@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks CT for the post. Indeed this is a long-standing bug impacting
(most likely)
all architectures. The rate throttling code does not consider event groupin=
g. It
stops the sampling event in place (on x86) at the hardware level, not
the generic
scheduling layer. But if the event is in a group, it may make sense to also=
 stop
all the other events in the group, i.e., stop the group. Otherwise you may =
get
discrepancies between samples of the "slave events". Similarly, the time_ru=
nning
and time_enable logic is not modified during throttling.
Interested in hearing potential ways of solving this in a portable manner.

On Fri, Mar 28, 2025 at 11:27=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> =
wrote:
>
> We believe we know the problem, appreciate Stephan Eranian's investigatio=
n.
> It comes from throttling. While the sampling is too high, the generic cod=
e
> does not modify event scheduling. `perf_event_overflow()` simply returns =
1,
> and subsequently, `pmu_stop()` only stops the leader event, not the slave
> events because the arch layer does not consider groups. Also, the
> `event_stop()` callback only operates on a single event, not the siblings=
.
>
> This would impact all architectures. Perhaps we can extend the
> `evnet_stop()` callback to include a new argument to also stop the siblin=
gs.
> We also welcome all suggestions and open to discuss any potential solutio=
ns.
>
> Thanks,
> CT
>
> Cc: Stephane Eranian <eranian@google.com>
