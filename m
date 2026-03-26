Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5BA2DF12F;
	Thu, 26 Mar 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509644; cv=none; b=gO0WPvydaon+I6xRD7oqemnzDorJV2hSjQ6qjI9uHi1hQCJNwXtFj3xXdFuEXfoI3Z4ko+FOdkZaQEii5pg8nsmx6+RbM5yBxFDELXHPMaf9BTmK/A3wlPhci83aWuHuR1Gx9EblrlUn0Oyt7D4IWPJIIaote8zy8cjoF+4edYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509644; c=relaxed/simple;
	bh=pSlQKT/b1HCPvWFIQb+8xqExFbpC07qWgZu3ngrk98I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCtHey1g6WPw0W3XDN3qtEe33wgSRXeel/qGtNrZFUX6HxEBKhzGiBgl44bqvMSGE6f7Qdc6LBT7dXksZ/XLqkbUUgDmqQDWTzIbzdNxX+4W+JsrRFc6SzKGJqvu+lrQSF+oNJUp54eLV12jxOh3G+tz0FFUAWWiXbp0aIbZWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=G1wa8LS5; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="G1wa8LS5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=lscYA8WasBHC0985AOl1Uc+DlR92krmpHLmMCBJENuU=;
	b=G1wa8LS5QQmSraxZLhAf150xJlw06iTDowYTgKjhJdA4fEPuGW45iZHMuYEWlZ
	+vD1f5cwA2VlUIRV8torep0CtT4o/mRHqF0xvE3Q40UVfm0V+p4QDTN6UQrVQlel
	mFnC0ROJQqIkBD16zdvUgT7YG6e4I/gLHUDUSYo80gUe0=
Received: from [172.24.149.146] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Zxwh3sRp3DTSAg--.48128S2;
	Thu, 26 Mar 2026 15:20:02 +0800 (CST)
Message-ID: <c9b522c0-09ce-47c4-a377-1a46ae84e609@126.com>
Date: Thu, 26 Mar 2026 15:20:01 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf symbol: Lazily compute idle and use the perf_env
To: Ian Rogers <irogers@google.com>, acme@kernel.org, namhyung@kernel.org,
 tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
 japo@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
 sumanthk@linux.ibm.com
References: <20260302234343.564937-1-irogers@google.com>
 <20260325161836.1029457-1-irogers@google.com>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <20260325161836.1029457-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3Zxwh3sRp3DTSAg--.48128S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfJr4rtr4DAFyrtF1rKrWfXwb_yoWDZw13pF
	WDCr47Zr48Jr45W34fJF4UuFy5uwnavw4rCr4UJ3yrAFsIkr1UKFZ7GF1Y9w4rXrn3G3Wr
	ArsFkFyfWa18JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtKsbUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/xtbBrwNL+GnE3iPPewAA37

Hi Ian,

