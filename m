Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E89D1487F4;
	Mon,  6 Jan 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177018; cv=none; b=APKafJGiHC7OmRUME0O7ncMSXx8QzsGIEwt0L+A8bgymBufeP3CdOUjby+iJJnbvX2i+VopB3MJ/9r9rxrdI3KrjnH6ukKiHcueHdwHfHpQhj50CHarFGv9s/h6jCxO626ml2oDQoguLiBdjLz1lAKJAOBVT0bSUMZpIiQTz7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177018; c=relaxed/simple;
	bh=Y0KU9ovyogcNCc8R9KVU8jv9gT6DMqvtPoi1t1DUCUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYgPCb5euEHdapy9ngJg7gpKcpfebmgt9ZcNKU8uvuYcdrtdfHuzBmyag/zv7dI108Y1uE102P3jCZa8O+GDIPtabhn68v6J//+4Bt8BfOQGqRSDZWqUjAvmB2lMdFS6QqxZAf4JaBZ3vE8ORUCob7GkZGpdD5x2lE8c0RPnRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99914143D;
	Mon,  6 Jan 2025 07:24:03 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16DE23F59E;
	Mon,  6 Jan 2025 07:23:32 -0800 (PST)
Date: Mon, 6 Jan 2025 15:23:30 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 0/5] elf: Define note name macros
Message-ID: <Z3v1clew2t+XH5F5@e133380.arm.com>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>

Hi,

On Sat, Jan 04, 2025 at 11:38:33PM +0900, Akihiko Odaki wrote:
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
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Should this be Cc'd at least to the GNU binutils or gdb folks?
Also the glibc and elfutils projects, both of which maintain a version
of elf.h.  They may have their own view on the best way to approach
this issue.

If cross-posting to other project mailing lists, it might make sense to
add a bit more background explaining the motivation for the change.

[...]

Cheers
---Dave
