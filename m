From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 00/11] perf/s390/kvm: trace events, perf kvm stat
Date: Fri, 25 Apr 2014 11:12:22 +0200
Message-ID: <1398417153-57347-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The goal of this series is to
- enable perf kvm stat on s390
- get rid of a perf warning "insn_to_mnemonic not found" when it tries to
  decode s390 perf trace events

Review feedback is welcome.
In addition, The patch set touches s390/kvm code and perf code.
So any feedback on which tree to use for this series is also 
welcome.

Christian


Alexander Yarygin (11):
  s390: add sie exit reasons tables
  KVM: s390: Use trace tables from sie.h.
  KVM: s390: decoder of SIE intercepted instructions
  KVM: s390: Use intercept_insn decoder in trace event
  perf kvm: Intoduce HAVE_KVM_STAT_SUPPORT flag
  perf kvm: simplify of exit reasons tables definitions
  perf kvm: Refactoring of cpu_isa_config()
  perf kvm: allow for variable string sizes
  perf kvm: use defines of kvm events
  perf: allow to use cpuinfo on s390
  perf kvm: add stat support on s390

 arch/s390/include/uapi/asm/kvm.h   |   7 +
 arch/s390/include/uapi/asm/sie.h   | 245 ++++++++++++++++++++++++++++++++++
 arch/s390/kvm/trace.h              |  39 +-----
 arch/x86/include/uapi/asm/kvm.h    |   8 ++
 tools/perf/MANIFEST                |   3 +
 tools/perf/arch/s390/Makefile      |   2 +
 tools/perf/arch/s390/util/header.c |  17 +++
 tools/perf/arch/x86/Makefile       |   1 +
 tools/perf/builtin-kvm.c           | 263 +++++++++++++++++++++++++++++--------
 tools/perf/config/Makefile         |   4 +
 tools/perf/perf.h                  |   1 +
 11 files changed, 499 insertions(+), 91 deletions(-)
 create mode 100644 arch/s390/include/uapi/asm/sie.h
 create mode 100644 tools/perf/arch/s390/util/header.c

-- 
1.8.4.2