On 3/26/26 12:18 AM, Ian Rogers wrote:
> Move the idle boolean to a helper symbol__is_idle function. In the
> function lazily compute whether a symbol is an idle function taking
> into consideration the kernel version and architecture of the
> machine. As symbols__insert no longer needs to know if a symbol is for
> the kernel, remove the argument.
> 
> This change is inspired by mailing list discussion, particularly from
> Thomas Richter <tmricht@linux.ibm.com> and Heiko Carstens
> <hca@linux.ibm.com>:
> https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ibm.com/
> 
> The change switches x86 matches to use strstarts which means
> intel_idle_irq is matched as part of strstarts(name, "intel_idle"), a
> change suggested by Honglei Wang <jameshongleiwang@126.com> in:
> https://lore.kernel.org/lkml/20260323085255.98173-1-jameshongleiwang@126.com/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v1: https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google.com/
> ---
>  tools/perf/builtin-top.c     |   6 +-
>  tools/perf/util/symbol-elf.c |   2 +-
>  tools/perf/util/symbol.c     | 105 ++++++++++++++++++++++-------------
>  tools/perf/util/symbol.h     |  15 +++--
>  4 files changed, 84 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 37950efb28ac..bdc1c761cd61 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -751,6 +751,7 @@ static void perf_event__process_sample(const struct perf_tool *tool,
>  {
>  	struct perf_top *top = container_of(tool, struct perf_top, tool);
>  	struct addr_location al;
> +	struct dso *dso = NULL;
>  
>  	if (!machine && perf_guest) {
>  		static struct intlist *seen;
> @@ -830,7 +831,10 @@ static void perf_event__process_sample(const struct perf_tool *tool,
>  		}
>  	}
>  
> -	if (al.sym == NULL || !al.sym->idle) {
> +	if (al.map)
> +		dso = map__dso(al.map);
> +
> +	if (al.sym == NULL || !symbol__is_idle(al.sym, dso, machine->env)) {
>  		struct hists *hists = evsel__hists(evsel);
>  		struct hist_entry_iter iter = {
>  			.evsel		= evsel,
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 3cd4e5a03cc5..9fabf5146d89 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1723,7 +1723,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  
>  		arch__sym_update(f, &sym);
>  
> -		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
> +		__symbols__insert(dso__symbols(curr_dso), f);
>  		nr++;
>  	}
>  	dso__put(curr_dso);
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index ce9195717f44..1a357af93a0a 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -25,6 +25,8 @@
>  #include "demangle-ocaml.h"
>  #include "demangle-rust-v0.h"
>  #include "dso.h"
> +#include "dwarf-regs.h"
> +#include "env.h"
>  #include "util.h" // lsdir()
>  #include "event.h"
>  #include "machine.h"
> @@ -50,7 +52,6 @@
>  
>  static int dso__load_kernel_sym(struct dso *dso, struct map *map);
>  static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
> -static bool symbol__is_idle(const char *name);
>  
>  int vmlinux_path__nr_entries;
>  char **vmlinux_path;
> @@ -357,8 +358,7 @@ void symbols__delete(struct rb_root_cached *symbols)
>  	}
>  }
>  
> -void __symbols__insert(struct rb_root_cached *symbols,
> -		       struct symbol *sym, bool kernel)
> +void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
>  {
>  	struct rb_node **p = &symbols->rb_root.rb_node;
>  	struct rb_node *parent = NULL;
> @@ -366,17 +366,6 @@ void __symbols__insert(struct rb_root_cached *symbols,
>  	struct symbol *s;
>  	bool leftmost = true;
>  
> -	if (kernel) {
> -		const char *name = sym->name;
> -		/*
> -		 * ppc64 uses function descriptors and appends a '.' to the
> -		 * start of every instruction address. Remove it.
> -		 */
> -		if (name[0] == '.')
> -			name++;
> -		sym->idle = symbol__is_idle(name);
> -	}
> -
>  	while (*p != NULL) {
>  		parent = *p;
>  		s = rb_entry(parent, struct symbol, rb_node);
> @@ -393,7 +382,7 @@ void __symbols__insert(struct rb_root_cached *symbols,
>  
>  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
>  {
> -	__symbols__insert(symbols, sym, false);
> +	__symbols__insert(symbols, sym);
>  }
>  
>  static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
> @@ -554,7 +543,7 @@ void dso__reset_find_symbol_cache(struct dso *dso)
>  
>  void dso__insert_symbol(struct dso *dso, struct symbol *sym)
>  {
> -	__symbols__insert(dso__symbols(dso), sym, dso__kernel(dso));
> +	__symbols__insert(dso__symbols(dso), sym);
>  
>  	/* update the symbol cache if necessary */
>  	if (dso__last_find_result_addr(dso) >= sym->start &&
> @@ -716,47 +705,87 @@ int modules__parse(const char *filename, void *arg,
>  	return err;
>  }
>  
> +static int sym_name_cmp(const void *a, const void *b)
> +{
> +	const char *name = a;
> +	const char *const *sym = b;
> +
> +	return strcmp(name, *sym);
> +}
> +
>  /*
>   * These are symbols in the kernel image, so make sure that
>   * sym is from a kernel DSO.
>   */
> -static bool symbol__is_idle(const char *name)
> +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const struct perf_env *env)
>  {
> -	const char * const idle_symbols[] = {
> +	static const char * const idle_symbols[] = {
>  		"acpi_idle_do_entry",
>  		"acpi_processor_ffh_cstate_enter",
>  		"arch_cpu_idle",
>  		"cpu_idle",
>  		"cpu_startup_entry",
> -		"idle_cpu",
> -		"intel_idle",
> -		"intel_idle_ibrs",
>  		"default_idle",
> -		"native_safe_halt",
>  		"enter_idle",
>  		"exit_idle",
> -		"mwait_idle",
> -		"mwait_idle_with_hints",
> -		"mwait_idle_with_hints.constprop.0",
> +		"idle_cpu",
> +		"native_safe_halt",
>  		"poll_idle",
> -		"ppc64_runlatch_off",
>  		"pseries_dedicated_idle_sleep",
> -		"psw_idle",
> -		"psw_idle_exit",
> -		NULL
>  	};
> -	int i;
> -	static struct strlist *idle_symbols_list;
> +	const char *name = sym->name;
> +	uint16_t e_machine = env ? env->e_machine : EM_HOST;
>  
> -	if (idle_symbols_list)
> -		return strlist__has_entry(idle_symbols_list, name);
> +	if (sym->idle)
> +		return sym->idle == SYMBOL_IDLE__IDLE;
>  
> -	idle_symbols_list = strlist__new(NULL, NULL);
> +	if (!dso || dso__kernel(dso) == DSO_SPACE__USER) {
> +		sym->idle = SYMBOL_IDLE__NOT_IDLE;
> +		return false;
> +	}
>  
> -	for (i = 0; idle_symbols[i]; i++)
> -		strlist__add(idle_symbols_list, idle_symbols[i]);
> +	/*
> +	 * ppc64 uses function descriptors and appends a '.' to the
> +	 * start of every instruction address. Remove it.
> +	 */
> +	if (name[0] == '.')
> +		name++;
>  
> -	return strlist__has_entry(idle_symbols_list, name);
> +	if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
> +		    sizeof(idle_symbols[0]), sym_name_cmp)) {
> +		sym->idle = SYMBOL_IDLE__IDLE;
> +		return true;
> +	}
> +
> +	if (e_machine == EM_386 || e_machine == EM_X86_64) {

As said in anther thread, intel_idle_irq was still there on my test
machine. I did a bit debug and found e_machine == 0 so it couldn't run
into this branch. After dig more, it should be
deliver_event()->perf_session__find_machine() return a struct machine
whose env->e_machine is 0. I'm still busy today to do more, wish this
clue can help.

Thanks,
Honglei

> +		if (strstarts(name, "mwait_idle") ||
> +		    strstarts(name, "intel_idle")) {
> +			sym->idle = SYMBOL_IDLE__IDLE;
> +			return true;
> +		}
> +	}
> +
> +	if (e_machine == EM_PPC64 && !strcmp(name, "ppc64_runlatch_off")) {
> +		sym->idle = SYMBOL_IDLE__IDLE;
> +		return true;
> +	}
> +
> +	if (e_machine == EM_S390) {
> +		int major = 0, minor = 0;
> +		const char *release = env && env->os_release
> +			? env->os_release : perf_version_string;
> +
> +		sscanf(release, "%d.%d", &major, &minor);
> +
> +		/* Before v6.10, s390 used psw_idle. */
> +		if ((major < 6 || (major == 6 && minor < 10)) && strstarts(name, "psw_idle")) {
> +			sym->idle = SYMBOL_IDLE__IDLE;
> +			return true;
> +		}
> +	}
> +
> +	sym->idle = SYMBOL_IDLE__NOT_IDLE;
> +	return false;
>  }
>  
>  static int map__process_kallsym_symbol(void *arg, const char *name,
> @@ -785,7 +814,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
>  	 * We will pass the symbols to the filter later, in
>  	 * map__split_kallsyms, when we have split the maps per module
>  	 */
> -	__symbols__insert(root, sym, !strchr(name, '['));
> +	__symbols__insert(root, sym);
>  
>  	return 0;
>  }
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index c67814d6d6d6..f26f67bd7982 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -25,6 +25,7 @@ struct dso;
>  struct map;
>  struct maps;
>  struct option;
> +struct perf_env;
>  struct build_id;
>  
>  /*
> @@ -42,6 +43,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>  			     GElf_Shdr *shp, const char *name, size_t *idx);
>  #endif
>  
> +enum symbol_idle_kind {
> +	SYMBOL_IDLE__UNKNOWN = 0,
> +	SYMBOL_IDLE__NOT_IDLE = 1,
> +	SYMBOL_IDLE__IDLE = 2,
> +};
> +
>  /**
>   * A symtab entry. When allocated this may be preceded by an annotation (see
>   * symbol__annotation) and/or a browser_index (see symbol__browser_index).
> @@ -57,8 +64,8 @@ struct symbol {
>  	u8		type:4;
>  	/** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBAL. */
>  	u8		binding:4;
> -	/** Set true for kernel symbols of idle routines. */
> -	u8		idle:1;
> +	/** Cache for symbol__is_idle. */
> +	enum symbol_idle_kind idle:2;
>  	/** Resolvable but tools ignore it (e.g. idle routines). */
>  	u8		ignore:1;
>  	/** Symbol for an inlined function. */
> @@ -202,8 +209,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
>  
>  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
>  
> -void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
> -		       bool kernel);
> +void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
>  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
>  void symbols__fixup_duplicate(struct rb_root_cached *symbols);
>  void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
> @@ -286,5 +292,6 @@ enum {
>  };
>  
>  int symbol__validate_sym_arguments(void);
> +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const struct perf_env *env);
>  
>  #endif /* __PERF_SYMBOL */

