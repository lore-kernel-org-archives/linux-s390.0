Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727031AbhAMJmW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:22 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 00/14] KVM: s390: Add huge page VSIE support
Date: Wed, 13 Jan 2021 09:40:59 +0000
Message-Id: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

As we finally want to get rid of the nested and hpage s390 KVM module
parameters let's try again to integrate huge page VSIE support.

The following patches have been rebased on 5.11-rc3 and enable us to
start huge page and normal page VSIE guest 3s in a huge page guest 2.

Branch:
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=hlp_vsie


Problems that need to be solved:
	* The VSIE guests crash on migration...
	* I have lost most of my knowledge about this topic and I'm
          currently paging back in
	* Lots of testing


Janosch Frank (14):
  s390/mm: Code cleanups
  s390/mm: Improve locking for huge page backings
  s390/mm: Take locking out of gmap_protect_pte
  s390/mm: split huge pages in GMAP when protecting
  s390/mm: Split huge pages when migrating
  s390/mm: Provide vmaddr to pmd notification
  s390/mm: factor out idte global flush into gmap_idte_global
  s390/mm: Make gmap_read_table EDAT1 compatible
  s390/mm: Make gmap_protect_rmap EDAT1 compatible
  s390/mm: Add simple ptep shadow function
  s390/mm: Add gmap shadowing for large pmds
  s390/mm: Add gmap lock classes
  s390/mm: Pull pmd invalid check in gmap_pmd_op_walk
  KVM: s390: Allow the VSIE to be used with huge pages

 Documentation/virt/kvm/api.rst  |   9 +-
 arch/s390/include/asm/gmap.h    |  31 +-
 arch/s390/include/asm/pgtable.h |   5 +
 arch/s390/kvm/gaccess.c         |  52 +-
 arch/s390/kvm/kvm-s390.c        |  14 +-
 arch/s390/mm/gmap.c             | 917 ++++++++++++++++++++++++--------
 arch/s390/mm/pgtable.c          |  61 ++-
 7 files changed, 819 insertions(+), 270 deletions(-)

-- 
2.27.0
