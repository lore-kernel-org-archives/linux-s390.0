From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 0/3] perf fix test case 14
Date: Wed, 7 Jun 2017 13:17:58 +0200
Message-ID: <20170607111758.GB6356@krava>
References: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 06, 2017 at 04:31:53PM +0200, Thomas Richter wrote:
> I have taken the following commits from Jiri Olsa's
> branch perf/attr_test to work on a fix.
> 
> Commit-id
> 070b9644981e perf tests attr: Do not store failed events
> c9666c26ead0 perf tests attr: Make compare_data global
> 10eb9496d1c3 perf tests attr: Fix compare logic
> 4ba31b633fab perf tests attr: Add 1s for exclude_kernel ..
> ede0b0a2e007 perf tests attr: Fix no-delay test
> 
> I have then added 3 new fixes
> 
> Thomas Richter (3):
>   perf: fix incorrect sample_type value for perf stat tests
>   perf: fix exit code check in test case execution
>   perf: fix perf test case 14

those looks fine.. any chance you could take over
those other 5 from me and post all together?

> 
> I can test these changes only on s390.
> With these changes some test-stat-xxx tests run fine.
> 
> How to handle test cases currently unsupported on a platform?
> For example  test-stat-default issues a setup for 
> PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
> which is not supported on s390. The perf_event_open()
> system call fails and no event-00-07--1 file is created.
> 
> The compare of the test result then fails because attr.py
> has nothing to check against.
> We could test if an event file exists and if not report an
> unsupported test. Is this a good idea?
> Any other proposals?

or maybe add list of supported or not supported archs
to test's [config] section?

thanks,
jirka
