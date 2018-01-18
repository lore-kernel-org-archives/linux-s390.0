From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 18 Jan 2018 06:17:09 +0000
Subject: [strace PATCH 12/12] Update NEWS
Message-Id: <20180118061709.GA29341@asgard.redhat.com>
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

---
 NEWS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/NEWS b/NEWS
index 550fc38..8b98a40 100644
--- a/NEWS
+++ b/NEWS
@@ -13,7 +13,9 @@ Noteworthy changes in release ?.?? (????-??-??)
     BPF_MAP_GET_NEXT_ID, BPF_PROG_GET_FD_BY_ID, BPF_MAP_GET_FD_BY_ID,
     and BPF_OBJ_GET_INFO_BY_FD commands of bpf syscall.
   * Enhanced decoding of get_thread_area, memfd_create, modify_ldt,
-    perf_event_open, reboot, set_thread_area, and shmget syscalls.
+    perf_event_open, reboot, s390_guarded_storage, s390_pcio_mmio_read,
+    s390_pci_mmio_write, s390_runtime_instr, s390_sthyi, set_thread_area,
+    and shmget syscalls.
   * Implemented decoding of KVM_* ioctl commands.
   * Enhanced decoding of getsockopt and setsockopt syscalls for SOL_NETLINK
     level.
-- 
2.1.4
