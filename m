Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH RFC v3] s390: convert to GENERIC_VDSO
Date: Tue,  4 Aug 2020 17:01:21 +0200
Message-Id: <20200804150124.41692-1-svens@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com

here's the third version of the generic vdso patchset for s390.

Changes in v3;
- update the architecture specific data patch to the correct one.

Changes in v2:
- added patch from Thomas that adds vdso_update_begin()/vdso_update_end()
- changed the s390 code to use the vdso update functions
- changed the name of the architecture specific data to 'arch_data'
