From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Subject: [PATCH 3/3] perf-test: Add a test of kvm-390: trace event
Date: Fri, 25 Apr 2014 17:34:07 +0200
Message-ID: <1398440047-6641-4-git-send-email-yarygin@linux.vnet.ibm.com>
References: <1398440047-6641-1-git-send-email-yarygin@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1398440047-6641-1-git-send-email-yarygin@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Add a s390 specific test of a hardcoded trace event with '-'
in the name.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
---
 tools/perf/tests/parse-events.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 81dbd5a..deba669 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1389,6 +1389,13 @@ static struct evlist_test test__events[] = {
 		.check = test__pinned_group,
 		.id    = 41,
 	},
+#if defined(__s390x__)
+	{
+		.name  = "kvm-s390:kvm_s390_create_vm",
+		.check = test__checkevent_tracepoint,
+		.id    = 100,
+	},
+#endif
 };
 
 static struct evlist_test test__events_pmu[] = {
-- 
1.7.9.5
