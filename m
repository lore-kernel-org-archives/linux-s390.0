From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 2/5] tools include asm-generic: Grab errno.h and errno-base.h
Date: Tue, 16 Jan 2018 10:46:28 +0100
Message-ID: <1516095991-16337-3-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1516095991-16337-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <1516095991-16337-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

This is a pre-req to generate an architecture specific mapping of
errno numbers to their names.  This errno mapping can be used by
perf trace to support cross-architecture trace reports and to
get rid of the audit-libs dependency.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
---
 tools/include/uapi/asm-generic/errno-base.h |  40 +++++++++
 tools/include/uapi/asm-generic/errno.h      | 123 ++++++++++++++++++++++++++++
 tools/perf/check-headers.sh                 |   2 +
 3 files changed, 165 insertions(+)
 create mode 100644 tools/include/uapi/asm-generic/errno-base.h
 create mode 100644 tools/include/uapi/asm-generic/errno.h

diff --git a/tools/include/uapi/asm-generic/errno-base.h b/tools/include/uapi/asm-generic/errno-base.h
new file mode 100644
index 0000000..9653140
--- /dev/null
+++ b/tools/include/uapi/asm-generic/errno-base.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_GENERIC_ERRNO_BASE_H
+#define _ASM_GENERIC_ERRNO_BASE_H
+
+#define	EPERM		 1	/* Operation not permitted */
+#define	ENOENT		 2	/* No such file or directory */
+#define	ESRCH		 3	/* No such process */
+#define	EINTR		 4	/* Interrupted system call */
+#define	EIO		 5	/* I/O error */
+#define	ENXIO		 6	/* No such device or address */
+#define	E2BIG		 7	/* Argument list too long */
+#define	ENOEXEC		 8	/* Exec format error */
+#define	EBADF		 9	/* Bad file number */
+#define	ECHILD		10	/* No child processes */
+#define	EAGAIN		11	/* Try again */
+#define	ENOMEM		12	/* Out of memory */
+#define	EACCES		13	/* Permission denied */
+#define	EFAULT		14	/* Bad address */
+#define	ENOTBLK		15	/* Block device required */
+#define	EBUSY		16	/* Device or resource busy */
+#define	EEXIST		17	/* File exists */
+#define	EXDEV		18	/* Cross-device link */
+#define	ENODEV		19	/* No such device */
+#define	ENOTDIR		20	/* Not a directory */
+#define	EISDIR		21	/* Is a directory */
+#define	EINVAL		22	/* Invalid argument */
+#define	ENFILE		23	/* File table overflow */
+#define	EMFILE		24	/* Too many open files */
+#define	ENOTTY		25	/* Not a typewriter */
+#define	ETXTBSY		26	/* Text file busy */
+#define	EFBIG		27	/* File too large */
+#define	ENOSPC		28	/* No space left on device */
+#define	ESPIPE		29	/* Illegal seek */
+#define	EROFS		30	/* Read-only file system */
+#define	EMLINK		31	/* Too many links */
+#define	EPIPE		32	/* Broken pipe */
+#define	EDOM		33	/* Math argument out of domain of func */
+#define	ERANGE		34	/* Math result not representable */
+
+#endif
diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
new file mode 100644
index 0000000..cf9c51a
--- /dev/null
+++ b/tools/include/uapi/asm-generic/errno.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_GENERIC_ERRNO_H
+#define _ASM_GENERIC_ERRNO_H
+
+#include <asm-generic/errno-base.h>
+
+#define	EDEADLK		35	/* Resource deadlock would occur */
+#define	ENAMETOOLONG	36	/* File name too long */
+#define	ENOLCK		37	/* No record locks available */
+
+/*
+ * This error code is special: arch syscall entry code will return
+ * -ENOSYS if users try to call a syscall that doesn't exist.  To keep
+ * failures of syscalls that really do exist distinguishable from
+ * failures due to attempts to use a nonexistent syscall, syscall
+ * implementations should refrain from returning -ENOSYS.
+ */
+#define	ENOSYS		38	/* Invalid system call number */
+
+#define	ENOTEMPTY	39	/* Directory not empty */
+#define	ELOOP		40	/* Too many symbolic links encountered */
+#define	EWOULDBLOCK	EAGAIN	/* Operation would block */
+#define	ENOMSG		42	/* No message of desired type */
+#define	EIDRM		43	/* Identifier removed */
+#define	ECHRNG		44	/* Channel number out of range */
+#define	EL2NSYNC	45	/* Level 2 not synchronized */
+#define	EL3HLT		46	/* Level 3 halted */
+#define	EL3RST		47	/* Level 3 reset */
+#define	ELNRNG		48	/* Link number out of range */
+#define	EUNATCH		49	/* Protocol driver not attached */
+#define	ENOCSI		50	/* No CSI structure available */
+#define	EL2HLT		51	/* Level 2 halted */
+#define	EBADE		52	/* Invalid exchange */
+#define	EBADR		53	/* Invalid request descriptor */
+#define	EXFULL		54	/* Exchange full */
+#define	ENOANO		55	/* No anode */
+#define	EBADRQC		56	/* Invalid request code */
+#define	EBADSLT		57	/* Invalid slot */
+
+#define	EDEADLOCK	EDEADLK
+
+#define	EBFONT		59	/* Bad font file format */
+#define	ENOSTR		60	/* Device not a stream */
+#define	ENODATA		61	/* No data available */
+#define	ETIME		62	/* Timer expired */
+#define	ENOSR		63	/* Out of streams resources */
+#define	ENONET		64	/* Machine is not on the network */
+#define	ENOPKG		65	/* Package not installed */
+#define	EREMOTE		66	/* Object is remote */
+#define	ENOLINK		67	/* Link has been severed */
+#define	EADV		68	/* Advertise error */
+#define	ESRMNT		69	/* Srmount error */
+#define	ECOMM		70	/* Communication error on send */
+#define	EPROTO		71	/* Protocol error */
+#define	EMULTIHOP	72	/* Multihop attempted */
+#define	EDOTDOT		73	/* RFS specific error */
+#define	EBADMSG		74	/* Not a data message */
+#define	EOVERFLOW	75	/* Value too large for defined data type */
+#define	ENOTUNIQ	76	/* Name not unique on network */
+#define	EBADFD		77	/* File descriptor in bad state */
+#define	EREMCHG		78	/* Remote address changed */
+#define	ELIBACC		79	/* Can not access a needed shared library */
+#define	ELIBBAD		80	/* Accessing a corrupted shared library */
+#define	ELIBSCN		81	/* .lib section in a.out corrupted */
+#define	ELIBMAX		82	/* Attempting to link in too many shared libraries */
+#define	ELIBEXEC	83	/* Cannot exec a shared library directly */
+#define	EILSEQ		84	/* Illegal byte sequence */
+#define	ERESTART	85	/* Interrupted system call should be restarted */
+#define	ESTRPIPE	86	/* Streams pipe error */
+#define	EUSERS		87	/* Too many users */
+#define	ENOTSOCK	88	/* Socket operation on non-socket */
+#define	EDESTADDRREQ	89	/* Destination address required */
+#define	EMSGSIZE	90	/* Message too long */
+#define	EPROTOTYPE	91	/* Protocol wrong type for socket */
+#define	ENOPROTOOPT	92	/* Protocol not available */
+#define	EPROTONOSUPPORT	93	/* Protocol not supported */
+#define	ESOCKTNOSUPPORT	94	/* Socket type not supported */
+#define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint */
+#define	EPFNOSUPPORT	96	/* Protocol family not supported */
+#define	EAFNOSUPPORT	97	/* Address family not supported by protocol */
+#define	EADDRINUSE	98	/* Address already in use */
+#define	EADDRNOTAVAIL	99	/* Cannot assign requested address */
+#define	ENETDOWN	100	/* Network is down */
+#define	ENETUNREACH	101	/* Network is unreachable */
+#define	ENETRESET	102	/* Network dropped connection because of reset */
+#define	ECONNABORTED	103	/* Software caused connection abort */
+#define	ECONNRESET	104	/* Connection reset by peer */
+#define	ENOBUFS		105	/* No buffer space available */
+#define	EISCONN		106	/* Transport endpoint is already connected */
+#define	ENOTCONN	107	/* Transport endpoint is not connected */
+#define	ESHUTDOWN	108	/* Cannot send after transport endpoint shutdown */
+#define	ETOOMANYREFS	109	/* Too many references: cannot splice */
+#define	ETIMEDOUT	110	/* Connection timed out */
+#define	ECONNREFUSED	111	/* Connection refused */
+#define	EHOSTDOWN	112	/* Host is down */
+#define	EHOSTUNREACH	113	/* No route to host */
+#define	EALREADY	114	/* Operation already in progress */
+#define	EINPROGRESS	115	/* Operation now in progress */
+#define	ESTALE		116	/* Stale file handle */
+#define	EUCLEAN		117	/* Structure needs cleaning */
+#define	ENOTNAM		118	/* Not a XENIX named type file */
+#define	ENAVAIL		119	/* No XENIX semaphores available */
+#define	EISNAM		120	/* Is a named type file */
+#define	EREMOTEIO	121	/* Remote I/O error */
+#define	EDQUOT		122	/* Quota exceeded */
+
+#define	ENOMEDIUM	123	/* No medium found */
+#define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	ECANCELED	125	/* Operation Canceled */
+#define	ENOKEY		126	/* Required key not available */
+#define	EKEYEXPIRED	127	/* Key has expired */
+#define	EKEYREVOKED	128	/* Key has been revoked */
+#define	EKEYREJECTED	129	/* Key was rejected by service */
+
+/* for robust mutexes */
+#define	EOWNERDEAD	130	/* Owner died */
+#define	ENOTRECOVERABLE	131	/* State not recoverable */
+
+#define ERFKILL		132	/* Operation not possible due to RF-kill */
+
+#define EHWPOISON	133	/* Memory page has hardware error */
+
+#endif
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 83a65d3..51abdb0 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -49,6 +49,8 @@ include/asm-generic/bitops/__fls.h
 include/asm-generic/bitops/fls.h
 include/asm-generic/bitops/fls64.h
 include/linux/coresight-pmu.h
+include/uapi/asm-generic/errno.h
+include/uapi/asm-generic/errno-base.h
 include/uapi/asm-generic/ioctls.h
 include/uapi/asm-generic/mman-common.h
 '
-- 
1.8.3.1
