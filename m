Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7734C3A9D85;
	Tue, 24 Feb 2026 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955847; cv=none; b=KvmGS6k7EG/+I2iHzNLAN3B8P06xKF4BfRXSFk2g0c7BM5AOzUCGFdEuAcNYKmxLMOr5/wxiYcY3y9ahVeqUojDelZlScMey6gwx9E+OGgm2jjuXtYb8wJOv5huEhHYP1gqft5wMcROPvh9kJgtd4pRCTX1x8ZrPaX/AECji8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955847; c=relaxed/simple;
	bh=P0W2qgMn8eK7rOLDE6yj7CRPUL43ye8iCKlp2nsc4OA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lCY/4ctHWYzSMHjZo8SuBmDhsKc2sCQWvlN8s8XcpUhrEZJbQsJN20h2a6p8tV7JXKLs8Shva8IVBCS8tKaZNthKo5lnc4bmJbmYpW+t0C3qg07fvnEPYv9vB3zGC4h3xk7iIbW8D6MKgjajOOghmkpgPWxVPGAuqAreHm4R7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMyI4dj4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMyI4dj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF90C116D0;
	Tue, 24 Feb 2026 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771955847;
	bh=P0W2qgMn8eK7rOLDE6yj7CRPUL43ye8iCKlp2nsc4OA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oMyI4dj4VUIWEATDuvnigQ3XojMInIKXW1usQquglc9BjhH2D+9hsk4uqLYr9JZs9
	 UQ/+zuEzmynTv5SEpcpA04m3i2Mc6NFlFsZeN2XmFW2sbuHOu9N5c+g2IVCbEVg80V
	 vILTo1yRNMQiCUgaErytWorUpwNJnG4ZrLamdb4LukGwYao++ibcw066lXgn1IKG1E
	 8Dhyxn/Ih/p5xpHlW6fli3EpyDj15FzNx1ZbHOb/A1/U0AHjI/yS2ur9VOP+Yd77i5
	 BCq0x06FvfuvNhU9TlE5XwBpJKrWml4fP8vhVQziW311+ZP2tYYSnSctSeoDC1WiHk
	 8EQjPLouEXT1w==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, james.clark@linaro.org, 
 irogers@google.com, Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com, japo@linux.ibm.com
In-Reply-To: <20260217131456.4085419-1-tmricht@linux.ibm.com>
References: <20260217131456.4085419-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH v4 linux-next] perf parse-events: Fix big-endian
 'overwrite' by writing correct union member
Message-Id: <177195584659.2594382.16344499821464213799.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 09:57:26 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 17 Feb 2026 14:14:56 +0100, Thomas Richter wrote:
> v1 -> v2: Add comments from James Clark and Ian Rogers
> v2 -> v3: Improve switch statement in add_config_term()
> v3 -> v4: Fix clang warnings
> 
> The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
> due to a NULL dereference when the backward mmap path isn't enabled.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


