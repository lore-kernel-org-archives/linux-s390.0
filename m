From: Alexander Graf <agraf@suse.de>
Subject: [PATCH 3/3] S390: Export kvm_virtio.h
Date: Tue, 24 Aug 2010 15:48:52 +0200
Message-ID: <1282657732-20902-3-git-send-email-agraf@suse.de>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1282657732-20902-1-git-send-email-agraf@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: virtualization@lists.linux-foundation.org
Cc: linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, borntraeger@de.ibm.com, Carsten Otte <carsteno@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

As suggested by Christian, we should expose headers to user space with
information that might be valuable there. The s390 virtio interface is
one of those cases. It defines an ABI between hypervisor and guest, so
it should be exposed to user space.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/s390/include/asm/Kbuild |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 63a2341..ee7937d 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -8,6 +8,7 @@ header-y += ucontext.h
 header-y += vtoc.h
 header-y += zcrypt.h
 header-y += chsc.h
+header-y += kvm_virtio.h
 
 unifdef-y += cmb.h
 unifdef-y += debug.h
-- 
1.6.0.2
