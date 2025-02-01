Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6992AD27;
	Sat,  1 Feb 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430080; cv=none; b=ohyhuRVt5AuUq6rALJ376cJUCJq/gzi7th3+OOyx96I3aQEEitk3eZGtLiWNDD6yAco0NGTTsDyseZIbTPmeOV8tidZUNsyV39rHWXPb+EyolFaBGPFHBw+KfPyeLPvnM/nkeDbEd44L3c7Cz0JeaGUGDzgAd5q+Trk6synIjQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430080; c=relaxed/simple;
	bh=glOtacSOb3VnoErJh85L1EdXaOEGDMJnZ1hdbr1EEAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MldQa6NodAlqKros6xRlm6000fsQdKaz0gtTfJOj7QqwnIw2MOJWxKhd+W+wcIk7J2hM4QW94RGAD2n6XIaNfwnABHseAx/kkkauzy8QDUcJEH+bmtjv0pI9aoRT79XrKFQ2Yy+USTpj6eDZMWSj2Z7ec+/MluDJit0ghhXE7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN8ldEmK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN8ldEmK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38a8b35e168so1837810f8f.1;
        Sat, 01 Feb 2025 09:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738430077; x=1739034877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFDG2a+7NOaOAduK0oLgqFYoY3nO38dnC6e3BKi6gjQ=;
        b=NN8ldEmKS4fr6xi/co0EXvmAegT69wDD8UGyVcOaI1At7Iwd1NdWD4REWmIAH12rt1
         JkjWoZI4dXgxTRpKq53X9hpHVaPnTBA2Ce7Jgob+5IMps9ZmWfLIBfy1bklXyz1AUaw5
         fJROvBZGDh4A10RB2uQxwwIIXuV90FQ9VQNGxBR4urAqISjFFG575bobQUpKZ7SCKG08
         MJHkAFuC/rqgvj/O+GOgeyUeIuuMuowqEd9/mUyIyJ40T4D+nhj5C1l2cDQ1rmhRGTPy
         4JETceOUGIO0Gj2DOXf5vHCZR9z0/6w62IoDIvVkCHW1Cx07jqVIyqZZ9K/NhtdJJ+PQ
         1umA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738430077; x=1739034877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFDG2a+7NOaOAduK0oLgqFYoY3nO38dnC6e3BKi6gjQ=;
        b=SscRzqQC8taLkXF6UXNgBCAq151OVMUXYNOUfDnIctZsO/sTRtBp8b+M2jZs+RxKKt
         F68Dgd4Nkz9SFrAhZFKgN0jgrd6F2UbWWo9rxpxSTC9LieOic6UU9AWF/uLYGqcZHa+p
         rkqq0XvxkgZc7cQzCmWXSCPNLsjAHgRzq3Mi2WqdKX8juQSZxlzc8Cwpz0/ytQvvBcwj
         jhTTW/q+3QRse4f6qpCybfZ2LBaoz973cwy0oGOz24Z07X6JPQaJ5ZfhIi4eB5wYFX0w
         wdABk9XDxAzFwbVU+rR6ZMfVyXMGCKLSW6266jKT6N2PzVlTvPoecZxM1DhyYHu5EC0m
         gUfg==
X-Forwarded-Encrypted: i=1; AJvYcCVOKqOTiXhSntAzRIkLex3RXky2jazAyOtnNwcxv884QbHp1WCmQ12eun4NSWXwgZ9+eqhZP1+TyPl//NE=@vger.kernel.org, AJvYcCX4cYt1hYwnun+hGnJTy2wSYDE/e2Oi0u6xTZZCFAb2p3A3tPPQibs8nHuxep0DdelWyiIF7CQuIGf0q+R7VBbBhg==@vger.kernel.org, AJvYcCXGbKQpez+UrdW78Zsf7d9/g2lJ4BeBBuUFevhza6f5pQoZHjIormulykMs1IFLR22FtmD46GMaGsNq3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhNnohFuVpTOygc7maXxHzuGISswux2SePOtLCFsCyidSNRT7/
	s4KpsWG4JnTGjOvpEfltaRuUTPQEU8t+vlGzT1PPjXBSqjWZBRUc
X-Gm-Gg: ASbGncvXqGfyIeGU+b68PMf2nl+QnKIyKNv8mrN6F9OhNIzMvAWeaRJGoiYN+IFf6Tk
	2XJDECoyzYUn6xG9bTiaHtrqiOHss7CoIK4vCM+ItuQVDeHiqrL0hIbMdueG2N0BtsOsQiHgi3A
	n2ZTKHaSTrkLxoGLFL7iaN/onkQBBU0k5Hl6YXVF0GrW1EO0tc8pJPxpP6+qvPriZMFcazkfwTG
	CmEN/HnbTeDdj7VCEtv6c16wNUH3hiGCqkbWc0O7jdjniWGGJ0g4ocNreM4iv5uM2ZuiJyqZGLQ
	qkVxror0k2wgchKHkRNq0ERnCh6IoZ8/OWFEoWPQeRdujVqKN88NNg==
