Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEF3E1CEF;
	Thu,  9 Apr 2026 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753179; cv=none; b=u4+jSYxahE5AR3yUSh6oeJYwHOy1WP6TVfCkwQD7BHlbl5setmP7eH+tIjKWoNQgghS+0/xIyvEajiS9HLxvyNpgsdixcCXXV+B4egG86+EyvlwOSpooJB9vK5FLn8zxHQiDUMZapo4nRpGxAGWaohrtY79mmyMkugqgwZLYYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753179; c=relaxed/simple;
	bh=qpWD/yjK0arJ1obCvvRJEwshf6XF8B+xNDKzyynnsuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nx/WeiU23KabH7n8csbSEl0jw6oBK88TQx/u8ZcD+IpyQ7ItFx11RJmjgDAwejpDNoeWQbMkP31RBbVIdXbe2iMKF9S+HbBcZlFcSB47oEfJyzkfRfxqSyM8eIO11fdSWxb9Papk3F4/HukX+2bYCwVa9FfJFp1EAJGSeIZPi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlFc87FI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlFc87FI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3B8C2BCB0;
	Thu,  9 Apr 2026 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775753179;
	bh=qpWD/yjK0arJ1obCvvRJEwshf6XF8B+xNDKzyynnsuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SlFc87FITQeeWUPbTYWeZFiH32YajmawhAI1LN86U6dmVY4V1gFxQPq/1pArIETFP
	 FWALITz5RYt66o+w2Nh+WNRawjbK3Rs8EztPZcWdK9/xwugiKGBVe227XD86QpJiwm
	 oGtkYbjh0CfJm3vbzuVV23eIhtQ0PwwxYz0Mhj0uBHjxf1qZ4AXI/0NbRlksZiujPf
	 5dxktPU3m7JDkM0k1jebfxKAckIxkfOCuyzHeF0JBhgPIQUQI8u9by+4Z+kMaFNmN6
	 IV6s5xmiLLj0hqJT6TSI2aCRMn1w6GzAAxbNEG5BbpslMdXd38i58un/Sp/NyQ9eAg
	 iicGl2HI+8XRQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com, 
 howardchu95@gmail.com, Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com, japo@linux.ibm.com
In-Reply-To: <20260408113143.1645091-1-tmricht@linux.ibm.com>
References: <20260408113143.1645091-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH v2] perf test: Run test 126 exclusive
Message-Id: <177575317901.128404.8151097001939608130.b4-ty@kernel.org>
Date: Thu, 09 Apr 2026 09:46:19 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Apr 2026 13:31:43 +0200, Thomas Richter wrote:
> V1 --> V2 Fixed commit message
> 
> Running both tests cases 126 128 together causes the first test case
> 126 to fail:
>  # for i in $(seq 3); do ./perf test 126 128; done
>  126: perf trace BTF general tests    : FAILED!
>  128: perf trace record and replay    : Ok
>  126: perf trace BTF general tests    : FAILED!
>  128: perf trace record and replay    : Ok
>  126: perf trace BTF general tests    : FAILED!
>  128: perf trace record and replay    : Ok
>  #
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


