From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 06 Nov 2015 12:28:25 +0000
Subject: [PATCH] Update s390 system call tables
Message-Id: <1446812905-56448-2-git-send-email-heiko.carstens@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Update the s390 system call tables:

- add all new system calls
- remove extra and incorrect "16" suffix from a couple of system calls
- add a missing "32" suffix to a couple of system calls

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sysdeps/linux-gnu/mksyscallent_s390 |  18 ++--
 sysdeps/linux-gnu/s390/syscalls31.h | 162 +++++++++++++++++++++++++-----------
 sysdeps/linux-gnu/s390/syscalls64.h |  78 +++++++++++++++--
 3 files changed, 194 insertions(+), 64 deletions(-)
 mode change 100644 => 100755 sysdeps/linux-gnu/mksyscallent_s390

diff --git a/sysdeps/linux-gnu/mksyscallent_s390 b/sysdeps/linux-gnu/mksyscallent_s390
old mode 100644
new mode 100755
index 1964d1491c34..4186785f5a8f
--- a/sysdeps/linux-gnu/mksyscallent_s390
+++ b/sysdeps/linux-gnu/mksyscallent_s390
@@ -20,11 +20,10 @@
 #
 # Generate syscall table for s390/s390x
 #
-# Use this on arch/s390/kernel/syscall.s after removing the first few
-# nonsyscall lines.
+# Use this on arch/s390/kernel/syscalls.S
 #
-# cat syscall.s | mksyscallent_s390 > syscalls31.h
-# cat syscall.s | mksyscallent_s390 -x > syscalls64.h
+# mksyscallent_s390 syscalls.S > syscalls31.h
+# mksyscallent_s390 -x syscalls.S > syscalls64.h
 #
 
 use Getopt::Std;
