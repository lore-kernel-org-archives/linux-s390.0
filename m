Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v2 7/7] padata: document multithreaded jobs
Date: Wed, 20 May 2020 14:26:45 -0400
Message-Id: <20200520182645.1658949-8-daniel.m.jordan@oracle.com>
In-Reply-To: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
References: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert <steffen.klassert@secunet.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Robert Elliott <elliott@hpe.com>, Shile Zhang <shile.zhang@linux.alibaba.com>, Steven Sistare <steven.sistare@oracle.com>, Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Daniel Jordan <daniel.m.jordan@oracle.com>

Add Documentation for multithreaded jobs.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 Documentation/core-api/padata.rst | 41 +++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/core-api/padata.rst b/Documentation/core-api/padata.rst
index 9a24c111781d9..b7e047af993e8 100644
--- a/Documentation/core-api/padata.rst
+++ b/Documentation/core-api/padata.rst
@@ -4,23 +4,26 @@
 The padata parallel execution mechanism
 =======================================
 
-:Date: December 2019
+:Date: April 2020
 
 Padata is a mechanism by which the kernel can farm jobs out to be done in
-parallel on multiple CPUs while retaining their ordering.  It was developed for
-use with the IPsec code, which needs to be able to perform encryption and
-decryption on large numbers of packets without reordering those packets.  The
-crypto developers made a point of writing padata in a sufficiently general
-fashion that it could be put to other uses as well.
+parallel on multiple CPUs while optionally retaining their ordering.
 
-Usage
-=====
+It was originally developed for IPsec, which needs to perform encryption and
+decryption on large numbers of packets without reordering those packets.  This
+is currently the sole consumer of padata's serialized job support.
+
+Padata also supports multithreaded jobs, splitting up the job evenly while load
+balancing and coordinating between threads.
+
+Running Serialized Jobs
+=======================
 
 Initializing
 ------------
 
-The first step in using padata is to set up a padata_instance structure for
-overall control of how jobs are to be run::
+The first step in using padata to run parallel jobs is to set up a
+padata_instance structure for overall control of how jobs are to be run::
 
     #include <linux/padata.h>
 
@@ -162,6 +165,24 @@ functions that correspond to the allocation in reverse::
 It is the user's responsibility to ensure all outstanding jobs are complete
 before any of the above are called.
 
+Running Multithreaded Jobs
+==========================
+
+A multithreaded job has a main thread and zero or more helper threads, with the
+main thread participating in the job and then waiting until all helpers have
+finished.  padata splits the job into units called chunks, where a chunk is a
+piece of the job that one thread completes in one call to the thread function.
+
+A user has to do three things to run a multithreaded job.  First, describe the
+job by defining a padata_mt_job structure, which is explained in the Interface
+section.  This includes a pointer to the thread function, which padata will
+call each time it assigns a job chunk to a thread.  Then, define the thread
+function, which accepts three arguments, ``start``, ``end``, and ``arg``, where
+the first two delimit the range that the thread operates on and the last is a
+pointer to the job's shared state, if any.  Prepare the shared state, which is
+typically a stack-allocated structure that wraps the required data.  Last, call
+padata_do_multithreaded(), which will return once the job is finished.
+
 Interface
 =========
 
-- 
2.26.2