X-Google-Smtp-Source: AGHT+IFml2u8VO39+rOpPFsV/O/FRYe/qEKkgnI/HW7TtT8WSQvnZ9AFbS5x1DZFbvPNsu8FUAiDdg==
X-Received: by 2002:a5d:64ec:0:b0:385:df17:2148 with SMTP id ffacd0b85a97d-38c60f657admr6836427f8f.20.1738430076954;
        Sat, 01 Feb 2025 09:14:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1cf53asm7592627f8f.87.2025.02.01.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 09:14:36 -0800 (PST)
Date: Sat, 1 Feb 2025 17:14:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, agordeev@linux.ibm.com,
 gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix perf test 11 hwmon endianess issue
Message-ID: <20250201171435.4bd5578e@pumpkin>
In-Reply-To: <CAP-5=fUOS6ZmfVdzwNL6+5VfUr9fms0zE4FXW6vsRqSfS9F7sA@mail.gmail.com>
References: <20250131112400.568975-1-tmricht@linux.ibm.com>
	<20250201113406.4312a601@pumpkin>
	<CAP-5=fUOS6ZmfVdzwNL6+5VfUr9fms0zE4FXW6vsRqSfS9F7sA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 1 Feb 2025 08:12:38 -0800
Ian Rogers <irogers@google.com> wrote:

> On Sat, Feb 1, 2025 at 3:34=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri, 31 Jan 2025 12:24:00 +0100
> > Thomas Richter <tmricht@linux.ibm.com> wrote:
> > =20
> > > perf test 11 hwmon fails on s390 with this error
> > >
> > >  # ./perf test -Fv 11
> > >  --- start ---
> > >  ---- end ----
> > >  11.1: Basic parsing test             : Ok
> > >  --- start ---
> > >  Testing 'temp_test_hwmon_event1'
> > >  Using CPUID IBM,3931,704,A01,3.7,002f
> > >  temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_eve=
nt1/
> > >  FAILED tests/hwmon_pmu.c:189 Unexpected config for
> > >     'temp_test_hwmon_event1', 292470092988416 !=3D 655361
> > >  ---- end ----
> > >  11.2: Parsing without PMU name       : FAILED!
> > >  --- start ---
> > >  Testing 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
> > >  FAILED tests/hwmon_pmu.c:189 Unexpected config for
> > >     'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/',
> > >     292470092988416 !=3D 655361
> > >  ---- end ----
> > >  11.3: Parsing with PMU name          : FAILED!
> > >  #
> > >
> > > The root cause is in member test_event::config which is initialized
> > > to 0xA0001 or 655361. During event parsing a long list event parsing
> > > functions are called and end up with this gdb call stack: =20
> > ... =20
> > > However member key::type_and_num is defined as union and bit field:
> > >
> > >    union hwmon_pmu_event_key {
> > >         long type_and_num;
> > >         struct {
> > >                 int num :16;
> > >                 enum hwmon_type type :8;
> > >         };
> > >    }; =20
> >
> > That is entirely horrid. =20
>=20
> It also has the side-effect that if you initialize the struct bits in
> the type_and_num will be undefined and sanitizers will try to trip you
> up.
>=20
> > I'm surprised this even compiles:
> > static size_t hwmon_pmu__event_hashmap_hash(long key, void *ctx __maybe=
_unused)
> > {
> >         return ((union hwmon_pmu_event_key)key).type_and_num;
> > }
> > It has to be just 'return key', but I'm not sure what the hashmap code =
is doing.
> >
> > AFAICT the code is just trying to generate a value for the hashmap to h=
ash on?
> > Why not just use (type << 16 | num) instead of 'trying to be clever' wi=
th a union? =20
>=20
> The purpose wasn't so much to be 'clever' as you say. Perf event
> configs, which is where type_and_num lives in the events, have their
> bitfields described either by convention or by files in
> /sys/devices/<pmu>/format. On an Intel laptop:
> ```
> $ cat /sys/devices/cpu/format/inv
> config:23
> ```
> So I can go:
> ```
> $ perf stat -e 'inst_retired.any/inv=3D1/' true
>=20
> Performance counter stats for 'true':
>=20
>         1,069,756      inst_retired.any/inv=3D1/
>=20
>       0.001539265 seconds time elapsed
>=20
>       0.001719000 seconds user
>       0.000000000 seconds sys
> ```
> and the configuration of my inst_retired.any event now has bit 23 in
> the config set. Just as the format files try to break down what the
> bitfields within a config u64 are doing, the union was trying to do
> similar. Making an attempt to have the value be intention revealing
> which the shift and masking may lose, for example, by making it look
> like bits in the num could overlap with and modify the type.

Except that is really doesn't work for big-endian at all.
The 'fix' doesn't even really paper over the cracks properly.

I'm not even sure the hashing works on 64bit BE.
(assuming the int:n are also BE - but that is a different ABI option.)
The 'num' and 'type' will be in the high 24 bits of the 64bit 'long'.
If we assume the rest of the union is actually initialised the other
bits are all zero.
And I guess that the hash function is masking with 2^n-1 - so always gets z=
ero.

	David

>=20
> Thanks,
> Ian

