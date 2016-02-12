From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 17/18] KVM: s390: do not block CPU on dirty logging
Date: Fri, 12 Feb 2016 14:23:01 +0100
Message-ID: <1455283382-62999-18-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

When doing dirty logging on huge guests (e.g.600GB) we sometimes
get rcu stall timeouts with backtraces like

[ 2753.194083] ([<0000000000112fb2>] show_trace+0x12a/0x130)
[ 2753.194092]  [<0000000000113024>] show_stack+0x6c/0xe8
[ 2753.194094]  [<00000000001ee6a8>] rcu_pending+0x358/0xa48
[ 2753.194099]  [<00000000001f20cc>] rcu_check_callbacks+0x84/0x168
[ 2753.194102]  [<0000000000167654>] update_process_times+0x54/0x80
[ 2753.194107]  [<00000000001bdb5c>] tick_sched_handle.isra.16+0x4c/0x60
[ 2753.194113]  [<00000000001bdbd8>] tick_sched_timer+0x68/0x90
[ 2753.194115]  [<0000000000182a88>] __run_hrtimer+0x88/0x1f8
[ 2753.194119]  [<00000000001838ba>] hrtimer_interrupt+0x122/0x2b0
[ 2753.194121]  [<000000000010d034>] do_extint+0x16c/0x170
[ 2753.194123]  [<00000000005e206e>] ext_skip+0x38/0x3e
[ 2753.194129]  [<000000000012157c>] gmap_test_and_clear_dirty+0xcc/0x118
[ 2753.194134] ([<00000000001214ea>] gmap_test_and_clear_dirty+0x3a/0x118)
[ 2753.194137]  [<0000000000132da4>] kvm_vm_ioctl_get_dirty_log+0xd4/0x1b0
[ 2753.194143]  [<000000000012ac12>] kvm_vm_ioctl+0x21a/0x548
[ 2753.194146]  [<00000000002b57f6>] do_vfs_ioctl+0x30e/0x518
[ 2753.194149]  [<00000000002b5a9c>] SyS_ioctl+0x9c/0xb0
[ 2753.194151]  [<00000000005e1ae6>] sysc_tracego+0x14/0x1a
[ 2753.194153]  [<000003ffb75f3972>] 0x3ffb75f3972

We should do a cond_resched in here.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d4bcd86..bb99ca2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -281,6 +281,7 @@ static void kvm_s390_sync_dirty_log(struct kvm *kvm,
 
 		if (gmap_test_and_clear_dirty(address, gmap))
 			mark_page_dirty(kvm, cur_gfn);
+		cond_resched();
 	}
 }
 
-- 
2.3.0
