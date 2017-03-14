Return-Path: <owner-linux-mm@kvack.org>
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCHv2 0/2] mm: add private lock to serialize memory hotplug operations
Date: Tue, 14 Mar 2017 13:52:24 +0100
Message-Id: <20170314125226.16779-1-heiko.carstens@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Vladimir Davydov <vdavydov.dev@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

v1->v2:
Add Acks from Dan and Raphael. Otherwise the patches are identical to v1.

v1:
These two patches are supposed to hopefully fix a memory hotplug
problem reported by Sebastian Ott.

Heiko Carstens (2):
  mm: add private lock to serialize memory hotplug operations
  drivers core: remove assert_held_device_hotplug()

 drivers/base/core.c    | 5 -----
 include/linux/device.h | 1 -
 kernel/memremap.c      | 4 ----
 mm/memory_hotplug.c    | 6 +++++-
 4 files changed, 5 insertions(+), 11 deletions(-)

-- 
2.8.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
