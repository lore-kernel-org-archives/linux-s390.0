Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F533D6EE;
	Tue, 30 Jun 2026 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862557; cv=none; b=cnwZbdbdFY7GAYcWtA6YKtexNSBvW2s96hsvRqCvxAWP6KOvEGCrmnuhKGxyFEl6eZdXAuB5oR2SyFfxK9BxhH7NHomW+G1oIx3z6aH8qovGxBCUtW3cSAHNeytNLmZ+GIQGAS0HcdZ0QdUShnIFBW+fn6lEBmJ4pJ9lxwizTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862557; c=relaxed/simple;
	bh=Z3xrLFeucB+Zr5CdU1wRPEK49/2N4X7awlP2U5T+shY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=driHV/DPODFH+Cx3xVRmyFDbf8l3mDmi3Y7yHWLWhAvD+kwRpKmXFFHzIBOD8C/oJxSnSlrM7REN6iOoeT6I18gsyOGlxuV15ZN1Jt57ovbpIWn9691ubkbdkLcnIvLlJEwZrWq0WTBW5ujGp2au8wNrzzEb6YRNiNjkw224WCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5cCW/cW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5cCW/cW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302D1F00A3A;
	Tue, 30 Jun 2026 23:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862556;
	bh=ZIgosT/66ZmkpCeqgtXuuTpUUCceyrs2Yhc2tBnwvOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f5cCW/cWLYiQODPjwmUTJDLes5DOcYpyqPCfNAmzntoCDjL8rl4Vh//AriMWCzeHO
	 rHnKLbIzoaMfIVDc4zMfRlY2ruRzls+RwhxlIYx7SqVd/JwdzwpHiCcMBvIk3WVLhb
	 NNnOnmJ3bwrqF7zgVYatj59qzsMClLdLyM+XXmLTSQUpHi30a3tV19mQLY2BgM1Pjb
	 nObPh4oNtHX1EVztOOmxzGLgEafXmI+BUjouxuMSiNqQvmUrs/Wz3O16fvKt+YxpXO
	 /KC8mQR9AdL0trMZYz1Kju/CVZ4KNtMTtdnctJQ7AGiIJYdJqNMNHzRAEmGODrXK9J
	 SpA2FGrKsRb1Q==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com, 
 Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com, japo@linux.ibm.com
In-Reply-To: <20260629110559.1283453-1-tmricht@linux.ibm.com>
References: <20260629110559.1283453-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH V2 linux-next] perf test: Skip failing 'perf test aslr'
 test case
Message-Id: <178286255589.2863034.12733867840702308395.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 16:35:55 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 29 Jun 2026 13:05:59 +0200, Thomas Richter wrote:
> V2: In response to sashiko:
>   > [Severity: Medium]
>   > Does unconditionally setting err=2 here mask prior test failures?
>   >
>   Do not change the return code when skipping the test. The failure
>   is printed on stdout anyway and does not hide any previouly
>   failed tests.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


