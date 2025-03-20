Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BB223702;
	Thu, 20 Mar 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486444; cv=none; b=Z4/F0i7czypCTesADAK/nKY4z68yp/O8eI3lvbs2IZHoueBRHP7e8n5vc9NEWW+Ir6rJ3pLo6Dolws27zj3QC3+S0HKMR94sHQkfSgPWyw7BNry+wfGPHnypfxeRk7L4SQ0pZadVisuPff/VoA14ZReumIPQQYJCx2KzPGMHDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486444; c=relaxed/simple;
	bh=mWuNhen97+ogDvScWS3rwJwyCCtu/yl0TBX4KFYDSFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FS8IAmoKdMnSuUjYsayqgLKDfSP05X3BbYlLA/xYeuwW4UAVd6Y/LgBMrRC/yrQH6rchDMMEH8A0EikoCNJjgWB+s7kaT7BcTfSURNaWu+Jbgvbt/6x+F1TJzLnf2sN1FAFvofMdrBoQrUiQNCiML/SPGuwTe9yRd7WKSXw9LXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZOWkAbv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZOWkAbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4EFC4CEED;
	Thu, 20 Mar 2025 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486443;
	bh=mWuNhen97+ogDvScWS3rwJwyCCtu/yl0TBX4KFYDSFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MZOWkAbvPX2oYW8UC17gB/g/VoY/CS/PeElhjPR1jUkLxlqyW/pHsjnbsA0f5b9uR
	 lw0vZ7gH4B2z6gnnJYpvVEEcHyoNDU/1l+RVsnXqfMTQ7uWZuD5wf/j35u8S+j6N6k
	 6hlAJVaQ111VldpY8X9Y0zLAVjgUkQRPHafbXqxumeDsdbX4ZET3N1tnXb/rDAVWq3
	 D8oD8SGkCkTdNQFqxZBDhrzvLzlqv2PFSv3xi89cQXVDeGIkB+nXoYpL+Lp2uY1boO
	 Xajl2FQRb7WSSn7WP4uDm+QPmfeRaNx7cFpllkPpJpnfjvA21PpZr/BBhotMlUuRt7
	 2frHLXwNOZMSQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com, 
 james.clark@linaro.org, Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com
In-Reply-To: <20250319122820.2898333-1-tmricht@linux.ibm.com>
References: <20250319122820.2898333-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH v2] perf pmu: Handle memory failure in tool_pmu__new()
Message-Id: <174248644314.3704425.8927077374160851392.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 09:00:43 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 19 Mar 2025 13:28:20 +0100, Thomas Richter wrote:
> On linux-next
> commit 72c6f57a4193 ("perf pmu: Dynamically allocate tool PMU")
> allocated PMU named "tool" dynamicly. However that allocation
> can fail and a NULL pointer is returned. That case is currently
> not handled and would result in an invalid address reference.
> Add a check for NULL pointer.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


