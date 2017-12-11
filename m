From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/3 v2] perf trace: Introduce errno_to_name()
Date: Mon, 11 Dec 2017 12:00:45 -0300
Message-ID: <20171211150045.GB3958@kernel.org>
References: <20171207144846.GB6458@kernel.org>
 <1512658810-7874-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <20171207175256.GG3173@kernel.org>
 <20171211113259.GF4369@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171211113259.GF4369@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Em Mon, Dec 11, 2017 at 12:32:59PM +0100, Hendrik Brueckner escreveu:
> Hi Arnaldo,
> 
> On Thu, Dec 07, 2017 at 02:52:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Dec 07, 2017 at 04:00:10PM +0100, Hendrik Brueckner escreveu:
> > > Introduce an errno_to_name() function to return the name of a
> > > give errno number as string.
> > 
> > Humm, we cannot use asm-generic for all, as there are differences in the
> > errno numbers from arch to arch, for instance:
> > 
> > In arch/alpha/include/uapi/asm/errno.h we use errno-base.h but even in
> > that part one of its entries gets a different number on the Alpha arch,
> > EAGAIN:
> > -------------------
> > #include <asm-generic/errno-base.h>
> > 
> > #undef  EAGAIN                  /* 11 in errno-base.h */
> > 
> > #define EDEADLK         11      /* Resource deadlock would occur */
> > 
> > #define EAGAIN          35      /* Try again */
> > #define EWOULDBLOCK     EAGAIN  /* Operation would block */
> > -------------------
 
> With that in the mind, I have changed the generation in a way similar
> I did for s390 syscall table generation.  The util/generate-errno-names.sh
> script can simply process the arch specific errno.h with cpp/gcc.
 
> This approach will work fine if the arch errno.h does only include the
> asm-generic/errno*.h files and does not have any differences between 32/64
> bit.  Otherwise it becomes more difficult.
 
> > So you can try to copy all arch/*/include/uapi/asm/errno.h files and
> > use the arch to key that, i.e. its almost what you did, but needs to
> > take the arch into consideration.
 
> util/generate-errno-names.sh is also extended to process architectures
> for which there is a resp. directory below the tools/arch/ directory.
> Generation of the errno name mappings is still the same but one ALL_
> define for each architecture.
 
> > Later we'll generate a two dimensional table of sorts, having the first
> > dimension be the arch name, so that we can translate errnos in a
> > perf.data file collected on, say, mips (one of these routers) in a tool
> > running on x86_64 (or S/390 :)).
> 
> Yep... for this I need your help: How to obtain the arch string/ID whatever
> in builtin-trace to use the correct errno map?

you can get it from the running system, for live sessions, from uname(),
and for a perf.data file from its header, see the annotation code, but
the function is this:

   perf_evsel__env_arch(evsel)

Will return a perf_env pointer, and that has a lot of details about the
environment where that perf.data file was recorded:

struct perf_env {
        char                    *hostname;
        char                    *os_release;
        char                    *version;
        char                    *arch;
        int                     nr_cpus_online;
        int                     nr_cpus_avail;
        char                    *cpu_desc;
        char                    *cpuid;
        unsigned long long      total_mem;
        unsigned int            msr_pmu_type;

        int                     nr_cmdline;
        int                     nr_sibling_cores;
        int                     nr_sibling_threads;
        int                     nr_numa_nodes;
        int                     nr_pmu_mappings;
        int                     nr_groups;
        char                    *cmdline;
        const char              **cmdline_argv;
        char                    *sibling_cores;
        char                    *sibling_threads;
        char                    *pmu_mappings;
        struct cpu_topology_map *cpu;
        struct cpu_cache_level  *caches;
        int                      caches_cnt;
        struct numa_node        *numa_nodes;
};

The annotate code does some more massaging:

tools/perf/util/annotate.c

        arch_name = annotate__norm_arch(arch_name);

static const char *annotate__norm_arch(const char *arch_name)
{
        struct utsname uts;

        if (!arch_name) { /* Assume we are annotating locally. */
                if (uname(&uts) < 0)
                        return NULL;
                arch_name = uts.machine;
        }
        return normalize_arch((char *)arch_name);
}

