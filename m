From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 1/5] tools include arch: Grab a copy of errno.h for arch's supported by perf
Date: Tue, 16 Jan 2018 10:46:27 +0100
Message-ID: <1516095991-16337-2-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1516095991-16337-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <1516095991-16337-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

For each arch in tools/perf/arch, grab a copy of errno.h.

This is a pre-req to generate an architecture specific mapping of
errno numbers to their names.  This errno mapping can be used by
perf trace to support cross-architecture trace reports and to get
rid of the audit-libs dependency.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
---
 tools/arch/alpha/include/uapi/asm/errno.h   | 128 +++++++++++++++++++++++++++
 tools/arch/mips/include/asm/errno.h         |  17 ++++
 tools/arch/mips/include/uapi/asm/errno.h    | 130 ++++++++++++++++++++++++++++
 tools/arch/parisc/include/uapi/asm/errno.h  | 128 +++++++++++++++++++++++++++
 tools/arch/powerpc/include/uapi/asm/errno.h |  10 +++
 tools/arch/sparc/include/uapi/asm/errno.h   | 118 +++++++++++++++++++++++++
 tools/arch/x86/include/uapi/asm/errno.h     |   1 +
 tools/perf/check-headers.sh                 |   7 ++
 8 files changed, 539 insertions(+)
 create mode 100644 tools/arch/alpha/include/uapi/asm/errno.h
 create mode 100644 tools/arch/mips/include/asm/errno.h
 create mode 100644 tools/arch/mips/include/uapi/asm/errno.h
 create mode 100644 tools/arch/parisc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/powerpc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/sparc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/x86/include/uapi/asm/errno.h

diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
new file mode 100644
index 0000000..3d265f6
--- /dev/null
+++ b/tools/arch/alpha/include/uapi/asm/errno.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ALPHA_ERRNO_H
+#define _ALPHA_ERRNO_H
+
+#include <asm-generic/errno-base.h>
+
+#undef	EAGAIN			/* 11 in errno-base.h */
+
+#define	EDEADLK		11	/* Resource deadlock would occur */
+
+#define	EAGAIN		35	/* Try again */
+#define	EWOULDBLOCK	EAGAIN	/* Operation would block */
+#define	EINPROGRESS	36	/* Operation now in progress */
+#define	EALREADY	37	/* Operation already in progress */
+#define	ENOTSOCK	38	/* Socket operation on non-socket */
+#define	EDESTADDRREQ	39	/* Destination address required */
+#define	EMSGSIZE	40	/* Message too long */
+#define	EPROTOTYPE	41	/* Protocol wrong type for socket */
+#define	ENOPROTOOPT	42	/* Protocol not available */
+#define	EPROTONOSUPPORT	43	/* Protocol not supported */
+#define	ESOCKTNOSUPPORT	44	/* Socket type not supported */
+#define	EOPNOTSUPP	45	/* Operation not supported on transport endpoint */
+#define	EPFNOSUPPORT	46	/* Protocol family not supported */
+#define	EAFNOSUPPORT	47	/* Address family not supported by protocol */
+#define	EADDRINUSE	48	/* Address already in use */
+#define	EADDRNOTAVAIL	49	/* Cannot assign requested address */
+#define	ENETDOWN	50	/* Network is down */
+#define	ENETUNREACH	51	/* Network is unreachable */
+#define	ENETRESET	52	/* Network dropped connection because of reset */
+#define	ECONNABORTED	53	/* Software caused connection abort */
+#define	ECONNRESET	54	/* Connection reset by peer */
+#define	ENOBUFS		55	/* No buffer space available */
+#define	EISCONN		56	/* Transport endpoint is already connected */
+#define	ENOTCONN	57	/* Transport endpoint is not connected */
+#define	ESHUTDOWN	58	/* Cannot send after transport endpoint shutdown */
+#define	ETOOMANYREFS	59	/* Too many references: cannot splice */
+#define	ETIMEDOUT	60	/* Connection timed out */
+#define	ECONNREFUSED	61	/* Connection refused */
+#define	ELOOP		62	/* Too many symbolic links encountered */
+#define	ENAMETOOLONG	63	/* File name too long */
+#define	EHOSTDOWN	64	/* Host is down */
+#define	EHOSTUNREACH	65	/* No route to host */
+#define	ENOTEMPTY	66	/* Directory not empty */
+
+#define	EUSERS		68	/* Too many users */
+#define	EDQUOT		69	/* Quota exceeded */
+#define	ESTALE		70	/* Stale file handle */
+#define	EREMOTE		71	/* Object is remote */
+
+#define	ENOLCK		77	/* No record locks available */
+#define	ENOSYS		78	/* Function not implemented */
+
+#define	ENOMSG		80	/* No message of desired type */
+#define	EIDRM		81	/* Identifier removed */
+#define	ENOSR		82	/* Out of streams resources */
+#define	ETIME		83	/* Timer expired */
+#define	EBADMSG		84	/* Not a data message */
+#define	EPROTO		85	/* Protocol error */
+#define	ENODATA		86	/* No data available */
+#define	ENOSTR		87	/* Device not a stream */
+
+#define	ENOPKG		92	/* Package not installed */
+
+#define	EILSEQ		116	/* Illegal byte sequence */
+
+/* The following are just random noise.. */
+#define	ECHRNG		88	/* Channel number out of range */
+#define	EL2NSYNC	89	/* Level 2 not synchronized */
+#define	EL3HLT		90	/* Level 3 halted */
+#define	EL3RST		91	/* Level 3 reset */
+
+#define	ELNRNG		93	/* Link number out of range */
+#define	EUNATCH		94	/* Protocol driver not attached */
+#define	ENOCSI		95	/* No CSI structure available */
+#define	EL2HLT		96	/* Level 2 halted */
+#define	EBADE		97	/* Invalid exchange */
+#define	EBADR		98	/* Invalid request descriptor */
+#define	EXFULL		99	/* Exchange full */
+#define	ENOANO		100	/* No anode */
+#define	EBADRQC		101	/* Invalid request code */
+#define	EBADSLT		102	/* Invalid slot */
+
+#define	EDEADLOCK	EDEADLK
+
+#define	EBFONT		104	/* Bad font file format */
+#define	ENONET		105	/* Machine is not on the network */
+#define	ENOLINK		106	/* Link has been severed */
+#define	EADV		107	/* Advertise error */
+#define	ESRMNT		108	/* Srmount error */
+#define	ECOMM		109	/* Communication error on send */
+#define	EMULTIHOP	110	/* Multihop attempted */
+#define	EDOTDOT		111	/* RFS specific error */
+#define	EOVERFLOW	112	/* Value too large for defined data type */
+#define	ENOTUNIQ	113	/* Name not unique on network */
+#define	EBADFD		114	/* File descriptor in bad state */
+#define	EREMCHG		115	/* Remote address changed */
+
+#define	EUCLEAN		117	/* Structure needs cleaning */
+#define	ENOTNAM		118	/* Not a XENIX named type file */
+#define	ENAVAIL		119	/* No XENIX semaphores available */
+#define	EISNAM		120	/* Is a named type file */
+#define	EREMOTEIO	121	/* Remote I/O error */
+
+#define	ELIBACC		122	/* Can not access a needed shared library */
+#define	ELIBBAD		123	/* Accessing a corrupted shared library */
+#define	ELIBSCN		124	/* .lib section in a.out corrupted */
+#define	ELIBMAX		125	/* Attempting to link in too many shared libraries */
+#define	ELIBEXEC	126	/* Cannot exec a shared library directly */
+#define	ERESTART	127	/* Interrupted system call should be restarted */
+#define	ESTRPIPE	128	/* Streams pipe error */
+
+#define ENOMEDIUM	129	/* No medium found */
+#define EMEDIUMTYPE	130	/* Wrong medium type */
+#define	ECANCELED	131	/* Operation Cancelled */
+#define	ENOKEY		132	/* Required key not available */
+#define	EKEYEXPIRED	133	/* Key has expired */
+#define	EKEYREVOKED	134	/* Key has been revoked */
+#define	EKEYREJECTED	135	/* Key was rejected by service */
+
+/* for robust mutexes */
+#define	EOWNERDEAD	136	/* Owner died */
+#define	ENOTRECOVERABLE	137	/* State not recoverable */
+
+#define	ERFKILL		138	/* Operation not possible due to RF-kill */
+
+#define EHWPOISON	139	/* Memory page has hardware error */
+
+#endif
diff --git a/tools/arch/mips/include/asm/errno.h b/tools/arch/mips/include/asm/errno.h
new file mode 100644
index 0000000..21d91cd
--- /dev/null
+++ b/tools/arch/mips/include/asm/errno.h
@@ -0,0 +1,17 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1995, 1999, 2001, 2002 by Ralf Baechle
+ */
+#ifndef _ASM_ERRNO_H
+#define _ASM_ERRNO_H
+
+#include <uapi/asm/errno.h>
+
+
+/* The biggest error number defined here or in <linux/errno.h>. */
+#define EMAXERRNO	1133
+
+#endif /* _ASM_ERRNO_H */
diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
new file mode 100644
index 0000000..2fb714e
--- /dev/null
+++ b/tools/arch/mips/include/uapi/asm/errno.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1995, 1999, 2001, 2002 by Ralf Baechle
+ */
+#ifndef _UAPI_ASM_ERRNO_H
+#define _UAPI_ASM_ERRNO_H
+
+/*
+ * These error numbers are intended to be MIPS ABI compatible
+ */
+
+#include <asm-generic/errno-base.h>
+
+#define ENOMSG		35	/* No message of desired type */
+#define EIDRM		36	/* Identifier removed */
+#define ECHRNG		37	/* Channel number out of range */
+#define EL2NSYNC	38	/* Level 2 not synchronized */
+#define EL3HLT		39	/* Level 3 halted */
+#define EL3RST		40	/* Level 3 reset */
+#define ELNRNG		41	/* Link number out of range */
+#define EUNATCH		42	/* Protocol driver not attached */
+#define ENOCSI		43	/* No CSI structure available */
+#define EL2HLT		44	/* Level 2 halted */
+#define EDEADLK		45	/* Resource deadlock would occur */
+#define ENOLCK		46	/* No record locks available */
+#define EBADE		50	/* Invalid exchange */
+#define EBADR		51	/* Invalid request descriptor */
+#define EXFULL		52	/* Exchange full */
+#define ENOANO		53	/* No anode */
+#define EBADRQC		54	/* Invalid request code */
+#define EBADSLT		55	/* Invalid slot */
+#define EDEADLOCK	56	/* File locking deadlock error */
+#define EBFONT		59	/* Bad font file format */
+#define ENOSTR		60	/* Device not a stream */
+#define ENODATA		61	/* No data available */
+#define ETIME		62	/* Timer expired */
+#define ENOSR		63	/* Out of streams resources */
+#define ENONET		64	/* Machine is not on the network */
+#define ENOPKG		65	/* Package not installed */
+#define EREMOTE		66	/* Object is remote */
+#define ENOLINK		67	/* Link has been severed */
+#define EADV		68	/* Advertise error */
+#define ESRMNT		69	/* Srmount error */
+#define ECOMM		70	/* Communication error on send */
+#define EPROTO		71	/* Protocol error */
+#define EDOTDOT		73	/* RFS specific error */
+#define EMULTIHOP	74	/* Multihop attempted */
+#define EBADMSG		77	/* Not a data message */
+#define ENAMETOOLONG	78	/* File name too long */
+#define EOVERFLOW	79	/* Value too large for defined data type */
+#define ENOTUNIQ	80	/* Name not unique on network */
+#define EBADFD		81	/* File descriptor in bad state */
+#define EREMCHG		82	/* Remote address changed */
+#define ELIBACC		83	/* Can not access a needed shared library */
+#define ELIBBAD		84	/* Accessing a corrupted shared library */
+#define ELIBSCN		85	/* .lib section in a.out corrupted */
+#define ELIBMAX		86	/* Attempting to link in too many shared libraries */
+#define ELIBEXEC	87	/* Cannot exec a shared library directly */
+#define EILSEQ		88	/* Illegal byte sequence */
+#define ENOSYS		89	/* Function not implemented */
+#define ELOOP		90	/* Too many symbolic links encountered */
+#define ERESTART	91	/* Interrupted system call should be restarted */
+#define ESTRPIPE	92	/* Streams pipe error */
+#define ENOTEMPTY	93	/* Directory not empty */
+#define EUSERS		94	/* Too many users */
+#define ENOTSOCK	95	/* Socket operation on non-socket */
+#define EDESTADDRREQ	96	/* Destination address required */
+#define EMSGSIZE	97	/* Message too long */
+#define EPROTOTYPE	98	/* Protocol wrong type for socket */
+#define ENOPROTOOPT	99	/* Protocol not available */
+#define EPROTONOSUPPORT 120	/* Protocol not supported */
+#define ESOCKTNOSUPPORT 121	/* Socket type not supported */
+#define EOPNOTSUPP	122	/* Operation not supported on transport endpoint */
+#define EPFNOSUPPORT	123	/* Protocol family not supported */
+#define EAFNOSUPPORT	124	/* Address family not supported by protocol */
+#define EADDRINUSE	125	/* Address already in use */
+#define EADDRNOTAVAIL	126	/* Cannot assign requested address */
+#define ENETDOWN	127	/* Network is down */
+#define ENETUNREACH	128	/* Network is unreachable */
+#define ENETRESET	129	/* Network dropped connection because of reset */
+#define ECONNABORTED	130	/* Software caused connection abort */
+#define ECONNRESET	131	/* Connection reset by peer */
+#define ENOBUFS		132	/* No buffer space available */
+#define EISCONN		133	/* Transport endpoint is already connected */
+#define ENOTCONN	134	/* Transport endpoint is not connected */
+#define EUCLEAN		135	/* Structure needs cleaning */
+#define ENOTNAM		137	/* Not a XENIX named type file */
+#define ENAVAIL		138	/* No XENIX semaphores available */
+#define EISNAM		139	/* Is a named type file */
+#define EREMOTEIO	140	/* Remote I/O error */
+#define EINIT		141	/* Reserved */
+#define EREMDEV		142	/* Error 142 */
+#define ESHUTDOWN	143	/* Cannot send after transport endpoint shutdown */
+#define ETOOMANYREFS	144	/* Too many references: cannot splice */
+#define ETIMEDOUT	145	/* Connection timed out */
+#define ECONNREFUSED	146	/* Connection refused */
+#define EHOSTDOWN	147	/* Host is down */
+#define EHOSTUNREACH	148	/* No route to host */
+#define EWOULDBLOCK	EAGAIN	/* Operation would block */
+#define EALREADY	149	/* Operation already in progress */
+#define EINPROGRESS	150	/* Operation now in progress */
+#define ESTALE		151	/* Stale file handle */
+#define ECANCELED	158	/* AIO operation canceled */
+
+/*
+ * These error are Linux extensions.
+ */
+#define ENOMEDIUM	159	/* No medium found */
+#define EMEDIUMTYPE	160	/* Wrong medium type */
+#define ENOKEY		161	/* Required key not available */
+#define EKEYEXPIRED	162	/* Key has expired */
+#define EKEYREVOKED	163	/* Key has been revoked */
+#define EKEYREJECTED	164	/* Key was rejected by service */
+
+/* for robust mutexes */
+#define EOWNERDEAD	165	/* Owner died */
+#define ENOTRECOVERABLE 166	/* State not recoverable */
+
+#define ERFKILL		167	/* Operation not possible due to RF-kill */
+
+#define EHWPOISON	168	/* Memory page has hardware error */
+
+#define EDQUOT		1133	/* Quota exceeded */
+
+
+#endif /* _UAPI_ASM_ERRNO_H */
diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
new file mode 100644
index 0000000..fc0df35
--- /dev/null
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _PARISC_ERRNO_H
+#define _PARISC_ERRNO_H
+
+#include <asm-generic/errno-base.h>
+
+#define	ENOMSG		35	/* No message of desired type */
+#define	EIDRM		36	/* Identifier removed */
+#define	ECHRNG		37	/* Channel number out of range */
+#define	EL2NSYNC	38	/* Level 2 not synchronized */
+#define	EL3HLT		39	/* Level 3 halted */
+#define	EL3RST		40	/* Level 3 reset */
+#define	ELNRNG		41	/* Link number out of range */
+#define	EUNATCH		42	/* Protocol driver not attached */
+#define	ENOCSI		43	/* No CSI structure available */
+#define	EL2HLT		44	/* Level 2 halted */
+#define	EDEADLK		45	/* Resource deadlock would occur */
+#define	EDEADLOCK	EDEADLK
+#define	ENOLCK		46	/* No record locks available */
+#define	EILSEQ		47	/* Illegal byte sequence */
+
+#define	ENONET		50	/* Machine is not on the network */
+#define	ENODATA		51	/* No data available */
+#define	ETIME		52	/* Timer expired */
+#define	ENOSR		53	/* Out of streams resources */
+#define	ENOSTR		54	/* Device not a stream */
+#define	ENOPKG		55	/* Package not installed */
+
+#define	ENOLINK		57	/* Link has been severed */
+#define	EADV		58	/* Advertise error */
+#define	ESRMNT		59	/* Srmount error */
+#define	ECOMM		60	/* Communication error on send */
+#define	EPROTO		61	/* Protocol error */
+
+#define	EMULTIHOP	64	/* Multihop attempted */
+
+#define	EDOTDOT		66	/* RFS specific error */
+#define	EBADMSG		67	/* Not a data message */
+#define	EUSERS		68	/* Too many users */
+#define	EDQUOT		69	/* Quota exceeded */
+#define	ESTALE		70	/* Stale file handle */
+#define	EREMOTE		71	/* Object is remote */
+#define	EOVERFLOW	72	/* Value too large for defined data type */
+
+/* these errnos are defined by Linux but not HPUX. */
+
+#define	EBADE		160	/* Invalid exchange */
+#define	EBADR		161	/* Invalid request descriptor */
+#define	EXFULL		162	/* Exchange full */
+#define	ENOANO		163	/* No anode */
+#define	EBADRQC		164	/* Invalid request code */
+#define	EBADSLT		165	/* Invalid slot */
+#define	EBFONT		166	/* Bad font file format */
+#define	ENOTUNIQ	167	/* Name not unique on network */
+#define	EBADFD		168	/* File descriptor in bad state */
+#define	EREMCHG		169	/* Remote address changed */
+#define	ELIBACC		170	/* Can not access a needed shared library */
+#define	ELIBBAD		171	/* Accessing a corrupted shared library */
+#define	ELIBSCN		172	/* .lib section in a.out corrupted */
+#define	ELIBMAX		173	/* Attempting to link in too many shared libraries */
+#define	ELIBEXEC	174	/* Cannot exec a shared library directly */
+#define	ERESTART	175	/* Interrupted system call should be restarted */
+#define	ESTRPIPE	176	/* Streams pipe error */
+#define	EUCLEAN		177	/* Structure needs cleaning */
+#define	ENOTNAM		178	/* Not a XENIX named type file */
+#define	ENAVAIL		179	/* No XENIX semaphores available */
+#define	EISNAM		180	/* Is a named type file */
+#define	EREMOTEIO	181	/* Remote I/O error */
+#define	ENOMEDIUM	182	/* No medium found */
+#define	EMEDIUMTYPE	183	/* Wrong medium type */
+#define	ENOKEY		184	/* Required key not available */
+#define	EKEYEXPIRED	185	/* Key has expired */
+#define	EKEYREVOKED	186	/* Key has been revoked */
+#define	EKEYREJECTED	187	/* Key was rejected by service */
+
+/* We now return you to your regularly scheduled HPUX. */
+
+#define ENOSYM		215	/* symbol does not exist in executable */
+#define	ENOTSOCK	216	/* Socket operation on non-socket */
+#define	EDESTADDRREQ	217	/* Destination address required */
+#define	EMSGSIZE	218	/* Message too long */
+#define	EPROTOTYPE	219	/* Protocol wrong type for socket */
+#define	ENOPROTOOPT	220	/* Protocol not available */
+#define	EPROTONOSUPPORT	221	/* Protocol not supported */
+#define	ESOCKTNOSUPPORT	222	/* Socket type not supported */
+#define	EOPNOTSUPP	223	/* Operation not supported on transport endpoint */
+#define	EPFNOSUPPORT	224	/* Protocol family not supported */
+#define	EAFNOSUPPORT	225	/* Address family not supported by protocol */
+#define	EADDRINUSE	226	/* Address already in use */
+#define	EADDRNOTAVAIL	227	/* Cannot assign requested address */
+#define	ENETDOWN	228	/* Network is down */
+#define	ENETUNREACH	229	/* Network is unreachable */
+#define	ENETRESET	230	/* Network dropped connection because of reset */
+#define	ECONNABORTED	231	/* Software caused connection abort */
+#define	ECONNRESET	232	/* Connection reset by peer */
+#define	ENOBUFS		233	/* No buffer space available */
+#define	EISCONN		234	/* Transport endpoint is already connected */
+#define	ENOTCONN	235	/* Transport endpoint is not connected */
+#define	ESHUTDOWN	236	/* Cannot send after transport endpoint shutdown */
+#define	ETOOMANYREFS	237	/* Too many references: cannot splice */
+#define	ETIMEDOUT	238	/* Connection timed out */
+#define	ECONNREFUSED	239	/* Connection refused */
+#define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
+#define	EREMOTERELEASE	240	/* Remote peer released connection */
+#define	EHOSTDOWN	241	/* Host is down */
+#define	EHOSTUNREACH	242	/* No route to host */
+
+#define	EALREADY	244	/* Operation already in progress */
+#define	EINPROGRESS	245	/* Operation now in progress */
+#define	EWOULDBLOCK	EAGAIN	/* Operation would block (Not HPUX compliant) */
+#define	ENOTEMPTY	247	/* Directory not empty */
+#define	ENAMETOOLONG	248	/* File name too long */
+#define	ELOOP		249	/* Too many symbolic links encountered */
+#define	ENOSYS		251	/* Function not implemented */
+
+#define ENOTSUP		252	/* Function not implemented (POSIX.4 / HPUX) */
+#define ECANCELLED	253	/* aio request was canceled before complete (POSIX.4 / HPUX) */
+#define ECANCELED	ECANCELLED	/* SuSv3 and Solaris wants one 'L' */
+
+/* for robust mutexes */
+#define EOWNERDEAD	254	/* Owner died */
+#define ENOTRECOVERABLE	255	/* State not recoverable */
+
+#define	ERFKILL		256	/* Operation not possible due to RF-kill */
+
+#define EHWPOISON	257	/* Memory page has hardware error */
+
+#endif
diff --git a/tools/arch/powerpc/include/uapi/asm/errno.h b/tools/arch/powerpc/include/uapi/asm/errno.h
new file mode 100644
index 0000000..cc79856
--- /dev/null
+++ b/tools/arch/powerpc/include/uapi/asm/errno.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_POWERPC_ERRNO_H
+#define _ASM_POWERPC_ERRNO_H
+
+#include <asm-generic/errno.h>
+
+#undef	EDEADLOCK
+#define	EDEADLOCK	58	/* File locking deadlock error */
+
+#endif	/* _ASM_POWERPC_ERRNO_H */
diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
new file mode 100644
index 0000000..81a732b
--- /dev/null
+++ b/tools/arch/sparc/include/uapi/asm/errno.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _SPARC_ERRNO_H
+#define _SPARC_ERRNO_H
+
+/* These match the SunOS error numbering scheme. */
+
+#include <asm-generic/errno-base.h>
+
+#define	EWOULDBLOCK	EAGAIN	/* Operation would block */
+#define	EINPROGRESS	36	/* Operation now in progress */
+#define	EALREADY	37	/* Operation already in progress */
+#define	ENOTSOCK	38	/* Socket operation on non-socket */
+#define	EDESTADDRREQ	39	/* Destination address required */
+#define	EMSGSIZE	40	/* Message too long */
+#define	EPROTOTYPE	41	/* Protocol wrong type for socket */
+#define	ENOPROTOOPT	42	/* Protocol not available */
+#define	EPROTONOSUPPORT	43	/* Protocol not supported */
+#define	ESOCKTNOSUPPORT	44	/* Socket type not supported */
+#define	EOPNOTSUPP	45	/* Op not supported on transport endpoint */
+#define	EPFNOSUPPORT	46	/* Protocol family not supported */
+#define	EAFNOSUPPORT	47	/* Address family not supported by protocol */
+#define	EADDRINUSE	48	/* Address already in use */
+#define	EADDRNOTAVAIL	49	/* Cannot assign requested address */
+#define	ENETDOWN	50	/* Network is down */
+#define	ENETUNREACH	51	/* Network is unreachable */
+#define	ENETRESET	52	/* Net dropped connection because of reset */
+#define	ECONNABORTED	53	/* Software caused connection abort */
+#define	ECONNRESET	54	/* Connection reset by peer */
+#define	ENOBUFS		55	/* No buffer space available */
+#define	EISCONN		56	/* Transport endpoint is already connected */
+#define	ENOTCONN	57	/* Transport endpoint is not connected */
+#define	ESHUTDOWN	58	/* No send after transport endpoint shutdown */
+#define	ETOOMANYREFS	59	/* Too many references: cannot splice */
+#define	ETIMEDOUT	60	/* Connection timed out */
+#define	ECONNREFUSED	61	/* Connection refused */
+#define	ELOOP		62	/* Too many symbolic links encountered */
+#define	ENAMETOOLONG	63	/* File name too long */
+#define	EHOSTDOWN	64	/* Host is down */
+#define	EHOSTUNREACH	65	/* No route to host */
+#define	ENOTEMPTY	66	/* Directory not empty */
+#define EPROCLIM        67      /* SUNOS: Too many processes */
+#define	EUSERS		68	/* Too many users */
+#define	EDQUOT		69	/* Quota exceeded */
+#define	ESTALE		70	/* Stale file handle */
+#define	EREMOTE		71	/* Object is remote */
+#define	ENOSTR		72	/* Device not a stream */
+#define	ETIME		73	/* Timer expired */
+#define	ENOSR		74	/* Out of streams resources */
+#define	ENOMSG		75	/* No message of desired type */
+#define	EBADMSG		76	/* Not a data message */
+#define	EIDRM		77	/* Identifier removed */
+#define	EDEADLK		78	/* Resource deadlock would occur */
+#define	ENOLCK		79	/* No record locks available */
+#define	ENONET		80	/* Machine is not on the network */
+#define ERREMOTE        81      /* SunOS: Too many lvls of remote in path */
+#define	ENOLINK		82	/* Link has been severed */
+#define	EADV		83	/* Advertise error */
+#define	ESRMNT		84	/* Srmount error */
+#define	ECOMM		85      /* Communication error on send */
+#define	EPROTO		86	/* Protocol error */
+#define	EMULTIHOP	87	/* Multihop attempted */
+#define	EDOTDOT		88	/* RFS specific error */
+#define	EREMCHG		89	/* Remote address changed */
+#define	ENOSYS		90	/* Function not implemented */
+
+/* The rest have no SunOS equivalent. */
+#define	ESTRPIPE	91	/* Streams pipe error */
+#define	EOVERFLOW	92	/* Value too large for defined data type */
+#define	EBADFD		93	/* File descriptor in bad state */
+#define	ECHRNG		94	/* Channel number out of range */
+#define	EL2NSYNC	95	/* Level 2 not synchronized */
+#define	EL3HLT		96	/* Level 3 halted */
+#define	EL3RST		97	/* Level 3 reset */
+#define	ELNRNG		98	/* Link number out of range */
+#define	EUNATCH		99	/* Protocol driver not attached */
+#define	ENOCSI		100	/* No CSI structure available */
+#define	EL2HLT		101	/* Level 2 halted */
+#define	EBADE		102	/* Invalid exchange */
+#define	EBADR		103	/* Invalid request descriptor */
+#define	EXFULL		104	/* Exchange full */
+#define	ENOANO		105	/* No anode */
+#define	EBADRQC		106	/* Invalid request code */
+#define	EBADSLT		107	/* Invalid slot */
+#define	EDEADLOCK	108	/* File locking deadlock error */
+#define	EBFONT		109	/* Bad font file format */
+#define	ELIBEXEC	110	/* Cannot exec a shared library directly */
+#define	ENODATA		111	/* No data available */
+#define	ELIBBAD		112	/* Accessing a corrupted shared library */
+#define	ENOPKG		113	/* Package not installed */
+#define	ELIBACC		114	/* Can not access a needed shared library */
+#define	ENOTUNIQ	115	/* Name not unique on network */
+#define	ERESTART	116	/* Interrupted syscall should be restarted */
+#define	EUCLEAN		117	/* Structure needs cleaning */
+#define	ENOTNAM		118	/* Not a XENIX named type file */
+#define	ENAVAIL		119	/* No XENIX semaphores available */
+#define	EISNAM		120	/* Is a named type file */
+#define	EREMOTEIO	121	/* Remote I/O error */
+#define	EILSEQ		122	/* Illegal byte sequence */
+#define	ELIBMAX		123	/* Atmpt to link in too many shared libs */
+#define	ELIBSCN		124	/* .lib section in a.out corrupted */
+
+#define	ENOMEDIUM	125	/* No medium found */
+#define	EMEDIUMTYPE	126	/* Wrong medium type */
+#define	ECANCELED	127	/* Operation Cancelled */
+#define	ENOKEY		128	/* Required key not available */
+#define	EKEYEXPIRED	129	/* Key has expired */
+#define	EKEYREVOKED	130	/* Key has been revoked */
+#define	EKEYREJECTED	131	/* Key was rejected by service */
+
+/* for robust mutexes */
+#define	EOWNERDEAD	132	/* Owner died */
+#define	ENOTRECOVERABLE	133	/* State not recoverable */
+
+#define	ERFKILL		134	/* Operation not possible due to RF-kill */
+
+#define EHWPOISON	135	/* Memory page has hardware error */
+
+#endif
diff --git a/tools/arch/x86/include/uapi/asm/errno.h b/tools/arch/x86/include/uapi/asm/errno.h
new file mode 100644
index 0000000..4c82b50
--- /dev/null
+++ b/tools/arch/x86/include/uapi/asm/errno.h
@@ -0,0 +1 @@
+#include <asm-generic/errno.h>
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index f81ca50..83a65d3 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -36,6 +36,13 @@ arch/s390/include/uapi/asm/sie.h
 arch/s390/include/uapi/asm/unistd.h
 arch/arm/include/uapi/asm/kvm.h
 arch/arm64/include/uapi/asm/kvm.h
+arch/alpha/include/uapi/asm/errno.h
+arch/mips/include/asm/errno.h
+arch/mips/include/uapi/asm/errno.h
+arch/parisc/include/uapi/asm/errno.h
+arch/powerpc/include/uapi/asm/errno.h
+arch/sparc/include/uapi/asm/errno.h
+arch/x86/include/uapi/asm/errno.h
 include/asm-generic/bitops/arch_hweight.h
 include/asm-generic/bitops/const_hweight.h
 include/asm-generic/bitops/__fls.h
-- 
1.8.3.1
