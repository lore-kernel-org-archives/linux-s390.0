From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] Fix usage of trace events with '-' in trace system name.
Date: Fri, 25 Apr 2014 17:34:04 +0200
Message-ID: <1398440047-6641-1-git-send-email-yarygin@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This path series allows perf tool to work with trace events,
which have '-' in trace system name (i.e. kvm-s390:*).

v2 changes:
    - added s390 specific test to perf/tests/parse-events.c
    - use array with a constant length in the parse rule
    - rephrased description of patch 1/3

Patch 2/3 makes possible to add arch specific tests
to perf/tests/parse-events.c.

Alexander Yarygin (3):
  perf tools: parse tracepooints with '-' in system name
  perf-test: add numeric identifier to evlist_test
  perf-test: Add a test of kvm-390: trace event

 tools/perf/tests/parse-events.c |  142 ++++++++++++++++++++++++++-------------
 tools/perf/util/parse-events.y  |   12 ++++
 2 files changed, 109 insertions(+), 45 deletions(-)

--
1.7.9.5
