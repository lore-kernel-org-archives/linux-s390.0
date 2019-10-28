Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] scripts/gdb: fix debugging modules compiled with hot/cold partitioning
Date: Mon, 28 Oct 2019 16:27:34 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191028152734.13065-1-iii@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>

gcc's -freorder-blocks-and-partition option makes it group frequently
and infrequently used code in .text.hot and .text.unlikely sections
respectively. At least when building modules on s390, this option is
used by default.

gdb assumes that all code is located in .text section, and that .text
section is located at module load address. With such modules this is no
longer the case: there is code in .text.hot and .text.unlikely, and
either of them might precede .text.

Fix by explicitly telling gdb the addresses of code sections.

It might be tempting to do this for all sections, not only the ones in
the white list. Unfortunately, gdb appears to have an issue, when telling
it about e.g. loadable .note.gnu.build-id section causes it to think that
non-loadable .note.Linux section is loaded at address 0, which in turn
causes NULL pointers to be resolved to bogus symbols. So keep using the
white list approach for the time being.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 scripts/gdb/linux/symbols.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 7b7c2fafbc68..be984aa29b75 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -99,7 +99,8 @@ lx-symbols command."""
             attrs[n]['name'].string(): attrs[n]['address']
             for n in range(int(sect_attrs['nsections']))}
         args = []
-        for section_name in [".data", ".data..read_mostly", ".rodata", ".bss"]:
+        for section_name in [".data", ".data..read_mostly", ".rodata", ".bss",
+                             ".text", ".text.hot", ".text.unlikely"]:
             address = section_name_to_address.get(section_name)
             if address:
                 args.append(" -s {name} {addr}".format(
-- 
2.23.0
