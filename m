From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 18 Jan 2019 11:42:03 +0000
Subject: [kvm-unit-tests PATCH v6 10/11] s390x: Add binary generation to makefile
Message-Id: <20190118114204.147868-11-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

"make test_cases_binary" will now generate binaries that can be booted
from disk or as a non ELF kernel boot.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 s390x/Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/s390x/Makefile b/s390x/Makefile
index ed6ef0b..af40fd4 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -10,10 +10,12 @@ tests += $(TEST_DIR)/cmm.elf
 tests += $(TEST_DIR)/vector.elf
 tests += $(TEST_DIR)/gs.elf
 tests += $(TEST_DIR)/iep.elf
+tests_binary = $(patsubst %.elf,%.bin,$(tests))
 
-all: directories test_cases
+all: directories test_cases test_cases_binary
 
 test_cases: $(tests)
+test_cases_binary: $(tests_binary)
 
 CFLAGS += -std=gnu99
 CFLAGS += -ffreestanding
@@ -55,8 +57,11 @@ FLATLIBS = $(libcflat)
 	$(RM) $(@:.elf=.aux.o)
 	@chmod a-x $@
 
+%.bin: %.elf
+	$(OBJCOPY) -O binary  $< $@
+
 arch_clean: asm_offsets_clean
-	$(RM) $(TEST_DIR)/*.{o,elf} $(TEST_DIR)/.*.d lib/s390x/.*.d
+	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(TEST_DIR)/.*.d lib/s390x/.*.d
 
 generated-files = $(asm-offsets)
 $(tests:.elf=.o) $(cstart.o) $(cflatobjs): $(generated-files)
-- 
2.14.3
