Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585572AD3E;
	Thu,  3 Jul 2025 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566612; cv=none; b=rVKnZtGoLhpvj+LdMv7H7bjf6STZzs6/DBrVhE615PZeF/AEWP2nTYkAxCO3gmB97brdzF5VREuCfpgB9U5BrS9ZwFdNN64wqrDLOZNNIqQSdDgJGi5WDC9WqOn+BZ6woFjyPYL5zIOSzNtxsa+sHq4yGVcEuzI43LZ07uRWrhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566612; c=relaxed/simple;
	bh=jqsvENx3Fc0ITmwnzAoELZCWoKd18bErYznEf9tX6SE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BKZiKPx1KqgnK4B959jcLOsrPDhphm2GZzrJ2MzBPyRH52Dhav7qE+iA2jJhRQ2BO3va/jiy0Ec72f22NM9DJP917h24vwgjSJc7acn1fU2e+S/6e5MOqM2PcvtugD3UJQWPWO8ttAEQYjV/3lgTy8RN/Ek+x/ZDew19oMhnHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GALNq40T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GALNq40T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F076C4CEE3;
	Thu,  3 Jul 2025 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751566611;
	bh=jqsvENx3Fc0ITmwnzAoELZCWoKd18bErYznEf9tX6SE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GALNq40T7sIeGZgZxlsszEEAweaV76HBHEJJVR+p6xles8O0OUSpWKhCBorQi6Txj
	 Lrjwh0JnU80nP5CpQQk5kh+xLNRh1UaX2sQeCMQIjIOBF56K//baJXFPaKOoku2lrL
	 3ZzN6rWa4e4wFYlfStqmU7D3RERQKzRpVsTFuITmEfYvTXF4RuMs0bd6pppiaupkeF
	 XMbCZF5yq1xbUHnKnFdS1AWyi9UEU3OUr10L0b1ufrBaE0tVe/ieNsBWyTqQ2ZdDod
	 bn2zux/XB8tKdGX4T/VYKbi2pbwKRKNQuP6qpmzlF4qTaZ76eeMFeQgZC4a7bjZP5o
	 g7bh/m7TXWfzw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, 
 Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com, japo@linux.ibm.com
In-Reply-To: <20250623132731.899525-1-tmricht@linux.ibm.com>
References: <20250623132731.899525-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf list: Add IBM z17 event descriptions
Message-Id: <175156661154.2551523.16915400489545554468.b4-ty@kernel.org>
Date: Thu, 03 Jul 2025 11:16:51 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 23 Jun 2025 15:27:31 +0200, Thomas Richter wrote:
> Update IBM z17 counter description using document SA23-2260-08:
> "The Load-Program-Parameter and the CPU-Measurement Facilities"
> released in May 2025 to include counter definitions for IBM z17
> counter sets:
> * Basic counter set
> * Problem/user counter set
> * Crypto counter set.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


