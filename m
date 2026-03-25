Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D435FF6B;
	Wed, 25 Mar 2026 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421892; cv=none; b=B3odU/1JPOsLw463UeMHdfSlrqTRqGIhDXAucSXYiIrnBMow/zzV8FcH4KvJLmIAIg/KkTXE3A5vIa7whOs7S7BHSJ5uPBAGXtww26mvgheShqrvffSw3p7w871YdQrwSDVhPmTEpvLvDf3ATt17Sg6rFSlEG8WdAOV5huN8uD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421892; c=relaxed/simple;
	bh=6eYGJ2LbQlnZQ24DKIA4YQNf2DSG4IkIa2fRS+NpsDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF5tEtiYrLVNvShahyPIzJoKMQ6tTZ3bxglZgXfMO4444eUyIHI0IKTTTue6rtfeDnFcc4RbEUgjB6BAtHPhftzOMLaOro/RHS56QZGM+zoPNfvdnnRmW401NQVbKAzGvkovt060vSYJOwIekN3WUu/VPAwqxhd8+VuQDavEjC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k26dan2c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k26dan2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CFCC4CEF7;
	Wed, 25 Mar 2026 06:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774421891;
	bh=6eYGJ2LbQlnZQ24DKIA4YQNf2DSG4IkIa2fRS+NpsDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k26dan2cYkWaB4MHDF43RmUqrtE7rTEzjKpgr+6+V43BGxPZL7GvVBCVo5h+5Splq
	 xHe5TdAPTUZXgO8v5b6DegjWlzhR5qgjnAUKhjTvnhJaMSYQhUZlC+yqcrKfe9TNif
	 dp7/nfLUMQaN0CbdfD6hwlZ0yY33RUUvfzJj7FzWrs0lpgHUpwFg3A4Ww9D3TMno6x
	 gGIS2Lz+IKeo9TqW6lgQPPdlpoGyAIFFDpCWrerXSXeSSFmGRpwzeByEyv0EMqAZKs
	 W5LK7bTB/WvtM+PavhYf4BpZ8/5+66Jwu2kMfdRlf6h7onHDLZ2Zu/BjBvmfwP6C/5
	 IEAPfx8tCohrw==
Date: Tue, 24 Mar 2026 23:58:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: tmricht@linux.ibm.com, acme@kernel.org, agordeev@linux.ibm.com,
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com
Subject: Re: [PATCH v1] perf symbol: Lazily compute idle and use the perf_env
Message-ID: <acOHgYoM6oYWWTmC@google.com>
References: <20260219113850.354271-1-tmricht@linux.ibm.com>
 <20260302234343.564937-1-irogers@google.com>
 <CAP-5=fW0Bu2313nAuhur+wP5Y2JtBNY+wpPoiKLqNzcSe-R3gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW0Bu2313nAuhur+wP5Y2JtBNY+wpPoiKLqNzcSe-R3gA@mail.gmail.com>

Hi Ian,

Sorry for the delay.

On Tue, Mar 24, 2026 at 10:14:01AM -0700, Ian Rogers wrote:
> On Mon, Mar 2, 2026 at 3:43 PM Ian Rogers <irogers@google.com> wrote:
[SNIP]
> > -       if (idle_symbols_list)
> > -               return strlist__has_entry(idle_symbols_list, name);
> > +       /*
> > +        * ppc64 uses function descriptors and appends a '.' to the
> > +        * start of every instruction address. Remove it.
> > +        */
> > +       if (name[0] == '.')

Then e_machine == EM_PPC64 can be checked here.

> > +               name++;
> > +
> > +

Two blank lines.

