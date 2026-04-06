Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFBB238C36;
	Mon,  6 Apr 2026 05:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775451904; cv=none; b=cnNZrTd/8eCnH0BLzibA0OeA/2r1LXvIPS1oM6LepEAO3v6cAQVsV3m4vgNWn6OQtKwmKvk9dfhB9KoxR7IGNO2SrZh+Vc9yXco1b++xpwY7O+VWrampMnwsHoT33niPaBa+pggDQKQcFZNEjVyTvGjrvc1j0OjNkf6vXu3ARHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775451904; c=relaxed/simple;
	bh=cOdL58n5I56C5QNJCB03sCRH37/B8STximkRYX7LoWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9GqvrTP2X6h4DghQ3NxDoahMVj6XyTUwVr4Izn6DKvKtpLHftkk3037LpFP9XHJvdiSKFnefQ0SCgovKUxCsqo4upg69wd0j2HkyjUzlZtNp5MkKARURNI3uxSAUL1ns9fzg6gyg3ZDrFTv28RtfeAvPsjTuLec/zhMg9xTqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI/RcrRx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI/RcrRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50F3C4CEF7;
	Mon,  6 Apr 2026 05:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775451904;
	bh=cOdL58n5I56C5QNJCB03sCRH37/B8STximkRYX7LoWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sI/RcrRxzvuxT3uciNFNvZwNEUp4lqfafirR7glxyJkyot4SWooPQljtHMG/RcVqR
	 JWbm6bcfoayzUlZxjqqz4Hf3m6WTYgqIh4r5MudhiJnJvCDskheNd1n6qGiz+q++fT
	 EELebUiJldeK0lV5QM7yLDTDFjKPS9v1gURlsiXDB3sRrsUYTGwhDITmntCeBmrJzC
	 kWkkBBF6AyVW8sO1Jyx8bUPaccBJMCcybMuzGrY0tDxDJdJVr8ghNo+llyOfXSPNno
	 EjCTPHXvHTFd7MTtSI4vG37cZb8Oxt/2SBanCRBwtu0ycz0OU64lzQiQagtfCA2fIR
	 ufWwAC+jlDeFw==
Date: Sun, 5 Apr 2026 22:05:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, tmricht@linux.ibm.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com,
	japo@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
	sumanthk@linux.ibm.com
Subject: Re: [PATCH v4 1/2] perf env: Add perf_env__e_machine helper and use
 in perf_env__arch
Message-ID: <adM-_viYsw5KEoeV@google.com>
References: <20260326174521.1829203-1-irogers@google.com>
 <20260327045025.2276517-1-irogers@google.com>
 <20260327045025.2276517-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260327045025.2276517-2-irogers@google.com>

