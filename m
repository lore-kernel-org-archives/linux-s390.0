Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729705AbgC3MTm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 08:19:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UCAgmM056840
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 08:19:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3022nm8edy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 08:19:41 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 30 Mar 2020 13:19:33 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: Fix for 5.7 merge window
Date: Mon, 30 Mar 2020 14:19:33 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200330121934.28143-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>

Paolo,

The following changes since commit f3dd18d444c757840920434e62809b6104081b06:

  KVM: s390: mark sie block as 512 byte aligned (2020-03-23 18:30:33 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.7-3

for you to fetch changes up to 7a2653612bb6f18fb236c5b0c4d28f7b459bf7c2:

  s390/gmap: return proper error code on ksm unsharing (2020-03-27 06:42:53 -0400)

----------------------------------------------------------------
KVM: s390: Fix for error codes

- return the proper error to userspace when a signal interrupts the
  KSM unsharing operation

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/gmap: return proper error code on ksm unsharing

 Documentation/virt/kvm/api.rst | 6 ++++++
 arch/s390/mm/gmap.c            | 9 +++++----
 2 files changed, 11 insertions(+), 4 deletions(-)
