From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Sat, 14 Apr 2018 16:43:42 +0000
Subject: [man-pages PATCH v2 2/4] s390_runtime_instr.2: document signum argument behavior change
Message-Id: <20180414164342.GA15190@asgard.redhat.com>
To: linux-s390@vger.kernel.org, linux-man@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Document that the signum argument is ignored in newer kernels, but
that user space should pass a valid real-time signal number for
backwards compatibility.

Co-Authored-by: Eugene Syromyatnikov <evgsyr@gmail.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Eugene Syromyatnikov <evgsyr@gmail.com>
---
 man2/s390_runtime_instr.2 | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/man2/s390_runtime_instr.2 b/man2/s390_runtime_instr.2
index 9ef293f..17665b7 100644
--- a/man2/s390_runtime_instr.2
+++ b/man2/s390_runtime_instr.2
@@ -48,9 +48,11 @@ argument controls whether run-time instrumentation is started
 The
 .IR signum
 argument specifies the number of a real-time signal.
-The real-time signal is sent to the thread if the run-time instrumentation
-buffer is full or if the run-time-instrumentation-halted interrupt
-occurred.
+This argument was used to specify a signal number that should be delivered
+to the thread if the run-time instrumentation buffer was full or if
+the run-time-instrumentation-halted interrupt had occurred.
+It has no effect beginning with Linux 4.4, since support for signalling
+was never used and kernel support was removed.
 .SH RETURN VALUE
 On success,
 .BR s390_runtime_instr ()
@@ -67,9 +69,16 @@ is set to one of the error codes listed below.
 .B EINVAL
 The value specified in
 .IR command
-is not a valid command or the value specified in
+is not a valid command.
+.TP
+.B EINVAL
+The value specified in
 .IR signum
 is not a real-time signal number.
+From Linux 4.4 onwards, the
+.IR signum
+argument has no effect, so that an invalid signal number will not result in an
+error.
 .TP
 .B ENOMEM
 Allocating memory for the run-time instrumentation control block failed.
@@ -89,6 +98,13 @@ to call it.
 The header
 .B asm/runtime_instr.h
 is available since Linux 4.16.
+.PP
+Support for signalling was removed with Linux 4.4.
+With Linux 4.4 also the check whether
+.IR signum
+is a valid real-time signal was removed.
+For backwards compatibility with old kernels it is recommended to pass a valid
+real-time signal number and install a handler for it.
 .SH SEE ALSO
 .BR syscall (2),
 .BR signal (7)
-- 
2.1.4