On Thu, Mar 26, 2026 at 09:50:24PM -0700, Ian Rogers wrote:
> Add a helper that lazily computes the e_machine and falls back of
> EM_HOST. Use the perf_env's arch to compute the e_machine if
> available. Use a binary search for some efficiency in this, but handle
> somewhat complex duplicate rules. Switch perf_env__arch to be derived
> the e_machine for consistency. This switches arch from being uname
> derived to matching that of the perf binary (via EM_HOST). Update
> session to use the helper, which may mean using EM_HOST when no
> threads are available. This also updates the perf data file header
> that gets the e_machine/e_flags from the session.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/env.c     | 185 ++++++++++++++++++++++++++++++--------
>  tools/perf/util/env.h     |   1 +
>  tools/perf/util/session.c |  14 +--
>  3 files changed, 157 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 93d475a80f14..ae08178870d7 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -1,10 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "cpumap.h"
> +#include "dwarf-regs.h"
>  #include "debug.h"
>  #include "env.h"
>  #include "util/header.h"
>  #include "util/rwsem.h"
>  #include <linux/compiler.h>
> +#include <linux/kernel.h>
>  #include <linux/ctype.h>
>  #include <linux/rbtree.h>
>  #include <linux/string.h>
> @@ -588,51 +590,160 @@ void cpu_cache_level__free(struct cpu_cache_level *cache)
>  	zfree(&cache->size);
>  }
>  
> +struct arch_to_e_machine {
> +	const char *prefix;
> +	uint16_t e_machine;
> +};
> +
>  /*
> - * Return architecture name in a normalized form.
> - * The conversion logic comes from the Makefile.
> + * A mapping from an arch prefix string to an ELF machine that can be used in a
> + * bsearch. Some arch prefixes are shared an need additional processing as
> + * marked next to the architecture. The prefixes handle both perf's architecture
> + * naming and those from uname.
>   */
> -static const char *normalize_arch(char *arch)
> -{
> -	if (!strcmp(arch, "x86_64"))
> -		return "x86";
> -	if (arch[0] == 'i' && arch[2] == '8' && arch[3] == '6')
> -		return "x86";
> -	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
> -		return "sparc";
> -	if (!strncmp(arch, "aarch64", 7) || !strncmp(arch, "arm64", 5))
> -		return "arm64";
> -	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
> -		return "arm";
> -	if (!strncmp(arch, "s390", 4))
> -		return "s390";
> -	if (!strncmp(arch, "parisc", 6))
> -		return "parisc";
> -	if (!strncmp(arch, "powerpc", 7) || !strncmp(arch, "ppc", 3))
> -		return "powerpc";
> -	if (!strncmp(arch, "mips", 4))
> -		return "mips";
> -	if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
> -		return "sh";
> -	if (!strncmp(arch, "loongarch", 9))
> -		return "loongarch";
> -
> -	return arch;
> +static const struct arch_to_e_machine prefix_to_e_machine[] = {
> +	{"aarch64", EM_AARCH64},
> +	{"alpha", EM_ALPHA},
> +	{"arc", EM_ARC},
> +	{"arm", EM_ARM}, /* Check also for EM_AARCH64. */
> +	{"avr", EM_AVR},  /* Check also for EM_AVR32. */
> +	{"bfin", EM_BLACKFIN},
> +	{"blackfin", EM_BLACKFIN},
> +	{"cris", EM_CRIS},
> +	{"csky", EM_CSKY},
> +	{"hppa", EM_PARISC},
> +	{"i386", EM_386},
> +	{"i486", EM_386},
> +	{"i586", EM_386},
> +	{"i686", EM_386},
> +	{"loongarch", EM_LOONGARCH},
> +	{"m32r", EM_M32R},
> +	{"m68k", EM_68K},
> +	{"microblaze", EM_MICROBLAZE},
> +	{"mips", EM_MIPS},
> +	{"msp430", EM_MSP430},
> +	{"parisc", EM_PARISC},
> +	{"powerpc", EM_PPC}, /* Check also for EM_PPC64. */
> +	{"ppc", EM_PPC}, /* Check also for EM_PPC64. */
> +	{"riscv", EM_RISCV},
> +	{"s390", EM_S390},
> +	{"sa110", EM_ARM},
> +	{"sh", EM_SH},
> +	{"sparc", EM_SPARC}, /* Check also for EM_SPARCV9. */
> +	{"sun4u", EM_SPARC},
> +	{"x86", EM_X86_64}, /* Check also for EM_386. */
> +	{"xtensa", EM_XTENSA},
> +};
> +
> +static int compare_prefix(const void *key, const void *element)
> +{
> +	const char *search_key = key;
> +	const struct arch_to_e_machine *map_element = element;
> +	size_t prefix_len = strlen(map_element->prefix);
> +
> +	return strncmp(search_key, map_element->prefix, prefix_len);
> +}
> +
> +static uint16_t perf_arch_to_e_machine(const char *perf_arch, bool is_64_bit)
> +{
> +	/* Binary search for a matching prefix. */
> +	const struct arch_to_e_machine *result;
> +
> +	if (!perf_arch)
> +		return EM_HOST;
> +
> +	result = bsearch(perf_arch,
> +			 prefix_to_e_machine, ARRAY_SIZE(prefix_to_e_machine),
> +			 sizeof(prefix_to_e_machine[0]),
> +			 compare_prefix);
> +
> +	if (!result) {
> +		pr_debug("Unknown perf arch for ELF machine mapping: %s\n", perf_arch);
> +		return EM_NONE;
> +	}
> +
> +	/* Handle conflicting prefixes. */
> +	switch (result->e_machine) {
> +	case EM_ARM:
> +		return !strcmp(perf_arch, "arm64") ? EM_AARCH64 : EM_ARM;
> +	case EM_AVR:
> +		return !strcmp(perf_arch, "avr32") ? EM_AVR32 : EM_AVR;
> +	case EM_PPC:
> +		return is_64_bit || strstarts(perf_arch, "ppc64") ? EM_PPC64 : EM_PPC;

I'm curious what's the name `uname -m` returns for PPC64.  Is
"powerpc64" possible?


> +	case EM_SPARC:
> +		return is_64_bit || !strcmp(perf_arch, "sparc64") ? EM_SPARCV9 : EM_SPARC;
> +	case EM_X86_64:
> +		return is_64_bit || !strcmp(perf_arch, "x86_64") ? EM_X86_64 : EM_386;
> +	default:
> +		return result->e_machine;
> +	}
> +}
> +
> +static const char *e_machine_to_perf_arch(uint16_t e_machine)
> +{
> +	/*
> +	 * Table for if either the perf arch string differs from uname or there
> +	 * are >1 ELF machine with the prefix.
> +	 */
> +	static const struct arch_to_e_machine extras[] = {
> +		{"arm64", EM_AARCH64},
> +		{"avr32", EM_AVR32},
> +		{"powerpc", EM_PPC},
> +		{"powerpc", EM_PPC64},

Here it returns powerpc for both.


> +		{"sparc", EM_SPARCV9},
> +		{"x86", EM_386},
> +		{"x86", EM_X86_64},
> +		{"none", EM_NONE},
> +	};
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(extras); i++) {
> +		if (extras[i].e_machine == e_machine)
> +			return extras[i].prefix;
> +	}
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(prefix_to_e_machine); i++) {
> +		if (prefix_to_e_machine[i].e_machine == e_machine)
> +			return prefix_to_e_machine[i].prefix;
> +
> +	}
> +	return "unknown";
> +}
> +
> +uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags)
> +{
> +	if (!env) {
> +		if (e_flags)
> +			*e_flags = EF_HOST;
> +
> +		return EM_HOST;
> +	}
> +	if (env->e_machine == EM_NONE) {
> +		env->e_machine = perf_arch_to_e_machine(env->arch, env->kernel_is_64_bit);
> +
> +		if (env->e_machine == EM_HOST)
> +			env->e_flags = EF_HOST;
> +	}
> +	if (e_flags)
> +		*e_flags = env->e_flags;
> +
> +	return env->e_machine;
>  }
>  
>  const char *perf_env__arch(struct perf_env *env)
>  {
> -	char *arch_name;
> +	if (!env)
> +		return e_machine_to_perf_arch(EM_HOST);
>  
> -	if (!env || !env->arch) { /* Assume local operation */
> -		static struct utsname uts = { .machine[0] = '\0', };
> -		if (uts.machine[0] == '\0' && uname(&uts) < 0)
> -			return NULL;
> -		arch_name = uts.machine;
> -	} else
> -		arch_name = env->arch;
> +	if (!env->arch) {
> +		/*
> +		 * Lazily compute/allocate arch. The e_machine may have been
> +		 * read from a data file and so may not be EM_HOST.
> +		 */
> +		uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
>  
> -	return normalize_arch(arch_name);
> +		env->arch = strdup(e_machine_to_perf_arch(e_machine));
> +	}
> +	return env->arch;
>  }
>  
>  #if defined(HAVE_LIBTRACEEVENT)
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index a4501cbca375..91ff252712f4 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -186,6 +186,7 @@ int perf_env__read_cpu_topology_map(struct perf_env *env);
>  
>  void cpu_cache_level__free(struct cpu_cache_level *cache);
>  
> +uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
>  const char *perf_env__arch(struct perf_env *env);
>  const char *perf_env__arch_strerrno(struct perf_env *env, int err);
>  const char *perf_env__cpuid(struct perf_env *env);
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 4b465abfa36c..dcc9bef303aa 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2996,14 +2996,16 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
>  		return EM_HOST;
>  	}
>  
> +	/* Is the env caching an e_machine? */
>  	env = perf_session__env(session);
> -	if (env && env->e_machine != EM_NONE) {
> -		if (e_flags)
> -			*e_flags = env->e_flags;
> -
> -		return env->e_machine;
> -	}
> +	if (env && env->e_machine != EM_NONE)
> +		return perf_env__e_machine(env, e_flags);
>  
> +	/*
> +	 * Compute from threads, note this is more accurate than
> +	 * perf_env__e_machine that falls back on EM_HOST and doesn't consider
> +	 * mixed 32-bit and 64-bit threads.
> +	 */
>  	machines__for_each_thread(&session->machines,
>  				  perf_session__e_machine_cb,
>  				  &args);
> -- 
> 2.53.0.1018.g2bb0e51243-goog
> 
