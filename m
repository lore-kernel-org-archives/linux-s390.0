From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v1 RFC 0/6] KVM: s390: cpu model implementation
Date: Tue, 13 May 2014 16:58:28 +0200
Message-ID: <1399993114-15333-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mimu@linux.vnet.ibm.com, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

The proposed patch set implements S390 cpu model support in kvm. A cpu
model is defined by a triple comprizing the cpu type , the cpu facility
set and instruction blocking control. A consumer requests a feasible
combination of that that triple before vcpu creation. All subsequently
created vcpu's will use this cpu configuration. 

Michael Mueller (6):
  s390/sclp: add sclp_get_ibc function
  KVM: s390: split SIE state guest prefix field
  KVM: s390: use facilities and cpu_id per KVM
  KVM: s390: add ibc api
  KVM: s390: initial implementation of soft facilities
  KVM: s390: add cpu model support

 arch/s390/include/asm/kvm_host.h |  13 +-
 arch/s390/include/asm/sclp.h     |   1 +
 arch/s390/include/uapi/asm/kvm.h |  23 ++++
 arch/s390/kvm/Makefile           |   2 +-
 arch/s390/kvm/diag.c             |   2 +-
 arch/s390/kvm/gaccess.c          |   4 +-
 arch/s390/kvm/gaccess.h          |   8 +-
 arch/s390/kvm/ibc.c              |  29 +++++
 arch/s390/kvm/kvm-s390.c         | 263 +++++++++++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.h         |  43 ++++++-
 arch/s390/kvm/priv.c             |  16 ++-
 arch/s390/kvm/softfac.c          |  38 ++++++
 drivers/s390/char/sclp_early.c   |  12 +-
 13 files changed, 397 insertions(+), 57 deletions(-)
 create mode 100644 arch/s390/kvm/ibc.c
 create mode 100644 arch/s390/kvm/softfac.c

-- 
1.8.3.1
