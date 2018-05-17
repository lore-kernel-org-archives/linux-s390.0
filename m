From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:15:04 +0000
Subject: [PATCH 22/25] zfcp: cleanup indentation for posting FC events
Message-Id: <20180517171507.18237-23-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

I just happened to see the function header indentation of
zfcp_fc_enqueue_event() and I picked some more from checkpatch:

$ checkpatch.pl --strict -f drivers/s390/scsi/zfcp_fc.c
...
CHECK: Alignment should match open parenthesis
 #113: FILE: drivers/s390/scsi/zfcp_fc.c:113:
+		fc_host_post_event(adapter->scsi_host, fc_get_event_number(),
+				event->code, event->data);

CHECK: Blank lines aren't necessary before a close brace '}'
 #118: FILE: drivers/s390/scsi/zfcp_fc.c:118:
+
+}
...

The change complements v2.6.36 commit 2d1e547f7523 ("[SCSI] zfcp: Post
events through FC transport class").

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index 54186943896b..f6c415d6ef48 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -111,11 +111,10 @@ void zfcp_fc_post_event(struct work_struct *work)
 
 	list_for_each_entry_safe(event, tmp, &tmp_lh, list) {
 		fc_host_post_event(adapter->scsi_host, fc_get_event_number(),
-				event->code, event->data);
+				   event->code, event->data);
 		list_del(&event->list);
 		kfree(event);
 	}
-
 }
 
 /**
@@ -126,7 +125,7 @@ void zfcp_fc_post_event(struct work_struct *work)
  * @event_data: The event data (e.g. n_port page in case of els)
  */
 void zfcp_fc_enqueue_event(struct zfcp_adapter *adapter,
-			enum fc_host_event_code event_code, u32 event_data)
+			   enum fc_host_event_code event_code, u32 event_data)
 {
 	struct zfcp_fc_event *event;
 
-- 
2.16.3
