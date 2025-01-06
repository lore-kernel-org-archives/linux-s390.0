Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672AC1DACA1;
	Mon,  6 Jan 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174365; cv=none; b=fSV/WWn4OlkCmHf37Z2oxH8t7Hlx/VbhZqqmbFb4RUn+6aiBhSCof91DgcpzFeWsm8QllbYXc6yNxbNWTcXHnWKokTAzwNYZS2S/pcdW1JMbSgpE5oHfvjmmNS6dUTZuXAmzf13QYMA7EfMwgBAMKlSiase61TG4isfzghL5nZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174365; c=relaxed/simple;
	bh=mI3EaaMN7i/ngoypLmxJ9MR7FpcdG/3geav6ciHIQSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF9/R2FR1t/Q0BgehqKtINL5Q4shv6QTQhZ6dLEuVg0LCPa1uDBXBNHld8/y950ZnxELo8yCWkC+9v/pQnOns82AjcpAx+eoGOt/BdbDWgfsZSrd9YHIaDd2hP5+9I23Cx5WpYUl5mtlT9/lunpJ7yYhgUqvqvpTrMlAyl5wtA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85C64143D;
	Mon,  6 Jan 2025 06:39:49 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 052903F59E;
	Mon,  6 Jan 2025 06:39:18 -0800 (PST)
Date: Mon, 6 Jan 2025 14:39:13 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 1/5] elf: Define note name macros
Message-ID: <Z3vrEYQVlff1+ZBW@e133380.arm.com>
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
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/uapi/linux/elf.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b44069d29cec..014b705b97d7 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -372,8 +372,6 @@ typedef struct elf64_shdr {
>   * Notes used in ET_CORE. Architectures export some of the arch register sets
>   * using the corresponding note types via the PTRACE_GETREGSET and
>   * PTRACE_SETREGSET requests.
> - * The note name for these types is "LINUX", except NT_PRFPREG that is named
> - * "CORE".

Maybe most people would find it obvious, but is it worth saying what
the NT_ and NN_ macros are for?  They can easily be explained in terms
of the elfXX_note struct fields.

>   */
>  #define NT_PRSTATUS	1
>  #define NT_PRFPREG	2
> @@ -460,9 +458,91 @@ typedef struct elf64_shdr {
>  #define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint registers */
>  #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
>  
> -/* Note types with note name "GNU" */
> +/* Note used in ET_EXEC and ET_DYN. */

May just "other notes"?  I think that the comment might bitrot
over time.

>  #define NT_GNU_PROPERTY_TYPE_0	5
>  
> +/* Note names */
> +#define NN_PRSTATUS	"CORE"

Can these be interleaved with the NT_ definitions?  I think this would
make the resulting header (and the diff) easier to read.

> +#define NN_PRFPREG	"CORE"

[...]

> +#define NN_GNU_PROPERTY_TYPE_0	"GNU"

[...]

Cheers
---Dave
