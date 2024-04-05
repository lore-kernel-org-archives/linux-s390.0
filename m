Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81DC16E897
	for <linux-s390@vger.kernel.org>; Fri,  5 Apr 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326342; cv=none; b=g3jKWKQwM7i5X8W2zybSflwskSrrX9IWK50YbqeIc4McTmztTOGCusjPM/0+b/BJa/vN2bR9bOw2G45FY1BtWgeIGJ8GS9HLbCOdHsbKdIWAb23x7+mhvZ7h/3bNopFVaZHhZyVanmL5W9hJcyT0c8fw6hhs3nB5nn24j0XIqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326342; c=relaxed/simple;
	bh=hfTXsKXQqlzKDkzFApYh2Oz6Ru67sRkqT+Ju0docQhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR9mTRGDrGc49qxzVM7SF/uxRMqjhGdcFHa8l0kkfitQ8UtMIM5D03xQGiOx5WNtwLMfbr3qoDnURW1FdvoFg6OKgOFIr4fQZWrIhu6CJ+GPHSbiFUX9zBG4FeQgzXWNHK0v9WAVjCDsjnkb9NbSFRCbr6b8p6AmaLE6yTeUguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J6I3F9Tm; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J6I3F9Tm"
Date: Fri, 5 Apr 2024 16:12:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712326336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQoJLZJ33UvQFVjEky3Db6r8F1/Ban2xfzk7iT3Ccso=;
	b=J6I3F9TmBsm0gp5AQe3Z69FaPMRuU9W7CtOWUYnWVuqH02b0zi86Mk+VycuRhnJIJH58f9
	RH/BfSyKg/1/j25LJVVmbhryi2XwYZ1PIyzfuZsLtdigNttTZF7N7x21fSGcMx/tonFpoS
	vRM5R0J9n55AxAerAjKiqE8Q5SUay3I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Eric Auger <eric.auger@redhat.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Nico =?utf-8?B?QsO2aHI=?= <nrb@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Nikos Nikoleris <nikos.nikoleris@arm.com>, 
	Nadav Amit <namit@vmware.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Ricardo Koller <ricarkol@google.com>, rminmin <renmm6@chinaunicom.cn>, Gavin Shan <gshan@redhat.com>, 
	Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests RFC PATCH 01/17] Add initial shellcheck checking
Message-ID: <20240405-4880f3f2b12bcae5f3383043@orel>
References: <20240405090052.375599-1-npiggin@gmail.com>
 <20240405090052.375599-2-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405090052.375599-2-npiggin@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 05, 2024 at 07:00:33PM +1000, Nicholas Piggin wrote:
> This adds a basic shellcheck sytle file, some directives to help
> find scripts, and a make shellcheck target.
> 
> When changes settle down this could be made part of the standard
> build / CI flow.
> 
> Suggested-by: Andrew Jones <andrew.jones@linux.dev>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  .shellcheckrc       | 32 ++++++++++++++++++++++++++++++++
>  Makefile            |  4 ++++
>  README.md           |  2 ++
>  scripts/common.bash |  5 ++++-
>  4 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 .shellcheckrc
> 
> diff --git a/.shellcheckrc b/.shellcheckrc
> new file mode 100644
> index 000000000..2a9a57c42
> --- /dev/null
> +++ b/.shellcheckrc
> @@ -0,0 +1,32 @@
> +# shellcheck configuration file
> +external-sources=true
> +
> +# Optional extras --  https://www.shellcheck.net/wiki/Optional
> +# Possibilities, e.g., -
> +# quote‐safe‐variables
> +# require-double-brackets
> +# require-variable-braces
> +# add-default-case
> +
> +# Disable SC2004 style? I.e.,
> +# In run_tests.sh line 67:
> +#            if (( $unittest_run_queues <= 0 )); then
> +#                  ^------------------^ SC2004 (style): $/${} is unnecessary on arithmetic variables.
> +disable=SC2004

I vote keep disabled. The problem pointed out in the wiki can be handled
with ($a), similar to how one handles variables to C preprocessor macros.

> +
> +# Disable SC2034 - config.mak contains a lot of these unused variable errors.
> +# Maybe we could have a script extract the ones used by shell script and put
> +# them in a generated file, to re-enable the warning.
> +#
> +# In config.mak line 1:
> +# SRCDIR=/home/npiggin/src/kvm-unit-tests
> +# ^----^ SC2034 (warning): SRCDIR appears unused. Verify use (or export if used externally).
> +disable=SC2034

Maybe we should export everything in config.mak.

> +
> +# Disable SC2086 for now, double quote to prevent globbing and word
> +# splitting. There are lots of places that use it for word splitting
> +# (e.g., invoking commands with arguments) that break. Should have a
> +# more consistent approach for this (perhaps use arrays for such cases)
> +# but for now disable.
> +# SC2086 (info): Double quote to prevent globbing and word splitting.
> +disable=SC2086

Agreed. We can cross this bridge later.

> diff --git a/Makefile b/Makefile
> index 4e0f54543..4863cfdc6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -141,6 +141,10 @@ cscope:
>  		-name '*.[chsS]' -exec realpath --relative-base=$(CURDIR) {} \; | sort -u > ./cscope.files
>  	cscope -bk
>  
> +.PHONY: shellcheck
> +shellcheck:
> +	shellcheck -a run_tests.sh */run */efi/run scripts/mkstandalone.sh
> +
>  .PHONY: tags
>  tags:
>  	ctags -R
> diff --git a/README.md b/README.md
> index 6e82dc225..77718675e 100644
> --- a/README.md
> +++ b/README.md
> @@ -193,3 +193,5 @@ with `git config diff.orderFile scripts/git.difforder` enables it.
>  
>  We strive to follow the Linux kernels coding style so it's recommended
>  to run the kernel's ./scripts/checkpatch.pl on new patches.
> +
> +Also run make shellcheck before submitting a patch.

which touches Bash scripts.


> diff --git a/scripts/common.bash b/scripts/common.bash
> index ee1dd8659..3aa557c8c 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -82,8 +82,11 @@ function arch_cmd()
>  }
>  
>  # The current file has to be the only file sourcing the arch helper
> -# file
> +# file. Shellcheck can't follow this so help it out. There doesn't appear to be a
> +# way to specify multiple alternatives, so we will have to rethink this if things
> +# get more complicated.
>  ARCH_FUNC=scripts/${ARCH}/func.bash
>  if [ -f "${ARCH_FUNC}" ]; then
> +# shellcheck source=scripts/s390x/func.bash
>  	source "${ARCH_FUNC}"
>  fi
> -- 
> 2.43.0
>

Other than the extension to the sentence in the README,

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

Thanks,
drew
