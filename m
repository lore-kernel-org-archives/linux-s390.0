Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D8335BA;
	Thu, 13 Feb 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459668; cv=none; b=NjCixn99yxILVzc4JnGADZznubs2St2TQ77A1MDQfWry+mIqoMvBEkj2jHjkhCq7IHt+jB+jEvYlTmthe2KHX3SLPS6UbSG+1FYuxtrWO23G6LYXpRXG0HNylGCPZrbysTLb5TbO70uNlFL+7vD1ydJiQYdpMjHDEx2JuY1OGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459668; c=relaxed/simple;
	bh=2/Su0nNJOTZ5Ivfe1qEfm4b8ERGy6jToxRGt6ddEdPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJKltyg/MnIGEuBKUUa+nEIn/MOz44ncf2yIKYP6JLLklKL69nDYjNMb2B58CffmZHVHKkRnjBgHgiCv0pqwssELORLXJ8Fiyf1hvYJYxtUmHz6tQDzvLbLV+Y+tg67OcafsSyeXpZul7mvwekJhcqd20fHeS2GwuCO3dqyCRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE95C4CED1;
	Thu, 13 Feb 2025 15:14:27 +0000 (UTC)
Date: Thu, 13 Feb 2025 10:14:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH] arm64: scripts/sorttable: Implement sorting mcount_loc
 at boot for arm64
Message-ID: <20250213101436.39981514@gandalf.local.home>
In-Reply-To: <20250213150934.12012-C-hca@linux.ibm.com>
References: <20250210142647.083ff456@gandalf.local.home>
	<20250213125302.12012-A-hca@linux.ibm.com>
	<20250213150934.12012-C-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 16:09:34 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> Something like this:

Thanks,

I'm about to send a bunch of patches to this code that removes weak
functions. Since s390 is big-endian, it would be good for you to test them
too. I'll Cc you on them. I think I handled the endianess correctly.
Although I found a bug where if you compile le arm64 on s390 it will break
because it assumed that the endianess of the build machine was the same as
the target.

I'll be sending them shortly. Just doing some more smoke tests.

-- Steve
