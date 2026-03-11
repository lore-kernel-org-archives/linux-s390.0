Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3B3446C0;
	Wed, 11 Mar 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251248; cv=none; b=luQr15xZOh8nCYVzgCnzhP3JOTaJAB4DgW0cRNh21QupwCXhgSX8v86UoqMCOwIjtCRp+sm1UTua7HovRJ3ttE+GJAi5UL2A16B4BHVt3arT+Nz+QYveARHkwvlC5Y7lZf48bQOQ7CntESHsIpg0Eu1WsvZLFdmtX+KXR+cr6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251248; c=relaxed/simple;
	bh=/ybzuH8CZwmWEqF4r8/RSN0H5TAVeamfd+1lEpsIwak=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P3JlsU4xprbIhd5Bw0B3eWnX/JoJPD299MbccLJnbDO0XbYdpn5NQHwp8GxPDk2KxKi+9EEEXEvvXnSSbIv79OB9MlWIwSNmXMhT6iFSydPhtrAQuo0gMFAU2aRlCl0vFwytbLgf2lT4fBJrT3Zm+E32ZK1T20b1+n6wdgDLwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DS23xBxG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DS23xBxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F53EC4CEF7;
	Wed, 11 Mar 2026 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773251248;
	bh=/ybzuH8CZwmWEqF4r8/RSN0H5TAVeamfd+1lEpsIwak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DS23xBxGGcvx8kZjIFD0mykrxquogeFa35HnOlnXp/eVFwtVuIM1i/qq7KctqP6yl
	 Raika8JLEK307TbSeO09Qo5o8eZOxB+aXEFNaZlED1YF4Z/WWi05sR36nKMdaLBji1
	 6BOzCv6zZH2UNV6gR1j1/4G+sG8zCP3wtPS8qHMg=
Date: Wed, 11 Mar 2026 10:47:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] debugobjects: Allow to configure the amount of
 pre-allocated objects
Message-Id: <20260311104727.8f7b1492141b6d61fc1b2791@linux-foundation.org>
In-Reply-To: <20260311100431.GC46248@p1gen4-pw042f0m.fritz.box>
References: <70f06193b3c3581802710ebcef74671e50c4c979.1772035270.git.bblock@linux.ibm.com>
	<20260311100431.GC46248@p1gen4-pw042f0m.fritz.box>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 11:04:31 +0100 Benjamin Block <bblock@linux.ibm.com> wrote:

> > ---
> >  lib/Kconfig.debug  | 32 ++++++++++++++++++++++++++++++++
> >  lib/debugobjects.c | 15 +++++++++++++--
> >  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> Gentle ping, any comments at all for tis?

Normally tglx stuff, but lgtm so I'll add it to mm.git and linux-next
for some test.

obj_static_pool[] is __initdata, so the consequences of making it large
are very slight.  So do we really need
CONFIG_DEBUG_OBJECTS_POOL_SIZE_SHIFT?  Requiring a rebuild is a huge
hassle.  How about simply making the static pool much larger and leave
it at that?  Some statement (or, better, comment) which reveals the
number of bytes which are (temporarily) consumed would be useful.
