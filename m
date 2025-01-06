Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C93224
	for <linux-s390@vger.kernel.org>; Mon,  6 Jan 2025 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736130130; cv=none; b=T4L/yRZG2hSXN7tpt+DwBAJlPAqMEo2Co4tqgj1cqmaXdrjp4YsvUKstUidW40/0OemI3gW/WgLYh9hO17ckukHLqBBeaCFkYz+XkMW8ITzVKYwCZ0PubF49j3G/lVFF0fbYwEagw0ab0+GVCIKmDp8sxFC3bapFwVZwiQOFY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736130130; c=relaxed/simple;
	bh=/NOu2yPx0pef5/9FbjHkK7N4tGONq2ogwrYJBCXZVvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSF1qHdgwjhtVd1E9HUvo+2EAULQXe9T1T+xaRbjJEynNv8YrLhFNlltJyxSZxXglvZSF72vdx+YnRPd24AX6nzsze1OHY9jqv4zyayHjBdDbqjNbIwUZkuReUo/0ShwaWk7yStnH+y8VB0saV76mL6aT/0jJi2kyK2sT3Fe+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ctyd3z2s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ctyd3z2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736130127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDNMuGdRbtFXOEF4wgeAn1mDrtVJdeBZdGzWjrJ9xwA=;
	b=Ctyd3z2sSCcfdarxXzjsemdA4OhEUpYBKBogz4+J2ZEgYIyaRisyy/07RFyQJudRZAJ7Gx
	OM04/zPjWCPPCXtKXgAw1PULHTN08HfOIXhoV4ylJjdscVh1IRGEdODaTwsgA1udZ8pH6G
	LB/PQ9YzVqB1+h/iVTHZA3NkOyc1sps=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-WPXHLyM9NlasFo14ZUzn-g-1; Sun,
 05 Jan 2025 21:22:04 -0500
X-MC-Unique: WPXHLyM9NlasFo14ZUzn-g-1
X-Mimecast-MFC-AGG-ID: WPXHLyM9NlasFo14ZUzn-g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DB7D19560A2;
	Mon,  6 Jan 2025 02:22:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7E113000197;
	Mon,  6 Jan 2025 02:21:57 +0000 (UTC)
