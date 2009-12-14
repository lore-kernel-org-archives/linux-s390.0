From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 14 Dec 2009 13:57:44 +0000
Subject: [patch 0/3] S390-HWBKPT: Hardware breakpoint implementation for
Message-Id: <20091214135557.GA21568@in.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi All,

Please find the set of patches that introduces s390 specific implementation for perf-events based hardware breakpoint interfaces.

The patch set has been tested with ksym_tracer and watchpoints over GDB+ptrace and works fine.
The patch set applies cleanly on latest linux-2.6 tree (commit f405425).

Thanks,
-Mahesh.
-- 
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
