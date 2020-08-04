Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726305AbgHDJgc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Aug 2020 05:36:32 -0400
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH RFC v2] s390: convert to GENERIC_VDSO
Date: Tue,  4 Aug 2020 11:36:04 +0200
Message-Id: <20200804093607.69841-1-svens@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com

as discussed here's the second version of the generic vdso patch for s390.

Changes in v2:
- added patch from Thomas that adds vdso_update_begin()/vdso_update_end()
- changed the s390 code to use the vdso update functions
- changed the name of the architecture specific data to 'arch_data'
