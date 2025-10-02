Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15CC946C;
	Thu,  2 Oct 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425636; cv=none; b=MzkQXziuAipBM5AM047CxcUad6xdgSyaGymJWJud/iUXvP9njb+RbJUzBmpYm4C7eytyyM2kCSrKwggErU7PVA0dx9q5muckXwrjn0Tk6Il0Dtba94FYagbEz8zDsHpmPuVbTr/dF6ybR1hGxL6cO9onUG0YqJtrOtC/MnMlny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425636; c=relaxed/simple;
	bh=RDE8KPUoi9SPtpr5Luix35i0mohR2YxtXEaEVdxdNbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpcYKBVQE1kUiWHmdUntbaWJcYcxutwv/7A29Gg6gnXcPBsie8kXlT3nYda0V4G046pqRXO61NYLcAZHbK0JYSe9653ZhIHPSXVupiYITd6+9xFHP2rKjfZM56/CUcyLS645ORP9l4QDN36cPTMKaP0AMm0k6fVGDY/g6yrtG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWX8ljIO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWX8ljIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50116C4CEF9;
	Thu,  2 Oct 2025 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759425636;
	bh=RDE8KPUoi9SPtpr5Luix35i0mohR2YxtXEaEVdxdNbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWX8ljIOchzW+5WFAKhQAbV/uM+vRCD+ev25n87CeKCgKnzpWTX2J1b0vk0GltXFz
	 zq6KKRS92ouhqLVNcnJTNDyyINWUjXLiM98n3JHemPOUApkq35oXA5xksYOZf6ASfT
	 V4inhpecVRAa4xUhsrsTdOqbJZLxrT6o2+PCGCWSm6Zpqo+d4XNP0MltXOoxDOrCI1
	 9KYU81YZ43qnFV6wNTRmCncvZoEZgVhm5b8DuaJ+7rDeuJ4lli1l6ADHRAsVp73I2r
	 Yf67UUHSFu7xs8BM0dx9IouTb5bRuFCIwSUy9QEkPGIs6qVBlNGth/mAgXClrazgQ1
	 lGJjnLG5GeIkA==
Date: Thu, 2 Oct 2025 10:20:35 -0700
From: Kees Cook <kees@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Josephine Pfeiffer <hi@josie.lol>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/sysinfo: Replace sprintf with snprintf for buffer
 safety
Message-ID: <202510020942.9BBB100C6@keescook>
References: <20251001174104.192486-1-hi@josie.lol>
 <20251002074821.7570A92-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002074821.7570A92-hca@linux.ibm.com>

On Thu, Oct 02, 2025 at 09:48:21AM +0200, Heiko Carstens wrote:
> On Wed, Oct 01, 2025 at 07:41:04PM +0200, Josephine Pfeiffer wrote:
> > Replace sprintf() with snprintf() when formatting symlink target name
> > to prevent potential buffer overflow. The link_to buffer is only 10
> > bytes, and using snprintf() ensures proper bounds checking if the
> > topology nesting limit value is unexpectedly large.
> > 
> > Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
> > ---
> >  arch/s390/kernel/sysinfo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
> > index 1ea84e942bd4..33ca3e47a0e6 100644
> > --- a/arch/s390/kernel/sysinfo.c
> > +++ b/arch/s390/kernel/sysinfo.c
> > @@ -526,7 +526,7 @@ static __init int stsi_init_debugfs(void)
> >  	if (IS_ENABLED(CONFIG_SCHED_TOPOLOGY) && cpu_has_topology()) {
> >  		char link_to[10];
> >  
> > -		sprintf(link_to, "15_1_%d", topology_mnest_limit());
> > +		snprintf(link_to, sizeof(link_to), "15_1_%d", topology_mnest_limit());
> 
> [Adding Kees]
> 
> I don't think that patches like this will make the world a better

topology_mnest_limit() returns u8, so length will never be >3, so the
link_to is already sized to the max possible needed size. In this case
the existing code is provably _currently_ safe. If the return type of
topology_mnest_limit() ever changed, though, it would be a problem. For
that reason, I would argue that in the interests of defensiveness, the
change is good. For more discoverable robustness, you could write it as:

WARN_ON(snprintf(link_to, sizeof(link_to), "15_1_%d",
		 topology_mnest_limit()) >= sizeof(link_to))

But that starts to get pretty ugly.

> place. But you could try some macro magic and try to figure out if the
> first parameter of sprintf() is an array, and if so change the call from
> sprintf() to snprintf() transparently for all users. Some similar magic
> that has been added to strscpy() with the optional third parameter.
> 
> No idea if that is possible at all, or if that would introduce some
> breakage.

Yeah, it should be possible. I actually thought CONFIG_FORTIFY_SOURCE
already covered sprintf, but it doesn't yet. Totally untested, and
requires renaming the existing sprintf to __sprintf:

#define sprintf(dst, fmt...)					\
	__builtin_choose_expr(__is_array(dst),			\
			      snprintf(dst, sizeof(dst), fmt),	\
			      __sprintf(dst, fmt))

The return values between sprintf and snprintf should be the same,
though there is a potential behavioral difference in that dst contents
will be terminated now, so any "silent" overflows that happened to work
before (e.g. writing the \0 just past the end of a buffer into padding)
will suddenly change. Making this kind of global change could lead to a
number of hard-to-find bugs.

Doing an explicit run-time check would probably be better, which would
warn about the overflow but still allow it to happen. Again, untested:

#define sprintf(dst, fmt...)	 ({					\
	const size_t __dst_len = __builtin_dynamic_object_size(dst, 1);	\
	/* __written doesn't include \0 */				\
	const size_t __written = __sprintf(dst, frm);			\
	/* If the destination buffer size knowable, check it */		\
	if (__dst_len != SIZE_MAX &&					\
	    (!__dst_len || __dst_len - 1 < __written)			\
		WARN_ONCE("sprintf buffer overflow: %d written to buffer size %zu!\n",\
			  __written + 1, __dst_len);			\
	__written;							\
})

tl;dr: I think it's worth switching to snprintf (or scnprintf) where
possible to make an explicit choice about what the destination buffer
is expected to contain in the case of an overflow. Using sprintf leaves
it potentially ambiguous.

-Kees

-- 
Kees Cook
