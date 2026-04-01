Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F927B4F7;
	Wed,  1 Apr 2026 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014908; cv=none; b=eaEFfRGGpYwhm8UcOHdFf0OLjVnMIgtzMhdr5pr/tXnPHupT+7On83AJP3mZQZvKgxaVK7l/UqMW8YioqsxxWuIFkVY+UDXMCwLpNw5+NSIFcyrFWns0ciBN8nM5lazeclyZDCxW5zoM0Cv4I069W/3iaJYbRKCUoASUNOgRXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014908; c=relaxed/simple;
	bh=xT1A1ghi2oF7C8alEdXW77pytLgkDnbIwD2JXTbo0aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwJlkuoR6rcB9fUimdo/1T9zjPVeT9rERxu7H0zJwLFzOVJKkQ2V1G5KF4+qk1RimNLk4oKhUalnak8up46WE0Lb0fXhjKvLk3uVb8VPDjCsMeOHB1DlxQhbtSXX6f9fKU2o723UAAOfzaPREnWgFS42bH8PLRh78mLcu48OF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+xBAsj/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+xBAsj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0FAC4CEF7;
	Wed,  1 Apr 2026 03:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775014908;
	bh=xT1A1ghi2oF7C8alEdXW77pytLgkDnbIwD2JXTbo0aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+xBAsj/SmESfH0r6zxi1mn4/LBwLZtnesEGD/3h8Vw4kb241eopRt6cyFnp3Bc16
	 iCa3zL09Q+4YoxMk0mx3j9l6JHkKdza2WjUImM9PzseRD1F5SdDUlTuvsYpaB2AXsu
	 6DSk0sGXWwphdQrlCegmikSjFSP9yxU4H3d+cdJkQzS67K+F9hl5dfsA8g4DLsXzQa
	 NF6KHyerwq0mABV6E1EFMgHNES7Yff3FOkuGm7RCpHuRnx2mwl567AUV9fr+WWagyu
	 6hvrF8hZakh1gsNKqpbbZDd9qQQqtqGECMxAvZZLJM7BTH29Xs50jLGBgJhEHq2KcB
	 kFmfU9XtnrGXQ==
Date: Tue, 31 Mar 2026 20:41:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com,
	tmricht@linux.ibm.com
Subject: Re: [PATCH v2] perf tests task-analyzer: Write test files to tmpdir
Message-ID: <acyT-ua9xspntyY0@google.com>
References: <20260326174521.1829203-1-irogers@google.com>
 <20260327060033.2294469-1-irogers@google.com>
 <act2RNT6-3Kx_h5p@google.com>
 <CAP-5=fX12Kmd26bq4xRjx50WzmuuMszEzuVY=g6y7-hkPd8Wzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX12Kmd26bq4xRjx50WzmuuMszEzuVY=g6y7-hkPd8Wzg@mail.gmail.com>

On Tue, Mar 31, 2026 at 10:58:55AM -0700, Ian Rogers wrote:
> On Tue, Mar 31, 2026 at 12:22 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I'm curious why this patch is in the idle symbol thread.
> 
> I'll separate it, I was gathering fixes. Same branch has the BPF
> counters test fix in it:
> https://lore.kernel.org/lkml/20260325171653.1091337-1-irogers@google.com/

Ok, I'll test and process it.

Thanks,
Namhyung