We need to first move this from annotate to a more generally available
function, say renaming annotate__norm_arch() to perf_env__norm_arch()
and using it.

I'll do this now and push to my perf/core branch, so that you can
continue from there.
 
> Below you can find an update on the patch (excluding the patch(es) to grab
> the header files, one can do that simply with
> 	cp --parents -v $(find arch/ -name errno.h) tools/
> in the linux source tree.)

Ok, I'll play with it and report back,

- Arnaldo
 
> ---->8---------
> 
> Introduce an errno_to_name() function to return the name of a
> give errno number as string.
> 
> With this change, the dependency to libaudit can be removed for
> architectures that support syscall tables.  Hence, remove the
> audit_errno_to_name() call in builtin-trace.c and just link
> util/syscalltbl.c against libaudit.  A follow-up commit could
> then clean-up this dependency with respect to the syscall table.
> 
> The errno name strings are generated by util/generate-errno-names.sh
> script and saved as util/errno-names.h.  Errno mappings are created
> for the architectures that are available in the tool/arch/ directory
> in the Linux source tree.
> 
> Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  tools/perf/.gitignore                   |  1 +
>  tools/perf/Makefile.config              |  2 +-
>  tools/perf/Makefile.perf                |  9 ++++-
>  tools/perf/builtin-trace.c              | 26 +++++++++++--
>  tools/perf/util/generate-errno-names.sh | 67 +++++++++++++++++++++++++++++++++
>  5 files changed, 99 insertions(+), 6 deletions(-)
>  create mode 100755 tools/perf/util/generate-errno-names.sh
> 
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index 643cc4ba..4e022f9 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -14,6 +14,7 @@ perf*.1
>  perf*.xml
>  perf*.html
>  common-cmds.h
> +errno-names.h
>  perf.data
>  perf.data.old
>  output.svg
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ab16aab..d8447b1 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -251,7 +251,7 @@ INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
>  INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/
>  INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/
>  
> -# $(obj-perf)      for generated common-cmds.h
> +# $(obj-perf)      for generated common-cmds.h and errno-names.h
>  # $(obj-perf)/util for generated bison/flex headers
>  ifneq ($(OUTPUT),)
>  INC_FLAGS += -I$(obj-perf)/util
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 68cf136..73a2616 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -518,6 +518,9 @@ $(OUTPUT)common-cmds.h: util/generate-cmdlist.sh command-list.txt
>  $(OUTPUT)common-cmds.h: $(wildcard Documentation/perf-*.txt)
>  	$(QUIET_GEN). util/generate-cmdlist.sh > $@+ && mv $@+ $@
>  
> +$(OUTPUT)util/errno-names.h: util/generate-errno-names.sh
> +	$(QUIET_GEN). util/generate-errno-names.sh "$(CC)" "$(srctree)/tools" > $@+ && mv $@+ $@
> +
>  $(SCRIPTS) : % : %.sh
>  	$(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'
>  
> @@ -565,7 +568,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
>  	$(vhost_virtio_ioctl_array) \
>  	$(madvise_behavior_array) \
>  	$(perf_ioctl_array) \
> -	$(prctl_option_array)
> +	$(prctl_option_array) \
> +	$(OUTPUT)util/errno-names.h
>  
>  $(OUTPUT)%.o: %.c prepare FORCE
>  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
> @@ -847,7 +851,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
>  		$(OUTPUT)$(kcmp_type_array) \
>  		$(OUTPUT)$(vhost_virtio_ioctl_array) \
>  		$(OUTPUT)$(perf_ioctl_array) \
> -		$(OUTPUT)$(prctl_option_array)
> +		$(OUTPUT)$(prctl_option_array) \
> +		$(OUTPUT)util/errno-names.h
>  	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
>  
>  #
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 84debdb..4c7805d 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -42,17 +42,16 @@
>  #include "string2.h"
>  #include "syscalltbl.h"
>  #include "rb_resort.h"
> +#include "util/errno-names.h"
>  
>  #include <errno.h>
>  #include <inttypes.h>
> -#include <libaudit.h> /* FIXME: Still needed for audit_errno_to_name */
>  #include <poll.h>
>  #include <signal.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <linux/err.h>
>  #include <linux/filter.h>
> -#include <linux/audit.h>
>  #include <linux/kernel.h>
>  #include <linux/random.h>
>  #include <linux/stringify.h>
> @@ -1659,6 +1658,27 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
>  	return sample__fprintf_callchain(sample, 38, print_opts, &callchain_cursor, trace->output);
>  }
>  
> +static const char *__generic_errno_to_name(int err)
> +{
> +#define ERRNO_NAME_MAP(_err, _num) case _num: return #_err;
> +#define ERRNO_NAME_MAP(_err, _num) case _num: return #_err;
> +	switch (err) {
> +	ALL_ERRNO_NAME_MAPPINGS__GENERIC
> +#undef ERRNO_NAME_MAP
> +	default:
> +		return "(unknown)";
> +		break;
> +	}
> +}
> +
> +static const char *errno_to_name(const int arch, int err)
> +{
> +	switch (arch) {
> +	default:
> +		return __generic_errno_to_name(err);
> +	}
> +}
> +
>  static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
>  			   union perf_event *event __maybe_unused,
>  			   struct perf_sample *sample)
> @@ -1729,7 +1749,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
>  errno_print: {
>  		char bf[STRERR_BUFSIZE];
>  		const char *emsg = str_error_r(-ret, bf, sizeof(bf)),
> -			   *e = audit_errno_to_name(-ret);
> +			   *e = errno_to_name(0, -ret);
>  
>  		fprintf(trace->output, ") = -1 %s %s", e, emsg);
>  	}
> diff --git a/tools/perf/util/generate-errno-names.sh b/tools/perf/util/generate-errno-names.sh
> new file mode 100755
> index 0000000..57f74d4
> --- /dev/null
> +++ b/tools/perf/util/generate-errno-names.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Generate errno names header file
> +#
> +# Copyright IBM Corp. 2017
> +# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> +
> +gcc="$1"
> +toolsdir="$2"
> +include_path="-I$toolsdir/include/uapi"
> +
> +arch_string()
> +{
> +	echo "$1" |sed -e 'y/- /__/' |tr '[[:lower:]]' '[[:upper:]]'
> +}
> +
> +asm_errno_file()
> +{
> +	local arch="$1"
> +	local header
> +
> +	header="$toolsdir/arch/$arch/include/uapi/asm/errno.h"
> +	if test -r "$header"; then
> +		echo "$header"
> +	else
> +		echo "$toolsdir/include/uapi/asm-generic/errno.h"
> +	fi
> +}
> +
> +process_arch()
> +{
> +	local arch="$1"
> +	local tmpfile=$(mktemp -t generate-errno-names.XXXXXXXXX)
> +	local asm_errno=$(asm_errno_file "$arch")
> +
> +	$gcc $include_path -E -dM -x c $asm_errno \
> +		|grep -hE '^#define[[:blank:]]+(E[^[:blank:]]+)[[:blank:]]+([[:digit:]]+).*' \
> +		|awk '{ print $2", "$3; }' \
> +		|sort -t, -k2 -nu \
> +		|sed -e 's/^/\tERRNO_NAME_MAP(/' -e 's/$/)/' \
> +		>  $tmpfile
> +
> +	printf '#define ALL_ERRNO_NAME_MAPPINGS__%s \\\n' $(arch_string "$arch")
> +	head -n -1 $tmpfile |sed -e 's/$/ \\/'
> +	tail -1 $tmpfile
> +	printf "\n"
> +	rm $tmpfile
> +}
> +
> +cat <<EoHeader
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _UTIL_ERRNO_NAMES_H
> +#define _UTIL_ERRNO_NAMES_H
> +
> +EoHeader
> +
> +for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" |sort); do
> +	process_arch "$arch"
> +done
> +
> +# Generic fallback
> +process_arch "generic"
> +
> +cat <<EoFooter
> +#endif	/* _UTIL_ERRNO_NAMES_H */
> +EoFooter
> -- 
> 1.8.3.1
