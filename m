Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405552AbgFYPHl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 11:07:41 -0400
From: Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v2 0/2] s390: Add API Docs for DIAGNOSE 0x318 and fix rst
Date: Thu, 25 Jun 2020 11:07:22 -0400
Message-Id: <20200625150724.10021-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

Changelog:

    v2

    • Reworded patch 1 doc text

    • Added "Introduced in commit..." for rst fix patch

    • Added r-b's (thanks!)

Adds documentation for the s390-specfic DIAGNOSE 0x318 instruction, as
well as fixes some missing rst symbols for the neighboring entries.

Suggested-by: Cornelia Huck <cohuck@redhat.com>

Collin Walling (2):
  docs: kvm: add documentation for KVM_CAP_S390_DIAG318
  docs: kvm: fix rst formatting

 Documentation/virt/kvm/api.rst | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

-- 
2.26.2
