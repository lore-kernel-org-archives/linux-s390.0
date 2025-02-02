Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B82F3B
	for <linux-s390@vger.kernel.org>; Sun,  2 Feb 2025 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738478912; cv=none; b=Xysqy/ff86PQH51H//smjt7YezVRjjus6CLbIeZk7kwshnAc6tjApJ52j5AOu1rf2GUSYrmPDaizVFQYBIBPG4blHQ8r5ZO5e8l6l/lnJgzjLDXuWjYREBr8siKx4s331I61dpum6gcJa3mK/JEJ6RIVPABmcZ0B9dPZVMqVwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738478912; c=relaxed/simple;
	bh=sLmp6xHNXRTUeReI1bD3dZuLC6sS6eL6CNF124KZbTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgYTcHSeisw6EDAuqvzMuKMcU8M+srQFZP6x5eg3jtq1H2RbQcNAOjJHlak/ij/D02yCqm4u97odkwt4h0Qc9O5izEZ0KFxGrhhr3cwLZ5hof0NEVDFyB6q8xlTbEsmcZtGP1NJe4lFgALW4PZtYfiSrX4YM5PBe5eGsz1PLR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQTFPfKa; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQTFPfKa"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so197305ab.0
        for <linux-s390@vger.kernel.org>; Sat, 01 Feb 2025 22:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738478910; x=1739083710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgeU84PIblBYIhQweVeMYLOZOfYeIUW0M5IhdSU3ktY=;
        b=SQTFPfKaK1sFZ7W5SLERIR7mP2zxUbMVkE9gth8IOd64NP5bOMclmCaECS+bdgSPCR
         tGcpYToG7+/eU++hamlP9tpDkCcbc1WAx4tFdqwZqOIQlz0XHilADsPY1KOqhgagdctf
         z9+AkWOnyfZUsMVs+upFay9iy+GCGI6E1eAG+6KLzRb9jOnnvDEqjVuN4YNEQsTZVllc
         Y+sfRiGnl6pH8JrXp0rpL6bGFr7g5ze64IceOBC817vbr18TdZBRz5JwqK5JXiM7WscD
         cJjZKjAuw5zSSZHyhzDaQRsr5tJlRPmV4t5jJRbDi7Ol2wKzXBnLf6WOacBIXbVTHIDN
         EIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738478910; x=1739083710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgeU84PIblBYIhQweVeMYLOZOfYeIUW0M5IhdSU3ktY=;
        b=p/NWeHEg9P66D28rFftmg276O7B+BRUeg7wLkDXm8RoHoAq0u0Ltk2bbYSMS5fDbLY
         5OjBRngTx2843SAM60R+qReTaoFJ/bvYpnd1KnzB7JSNXyXIbf8ioRySphjCEwzVzyCd
         MdjdmMoNl71gdgefFRWnl9SOr+mpR+2dwjNBBcaUExPIREzS8abw4lQGgpCq7Jv9hsD2
         chmPYVo20S7FEbhghwmRztYkzZx6PXV2EHNyzbvRQoy0HK05mZZ9agL72dSr0QrQO8jf
         /0CHobsIvXqSP1gH57AX6XbXXxH1B73vuzrshhWnyZlQQQfD3+TAYZPZt75QNbMuY7hJ
         ZnLA==
X-Forwarded-Encrypted: i=1; AJvYcCXZfRAurEmnAM5mlx1O2salwwWRQLIwYz3rIbIrHYsDSt683MetUFYkmrBEDLrEVoH3iIQucHUvjrM1@vger.kernel.org
X-Gm-Message-State: AOJu0YzeefyuEge2Wp1lHwENonZTttEoX6Zrr7cWq6AY3HzZFkg3G4RO
	U1YkJt38i/IZBR1TttJfD5jV0tToi1tbIYGrdWTNsBTWad2GfOK6qzl3EBlct6hPZs3O6L6r2a1
	v0oireaF9eHwn+iQBDDeVLn2SOqqXoc1ChTnz
X-Gm-Gg: ASbGnctfo/hreVw1a3TR+IDQGiiBUkgKk8grMAZd72Nb7VxRtGAKl7OY+HwyqhXdbPJ
	cVzRsyzw2gaMfiPnSRQ91JLWcLelo28zr+pbFQ3uamJioomKo1mx5U9AQ5ypTnJ5QwGDnEuO3IA
	==
X-Google-Smtp-Source: AGHT+IHDuXaMAdD5ocfiKBkx4DIie9oQrDvdnfqdAWCh6ZMKIAkF+q3joiOtL0hu6HokU+BrkokOafRdFvU47R4GRiw=
X-Received: by 2002:a05:6e02:13a1:b0:3a7:a468:69df with SMTP id
 e9e14a558f8ab-3d021f8ddb2mr2533065ab.3.1738478909521; Sat, 01 Feb 2025
 22:48:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131112400.568975-1-tmricht@linux.ibm.com>
 <20250201113406.4312a601@pumpkin> <CAP-5=fUOS6ZmfVdzwNL6+5VfUr9fms0zE4FXW6vsRqSfS9F7sA@mail.gmail.com>
 <20250201171435.4bd5578e@pumpkin>
