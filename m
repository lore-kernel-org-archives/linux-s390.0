Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgIWNsQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 09:48:16 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PATCH kvm-unit-tests v2 4/4] s390x: add Protected VM support
Date: Wed, 23 Sep 2020 15:47:58 +0200
Message-Id: <20200923134758.19354-5-mhartmay@linux.ibm.com>
In-Reply-To: <20200923134758.19354-1-mhartmay@linux.ibm.com>
References: <20200923134758.19354-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org

Add support for Protected Virtual Machine (PVM) tests. For starting a
PVM guest we must be able to generate a PVM image by using the
`genprotimg` tool from the s390-tools collection. This requires the
ability to pass a machine-specific host-key document, so the option
`--host-key-document` is added to the configure script.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 configure               |  9 +++++++++
 s390x/Makefile          | 17 +++++++++++++++--
 s390x/selftest.parmfile |  1 +
 s390x/unittests.cfg     |  1 +
 scripts/s390x/func.bash | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100644 s390x/selftest.parmfile
 create mode 100644 scripts/s390x/func.bash

diff --git a/configure b/configure
index f9305431a9cb..fe319233eb50 100755
--- a/configure
+++ b/configure
@@ -19,6 +19,7 @@ wa_divide=
 vmm="qemu"
 errata_force=0
 erratatxt="$srcdir/errata.txt"
+host_key_document=
 
 usage() {
     cat <<-EOF
@@ -41,6 +42,9 @@ usage() {
 	                           no environ is provided by the user (enabled by default)
 	    --erratatxt=FILE       specify a file to use instead of errata.txt. Use
 	                           '--erratatxt=' to ensure no file is used.
+	    --host-key-document=HOST_KEY_DOCUMENT
+	                           Specify the machine-specific host-key document for creating
+	                           a PVM image with 'genprotimg' (s390x only)
 EOF
     exit 1
 }
@@ -93,6 +97,9 @@ while [[ "$1" = -* ]]; do
 	    erratatxt=
 	    [ "$arg" ] && erratatxt=$(eval realpath "$arg")
 	    ;;
+	--host-key-document)
+	    host_key_document="$arg"
+	    ;;
 	--help)
 	    usage
 	    ;;
@@ -224,6 +231,8 @@ ENVIRON_DEFAULT=$environ_default
 ERRATATXT=$erratatxt
 U32_LONG_FMT=$u32_long
 WA_DIVIDE=$wa_divide
+GENPROTIMG=${GENPROTIMG-genprotimg}
+HOST_KEY_DOCUMENT=$host_key_document
 EOF
 
 cat <<EOF > lib/config.h
diff --git a/s390x/Makefile b/s390x/Makefile
index c2213ad92e0d..b079a26dffb7 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -19,12 +19,19 @@ tests += $(TEST_DIR)/smp.elf
 tests += $(TEST_DIR)/sclp.elf
 tests += $(TEST_DIR)/css.elf
 tests += $(TEST_DIR)/uv-guest.elf
-tests_binary = $(patsubst %.elf,%.bin,$(tests))
 
-all: directories test_cases test_cases_binary
+tests_binary = $(patsubst %.elf,%.bin,$(tests))
+ifneq ($(HOST_KEY_DOCUMENT),)
+tests_pv_binary = $(patsubst %.bin,%.pv.bin,$(tests_binary))
+else
+tests_pv_binary =
+endif
+
+all: directories test_cases test_cases_binary test_cases_pv
 
 test_cases: $(tests)
 test_cases_binary: $(tests_binary)
+test_cases_pv: $(tests_pv_binary)
 
 CFLAGS += -std=gnu99
 CFLAGS += -ffreestanding
@@ -73,6 +80,12 @@ FLATLIBS = $(libcflat)
 %.bin: %.elf
 	$(OBJCOPY) -O binary  $< $@
 
+%selftest.pv.bin: %selftest.bin $(HOST_KEY_DOCUMENT) $(patsubst %.pv.bin,%.parmfile,$@)
+	$(GENPROTIMG) --host-key-document $(HOST_KEY_DOCUMENT) --parmfile $(patsubst %.pv.bin,%.parmfile,$@) --no-verify --image $< -o $@
+
+%.pv.bin: %.bin $(HOST_KEY_DOCUMENT)
+	$(GENPROTIMG) --host-key-document $(HOST_KEY_DOCUMENT) --no-verify --image $< -o $@
+
 arch_clean: asm_offsets_clean
 	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(TEST_DIR)/.*.d lib/s390x/.*.d
 
diff --git a/s390x/selftest.parmfile b/s390x/selftest.parmfile
new file mode 100644
index 000000000000..5613931aa5c6
--- /dev/null
+++ b/s390x/selftest.parmfile
@@ -0,0 +1 @@
+test 123
\ No newline at end of file
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 6d50c634770f..3feb8bcaa13d 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -21,6 +21,7 @@
 [selftest-setup]
 file = selftest.elf
 groups = selftest
+# please keep the kernel cmdline in sync with $(TEST_DIR)/selftest.parmfile
 extra_params = -append 'test 123'
 
 [intercept]
diff --git a/scripts/s390x/func.bash b/scripts/s390x/func.bash
new file mode 100644
index 000000000000..4eae5e916c61
--- /dev/null
+++ b/scripts/s390x/func.bash
@@ -0,0 +1,36 @@
+# The file scripts/common.bash has to be the only file sourcing this
+# arch helper file
+source config.mak
+
+ARCH_CMD=arch_cmd_s390x
+
+function arch_cmd_s390x()
+{
+	local cmd=$1
+	local testname=$2
+	local groups=$3
+	local smp=$4
+	local kernel=$5
+	local opts=$6
+	local arch=$7
+	local check=$8
+	local accel=$9
+	local timeout=${10}
+
+	# run the normal test case
+	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+
+	# run PV test case
+	kernel=${kernel%.elf}.pv.bin
+	testname=${testname}_PV
+	if [ ! -f "${kernel}" ]; then
+		if [ -z "${HOST_KEY_DOCUMENT}" ]; then
+			print_result 'SKIP' $testname '' 'no host-key document specified'
+			return 2
+		fi
+
+		print_result 'SKIP' $testname '' 'PVM image was not created'
+		return 2
+	fi
+	"$cmd" "$testname" "$groups pv" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+}
-- 
2.25.4
