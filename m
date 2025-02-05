Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D41FDE2E;
	Wed,  5 Feb 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780799; cv=none; b=T6VI68MZlqcL5FPmfHz8/XamVRvGVtU+RdHG11GZ5oOwMU2ZufkZw2e22L6q+LbiwVhLlN6nvULTi/VUWO3he2DKCqyvs6335StTGvM90Z5jNCiXSWjXJqwBNjTHGgHsw+DVHnKObW21wmqE9GyK8mUJIe186B3x9zFPBVrFQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780799; c=relaxed/simple;
	bh=7sWFejsI1UCl+uJkGzueUtnSh1WmqUnOFRxmBVHo/xM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VL82D/ooZFU/FYmh9m3s7K8eg07VjwUnyvdtq3trMB1ixxv6okeoc+NcI2Zh/Nalm2bjHetrL0xxDOhwUinouvaNN68Te1HYDU4QS/oXcDT+vMgJZu9zEBVW7Ko0O/uKbz/RgqVYVuPXTGJqiv07WvQSsAN3Xv4erI6/rnEwT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/8axFdO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/8axFdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FE1C4CED1;
	Wed,  5 Feb 2025 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738780798;
	bh=7sWFejsI1UCl+uJkGzueUtnSh1WmqUnOFRxmBVHo/xM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N/8axFdO2VtANlm9amv+GOX1rf+wmuZiSP6HZ2Dn97Vs3k6J7lRjauVwsMaIir9my
	 7bptf4SdPsyjbSWAD9pejTdZbUQrS1DfGblSWthHyeyFj0pbiBluOFym+OMEDXxcNV
	 vAle1qHYmUgT1mO5jAQYjMwNUU4wpSwXkGHDL5siMn9XlWtnTyD+7hLzWVWEeGMUgH
	 8uqAgNZVViM26gqe8+2HiKBuW2RzmHa+GZpbEdlqu4EOVkoFbm8db+MP/OvYE8bxZv
	 OOrfIxZn0mVnhoOI0mAP9VlHdX8GIH6OlhNG2bG5TjE6uQUqu1j8Qsy73oH6LpXKA5
	 XEbrYpPsTkzgQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 acme@kernel.org, linux-s390@vger.kernel.org, james.clark@linaro.org, 
 Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com
In-Reply-To: <20250131102756.4185235-1-tmricht@linux.ibm.com>
References: <20250131102756.4185235-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH 0/2 v3] perf test: perf record tests (114) changes
Message-Id: <173878079824.596119.8970944890321793548.b4-ty@kernel.org>
Date: Wed, 05 Feb 2025 10:39:58 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 31 Jan 2025 11:27:54 +0100, Thomas Richter wrote:
> Change event intructions to cycles for subtests
>  - precise_max attribute
>  - Basic leader sampling
> as event instructions can not be used for sampling on s390.
> 
> Thomas Richter (2):
>   perf test: Fix perf test 114 perf record test subtest precise_max
>   perf test: Change event in perf test 114 perf record test subtest
>     test_leader_sampling
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


