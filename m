Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F233C9EE3;
	Fri, 20 Mar 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020371; cv=none; b=q3R5/m4m97kv6h0lr/1lK4gzE5iO9lhRVB0C86wfp5U4hu6lZ7yR5ggHGdcsal7eLxGLaypz6NYxjDHZOIAv7zSay82/ITj8MSdSxIiaZzosmlX+Pf4B4HbOyMsGYCVtSO3TkAMyBabg/2GFTtdMAn2e4luAf9ZQ7KqJ3t3QzxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020371; c=relaxed/simple;
	bh=ISGBVCX87LRHE4ZEbjeaQ26d5Y0JQsZg5i6XBXBqnP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DK1sC3xld/HR3pfEeyBIBHg5czA9AnJLIMO0i1CwNo2yiWwG8M+ScVzGNcWyFctcEXYe9bqK++Rds7X6OPA9j/0tJiWKS7pvafVRXJkuhtlLoHx+Rf6BjuaIOuVez+IGDtsFcwkuwbKZK5+M1dGaaW9Q4AJETUuhOQKYdKGMWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TexWJPce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TexWJPce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE448C4CEF7;
	Fri, 20 Mar 2026 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774020371;
	bh=ISGBVCX87LRHE4ZEbjeaQ26d5Y0JQsZg5i6XBXBqnP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TexWJPcemOYSbMSN7tcGvtCu9/JAwa9vSnC/hYUk7HWFkUJtdmhQruBG+iU0dawlU
	 EwUlYiqlf8yswXV8jB9oHS/dniQktVbWFhTHThwWuCna74IVmA9ECI2UaBcIYu5P3f
	 4bho17By0t2PvPaxh/Dj5nbqQgmFqwAm1MWHH5/c5Cvm99NGns1Uo1uwQzzM+gh+BU
	 69vju2TUNBZ6SyWviX/YQucFeuUfT/2PpRmGdaJNNS5qtANrlg7zHCurKVDJ1/irQD
	 Bd4N4qcXzoWN0H78GiqlZsvwjZPw75bBc1+/PoZ0ZrZs+fTq+Nl1mCM9n8xWouYLE8
	 YADewC2czdUng==
From: Thomas Gleixner <tglx@kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390
 <linux-s390@vger.kernel.org>, Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH] debugobjects: Allow to configure the amount of
 pre-allocated objects
In-Reply-To: <70f06193b3c3581802710ebcef74671e50c4c979.1772035270.git.bblock@linux.ibm.com>
References: <70f06193b3c3581802710ebcef74671e50c4c979.1772035270.git.bblock@linux.ibm.com>
Date: Fri, 20 Mar 2026 16:26:07 +0100
Message-ID: <878qbmjze8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 25 2026 at 17:05, Benjamin Block wrote:
> On s390 it has been observed, that even with 16384 such pre-allocated
> objects ODEBUG would still be disabled during boot.
>
> Similarly to other debug features like KMEMLEAK add a Kconfig option
> CONFIG_DEBUG_OBJECTS_POOL_SIZE_SHIFT that allows to increase the amount
> of pre-allocated objects (in both the static and later dynamic cases).
> Use it as exponential, rather than linear value to allow for head-room
> to grow into once set in a configuration.
>
> The calculation is done as such:
>     N_OBJECTS = 2^DEBUG_OBJECTS_POOL_SIZE_SHIFT * N_BATCH
>
> By default it is set to 6, so the actual amount is unchanged, unless
> the new options is changed:
>     N_OBJECTS = 2^6 * 16
>     N_OBJECTS = 1024
>
> For the previously mentioned observations on s390 it was necessary to
> increase the option to 11 in order to have enough space during boot.

That doesn't make sense. The only phase where debug objects needs to
allocate from the preallocated static pool is the time before the memory
allocator becomes available. I doubt that this early boot phase eats 16k
or more objects.

This smells like the problem I fixed recently:

  fd3634312a04 ("debugobject: Make it work with deferred page initialization - again")

Looks that I missed to add a cc:stable for it.

Thanks,

        tglx





