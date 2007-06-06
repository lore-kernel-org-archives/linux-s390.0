Return-Path: <linux-kernel-owner+w=401wt.eu-S935867AbXFFVdh@vger.kernel.org>
Subject: [RFC] [Patch 0/4] lock contention tracking slimmed down
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 23:33:22 +0200
Message-Id: <1181165602.7133.18.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We can save many lines of code in the lock contention tracking patches
by using some common code which implements statistics in a generic way.

Data is still gathered per cpu; output goes to debugfs files. Several
ideas that went into the lock contention tracking patches can be found
in the statistics infrastructure as well.

Please see the last patch for details and for some sample output.
The first three patches just prepare the statistics infrastructure
for this new use case.

Feel free to pick at any rough edge you want me to smooth out,
if you are interested in this approach.

[Patch 1/4] statistics: no include hell for users
[Patch 2/4] statistics: cleanups
[Patch 3/4] statistics: sets of statistics in single file
[Patch 4/4] lock contention tracking slimmed down

Please mind that the patches are against 2.6.22-rc3-mm1. They don't apply
against 2.6.22-rc4-mm1. (The statistics library functions have been dropped,
because a couple more users would be nice.)

Ah, and you might need to add CONFIG_STATISTICS to Kconfig of the
architecture of your choice (see s390).

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
