From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 1/2] drivers/base: export lock_device_hotplug/unlock_device_hotplug
Date: Fri, 17 Aug 2018 09:59:00 +0200
Message-ID: <20180817075901.4608-2-david@redhat.com>
References: <20180817075901.4608-1-david@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817075901.4608-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, devel@linuxdriverproject.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Oscar Salvador <osalvador@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Hildenbrand <david@redhat.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>Paul Mackerras <p>
List-ID: <linux-s390.vger.kernel.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Well require to call add_memory()/add_memory_resource() with
device_hotplug_lock held, to avoid a lock inversion. Allow external modules
(e.g. hv_balloon) that make use of add_memory()/add_memory_resource() to
lock device hotplug.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
[modify patch description]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..9010b9e942b5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -700,11 +700,13 @@ void lock_device_hotplug(void)
 {
 	mutex_lock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(lock_device_hotplug);
 
 void unlock_device_hotplug(void)
 {
 	mutex_unlock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(unlock_device_hotplug);
 
 int lock_device_hotplug_sysfs(void)
 {
-- 
2.17.1
