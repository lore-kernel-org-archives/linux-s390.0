Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD9920F991;
	Tue, 14 Jan 2025 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857365; cv=none; b=O/AUUQobfVGghcTXZqbOQ3kek/NOUMdVGEV3go9nu7h80xLrPJIbPCouurrDz1dwscuupBQBhA/aj8KlfthgmFJvjH2+RCmA5AzcWuO5+/14AE3NTxJOj9lSURTw96BPv5MdBFo9aSJo/5DJV+FiyAftbAUg5BzJ4sgg9/AKIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857365; c=relaxed/simple;
	bh=DSb7pxyV4wY39AQF/h0xE/2R40v22W5UV+uZCIyst/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn0/NXb3amK7mAKdkur8wjo+RHOiI3dhgJ+VmSTNNtn//kA3nCOFJ3LhK0RDpGU6acR+4eH3ct2xkYMWOAcL5XLKsGiiXzVGAkAE3NUVD6hcWw5E+HlUvLHn0w0reY47VNcfRqymcGxtT3sgTOkXi4m4JtMvYeDyHOsw8LH+xFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E61311FB;
	Tue, 14 Jan 2025 04:23:09 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E5BF3F66E;
	Tue, 14 Jan 2025 04:22:38 -0800 (PST)
Date: Tue, 14 Jan 2025 12:22:31 +0000
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
Subject: Re: [PATCH v4 1/6] elf: Define note name macros
Message-ID: <Z4ZXB2UJaZWOmshN@e133380.arm.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
 <20250111-elf-v4-1-b3841fa0dcd9@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-elf-v4-1-b3841fa0dcd9@daynix.com>

Hi,

On Sat, Jan 11, 2025 at 02:48:44PM +0900, Akihiko Odaki wrote:
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

I guess another motivation is to move towards having elf.h as the
single point of definition for the note names, so that obscure and
duplicate logic for determining note names can be removed.

(Could be worth adding a note on this is the patch is respun, but this
would be overkill otherwise...)


> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  include/uapi/linux/elf.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b44069d29cec..343f5c40d03a 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -368,99 +368,179 @@ typedef struct elf64_shdr {
>  #define ELF_OSABI ELFOSABI_NONE
>  #endif
>  
> +/* Note definitions: NN_ defines names. NT_ defines types. */
> +
>  /*
>   * Notes used in ET_CORE. Architectures export some of the arch register sets
>   * using the corresponding note types via the PTRACE_GETREGSET and
>   * PTRACE_SETREGSET requests.
> - * The note name for these types is "LINUX", except NT_PRFPREG that is named
> - * "CORE".
>   */
> +#define NN_PRSTATUS	"CORE"
>  #define NT_PRSTATUS	1
> +#define NN_PRFPREG	"CORE"
>  #define NT_PRFPREG	2
> +#define NN_PRPSINFO	"CORE"
>  #define NT_PRPSINFO	3
> +#define NN_TASKSTRUCT	"CORE"
>  #define NT_TASKSTRUCT	4
> +#define NN_AUXV		"CORE"
>  #define NT_AUXV		6
>  /*
>   * Note to userspace developers: size of NT_SIGINFO note may increase
>   * in the future to accomodate more fields, don't assume it is fixed!
>   */
> +#define NN_SIGINFO      "CORE"
>  #define NT_SIGINFO      0x53494749
> +#define NN_FILE         "CORE"
>  #define NT_FILE         0x46494c45
> +#define NN_PRXFPREG     "LINUX"
>  #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */

[...]

> +#define NN_LOONGARCH_HW_WATCH	"LINUX"
>  #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
>  
> -/* Note types with note name "GNU" */
> +/* Note used in other file types. */

For this, it may make sense to be vaguer, e.g.

	/* Other notes */

(We don't dump NT_GNU_PROPERTY_TYPE_0 in coredumps, but I don't think
it would be nonsensical to do so.)

> +#define NN_GNU_PROPERTY_TYPE_0	"GNU"
>  #define NT_GNU_PROPERTY_TYPE_0	5

[...]

With or without those changes,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

