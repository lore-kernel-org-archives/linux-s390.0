Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727009AbfFFU2l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jun 2019 16:28:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56KQuNb084025
        for <linux-s390@vger.kernel.org>; Thu, 6 Jun 2019 16:28:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sy8e9bk59-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Jun 2019 16:28:39 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 6 Jun 2019 21:28:37 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 0/9] s390: vfio-ccw code rework
Date: Thu,  6 Jun 2019 22:28:22 +0200
Message-Id: <20190606202831.44135-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Now that we've gotten a lot of other series either merged or
pending for the next merge window, I'd like to revisit some
code simplification that I started many moons ago.

In that first series, a couple of fixes got merged into 4.20,
a couple more got some "seems okay" acks/reviews, and the rest
were nearly forgotten about.  I dusted them off and did quite a
bit of rework to make things a little more sequential and
providing a better narrative (I think) based on the lessons we
learned in my earlier changes.  Because of this rework, the
acks/reviews on the first version didn't really translate to the
code that exists here (patch 1 being the closest exception), so
I didn't apply any of them here.  The end result is mostly the
same as before, but now looks like this:

Patch summary:
1:   Squash duplicate code
2-4: Remove duplicate code in CCW processor
5-7: Remove one layer of nested arrays
8-9: Combine direct/indirect addressing CCW processors

Using 5.2.0-rc3 as a base plus the vfio-ccw branch of recent fixes,
we shrink the code quite a bit (8.7% according to the bloat-o-meter),
and we remove one set of mallocs/frees on the I/O path by removing
one layer of the nested arrays.  There are no functional/behavioral
changes with this series; all the tests that I would run previously
continue to pass/fail as they today.

Changelog:
 v1/RFC->v2:
  - [Eric] Dropped first two patches, as they have been merged
  - [Eric] Shuffling of patches for readability/understandability
  - [Halil] Actually added meaningful comments/commit messages
    in the patches
 v1/RFC: https://patchwork.kernel.org/cover/10675251/

Eric Farman (9):
  s390/cio: Squash cp_free() and cp_unpin_free()
  s390/cio: Refactor the routine that handles TIC CCWs
  s390/cio: Generalize the TIC handler
  s390/cio: Use generalized CCW handler in cp_init()
  vfio-ccw: Rearrange pfn_array and pfn_array_table arrays
  vfio-ccw: Adjust the first IDAW outside of the nested loops
  vfio-ccw: Remove pfn_array_table
  vfio-ccw: Rearrange IDAL allocation in direct CCW
  s390/cio: Combine direct and indirect CCW paths

 drivers/s390/cio/vfio_ccw_cp.c | 313 +++++++++++----------------------
 1 file changed, 102 insertions(+), 211 deletions(-)

-- 
2.17.1
