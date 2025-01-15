Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F5A24A7DF;
	Wed, 15 Jan 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961107; cv=none; b=Gl/1LUTCdKmoC6zsdp/LhsShUwtmKxpwap56VVBRQJeegOIA2oleXoNIaBp/VCyaUaHzISrqmNtK14inQzluWcIz4mGdNgnKTIg3/l0Y2+060XUSPPuItekDof4r5tcRWywC0MM5yyizgNryFb/7YfoKhh8x9jyfEW1I9QIB30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961107; c=relaxed/simple;
	bh=0ennvpSNX2tdQJHbECQN0ibelim/6vZHVJrJvgfnWAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGvfZxdgzTRPh1sgiyLm1pJiJxgdL19OB2OwnIr5CRlUXNEgvSLwHgE4OZK5PjVmbO2GeOm0k0VEozjf6dKguwIQzf+32FQmDN5I1F6CcM2LLOg68rNw1aCcNil7XI3RZ+DXjUpLAFq2CoTEVJYqYWciFyg3apjWwNIQNcBeobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E6611FB;
	Wed, 15 Jan 2025 09:12:12 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A0F63F673;
	Wed, 15 Jan 2025 09:11:42 -0800 (PST)
Date: Wed, 15 Jan 2025 17:11:34 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, binutils@sourceware.org,
	devel@daynix.com
Subject: Re: [PATCH v5 1/6] elf: Define note name macros
Message-ID: <Z4fsRq4D4X5Qb+Dq@e133380.arm.com>
References: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
 <20250115-elf-v5-1-0f9e55bbb2fc@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115-elf-v5-1-0f9e55bbb2fc@daynix.com>

Hi,

On Wed, Jan 15, 2025 at 02:47:58PM +0900, Akihiko Odaki wrote:
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
> them to remove their duplicate definitions of note names.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  include/uapi/linux/elf.h | 89 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b44069d29cec..592507aa9b3a 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -368,101 +368,180 @@ typedef struct elf64_shdr {
>  #define ELF_OSABI ELFOSABI_NONE
>  #endif
>  
> +/* Note definitions: NN_ defines names. NT_ defines types. */
> +
> +#define NN_GNU_PROPERTY_TYPE_0	"GNU"
> +#define NT_GNU_PROPERTY_TYPE_0	5
> +

I guess this also works as a neutral way of saying that
NT_GNU_PROPERTY_TYPE_0 isn't _specifically_ for coredumps.

I would worry that moving this block is going to generate unwanted
context noise with other patches that may be in flight and add new
NT_ definitions.

But (a) changing the comments will cause that anyway, and
(b) if there are any new NT_ definitions in flight, we want people to
notice the conflict and add the accompanying NN_ definition.

So, perhaps context noise is not such a bad thing in this instance.

[...]

> +#define NN_LOONGARCH_HW_WATCH	"LINUX"
>  #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
>  
> -/* Note types with note name "GNU" */
> -#define NT_GNU_PROPERTY_TYPE_0	5
> -
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {
>    Elf32_Word	n_namesz;	/* Name size */

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave
