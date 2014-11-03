From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 0/1] KVM: s390: fix for 3.18-rc
Date: Mon,  3 Nov 2014 12:29:51 +0100
Message-ID: <1415014192-19194-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

one fix for a build warning regression introduced during the merge
window with some virtio changes. Rusty wanted me to send this through
the kvm/s390 tree. Branch is against 3.18-rc3.

The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:

  Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-20141103

for you to fetch changes up to f7ceb0dfec43d2d4e2373d02968f8fb58c6858f7:

  KVM: s390: virtio_ccw: remove unused variable (2014-11-03 10:43:00 +0100)

----------------------------------------------------------------
Fix a build warning in virtio-ccw introduced during the merge window.

----------------------------------------------------------------

Sebastian Ott (1):
  KVM: s390: virtio_ccw: remove unused variable

 drivers/s390/kvm/virtio_ccw.c |    1 -
 1 file changed, 1 deletion(-)

-- 
1.7.9.5
