Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391054AbgFXUWj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jun 2020 16:22:39 -0400
From: Collin Walling <walling@linux.ibm.com>
Subject: [PATCH 0/2] s390: Add API Docs for DIAGNOSE 0x318 and fix rst
Date: Wed, 24 Jun 2020 16:21:58 -0400
Message-Id: <20200624202200.28209-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

Adds documentation for the s390-specfic DIAGNOSE 0x318 instruction, as
well as fixes some missing rst symbols for the neighboring entries.

Suggested-by: Cornelia Huck <cohuck@redhat.com>

Collin Walling (2):
  docs: kvm: add documentation for KVM_CAP_S390_DIAG318
  docs: kvm: fix rst formatting

 Documentation/virt/kvm/api.rst | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

-- 
2.26.2
