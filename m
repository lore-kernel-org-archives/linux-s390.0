Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DBD33F8BA;
	Mon,  2 Mar 2026 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477028; cv=none; b=OpzynEC1kpA3yJkmCu+5K86+GhZ0GSlKV5ov8u3bxywtxekEEPoRIcSDpNgWoBDw/5wAa4sD/7VfG0jBsRSBZWHvhRtKbhbUaxOaOjE0zAqRbrcRIRLZk18MyEMGtWXJ3imLHbNRfTIVpDHAY4fZan/Qp4oKhb/IDpUlL65Dk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477028; c=relaxed/simple;
	bh=p69Wx+yYCdaAw5XuGCMj2PVRn6cK9Mhx6paMpqNVQVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll0g0L17g535Aoqf3Q8jK03C6llfvVwLEh86tKTKHAUbw0HorIefpQeE31vTabcEJkc82iEdSRPvdpi4I57jA05ArjZYF71oiQqH07b2LFYs3Uv6rKbdHBB7iC8UgnrSa5w9UOBVxbgqHiMUM5BOnTG0Rlf4Lvwkc9ByTYgzdo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IffqYYtv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IffqYYtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CA5C19423;
	Mon,  2 Mar 2026 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772477028;
	bh=p69Wx+yYCdaAw5XuGCMj2PVRn6cK9Mhx6paMpqNVQVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IffqYYtvMn7KJ6jXK9eOi+gE+xlaD6EJPDNx5of8uz6h8vvEqD51pHDXXLLxKdBF4
	 SA9qyp0ADi0pqBtEgk/XQpuGjNSLRSvmNNZePDZeP5sDTCg2IALjPAKSDVL5Rx436C
	 yPAmIXSpBTHb1J5GQ/Vm0eRfgKE73EKLOsByQ9OGQeJtJQeRsQPO8FdFs3Gh7OKama
	 PgpfzcmfhFwBC6YtZOnpiJb7JLFN2LjX/iNemuBikN4+CLlVxgE60ix5Cj2bz2p4Hq
	 8YlX+XMdJYyCtqHATOdsXUlxq9ymzw94CFRsvMgUgY2PLiqEQcTo6D6bwO6ZNVG3CV
	 47hWaHs6Ami9w==
Date: Mon, 2 Mar 2026 15:43:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH v2] perf symbol: Remove psw_idle() from list of idle
 symbols
Message-ID: <aaXaX676sTLCX_LG@x1>
References: <20260219113850.354271-1-tmricht@linux.ibm.com>
 <aZzKrRB0__RahFJV@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZzKrRB0__RahFJV@google.com>

On Mon, Feb 23, 2026 at 01:46:21PM -0800, Namhyung Kim wrote:
> On Thu, Feb 19, 2026 at 12:38:50PM +0100, Thomas Richter wrote:
> > Commit fa2ae4a377c0 ("s390/idle: Rewrite psw_idle() in C")
> > 
> > removes symbols psw_idle() and psw_idle_exit() from the linux
> > kernel for s390. Remove them in perf tool's list of idle
> > functions. They can not be detected anymore.
> 
> But I think old kernels may still run somewhere.  It seems the above
> commit was merged to v6.10.  Maybe we should wait some more time before
> removing it in the tool.

Agreed, using a new perf tool, say built from the tarballs made
available at:

https://www.kernel.org/pub/linux/kernel/tools/perf/v7.0.0/perf-7.0.0-rc1.tar.xz

(I will not make a rc2 available since there are no changes to the
tools/perf codebase in this rc).

On older kernels should still ignore those functions.

A suggestion for work in this area instead is to get those samples into
a special bucket, the "idle" one, and show it at some place in the
screen.

Thanks,

- Arnaldo
