From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Subject: [PATCH 1/3] perf tools: parse tracepooints with '-' in system name
Date: Fri, 25 Apr 2014 17:34:05 +0200
Message-ID: <1398440047-6641-2-git-send-email-yarygin@linux.vnet.ibm.com>
References: <1398440047-6641-1-git-send-email-yarygin@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1398440047-6641-1-git-send-email-yarygin@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Trace events potentially can have a '-' in their trace system name,
e.g. kvm on s390 defines kvm-s390:* tracepoints.
tools/perf could not parse them, because there was no rule for this:
$ sudo ./perf top -e "kvm-s390:*"
invalid or unsupported event: 'kvm-s390:*'

This patch adds an extra rule to event_legacy_tracepoint which handles
those cases. Without the patch, perf will not accept such tracepoints in
the -e option.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
---
 tools/perf/util/parse-events.y |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4eb67ec..ac9db9f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -299,6 +299,18 @@ PE_PREFIX_MEM PE_VALUE sep_dc
 }
 
 event_legacy_tracepoint:
+PE_NAME '-' PE_NAME ':' PE_NAME
+{
+	struct parse_events_evlist *data = _data;
+	struct list_head *list;
+	char sys_name[128];
+	snprintf(&sys_name, 128, "%s-%s", $1, $3);
+
+	ALLOC_LIST(list);
+	ABORT_ON(parse_events_add_tracepoint(list, &data->idx, &sys_name, $5));
+	$$ = list;
+}
+|
 PE_NAME ':' PE_NAME
 {
 	struct parse_events_evlist *data = _data;
-- 
1.7.9.5
