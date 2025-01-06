Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F90A8634A;
	Mon,  6 Jan 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175116; cv=none; b=Lksubtp7erVHnRwofryd1zvzQwGYBFU2MJDjsoglTD4bUKDUkNOwWbG8A8WRHPxrmsma1/sobZhiA/PiVF+QdH68f+nXSv8mi9xkbxCcSlrXH5gXpjYmV81nNi+PoqZDAC2sU4jCpKr4M1nKBjH2AJQ/BSIibRhVRBc6bI0sY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175116; c=relaxed/simple;
	bh=EtkFYRgPP8I+qjKq9oIL3DMsS4fT+1X/SN+WP1wZ3Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciKQLCqrpnWTOj9AoBrZbVQ9K52pdTFSZG3x4ixlt5ydSM+H8I4z2S8bGtl7uZ0pcnBj9ooSCb0QCXXhXXoNkNrNhtO215r51+wo2HFY1zwgR0KPVgohRz/s/7c+UkEAgCPDMXFPMw6QdrASBxKwhRRxtAoeB3uIUEiGDnBX6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58B98143D;
	Mon,  6 Jan 2025 06:52:22 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24D7D3F59E;
	Mon,  6 Jan 2025 06:51:52 -0800 (PST)
Date: Mon, 6 Jan 2025 14:51:49 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 5/5] crash: Remove KEXEC_CORE_NOTE_NAME
Message-ID: <Z3vuBTiQvnRvv9DQ@e133380.arm.com>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
 <20250104-elf-v2-5-77dc2e06db4e@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-elf-v2-5-77dc2e06db4e@daynix.com>

Hi,

On Sat, Jan 04, 2025 at 11:38:38PM +0900, Akihiko Odaki wrote:
> Now KEXEC_CORE_NOTE_NAME is only used at one place and it does not seem
> to provide any value anymore. Replace the remaining usage with the
> literal and remove the macro.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/s390/kernel/crash_dump.c | 2 +-
>  include/linux/kexec.h         | 2 --
>  include/linux/vmcore_info.h   | 1 -
>  3 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index cd0c93a8fb8b..4a9817489e35 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -253,7 +253,7 @@ static const char *nt_name(Elf64_Word type)
>  	const char *name = "LINUX";
>  
>  	if (type == NT_PRPSINFO || type == NT_PRSTATUS || type == NT_PRFPREG)
> -		name = KEXEC_CORE_NOTE_NAME;
> +		name = "CORE";

If I've understood the code here correctly, the note type is supplied
at all the nt_init() and nt_size() call sites, so instead of this hack
can we wrap those in macros that get the formal name from elf.h rather
than guessing it here?  e.g.:

#define nt_size(..., note, ...) \
	__nt_size(..., NT ## _ ## note, NN ## _ ## note, ...)

etc.

The compiler is quite likely to fold away most of the implied
duplication of code (it would be interesting to look at the compiler
output) -- but anyway, this is super-slow-path: nobody expects realtime
response when the kernel has crashed.

[...]

Cheers
---Dave
