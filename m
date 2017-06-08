From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf: correct precise_ip level for s390
Date: Thu,  8 Jun 2017 10:40:44 +0200
Message-ID: <20170608084044.71968-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On s390 the counter and sampling facility do not support a
precise IP skid level and sometimes returns EOPNOTSUPP when
structure member precise_ip in struct perf_event_attr
is not set to zero.

On s390 commnd 'perf record -- true' fails with error EOPNOTSUPP.
This happens only when no events are specified on command line.

The functions called are
...
--> perf_evlist__add_default
    --> perf_evsel__new_cycles
        --> perf_event_attr__set_max_precise_ip

The last function determines the value of structure member precise_ip
by invoking the perf_event_open() system call and checking the return code.
The first successful open is the value for precise_ip.
However the value is determined without setting member sample_period
and indicates no sampling.
On s390 the counter facility and sampling facility are different.
The above procedure determines a precise_ip value of 3 using the
counter facility. Later it uses the sampling facility with a value of 3
and fails with EOPNOTSUPP.

Fix this by changing function perf_evsel__new_cycles(). It is called
very early in the event setup. Delay the determination of
the value of precise_ip until the context is known. This is the case
when perf_evsel__config() is called.
Function perf_evsel__new_cycles() just marks precise_ip to be
determined later.

Also change the modifier to 'P' for maximum detected precise level.

Suggested-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/util/evsel.c         | 7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ac59710..9266908 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -264,15 +264,14 @@ struct perf_evsel *perf_evsel__new_cycles(void)
 
 	event_attr_init(&attr);
 
-	perf_event_attr__set_max_precise_ip(&attr);
-
 	evsel = perf_evsel__new(&attr);
 	if (evsel == NULL)
 		goto out;
 
+	evsel->precise_max = 1;
+
 	/* use asprintf() because free(evsel) assumes name is allocated */
-	if (asprintf(&evsel->name, "cycles%.*s",
-		     attr.precise_ip ? attr.precise_ip + 1 : 0, ":ppp") < 0)
+	if (asprintf(&evsel->name, "cycles:P") < 0)
 		goto error_free;
 out:
 	return evsel;
-- 
2.9.3
