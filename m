From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 3/3] perf trace: no longer require auditlibs if syscall
 tables are present
Date: Thu, 7 Dec 2017 14:53:52 -0300
Message-ID: <20171207175352.GH3173@kernel.org>
References: <1512635281-20733-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1512635281-20733-4-git-send-email-brueckner@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1512635281-20733-4-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Em Thu, Dec 07, 2017 at 09:28:01AM +0100, Hendrik Brueckner escreveu:
> Change the Makefile and build process to no longer require auditlibs
> interfaces when the architecture provides system call tables.

And this one will have to wait for the fix in how the errno translation
tables are generated, ok?

- Arnaldo
 
> Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  tools/perf/Makefile.config          | 10 ++++++++--
>  tools/perf/builtin-help.c           |  2 +-
>  tools/perf/perf.c                   |  4 ++--
>  tools/perf/util/generate-cmdlist.sh |  2 +-
>  4 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d8447b1..6a948bf 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -531,8 +531,14 @@ endif
>  
>  ifndef NO_LIBAUDIT
>    ifneq ($(feature-libaudit), 1)
> -    msg := $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev);
> -    NO_LIBAUDIT := 1
> +    ifeq ($(NO_SYSCALL_TABLE), 1)
> +      msg := $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev);
> +      NO_LIBAUDIT := 1
> +    else
> +      # With syscall table support, auditlibs are no longer required to build
> +      # the trace tool.
> +      $(call detected,CONFIG_AUDIT)
> +    endif
>    else
>      CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
>      EXTLIBS += -laudit
> diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
> index a0f7ed2..4aca13f 100644
> --- a/tools/perf/builtin-help.c
> +++ b/tools/perf/builtin-help.c
> @@ -439,7 +439,7 @@ int cmd_help(int argc, const char **argv)
>  #ifdef HAVE_LIBELF_SUPPORT
>  		"probe",
>  #endif
> -#ifdef HAVE_LIBAUDIT_SUPPORT
> +#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
>  		"trace",
>  #endif
>  	NULL };
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 62b1351..1b3fc8e 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -73,7 +73,7 @@ struct cmd_struct {
>  	{ "lock",	cmd_lock,	0 },
>  	{ "kvm",	cmd_kvm,	0 },
>  	{ "test",	cmd_test,	0 },
> -#ifdef HAVE_LIBAUDIT_SUPPORT
> +#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
>  	{ "trace",	cmd_trace,	0 },
>  #endif
>  	{ "inject",	cmd_inject,	0 },
> @@ -485,7 +485,7 @@ int main(int argc, const char **argv)
>  		argv[0] = cmd;
>  	}
>  	if (strstarts(cmd, "trace")) {
> -#ifdef HAVE_LIBAUDIT_SUPPORT
> +#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
>  		setup_path();
>  		argv[0] = "trace";
>  		return cmd_trace(argc, argv);
> diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
> index 9bbcec4..ff17920 100755
> --- a/tools/perf/util/generate-cmdlist.sh
> +++ b/tools/perf/util/generate-cmdlist.sh
> @@ -38,7 +38,7 @@ do
>  done
>  echo "#endif /* HAVE_LIBELF_SUPPORT */"
>  
> -echo "#ifdef HAVE_LIBAUDIT_SUPPORT"
> +echo "#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)"
>  sed -n -e 's/^perf-\([^ 	]*\)[ 	].* audit*/\1/p' command-list.txt |
>  sort |
>  while read cmd
> -- 
> 1.8.3.1
