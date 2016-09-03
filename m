Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 00/17] s390/debug: Fine-tuning for several function
 implementations
References: <566ABCD9.1060404@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:04:18 +0200
MIME-Version: 1.0
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Joe Perches <joe@perches.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Sep 2016 13:54:32 +0200

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (17):
  Use kmalloc_array() in debug_areas_alloc()
  Delete unnecessary braces
  Add some spaces for better code readability
  Rename jump labels in debug_areas_alloc()
  Fix jump targets in debug_info_alloc()
  Rename jump labels in debug_info_copy()
  Rename jump labels in debug_open()
  Fix a jump target in debug_register_mode()
  Return directly if a null pointer was passed to debug_unregister()
  Delete an unnecessary initialisation in debug_prolog_level_fn()
  Fix indentation in 13 functions
  Use memdup_user() rather than duplicating its implementation
  Improve a size determination in debug_open()
  Improve a size determination in debug_sprintf_format_fn()
  Improve a size determination in debug_raw_header_fn()
  Improve determination of sizes in debug_info_alloc()
  Improve another size determination in debug_info_alloc()

 arch/s390/kernel/debug.c | 433 ++++++++++++++++++++++-------------------------
 1 file changed, 204 insertions(+), 229 deletions(-)

-- 
2.9.3
