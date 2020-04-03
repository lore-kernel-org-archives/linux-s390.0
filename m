Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404011AbgDCPbB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Apr 2020 11:31:01 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/5] KVM: s390: vsie: fixes and cleanups
Date: Fri,  3 Apr 2020 17:30:45 +0200
Message-Id: <20200403153050.20569-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

Some vsie/gmap fixes and two cleanups/improvements.

Patch #1 fixes an issue reported by Janosch. It was never observed so far=
,
because KVM usually doesn't use a region 1 table for it's guest (unless
memory would be exceeding something like 16 EB, which isn't even supporte=
d
by the HW). Older QEMU+KVM or other hypervisors can trigger this.

Patch #2 fixes a code path that probably was never taken and will most
probably not be taken very often in the future - unless somebody really
messes up the page tables for a guest (or writes a test for it). At some
point, a test case for this would be nice.

Patch #3 fixes a rare possible race. Don't think this is stable material.

Gave it some testing with my limited access to somewhat-fast s390x
machines. Booted a Linux kernel, supplying all possible number of
page table hiearchies.

v1 -> v2:
- "KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks"
-- Fix WARN_ON_ONCE
- "gmap_table_walk() simplifications"
-- Also init "table" directly

David Hildenbrand (5):
  KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks
  KVM: s390: vsie: Fix delivery of addressing exceptions
  KVM: s390: vsie: Fix possible race when shadowing region 3 tables
  KVM: s390: vsie: Move conditional reschedule
  KVM: s390: vsie: gmap_table_walk() simplifications

 arch/s390/kvm/vsie.c |  4 ++--
 arch/s390/mm/gmap.c  | 17 +++++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

--=20
2.25.1
