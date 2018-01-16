From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 0/2] KVM: s390: vsie: protect from VCPUS modifying the SCB
Date: Tue, 16 Jan 2018 18:15:24 +0100
Message-ID: <20180116171526.12343-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

As the (nested) SCB is just guest memory, other VCPUs can try to modify it
while we are building our shadow SCB.

Let's avoid unpredictable behavior by adding some READ_ONCE and refactoring
unpinning of satellite control blocks.

Compile tested only for now.

David Hildenbrand (2):
  KVM: s390 vsie: use READ_ONCE to access some SCB fields
  KVM: s390: vsie: store guest addresses of satellite blocks in
    vsie_page

 arch/s390/kvm/vsie.c | 87 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 34 deletions(-)

-- 
2.14.3
