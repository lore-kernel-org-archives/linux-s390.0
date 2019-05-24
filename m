Return-Path: <SRS0=zbpt=TY=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] KVM: selftests: enable pgste option for the linker on s390
Date: Fri, 24 May 2019 12:33:01 +0200
In-Reply-To: <20190523164309.13345-1-thuth@redhat.com>
References: <20190523164309.13345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190524103301.87017-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Andrew Jones <drjones@redhat.com>, linux-kselftest@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

To avoid testcase failures we need to enable the pgstes. This can be
done with /proc/sys/vm/allocate_pgste or with a linker option that
creates an  S390_PGSTE program header.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index aef5bd1166cf..4aac14c1919f 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -44,7 +44,10 @@ CFLAGS += -O2 -g -std=gnu99 -fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
         $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
 
-LDFLAGS += -pthread $(no-pie-option)
+# On s390, build the testcases KVM-enabled
+pgste-option := $(call cc-ldoption, -Wl$(comma)--s390-pgste)
+
+LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 
 # After inclusion, $(OUTPUT) is defined and
 # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
-- 
2.21.0
