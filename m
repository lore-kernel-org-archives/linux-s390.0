Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0A395273;
	Fri, 27 Mar 2026 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645260; cv=none; b=m3SVQeiuY9Uo3oLjL5mnPBHAnrJO5u5gkij4FPQrKCFx1DDu7QgEvheIa0WedwtkArl1ZRV5SI6yVU312yIaotrDcf5+yly7xNPJrRBQExYddDhzyAkhE99pRADSvOPMnJIR07uHeCV9C/VY2yRDTTRuWxrokK0y9m9Sx1lV3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645260; c=relaxed/simple;
	bh=aDHLBVJxMK0ONwFt3edqT2x3Lljt0hW1DyL5Kz6PQEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UgxJux3K6exKO0w9L6qXE3B4BvR9A3OwbQewhWN4watGiiFrK36DBZF+IHgD37D2MexpEVW9WlKK7r7guL2N6jwJ9dJUM0Gv4G6fUJLBjCL6CuVazCkpfj7BmTFcOe+hd6GBMHvCiRXG8YXZ8o1IFWBMqsJL1zIl4VaSFQVLtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlGY9cib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlGY9cib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F1EC2BC9E;
	Fri, 27 Mar 2026 21:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774645260;
	bh=aDHLBVJxMK0ONwFt3edqT2x3Lljt0hW1DyL5Kz6PQEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DlGY9cibHau+jHnDQg0cKKGEkYcnGbncrfHVpIrpJAX3kVmUk8Ay4YCkvu31g4fel
	 89gGdhk7PxD1UlSnhEHtDml69ZgXxoPWVsEcmQsrejBFVK/yJA0BY93UaIvN77UnRs
	 B9jvtMfjC6R1R21SUxK6JVzBHJqJYI7xTHEbrLzz3MdCPBZwqmJl4Kxoe33QUQWTRZ
	 xzDK6HKPN3oEo5bMGvv1l4WEHoZp9ewybyRbxUukDjquziWB2n3h1nF0k1IZsZC5la
	 tRjIk31CPx3Gi4h6KieM+38hhjbO+UCuUdh51mWcywXuyRQVFV3vqVbsNEgAAVqCv0
	 5BS0v7Cxohyqg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com, 
 Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com, japo@linux.ibm.com
In-Reply-To: <20260319084754.3838828-1-tmricht@linux.ibm.com>
References: <20260319084754.3838828-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH v5 0/1] perf record: Add support for
 arch_sdt_arg_parse_op() on s390
Message-Id: <177464526012.2796353.18440741372940146066.b4-ty@kernel.org>
Date: Fri, 27 Mar 2026 14:01:00 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 19 Mar 2026 09:47:53 +0100, Thomas Richter wrote:
> V5: Add comments from Ian and Sashiko:
>     Moved version history to cover letter
>     Added missing comment line +NUM(%rREG).
> V4: Add comments from Ian and Sashiko:
>     Reset variable initialized to zero on error
>     Rework regular expression and reduce to one case.
> V3: Add comments from Ian
>     Print register expression without leading 'r' (wrong).
> V2: Add comments from Sumanth Koirkkar
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


