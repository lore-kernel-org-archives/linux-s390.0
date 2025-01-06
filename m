Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374E38F9C;
	Mon,  6 Jan 2025 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182089; cv=none; b=hXYzP/phxyDsvNbuzGq5AxtAUv9by2YbaFbvupgMQqEJe4UWaNyvDUxXjlVmsAebjuVuiqh95EV/1qOfp2CssSDEDs3J6UG4IOpPIEYJI03Fvi2iSWE+CwUC8/LdViX9752LU8DHm3EEOqTvq6fof9v14ho8OC/FHHekK0LHQnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182089; c=relaxed/simple;
	bh=HEO2MLf1VHgRzbREgQgzMwKlNqe5Agqt4kRQTnCkfOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e15wd0WchDr2rJvy9i8QlXcnIdbyhHlp5uumAIdLUbZgkVyq1LvrWoTuO498zb5A4KB7ffip01HVt/U4kD50GudpwrBg1r1Fex27xOvGKPiXqrG/czRZwxslWCTz1ae+nu/TwRWS2SWuA7Q9unA7Y9R+55Zqq0I/x+oMljGaDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsijK6UW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsijK6UW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDD3C4CED2;
	Mon,  6 Jan 2025 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182089;
	bh=HEO2MLf1VHgRzbREgQgzMwKlNqe5Agqt4kRQTnCkfOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsijK6UWM2KPMQJBfvl+vFx8bFrxXhTGRtzqTu1U2GAZFVUO1R/FJBcV18ZANjRcC
	 79g4z7UqwfAkLa7S41BW2+teSCP+ZIYOvvDEzSZxcH+vLnCV/J2IoXM4jk3IvKDLBf
	 zu++zuSzxQgAhJ0KmjLlPp2Vi/5h2VIe3LtNVEImtJ8t3KXkVu4FqE/Z27xA7sS2et
	 CYtIgvEMF2tm20TeugiUA6L8m3n4Lsfuo/Hdenv4NP7hoLTCSys9LUdUKAACMYF4iP
	 CfYhKGTpqBSWtli/1njZ/oNSHQS6ghcSospxSMXFD/xqHxEc/H/I31p0f17xEtsQsT
	 SCLecFPd/gdgA==
Date: Mon, 6 Jan 2025 08:48:05 -0800
From: Kees Cook <kees@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, kexec@lists.infradead.org,
	devel@daynix.com
Subject: Re: [PATCH v2 1/5] elf: Define note name macros
Message-ID: <202501060830.B735C3A@keescook>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
 <20250104-elf-v2-1-77dc2e06db4e@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-elf-v2-1-77dc2e06db4e@daynix.com>

On Sat, Jan 04, 2025 at 11:38:34PM +0900, Akihiko Odaki wrote:
> elf.h had a comment saying:
> > Notes used in ET_CORE. Architectures export some of the arch register
> > sets using the corresponding note types via the PTRACE_GETREGSET and
> > PTRACE_SETREGSET requests.
> > The note name for these types is "LINUX", except NT_PRFPREG that is
> > named "CORE".
> 
> However, NT_PRSTATUS is also named "CORE". It is also unclear what
> "these types" refers to.
> 
> To fix these problems, define a name for each note type. The added
> definitions are macros so the kernel and userspace can directly refer to
> them.

While ELF is specified in the Tool Interface Standard[1], the core dump
format doesn't have an official specification. It does follow a lot of
agreed rules, though, and the "note name" is intended to help coredump
consumers distinguish between "common" things ("CORE") and Linux-specific
things ("LINUX").

I think this should be explicitly spelled out in the UAPI header,
even if we have "mistakes" for this mapping.

I'm not convinced we need these macros, though: everything is "LINUX"
expect the common types. And the GNU types are "GNU". There are only 7
types under the "CORE" name. :)

For the macros, I'd much prefer NN_CORE, NN_LINUX, and NN_GNU.

If you really want to be able to examine the name from the type, then
yeah, I guess we need something like the macros you have, but I'd much
prefer also adding a macro like Dave suggested[2], and then replace the
fill_note() with a macro that can unwrap it:

	fill_note(note, NT_SIGINFO, size..., data...);

The repetition of NN_type, NT_type doesn't feel robust if we have a
programmatic mapping: only the "type" is needed to determine both, so
why supply both?

-Kees

[1] https://refspecs.linuxfoundation.org/elf/elf.pdf
[2] https://lore.kernel.org/lkml/Z3vuBTiQvnRvv9DQ@e133380.arm.com/

-- 
Kees Cook
