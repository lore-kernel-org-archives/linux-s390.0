Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89F25A627;
	Thu,  6 Mar 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281250; cv=none; b=nHo8S33XO3se/VWpcKfCEGotwMj82ifZrmNjhOYvhvoHXOCpLEvR886TgTiDibHQwpPnC2KUxiX6YPTxjPC3wWOXmIrVOMp+PORgDm6/3AXXvjX4hg/PKfHlPeuOMO2wTVxH+UST4+pxCQhkVHahWBbH/AipiRguHa3VwCmqMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281250; c=relaxed/simple;
	bh=LHZaCsmiI1Xxu72j/VFZX4yF42q/3KhljENA52wVHUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qukvQWDkhzLXXiono2q2RTZPinhw02SQkvNcmzlOVJtOZlJu8EfEgcRsABIzpr6/0VpNAt8ZiJp1U6vR3Vqism5tPByqkmw+faLK+a7+qIeESWkXAUaARzEU+2AgXR1S22mjvwehRnGmTZkIoBcCGn8tZNcvAUi6PVU18jLVO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0Hmfhh0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0Hmfhh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BECAC4CEEA;
	Thu,  6 Mar 2025 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281249;
	bh=LHZaCsmiI1Xxu72j/VFZX4yF42q/3KhljENA52wVHUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q0Hmfhh0ygfhFsrdqbi59TPkzObXa2Z/cpC/8O+HOAQ6uRTBW7lVKywzk1kteqBVQ
	 WIAJVFEaddth9aHGvVLBgjsfCxcXjVaz7TQiDANPTgf06P+5SjQ+z0gP1thUypE7kw
	 VL56wzhn0/noW4LwR31sZSlLfDqhRvuNfJjpap0TweKx4Mfv18EGJOWhpKBEqosKSv
	 bP70HQJpxZmny/9muvAEq6qS7zd0BtXhlonixF/Ulx1Eege2mYPVdVpC5z4NKGAe2J
	 XPaaq+KqNkqpS9QQRX0qjwoZdF3Tzi7+hlljAEMCmIXzDwSTFzBXXlIeky8fm/Urgy
	 sQU/+vNSqcF8w==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, yangtiezhu@loongson.cn, 
 Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com
In-Reply-To: <20250304092349.2618082-1-tmricht@linux.ibm.com>
References: <20250304092349.2618082-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf/bench: Fix perf bench syscall XXXX loop count
Message-Id: <174128124901.3835280.12336231396508752051.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 09:14:09 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 04 Mar 2025 10:23:49 +0100, Thomas Richter wrote:
> Command 'perf bench syscall fork -l 100000' offers option
> -l to run for a specified number of iterations. However this
> option is not always observed. The number is silently limited to
> 10000 iterations as can be seen:
> 
> Output before:
>  # perf bench syscall fork -l 100000
>  # Running 'syscall/fork' benchmark:
>  # Executed 10,000 fork() calls
>      Total time: 23.388 [sec]
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


