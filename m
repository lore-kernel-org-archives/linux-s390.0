From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 5/5] perf trace: Remove audit-libs dependency if
 syscall tables are present
Date: Fri, 19 Jan 2018 11:04:26 -0300
Message-ID: <20180119140426.GB23453@kernel.org>
References: <1516352177-11106-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1516352177-11106-6-git-send-email-brueckner@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516352177-11106-6-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Em Fri, Jan 19, 2018 at 09:56:17AM +0100, Hendrik Brueckner escreveu:
> Change the Makefile and build process to no longer require audit-libs
> interfaces when the architecture provides system call tables.
> 
> Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>

So, I need this extra patch to really stop linking against
audit-libs-devel (aka libaudit), which I merged with this 5/5 patch and
have now in my tree, thanks for your work! Now we can get on with this
and, for instance, get rid of those strcmp() and big switch statements,
which I think that could be just an array plus a helper to see if it is
in its bounds, etc, i.e. use an strarray, look at
tools/perf/trace/beauty/beauty.h:

struct strarray {
        int         offset;
        int         nr_entries;
        const char **entries;
};

#define DEFINE_STRARRAY(array) struct strarray strarray__##array = { \
        .nr_entries = ARRAY_SIZE(array), \
        .entries = array, \
}

#define DEFINE_STRARRAY_OFFSET(array, off) struct strarray strarray__##array = { \
        .offset     = off, \
        .nr_entries = ARRAY_SIZE(array), \
        .entries = array, \
}

size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, int val); 

tools/perf/trace/beauty/ has lots of uses for it.

[acme@seventh perf]$ rpm -q audit-libs-devel
audit-libs-devel-2.8.2-1.fc27.x86_64
[acme@seventh perf]$ ldd ~/bin/perf | grep audit
[acme@seventh perf]$ 

diff --git a/tools/perf/Build b/tools/perf/Build
index b48ca40fccf9..e5232d567611 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -25,7 +25,7 @@ perf-y += builtin-data.o
 perf-y += builtin-version.o
 perf-y += builtin-c2c.o
 
-perf-$(CONFIG_AUDIT) += builtin-trace.o
+perf-$(CONFIG_TRACE) += builtin-trace.o
 perf-$(CONFIG_LIBELF) += builtin-probe.o
 
 perf-y += bench/
@@ -50,6 +50,6 @@ libperf-y += util/
 libperf-y += arch/
 libperf-y += ui/
 libperf-y += scripts/
-libperf-$(CONFIG_AUDIT) += trace/beauty/
+libperf-$(CONFIG_TRACE) += trace/beauty/
 
 gtk-y += ui/gtk/
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 896dee62078c..a042ccca4e93 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -531,20 +531,18 @@ ifndef NO_LIBUNWIND
   EXTLIBS += $(EXTLIBS_LIBUNWIND)
 endif
 
-ifndef NO_LIBAUDIT
-  ifneq ($(feature-libaudit), 1)
-    ifeq ($(NO_SYSCALL_TABLE), 1)
+ifeq ($(NO_SYSCALL_TABLE),0)
+  $(call detected,CONFIG_TRACE)
+else
+  ifndef NO_LIBAUDIT
+    ifneq ($(feature-libaudit), 1)
       msg := $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev);
       NO_LIBAUDIT := 1
     else
-      # With syscall table support, auditlibs are no longer required to build
-      # the trace tool.
-      $(call detected,CONFIG_AUDIT)
+      CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
+      EXTLIBS += -laudit
+      $(call detected,CONFIG_TRACE)
     endif
-  else
-    CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
-    EXTLIBS += -laudit
-    $(call detected,CONFIG_AUDIT)
   endif
 endif
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7c6a8b461e24..4eef0c243306 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -44,7 +44,7 @@ libperf-y += machine.o
 libperf-y += map.o
 libperf-y += pstack.o
 libperf-y += session.o
-libperf-$(CONFIG_AUDIT) += syscalltbl.o
+libperf-$(CONFIG_TRACE) += syscalltbl.o
 libperf-y += ordered-events.o
 libperf-y += namespaces.o
 libperf-y += comm.o