@@ -37,16 +36,19 @@ $opt_x and $s390x = 1;
 while (<>) {
 	chomp;
 
+	next unless /^NI_SYSCALL/ || /^SYSCALL/;
 	if ($s390x==1) {
-		   s/^SYSCALL\([^,]*,//;
+		s/^SYSCALL\(//;
 	} else {
-	           s/^SYSCALL\(//;
+		s/^SYSCALL\([^,]*\,//;
 	}
 
 	s/,.*//;
+	s/^compat_//;
 	s/^sys_//;
-	s/^s390[x]*_//;
-	s/_glue$//;
+	s/^s390_//;
+	s/\).*//;
+	s/id16$/id/;
 	s/^ni_syscall.*/$i/i;
 	$len = 32 - length();
 	$tab = $len / 8;
diff --git a/sysdeps/linux-gnu/s390/syscalls31.h b/sysdeps/linux-gnu/s390/syscalls31.h
index 46f4cf3b443c..e185656974fa 100644
--- a/sysdeps/linux-gnu/s390/syscalls31.h
+++ b/sysdeps/linux-gnu/s390/syscalls31.h
@@ -35,15 +35,15 @@
     "time",    			 /* 13 */
     "mknod",   			 /* 14 */
     "chmod",   			 /* 15 */
-    "lchown16",			 /* 16 */
+    "lchown",			 /* 16 */
     "17",      			 /* 17 */
     "18",      			 /* 18 */
     "lseek",   			 /* 19 */
     "getpid",  			 /* 20 */
     "mount",   			 /* 21 */
-    "oldumount",       		 /* 22 */
-    "setuid16",			 /* 23 */
-    "getuid16",			 /* 24 */
+    "umount",       		 /* 22 */
+    "setuid",  			 /* 23 */
+    "getuid",  			 /* 24 */
     "stime",   			 /* 25 */
     "ptrace",  			 /* 26 */
     "alarm",   			 /* 27 */
@@ -65,11 +65,11 @@
     "times",   			 /* 43 */
     "44",      			 /* 44 */
     "brk",     			 /* 45 */
-    "setgid16",			 /* 46 */
-    "getgid16",			 /* 47 */
+    "setgid",  			 /* 46 */
+    "getgid",  			 /* 47 */
     "signal",  			 /* 48 */
-    "geteuid16",       		 /* 49 */
-    "getegid16",       		 /* 50 */
+    "geteuid", 			 /* 49 */
+    "getegid", 			 /* 50 */
     "acct",    			 /* 51 */
     "umount",  			 /* 52 */
     "53",      			 /* 53 */
@@ -89,18 +89,18 @@
     "sigaction",       		 /* 67 */
     "68",      			 /* 68 */
     "69",      			 /* 69 */
-    "setreuid16",      		 /* 70 */
-    "setregid16",      		 /* 71 */
+    "setreuid",			 /* 70 */
+    "setregid",			 /* 71 */
     "sigsuspend",      		 /* 72 */
     "sigpending",      		 /* 73 */
     "sethostname",     		 /* 74 */
     "setrlimit",       		 /* 75 */
-    "old_getrlimit",   		 /* 76 */
+    "getrlimit",   		 /* 76 */
     "getrusage",       		 /* 77 */
     "gettimeofday",    		 /* 78 */
     "settimeofday",    		 /* 79 */
-    "getgroups16",     		 /* 80 */
-    "setgroups16",     		 /* 81 */
+    "getgroups",     		 /* 80 */
+    "setgroups",     		 /* 81 */
     "82",      			 /* 82 */
     "symlink", 			 /* 83 */
     "84",      			 /* 84 */
@@ -108,13 +108,13 @@
     "uselib",  			 /* 86 */
     "swapon",  			 /* 87 */
     "reboot",  			 /* 88 */
-    "89",      			 /* 89 */
-    "old_mmap",			 /* 90 */
+    "readdir",     		 /* 89 */
+    "mmap",			 /* 90 */
     "munmap",  			 /* 91 */
     "truncate",			 /* 92 */
     "ftruncate",       		 /* 93 */
     "fchmod",  			 /* 94 */
-    "fchown16",			 /* 95 */
+    "fchown",			 /* 95 */
     "getpriority",     		 /* 96 */
     "setpriority",     		 /* 97 */
     "98",      			 /* 98 */
@@ -157,11 +157,11 @@
     "sysfs",   			 /* 135 */
     "personality",     		 /* 136 */
     "137",     			 /* 137 */
-    "setfsuid16",      		 /* 138 */
-    "setfsgid16",      		 /* 139 */
-    "llseek",  			 /* 140 */
+    "setfsuid",			 /* 138 */
+    "setfsgid",			 /* 139 */
+    "_llseek", 			 /* 140 */
     "getdents",			 /* 141 */
-    "select",  			 /* 142 */
+    "_newselect", 		 /* 142 */
     "flock",   			 /* 143 */
     "msync",   			 /* 144 */
     "readv",   			 /* 145 */
@@ -183,14 +183,14 @@
     "sched_rr_get_interval",   	 /* 161 */
     "nanosleep",       		 /* 162 */
     "mremap",  			 /* 163 */
-    "setresuid16",     		 /* 164 */
-    "getresuid16",     		 /* 165 */
+    "setresuid",       		 /* 164 */
+    "getresuid",       		 /* 165 */
     "166",     			 /* 166 */
     "167",     			 /* 167 */
     "poll",    			 /* 168 */
-    "nfsservctl",      		 /* 169 */
-    "setresgid16",     		 /* 170 */
-    "getresgid16",     		 /* 171 */
+    "169",     			 /* 169 */
+    "setresgid",       		 /* 170 */
+    "getresgid",       		 /* 171 */
     "prctl",   			 /* 172 */
     "rt_sigreturn",    		 /* 173 */
     "rt_sigaction",    		 /* 174 */
@@ -201,7 +201,7 @@
     "rt_sigsuspend",   		 /* 179 */
     "pread64", 			 /* 180 */
     "pwrite64",			 /* 181 */
-    "chown16", 			 /* 182 */
+    "chown", 			 /* 182 */
     "getcwd",  			 /* 183 */
     "capget",  			 /* 184 */
     "capset",  			 /* 185 */
@@ -217,25 +217,25 @@
     "stat64",  			 /* 195 */
     "lstat64", 			 /* 196 */
     "fstat64", 			 /* 197 */
-    "lchown",  			 /* 198 */
-    "getuid",  			 /* 199 */
-    "getgid",  			 /* 200 */
-    "geteuid", 			 /* 201 */
-    "getegid", 			 /* 202 */
-    "setreuid",			 /* 203 */
-    "setregid",			 /* 204 */
-    "getgroups",       		 /* 205 */
-    "setgroups",       		 /* 206 */
-    "fchown",  			 /* 207 */
-    "setresuid",       		 /* 208 */
-    "getresuid",       		 /* 209 */
-    "setresgid",       		 /* 210 */
-    "getresgid",       		 /* 211 */
-    "chown",   			 /* 212 */
-    "setuid",  			 /* 213 */
-    "setgid",  			 /* 214 */
-    "setfsuid",			 /* 215 */
-    "setfsgid",			 /* 216 */
+    "lchown32", 		 /* 198 */
+    "getuid32",			 /* 199 */
+    "getgid32",  		 /* 200 */
+    "geteuid32", 		 /* 201 */
+    "getegid32", 		 /* 202 */
+    "setreuid32",		 /* 203 */
+    "setregid32",		 /* 204 */
+    "getgroups32",       	 /* 205 */
+    "setgroups32",       	 /* 206 */
+    "fchown32",  		 /* 207 */
+    "setresuid32",       	 /* 208 */
+    "getresuid32",       	 /* 209 */
+    "setresgid32",       	 /* 210 */
+    "getresgid32",       	 /* 211 */
+    "chown32",   		 /* 212 */
+    "setuid32",  		 /* 213 */
+    "setgid32",  		 /* 214 */
+    "setfsuid32",		 /* 215 */
+    "setfsgid32",		 /* 216 */
     "pivot_root",      		 /* 217 */
     "mincore", 			 /* 218 */
     "madvise", 			 /* 219 */
@@ -287,9 +287,9 @@
     "statfs64",			 /* 265 */
     "fstatfs64",       		 /* 266 */
     "remap_file_pages",		 /* 267 */
-    "268",     			 /* 268 */
-    "269",     			 /* 269 */
-    "270",     			 /* 270 */
+    "mbind",   			 /* 268 */
+    "get_mempolicy",   		 /* 269 */
+    "set_mempolicy",   		 /* 270 */
     "mq_open", 			 /* 271 */
     "mq_unlink",       		 /* 272 */
     "mq_timedsend",    		 /* 273 */
@@ -306,7 +306,7 @@
     "inotify_init",    		 /* 284 */
     "inotify_add_watch",       	 /* 285 */
     "inotify_rm_watch",		 /* 286 */
-    "287",     			 /* 287 */
+    "migrate_pages",   		 /* 287 */
     "openat",  			 /* 288 */
     "mkdirat", 			 /* 289 */
     "mknodat", 			 /* 290 */
@@ -329,3 +329,67 @@
     "sync_file_range", 		 /* 307 */
     "tee",     			 /* 308 */
     "vmsplice",			 /* 309 */
+    "move_pages",      		 /* 310 */
+    "getcpu",  			 /* 311 */
+    "epoll_pwait",     		 /* 312 */
+    "utimes",  			 /* 313 */
+    "fallocate",       		 /* 314 */
+    "utimensat",       		 /* 315 */
+    "signalfd",			 /* 316 */
+    "317",     			 /* 317 */
+    "eventfd", 			 /* 318 */
+    "timerfd_create",  		 /* 319 */
+    "timerfd_settime", 		 /* 320 */
+    "timerfd_gettime", 		 /* 321 */
+    "signalfd4",       		 /* 322 */
+    "eventfd2",			 /* 323 */
+    "inotify_init1",   		 /* 324 */
+    "pipe2",   			 /* 325 */
+    "dup3",    			 /* 326 */
+    "epoll_create1",   		 /* 327 */
+    "preadv",  			 /* 328 */
+    "pwritev", 			 /* 329 */
+    "rt_tgsigqueueinfo",       	 /* 330 */
+    "perf_event_open", 		 /* 331 */
+    "fanotify_init",   		 /* 332 */
+    "fanotify_mark",   		 /* 333 */
+    "prlimit64",       		 /* 334 */
+    "name_to_handle_at",       	 /* 335 */
+    "open_by_handle_at",       	 /* 336 */
+    "clock_adjtime",   		 /* 337 */
+    "syncfs",  			 /* 338 */
+    "setns",   			 /* 339 */
+    "process_vm_readv",		 /* 340 */
+    "process_vm_writev",       	 /* 341 */
+    "s390_runtime_instr",   	 /* 342 */
+    "kcmp",    			 /* 343 */
+    "finit_module",    		 /* 344 */
+    "sched_setattr",   		 /* 345 */
+    "sched_getattr",   		 /* 346 */
+    "renameat2",       		 /* 347 */
+    "seccomp", 			 /* 348 */
+    "getrandom",       		 /* 349 */
+    "memfd_create",    		 /* 350 */
+    "bpf",     			 /* 351 */
+    "s390_pci_mmio_write",  	 /* 352 */
+    "s390_pci_mmio_read",   	 /* 353 */
+    "execveat",			 /* 354 */
+    "userfaultfd",     		 /* 355 */
+    "membarrier",      		 /* 356 */
+    "recvmmsg",			 /* 357 */
+    "sendmmsg",			 /* 358 */
+    "socket",  			 /* 359 */
+    "socketpair",      		 /* 360 */
+    "bind",    			 /* 361 */
+    "connect", 			 /* 362 */
+    "listen",  			 /* 363 */
+    "accept4", 			 /* 364 */
+    "getsockopt",      		 /* 365 */
+    "setsockopt",      		 /* 366 */
+    "getsockname",     		 /* 367 */
+    "getpeername",     		 /* 368 */
+    "sendto",  			 /* 369 */
+    "sendmsg", 			 /* 370 */
+    "recvfrom",			 /* 371 */
+    "recvmsg", 			 /* 372 */
+    "shutdown",			 /* 373 */
diff --git a/sysdeps/linux-gnu/s390/syscalls64.h b/sysdeps/linux-gnu/s390/syscalls64.h
index f2ec7f4fa639..939b996daa1e 100644
--- a/sysdeps/linux-gnu/s390/syscalls64.h
+++ b/sysdeps/linux-gnu/s390/syscalls64.h
@@ -41,7 +41,7 @@
     "lseek",   			 /* 19 */
     "getpid",  			 /* 20 */
     "mount",   			 /* 21 */
-    "oldumount",       		 /* 22 */
+    "umount",       		 /* 22 */
     "23",      			 /* 23 */
     "24",      			 /* 24 */
     "25",      			 /* 25 */
@@ -109,7 +109,7 @@
     "swapon",  			 /* 87 */
     "reboot",  			 /* 88 */
     "89",      			 /* 89 */
-    "old_mmap",			 /* 90 */
+    "mmap",			 /* 90 */
     "munmap",  			 /* 91 */
     "truncate",			 /* 92 */
     "ftruncate",       		 /* 93 */
@@ -188,7 +188,7 @@
     "166",     			 /* 166 */
     "167",     			 /* 167 */
     "poll",    			 /* 168 */
-    "nfsservctl",      		 /* 169 */
+    "169",     			 /* 169 */
     "170",     			 /* 170 */
     "171",     			 /* 171 */
     "prctl",   			 /* 172 */
@@ -287,9 +287,9 @@
     "statfs64",			 /* 265 */
     "fstatfs64",       		 /* 266 */
     "remap_file_pages",		 /* 267 */
-    "268",     			 /* 268 */
-    "269",     			 /* 269 */
-    "270",     			 /* 270 */
+    "mbind",   			 /* 268 */
+    "get_mempolicy",   		 /* 269 */
+    "set_mempolicy",   		 /* 270 */
     "mq_open", 			 /* 271 */
     "mq_unlink",       		 /* 272 */
     "mq_timedsend",    		 /* 273 */
@@ -306,7 +306,7 @@
     "inotify_init",    		 /* 284 */
     "inotify_add_watch",       	 /* 285 */
     "inotify_rm_watch",		 /* 286 */
-    "287",     			 /* 287 */
+    "migrate_pages",   		 /* 287 */
     "openat",  			 /* 288 */
     "mkdirat", 			 /* 289 */
     "mknodat", 			 /* 290 */
@@ -329,3 +329,67 @@
     "sync_file_range", 		 /* 307 */
     "tee",     			 /* 308 */
     "vmsplice",			 /* 309 */
+    "move_pages",      		 /* 310 */
+    "getcpu",  			 /* 311 */
+    "epoll_pwait",     		 /* 312 */
+    "utimes",  			 /* 313 */
+    "fallocate",       		 /* 314 */
+    "utimensat",       		 /* 315 */
+    "signalfd",			 /* 316 */
+    "317",     			 /* 317 */
+    "eventfd", 			 /* 318 */
+    "timerfd_create",  		 /* 319 */
+    "timerfd_settime", 		 /* 320 */
+    "timerfd_gettime", 		 /* 321 */
+    "signalfd4",       		 /* 322 */
+    "eventfd2",			 /* 323 */
+    "inotify_init1",   		 /* 324 */
+    "pipe2",   			 /* 325 */
+    "dup3",    			 /* 326 */
+    "epoll_create1",   		 /* 327 */
+    "preadv",  			 /* 328 */
+    "pwritev", 			 /* 329 */
+    "rt_tgsigqueueinfo",       	 /* 330 */
+    "perf_event_open", 		 /* 331 */
+    "fanotify_init",   		 /* 332 */
+    "fanotify_mark",   		 /* 333 */
+    "prlimit64",       		 /* 334 */
+    "name_to_handle_at",       	 /* 335 */
+    "open_by_handle_at",       	 /* 336 */
+    "clock_adjtime",   		 /* 337 */
+    "syncfs",  			 /* 338 */
+    "setns",   			 /* 339 */
+    "process_vm_readv",		 /* 340 */
+    "process_vm_writev",       	 /* 341 */
+    "s390_runtime_instr", 	 /* 342 */
+    "kcmp",    			 /* 343 */
+    "finit_module",    		 /* 344 */
+    "sched_setattr",   		 /* 345 */
+    "sched_getattr",   		 /* 346 */
+    "renameat2",       		 /* 347 */
+    "seccomp", 			 /* 348 */
+    "getrandom",       		 /* 349 */
+    "memfd_create",    		 /* 350 */
+    "bpf",     			 /* 351 */
+    "s390_pci_mmio_write", 	 /* 352 */
+    "s390_pci_mmio_read",  	 /* 353 */
+    "execveat",			 /* 354 */
+    "userfaultfd",     		 /* 355 */
+    "membarrier",      		 /* 356 */
+    "recvmmsg",			 /* 357 */
+    "sendmmsg",			 /* 358 */
+    "socket",  			 /* 359 */
+    "socketpair",      		 /* 360 */
+    "bind",    			 /* 361 */
+    "connect", 			 /* 362 */
+    "listen",  			 /* 363 */
+    "accept4", 			 /* 364 */
+    "getsockopt",      		 /* 365 */
+    "setsockopt",      		 /* 366 */
+    "getsockname",     		 /* 367 */
+    "getpeername",     		 /* 368 */
+    "sendto",  			 /* 369 */
+    "sendmsg", 			 /* 370 */
+    "recvfrom",			 /* 371 */
+    "recvmsg", 			 /* 372 */
+    "shutdown",			 /* 373 */
-- 
2.3.9