> > +       if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
> > +                   sizeof(idle_symbols[0]), sym_name_cmp)) {
> > +               sym->idle = SYMBOL_IDLE__IDLE;
> > +               return true;
> > +       }
> > +
> > +       if (e_machine == EM_386 || e_machine == EM_X86_64) {
> > +               if (strstarts(name, "mwait_idle") ||
> > +                   strstarts(name, "intel_idle")) {
> > +                       sym->idle = SYMBOL_IDLE__IDLE;
> > +                       return true;
> > +               }
> > +       }
> > +
> > +       if (e_machine == EM_PPC64 &&!strcmp(name, "ppc64_runlatch_off")) {
> > +               sym->idle = SYMBOL_IDLE__IDLE;
> > +               return true;
> > +       }
> >
> > -       idle_symbols_list = strlist__new(NULL, NULL);
> > +       if (e_machine == EM_S390) {
> > +               int major = 0, minor = 0;
> > +               const char *release = env && env->os_release
> > +                       ? env->os_release : perf_version_string;
> >
> > -       for (i = 0; idle_symbols[i]; i++)
> > -               strlist__add(idle_symbols_list, idle_symbols[i]);
> > +               sscanf(release, "%d.%d", &major, &minor);
> >
> > -       return strlist__has_entry(idle_symbols_list, name);
> > +               /* Before v6.10, s390 used psw_idle. */
> > +               if ((major < 6 || (major == 6 && minor < 10)) && strstarts(name, "psw_idle")) {
> > +                       sym->idle = SYMBOL_IDLE__IDLE;
> > +                       return true;
> > +               }
> > +       }
> > +
> > +       sym->idle = SYMBOL_IDLE__NOT_IDLE;
> > +       return false;
> >  }
> >
> >  static int map__process_kallsym_symbol(void *arg, const char *name,
> > @@ -785,7 +815,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
> >          * We will pass the symbols to the filter later, in
> >          * map__split_kallsyms, when we have split the maps per module
> >          */
> > -       __symbols__insert(root, sym, !strchr(name, '['));
> > +       __symbols__insert(root, sym);
> >
> >         return 0;
> >  }
> > diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> > index 3fb5d146d9b1..508dd9f336e9 100644
> > --- a/tools/perf/util/symbol.h
> > +++ b/tools/perf/util/symbol.h
> > @@ -24,6 +24,7 @@ struct dso;
> >  struct map;
> >  struct maps;
> >  struct option;
> > +struct perf_env;
> >  struct build_id;
> >
> >  /*
> > @@ -41,6 +42,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
> >                              GElf_Shdr *shp, const char *name, size_t *idx);
> >  #endif
> >
> > +enum symbol_idle_kind {
> > +       SYMBOL_IDLE__UNKNOWN = 0,
> > +       SYMBOL_IDLE__NOT_IDLE = 1,
> > +       SYMBOL_IDLE__IDLE = 2,
> > +};
> > +
> >  /**
> >   * A symtab entry. When allocated this may be preceded by an annotation (see
> >   * symbol__annotation) and/or a browser_index (see symbol__browser_index).
> > @@ -56,8 +63,8 @@ struct symbol {
> >         u8              type:4;
> >         /** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBAL. */
> >         u8              binding:4;
> > -       /** Set true for kernel symbols of idle routines. */
> > -       u8              idle:1;
> > +       /** Cache for symbol__is_idle. */
> > +       enum symbol_idle_kind idle:2;

I'm curious if bitfields with different types (u8 and enum) can be
placed consecutively bitwise.  There can be a lot of symbols so it
could be a concern.

Thanks,
Namhyung


> >         /** Resolvable but tools ignore it (e.g. idle routines). */
> >         u8              ignore:1;
> >         /** Symbol for an inlined function. */
> > @@ -184,8 +191,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
> >
> >  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
> >
> > -void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
> > -                      bool kernel);
> > +void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
> >  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
> >  void symbols__fixup_duplicate(struct rb_root_cached *symbols);
> >  void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
> > @@ -269,5 +275,6 @@ enum {
> >  };
> >
> >  int symbol__validate_sym_arguments(void);
> > +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const struct perf_env *env);
> >
> >  #endif /* __PERF_SYMBOL */
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >
