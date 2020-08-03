Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH RFC] s390: convert to GENERIC_VDSO
Date: Mon,  3 Aug 2020 07:56:43 +0200
Message-Id: <20200803055645.79042-1-svens@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org

these two patches convert the s390 architecture to generic VDSO. The
first patch adds an option to add architecture specific information
to struct vdso_data. We need that information because the old s390
assembly code had a steering capability, which steered the clock slowly.
To emulate that behaviour we need to add the steering offset to struct
vdso_data.

This requirements results in the need for a seqlock kind of lock, which is
implemented open-coded in __arch_get_hw_counter(). open-coded because we
cannot include seqlock.h in userspace code (and using the normal seqlock
interface on kernel side might result in people changing struct seqlock,
but not changing the vdso userspace part), therefore both sides are
open-coded. I think in theory we could also call vdso_write_begin()/
vdso_write_end(). What do you think?

If there are no objections we would carry both patches through the s390 tree.

Thanks
Sven
