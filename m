From: David Hildenbrand <david@redhat.com>
Date: Wed, 02 May 2018 11:06:52 +0000
Subject: [PATCH v1 0/2] KVM: s390: vsie: fix < 8k check for the itdba
Message-Id: <20180502110655.31811-1-david@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Fix the bug reported by Dan and refactore it so also I can understand
easily again what the code I've written does :)

David Hildenbrand (2):
  KVM: s390: vsie: fix < 8k check for the itdba
  KVM: s390: vsie: simplify < 8k address checks

 arch/s390/kvm/vsie.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.14.3
