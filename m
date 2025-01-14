Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDAB20F96C;
	Tue, 14 Jan 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857424; cv=none; b=gR0b0YvPur/HDrzDj1/MINauQuOQD/YJHqQIKtDQWZRlQ1wzlMtSm2JkymhTNubLskpmfaeChqjCinpn9bAvp6w2bzwuzJd3DNj3ToXGr35KqxnIdmRduzFPkTHUNgskUbfLePpteuV1rLknyKQk80PvrCfqtFdefag+xNOr4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857424; c=relaxed/simple;
	bh=WIzwJFV86ipwzbQUVBxBqXjyckcC8dyzV5PqWjDl2a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdyjS/R8bxT67S5S+e8oF3AEB/BrVeW7vQRzXh+T1c23Q5u1auPDAju5RNomV+5yrsEmUTD9Wma+xKKs2gWi92GnG/y0jIIN1zp28DKFhc7VUKqPOijaHKvEnYpMP06uEDSZJxW7OP8B7K6aqUnyDT16onvNt9jM31lMzCBdjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B66F412FC;
	Tue, 14 Jan 2025 04:24:09 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 257BF3F66E;
	Tue, 14 Jan 2025 04:23:39 -0800 (PST)
Date: Tue, 14 Jan 2025 12:23:36 +0000
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
Subject: Re: [PATCH v4 6/6] crash: Remove KEXEC_CORE_NOTE_NAME
Message-ID: <Z4ZXSGk2XpE4H6lQ@e133380.arm.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
 <20250111-elf-v4-6-b3841fa0dcd9@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-elf-v4-6-b3841fa0dcd9@daynix.com>

Hi,

On Sat, Jan 11, 2025 at 02:48:49PM +0900, Akihiko Odaki wrote:
> KEXEC_CORE_NOTE_NAME is no longer used.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  include/linux/kexec.h       | 2 --
>  include/linux/vmcore_info.h | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..c840431eadda 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -68,8 +68,6 @@ extern note_buf_t __percpu *crash_notes;
>  #define KEXEC_CRASH_MEM_ALIGN PAGE_SIZE
>  #endif
>  
> -#define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
> -
>  /*
>   * This structure is used to hold the arguments that are used when loading
>   * kernel binaries.
> diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
> index 1672801fd98c..37e003ae5262 100644
> --- a/include/linux/vmcore_info.h
> +++ b/include/linux/vmcore_info.h
> @@ -6,7 +6,6 @@
>  #include <linux/elfcore.h>
>  #include <linux/elf.h>
>  
> -#define CRASH_CORE_NOTE_NAME	   "CORE"
>  #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
>  #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
>  #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)
> 
> -- 
> 2.47.1
> 
> 
