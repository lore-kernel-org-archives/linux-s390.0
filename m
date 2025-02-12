Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3626137A;
	Wed, 12 Feb 2025 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386447; cv=none; b=Yoz7YISBz0Txsqsv2uJ20hUOsYytP+f+C80Xoqblgc+bB7Sox7g91WY+e/dez0Ty2Z6QwZTLE1vMUOz+cSwVJx42MoR908Es8pJQ/rN9Ciiw6T5haRQVHZqqpP9Yke6lUJg84BFWtmuJCX1YpfXb4ZKNlDBUKYNnIYP242BVrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386447; c=relaxed/simple;
	bh=bkVhflZeLEpbEPNVV8gcaf98X2tvO0WnYVzbJKOTJuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+DMQJ+YMTqUY8DCHpntmPvPOIuWAltIVq85HD8MLXFPTpcxulnJz/ILiq4woXzOSJWO3H5dCojejAok/4rXGIBfWXv7mM6Cj4fma7mYqymrN3Z+WI1yy9ynbpgITt+4iqeMKQrZ9q65gSlXTdXRKzfp2q/Kb+SM0USWSnbZQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856FEC4CEDF;
	Wed, 12 Feb 2025 18:54:06 +0000 (UTC)
Date: Wed, 12 Feb 2025 13:54:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] arm64: scripts/sorttable: Implement sorting
 mcount_loc at boot for arm64
Message-ID: <20250212135414.785e6403@gandalf.local.home>
In-Reply-To: <Z6zqHY0a5CPEaTCN@arm.com>
References: <20250211141139.03d2997e@gandalf.local.home>
	<Z6zqHY0a5CPEaTCN@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 18:36:13 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Much appreciated!

> 
> (unless you want this to go in via the arm64 tree)

Nope, I have more code to add on top of this that is related to function
tracing.

Thanks!

-- Steve
