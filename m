Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59061FC0A;
	Tue,  1 Jul 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751392514; cv=none; b=OQSuPNpisEuop47Xte6+P22njzFWOOvWjj/ZJ6pd9e0vbsPXSTrHHbNbUbVB5jLuq2q50IYBK0pGfXEwLAfDF2SdMaakW4asBRSTumFvwpBRDLnNsxabPFMNMPxh2K/8vptOV5QX7g8mQrTn0SbJtNBSCKtMsdZtxyurEY2KpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751392514; c=relaxed/simple;
	bh=mmJjoTZnRRpWNZphf6pjaNzOYayd41EX93Q6Qq8RYqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GcYGCpibV8L+q+XlFVh6dts1EZbCDhaUyGumVcL9PlfEXrXnkk4CeGyb48zrly8C21x/uBrRgsgE7LmupjzGUXcdaWMb27UaAqJXvTAA/2giLYXmsIb3VXzKYIdqFQ2kghIe3MPS56y/2eqNlkX3IPtEPSNKWBvxYikX8+td4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5tfX3sA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5tfX3sA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB85C4CEEB;
	Tue,  1 Jul 2025 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751392513;
	bh=mmJjoTZnRRpWNZphf6pjaNzOYayd41EX93Q6Qq8RYqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=j5tfX3sA3w9FTZlxot+ZE9FyfwB/J2/OlscAYwBtf8gXmysP3IjrUwHibMmOApwJs
	 PBuOayHEeGXFbORxbbZQ8tlpzH09RynMef9jf0ess32IbjE7BwWLewweZNeUFgRngC
	 nE6MsMTKbeHJc06Arl7noRxzog9dAIcqHMIzwUZIVP8yMdS282L/TJXbnQ0LeLBp5i
	 9eescFs2hjOzsR/bnobYEM/400Z/6uEA/OU6vxS49WL+ORy2+qzhkIrn19Rz//E9/1
	 3NyuoC0kxTDXFnmfDOZlwJMB8dO8gaXlJ5TidVLbgoFeOILfGKUuCYl1LFEyTC3n8Z
	 vEK8onslal8MA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com, 
 Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com, japo@linux.ibm.com
In-Reply-To: <20250630091613.3061664-1-tmricht@linux.ibm.com>
References: <20250630091613.3061664-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf test: perf header test fails on s390
Message-Id: <175139251355.738306.5236113669917576265.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 10:55:13 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 30 Jun 2025 11:16:13 +0200, Thomas Richter wrote:
> commit 2d584688643fa ("perf test: Add header shell test")
> introduced a new test case for perf header. It fails on s390
> because call graph option -g is not supported on s390.
> Also the option --call-graph dwarf is only supported for
> the event cpu-clock.
> 
> Remove this option and the test succeeds.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


