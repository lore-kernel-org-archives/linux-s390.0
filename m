Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA73DE45C
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669970; cv=none; b=BkM2R2ofpUYSewlRiIeGu4+fi/u5zOQ2ET30AF4EbEsT9gIbdJG1t4LES7E8xE+urIC+Da8eTxvQq9+vAZ7VFvCBxeBdr9khZWcxIXaqMP6PJdB6Xe6Vtbjwh/88SpMtqUXYhAa4JwjzLzlWqQ7nCMsGFO64xYFmtknBgRhawQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669970; c=relaxed/simple;
	bh=+O07iyphnPsMhbwdcZl/xEUDllR7WIMFNYTSmUuHDHk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=SKIMy0MCA75yWJE0kQDT24PhNPh/aqQoH2HnTGkDxGz7WmTiyMyJxJRPIS8usfFBFTari8+I5hu6ydJY6MDDJhTAj94lGMoloS493Aggd2xDyqNtA3otSg8SqlB5r+k6x3MhSeKnYE/6IZurxsmWHBQye81Fi4hpfuaE+bpkyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phCDgbmF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phCDgbmF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so23862425ad.1
        for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 00:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669968; x=1784274768; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hBmrtvJxIONdnfaPYnlm/oDBvJlVXO+AfljQowycHCs=;
        b=phCDgbmFYIabUWS3GMYDH/KvmwvHnZtuUplOhDQEjP3K5yuPobZmcgQ7t03x7nG/ce
         S4z1Dq19hMrKgJaBgxsRbxfGnTQ+IVJbeSAsH1exWak+mLxpKLi5drEiiG1EokCGWWH3
         0C0DHthSC/KRQfKUgdbWTZWDUdsG7XjkNWyz3W8trbQM9fnnJJq3jWgLylggWLFeRXsy
         HrYWKXpYD0bvsJjMDFJnG4dgoqMtJRof/M7wZqufQe/YzLpokIv3ifWgdSJ0KquZ+RX/
         YkSp+6aMdOiy4vQnrpuaAAoPlae9+iYRO/fVxN9dffw4liNXtWRwtenyOptOKvIdBo6h
         O2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669968; x=1784274768;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hBmrtvJxIONdnfaPYnlm/oDBvJlVXO+AfljQowycHCs=;
        b=JGrlOftonNU07XUexH4KtzBE30gNYT4Lph/A0J6F6Uc6KO5HUl7/CiSgOyzbhnhfkA
         sXAgiwGU72Fil+ePGDly7ARVVTSbU36LV9+1k7g8IIgp6Op4INNZ4cATtU0RT1bnm/0/
         jnUAHcQmSe6Sxs1J2dwO4Yg3i7nZxQXfA1I+cpa9wQ3i0PDqIbZfA08xdr+yk8iVD0zA
         MJ+FJvB25kTcFL8K/fRf9ni368n4R+E7SP4rcb32KAauizpVEIGjrL6VCPeROi1n+k5f
         0AnSlGyAC6K26vNOf8kyuSTYWxuxDtUlnLzgN/MIK3s9R2LfDRKW1HwQAz9yqgP3gDW8
         YG3w==
X-Forwarded-Encrypted: i=1; AHgh+Rr/KoWHO2SPzfYreDxW4SERnvVnxfO8sWaOtZYJWtA9ff9K5/30dZb9L5rw32WJ4OKxbDA3hRtBP4kj@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmMRVqbRivIw+0C05PuN8zh+JNpy2Zxbf6Gy9iZ5mDNwUiBAp
	ZlMERTSP/aQ/FR37DrdZJnV0srtG253C9bzgjbDQHWuOJO4A6TBaRQ2i
X-Gm-Gg: AfdE7clZ+DS+VyUwYH8o+0o3frvlJxRjOQMHHkcBJiHUhqtB9A+/1tYZ8suDAOSo6yS
	LmmzgFRFhtr6erQa18WpjqyA+iwvs/mX1uUlKrz2k6IShM7XqJ5KG0zUYgGvM6oXo+Xvctis+wn
	l5VVxkm8HUzvBeMbqeWTnlEtcjzl75R9g1moivvsEITN8VGHnZW0VdjKL/g2tAtvf3sXX66XlyO
	PlYzLLdiw5p0o0EfysTeopDw6dsWE+Xaxnqje699aUUbnzEZpxI7AcP3WZ0lDmz6V7L7GY5ND9j
	s6k+SKt96BVW+1ZvSJdD2CjHFK1L4Hk5mrbhclYajycO4z1V0DF81mopuVEunu2tM5XYr+2rWER
	k5KzyJVUw5kOG/l77iOZ+z4OIodiUQGboM4gnBqBxJpFtAAH1n8P3+PA0wstEooBQMuV9l+SFSr
	htBWvrAsh89DS+1gkFp9UGEojdasE8LcIxqtId6or3
X-Received: by 2002:a05:6300:6708:b0:3b5:445c:e483 with SMTP id adf61e73a8af0-3c0f085cde5mr3063429637.3.1783669968147;
        Fri, 10 Jul 2026 00:52:48 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm38555369eec.10.2026.07.10.00.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 3/8] arm64/runtime-const: Introduce
 runtime_const_mask_32()
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>
In-Reply-To: <20260630045531.3939-4-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-4-kprateek.nayak@amd.com>
Date: Fri, 10 Jul 2026 00:52:39 -0700
Message-Id: <178366995929.1208691.6493654690059057340.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783669964; l=605;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=+O07iyphnPsMhbwdcZl/xEUDllR7WIMFNYTSmUuHDHk=;
 b=cz9XXDbkR0SqPbqmjDnlzBYAVi5QXign/r4fxPETsJQjHLuhqKNi1lidC/VVBt9XeNDUNYCm6
 hNQu7cyMBW+DNBsieROPBZ33ez+ffYUCmOSl5oGIFtaAneSomqGU4B7
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Tue, 30 Jun 2026 04:55:26 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
> 
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path. Since all the current use-cases
> are of the form GENMASK(n, 0), with n > 0, a single:
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

