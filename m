Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728845AbgBQOxI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 09:53:08 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] example changes
Date: Mon, 17 Feb 2020 09:53:00 -0500
Message-Id: <20200217145302.19085-1-borntraeger@de.ibm.com>
In-Reply-To: <c77dbb1b-0f4b-e40a-52a4-7110aec75e32@redhat.com>
References: <c77dbb1b-0f4b-e40a-52a4-7110aec75e32@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: david@redhat.com
Cc: Ulrich.Weigand@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

I also need to rename the ioctls and do more testing,
but this is probably what you want?

Christian Borntraeger (2):
  lock changes
  merge vm/cpu create

 arch/s390/kvm/intercept.c |  6 +--
 arch/s390/kvm/interrupt.c | 35 ++++++++++-------
 arch/s390/kvm/kvm-s390.c  | 83 +++++++++++++++++++++++++--------------
 arch/s390/kvm/kvm-s390.h  | 18 ++++++---
 arch/s390/kvm/priv.c      |  4 +-
 5 files changed, 92 insertions(+), 54 deletions(-)

-- 
2.25.0
