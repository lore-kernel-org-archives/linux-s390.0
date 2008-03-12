Return-Path: <linux-kernel-owner+w=401wt.eu-S1753696AbYCLN1W@vger.kernel.org>
Message-Id: <20080312132132.520833247@de.ibm.com>
Date: Wed, 12 Mar 2008 14:21:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/6] Guest page hinting version 6.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com, zach@vmware.com, frankeh@watson.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Greetings,
I've dedusted the guest page hinting patches and ported them to todays
upstream git tree. There is one reject if applied to 2.6.24-rc5-mm1 but
that is easy to fix. The code stills works as expected on my test system.

Our z/VM performance team recently published a report on guest page
hinting vs. the ballooner approach on SLES10 for a farm of web servers.
The code on SLES10 differs a bit from the upstream variant but the
performance results should be still valid.  You will find the report
here:

  http://www.vm.ibm.com/perf/reports/zvm/html/530cmm.html

(the VMRM-CMM the web page speaks about is the balloon approach,
 CMMA is the guest page hinting).

Both approaches to the memory overcommit problem show comparable benefits
for this workload, with an advantage for guest page hinting for large
number of guests. For other workloads your mileage may vary.

The main benefit for guest page hinting vs. the ballooner is that there
is no need for a monitor that keeps track of the memory usage of all the
guests, a complex algorithm that calculates the working set sizes and for
the calls into the guest kernel to control the size of the balloons.
The host just does normal LRU based paging. If the host picks one of the
pages the guest can recreate, the host can throw it away instead of writing
it to the paging device. Simple and elegant.
The main disadvantage is the added complexity that is introduced to the
guests memory management code to do the page state changes and to deal
with discard faults.

The last versions of the patches do not differ much, I consider the code
to be stable. My question now is how to proceed with the code. I sure
would love to see the code going upstream some day but that depends on
the mm developers as the code adds complexity that needs to be supported.
If the general feeling is that the advantages of this approach do not
warrent for the added complexity this will likely be the last time you
will hear about guest page hinting. 

--
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