In-Reply-To: <20250201171435.4bd5578e@pumpkin>
From: Ian Rogers <irogers@google.com>
Date: Sat, 1 Feb 2025 22:48:17 -0800
X-Gm-Features: AWEUYZm7CRLEhubOw4Q8ZrinZn7ZTOkhLsJoCqWrkUc0Ijuw0r0iTqnW-ALz0c4
Message-ID: <CAP-5=fV55Tn0j0+ceKZeWheCuMw4RHHvVp0qOu3csZT=ojP_nQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix perf test 11 hwmon endianess issue
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-s390@vger.kernel.org, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	sumanth Korikkar <sumanthk@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025, 9:14=E2=80=AFAM David Laight <david.laight.linux@gmail=
.com> wrote:
>
> On Sat, 1 Feb 2025 08:12:38 -0800
> Ian Rogers <irogers@google.com> wrote:
>
> > On Sat, Feb 1, 2025 at 3:34=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Fri, 31 Jan 2025 12:24:00 +0100
> > > Thomas Richter <tmricht@linux.ibm.com> wrote:
> > >
> > > > perf test 11 hwmon fails on s390 with this error
> > > >
> > > >  # ./perf test -Fv 11
> > > >  --- start ---
> > > >  ---- end ----
> > > >  11.1: Basic parsing test             : Ok
> > > >  --- start ---
> > > >  Testing 'temp_test_hwmon_event1'
> > > >  Using CPUID IBM,3931,704,A01,3.7,002f
> > > >  temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_e=
vent1/
> > > >  FAILED tests/hwmon_pmu.c:189 Unexpected config for
> > > >     'temp_test_hwmon_event1', 292470092988416 !=3D 655361
> > > >  ---- end ----
> > > >  11.2: Parsing without PMU name       : FAILED!
> > > >  --- start ---
> > > >  Testing 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
> > > >  FAILED tests/hwmon_pmu.c:189 Unexpected config for
> > > >     'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/',
> > > >     292470092988416 !=3D 655361
> > > >  ---- end ----
> > > >  11.3: Parsing with PMU name          : FAILED!
> > > >  #
> > > >
> > > > The root cause is in member test_event::config which is initialized
> > > > to 0xA0001 or 655361. During event parsing a long list event parsin=
g
> > > > functions are called and end up with this gdb call stack:
> > > ...
> > > > However member key::type_and_num is defined as union and bit field:
> > > >
> > > >    union hwmon_pmu_event_key {
> > > >         long type_and_num;
> > > >         struct {
> > > >                 int num :16;
> > > >                 enum hwmon_type type :8;
> > > >         };
> > > >    };
> > >
> > > That is entirely horrid.
> >
> > It also has the side-effect that if you initialize the struct bits in
> > the type_and_num will be undefined and sanitizers will try to trip you
> > up.
> >
> > > I'm surprised this even compiles:
> > > static size_t hwmon_pmu__event_hashmap_hash(long key, void *ctx __may=
be_unused)
> > > {
> > >         return ((union hwmon_pmu_event_key)key).type_and_num;
> > > }
> > > It has to be just 'return key', but I'm not sure what the hashmap cod=
e is doing.
> > >
> > > AFAICT the code is just trying to generate a value for the hashmap to=
 hash on?
> > > Why not just use (type << 16 | num) instead of 'trying to be clever' =
with a union?
> >
> > The purpose wasn't so much to be 'clever' as you say. Perf event
> > configs, which is where type_and_num lives in the events, have their
> > bitfields described either by convention or by files in
> > /sys/devices/<pmu>/format. On an Intel laptop:
> > ```
> > $ cat /sys/devices/cpu/format/inv
> > config:23
> > ```
> > So I can go:
> > ```
> > $ perf stat -e 'inst_retired.any/inv=3D1/' true
> >
> > Performance counter stats for 'true':
> >
> >         1,069,756      inst_retired.any/inv=3D1/
> >
> >       0.001539265 seconds time elapsed
> >
> >       0.001719000 seconds user
> >       0.000000000 seconds sys
> > ```
> > and the configuration of my inst_retired.any event now has bit 23 in
> > the config set. Just as the format files try to break down what the
> > bitfields within a config u64 are doing, the union was trying to do
> > similar. Making an attempt to have the value be intention revealing
> > which the shift and masking may lose, for example, by making it look
> > like bits in the num could overlap with and modify the type.
>
> Except that is really doesn't work for big-endian at all.
> The 'fix' doesn't even really paper over the cracks properly.
>
> I'm not even sure the hashing works on 64bit BE.
> (assuming the int:n are also BE - but that is a different ABI option.)
> The 'num' and 'type' will be in the high 24 bits of the 64bit 'long'.
> If we assume the rest of the union is actually initialised the other
> bits are all zero.
> And I guess that the hash function is masking with 2^n-1 - so always gets=
 zero.

No, as is typical in any hash table you always do a secondary hash:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/hashmap.h#n15

Thanks,
Ian

>         David
>
> >
> > Thanks,
> > Ian
>
