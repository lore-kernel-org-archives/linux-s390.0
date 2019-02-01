From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1] KVM: s390: vsie: fix Do the CRYCB validation first
Date: Fri,  1 Feb 2019 10:52:04 +0100
Message-ID: <1549014725-28216-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: david@redhat.com, linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is a BUGFIX

Surely must be CC stable.



Pierre Morel (1):
  KVM: s390: vsie: fix Do the CRYCB validation first

 arch/s390/kvm/vsie.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.7.4