Date: Mon, 6 Jan 2025 10:21:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 1/5] elf: Define note name macros
Message-ID: <Z3s+QeMv8AaGbMGs@MiWiFi-R3L-srv>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 01/04/25 at 11:38pm, Akihiko Odaki wrote:
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
>   */
>  #define NT_PRSTATUS	1
>  #define NT_PRFPREG	2
> @@ -460,9 +458,91 @@ typedef struct elf64_shdr {
>  #define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint registers */
>  #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
>  
> -/* Note types with note name "GNU" */
> +/* Note used in ET_EXEC and ET_DYN. */
>  #define NT_GNU_PROPERTY_TYPE_0	5
>  
> +/* Note names */
> +#define NN_PRSTATUS	"CORE"
> +#define NN_PRFPREG	"CORE"
> +#define NN_PRPSINFO	"CORE"
> +#define NN_TASKSTRUCT	"CORE"
> +#define NN_AUXV	"CORE"
> +#define NN_SIGINFO	"CORE"
> +#define NN_FILE	"CORE"
> +#define NN_PRXFPREG	"LINUX"

No objection to make them clearer. Thanks for the effort.

Wondering where below arch specific macros are used. So you just
added all NN_xxx for the corresponding NT_xxx? Not sure if this is
needed if we don't use them at all in the current kernel.

> +#define NN_PPC_VMX	"LINUX"
> +#define NN_PPC_SPE	"LINUX"
> +#define NN_PPC_VSX	"LINUX"
> +#define NN_PPC_TAR	"LINUX"
> +#define NN_PPC_PPR	"LINUX"
> +#define NN_PPC_DSCR	"LINUX"
> +#define NN_PPC_EBB	"LINUX"
> +#define NN_PPC_PMU	"LINUX"
> +#define NN_PPC_TM_CGPR	"LINUX"
> +#define NN_PPC_TM_CFPR	"LINUX"
> +#define NN_PPC_TM_CVMX	"LINUX"
> +#define NN_PPC_TM_CVSX	"LINUX"
> +#define NN_PPC_TM_SPR	"LINUX"
> +#define NN_PPC_TM_CTAR	"LINUX"
> +#define NN_PPC_TM_CPPR	"LINUX"
> +#define NN_PPC_TM_CDSCR	"LINUX"
> +#define NN_PPC_PKEY	"LINUX"
> +#define NN_PPC_DEXCR	"LINUX"
> +#define NN_PPC_HASHKEYR	"LINUX"
> +#define NN_386_TLS	"LINUX"
> +#define NN_386_IOPERM	"LINUX"
> +#define NN_X86_XSTATE	"LINUX"
> +#define NN_X86_SHSTK	"LINUX"
> +#define NN_X86_XSAVE_LAYOUT	"LINUX"
> +#define NN_S390_HIGH_GPRS	"LINUX"
> +#define NN_S390_TIMER	"LINUX"
> +#define NN_S390_TODCMP	"LINUX"
> +#define NN_S390_TODPREG	"LINUX"
> +#define NN_S390_CTRS	"LINUX"
> +#define NN_S390_PREFIX	"LINUX"
> +#define NN_S390_LAST_BREAK	"LINUX"
> +#define NN_S390_SYSTEM_CALL	"LINUX"
> +#define NN_S390_TDB	"LINUX"
> +#define NN_S390_VXRS_LOW	"LINUX"
> +#define NN_S390_VXRS_HIGH	"LINUX"
> +#define NN_S390_GS_CB	"LINUX"
> +#define NN_S390_GS_BC	"LINUX"
> +#define NN_S390_RI_CB	"LINUX"
> +#define NN_S390_PV_CPU_DATA	"LINUX"
> +#define NN_ARM_VFP	"LINUX"
> +#define NN_ARM_TLS	"LINUX"
> +#define NN_ARM_HW_BREAK	"LINUX"
> +#define NN_ARM_HW_WATCH	"LINUX"
> +#define NN_ARM_SYSTEM_CALL	"LINUX"
> +#define NN_ARM_SVE	"LINUX"
> +#define NN_ARM_PAC_MASK	"LINUX"
> +#define NN_ARM_PACA_KEYS	"LINUX"
> +#define NN_ARM_PACG_KEYS	"LINUX"
> +#define NN_ARM_TAGGED_ADDR_CTRL	"LINUX"
> +#define NN_ARM_PAC_ENABLED_KEYS	"LINUX"
> +#define NN_ARM_SSVE	"LINUX"
> +#define NN_ARM_ZA	"LINUX"
> +#define NN_ARM_ZT	"LINUX"
> +#define NN_ARM_FPMR	"LINUX"
> +#define NN_ARM_POE	"LINUX"
> +#define NN_ARM_GCS	"LINUX"
> +#define NN_ARC_V2	"LINUX"
> +#define NN_VMCOREDD	"LINUX"
> +#define NN_MIPS_DSP	"LINUX"
> +#define NN_MIPS_FP_MODE	"LINUX"
> +#define NN_MIPS_MSA	"LINUX"
> +#define NN_RISCV_CSR	"LINUX"
> +#define NN_RISCV_VECTOR	"LINUX"
> +#define NN_RISCV_TAGGED_ADDR_CTRL	"LINUX"
> +#define NN_LOONGARCH_CPUCFG	"LINUX"
> +#define NN_LOONGARCH_CSR	"LINUX"
> +#define NN_LOONGARCH_LSX	"LINUX"
> +#define NN_LOONGARCH_LASX	"LINUX"
> +#define NN_LOONGARCH_LBT	"LINUX"
> +#define NN_LOONGARCH_HW_BREAK	"LINUX"
> +#define NN_LOONGARCH_HW_WATCH	"LINUX"
> +#define NN_GNU_PROPERTY_TYPE_0	"GNU"
> +
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {
>    Elf32_Word	n_namesz;	/* Name size */
> 
> -- 
> 2.47.1
> 

