From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 0/3] perf fix test case 14
Date: Tue,  6 Jun 2017 16:31:53 +0200
Message-ID: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

I have taken the following commits from Jiri Olsa's
branch perf/attr_test to work on a fix.

Commit-id
070b9644981e perf tests attr: Do not store failed events
c9666c26ead0 perf tests attr: Make compare_data global
10eb9496d1c3 perf tests attr: Fix compare logic
4ba31b633fab perf tests attr: Add 1s for exclude_kernel ..
ede0b0a2e007 perf tests attr: Fix no-delay test

I have then added 3 new fixes

Thomas Richter (3):
  perf: fix incorrect sample_type value for perf stat tests
  perf: fix exit code check in test case execution
  perf: fix perf test case 14

I can test these changes only on s390.
With these changes some test-stat-xxx tests run fine.

How to handle test cases currently unsupported on a platform?
For example  test-stat-default issues a setup for 
PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
which is not supported on s390. The perf_event_open()
system call fails and no event-00-07--1 file is created.

The compare of the test result then fails because attr.py
has nothing to check against.
We could test if an event file exists and if not report an
unsupported test. Is this a good idea?
Any other proposals?

Right now I have commented out these subtests in my environment.

-- 
2.9.3
