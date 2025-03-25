Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C41F2361;
	Tue, 25 Mar 2025 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932172; cv=none; b=Deq0DOpjJjHhJ1BGwtY/kZv7iCAiuI2a0CLzzQm0TPldQvvHvj9NIesQL7a65bQxubjvKZbSHi2c1qci75I++MqFsGTS5KJ4QpC6mRU+PcP4lF1ptOFnlNwQ0hB4B2lRtoMzd7cvCAvHtMs5hPBm/DbjTIpKTyPDmsnD1Ai5t+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932172; c=relaxed/simple;
	bh=4VQk3pFiSriwbHs0v3wS3Iq/EZ3JdXeMewF/E0+3tOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A6Qomct18rT6ZSGC/9bChpBGtf3ST8znFMhdX1dbR6swsg6pxoneNNAbdXd07mfisMf7JxQhK3EEdWwAseF1DzPijxhdQalSJapffrlhoroe68UEvWQhiPRBdGaHr/cAJ+FtELdJYDJXFNJnslrprK2WS1Dtd8kjqscWTOHYhBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gowlxC+0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gowlxC+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C350C4CEF1;
	Tue, 25 Mar 2025 19:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742932171;
	bh=4VQk3pFiSriwbHs0v3wS3Iq/EZ3JdXeMewF/E0+3tOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gowlxC+0XZ6ALnS4ljvZY2yFR0E1+afbpyEuPoc1m8nolyAvjrzOClx2GfhszCgrx
	 tGUjAVogebUg97sU0TRcY+yHC9h2ykOeHGtk0TCCgY5j7jEbZMdT9PSFPdt5fzpfrq
	 gz9dP3tPHBQums5BYH1uNPhW3qOTmEzmx4olYvKOP+1Y9jgQECPzhxJFiTqs6b5lIg
	 eTUvRRoazbxJTqnXA6E1SiuJk1XqGWPNHMmsN/ZLx9UpR03GKgficc7K3w3v1CXCcB
	 3H5OZlMqTBvQX7d7pZISYg9hG2xG9XloKNOlcaArV2u5hyJCXRCbwKboBfdNoyY3Nt
	 Ln6ZT5Ank5raw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com, 
 james.clark@linaro.org, Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com
In-Reply-To: <20250324152756.3879571-1-tmricht@linux.ibm.com>
References: <20250324152756.3879571-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf trace: Fix wrong size to bpf_map__update_elem
 call
Message-Id: <174293217146.2401011.2061055290446825468.b4-ty@kernel.org>
Date: Tue, 25 Mar 2025 12:49:31 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 24 Mar 2025 16:27:56 +0100, Thomas Richter wrote:
> In linux-next
> commit c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> causes the perf tests 100 126 to fail on s390:
> 
> Output before:
>  # ./perf test 100
>  100: perf trace BTF general tests         : FAILED!
>  #
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


