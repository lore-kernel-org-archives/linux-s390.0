Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18865 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727832AbgEHRXs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 13:23:48 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 6/8] zfcp: fence adapter status propagation for common statuses
Date: Fri,  8 May 2020 19:23:33 +0200
Message-Id: <f51fe5f236a1e3d1ce53379c308777561bfe35e1.1588956679.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1588956679.git.bblock@linux.ibm.com>
References: <cover.1588956679.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

Common status flags that all main objects - adapter, port, and unit -
support are propagated to sub-objects when set or cleared. For instance,
when setting the status ZFCP_STATUS_COMMON_ERP_INUSE for an adapter
object, we will propagate this to all its child ports and units - same
for when clearing a common status flag.

Units of an adapter object are enumerated via __shost_for_each_device()
over the scsi host object of the corresponding adapter.

Once we move the scsi host object allocation and registration to after
the first exchange config and exchange port data, this won't be possible
for cases where we set or clear common statuses during the very first
adapter recovery.

But since we won't have any port or unit objects yet at that point of
time, we can just fence the status propagation for cases where the scsi
host object is not yet set in the adapter object. It won't change any
effective status propagations, but will prevent us from dereferencing
invalid pointers.

For any later point in the work flow the scsi host object will be set
and thus nothing is changed then.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 356f51d2bbee..283bcb985655 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -1642,6 +1642,13 @@ void zfcp_erp_set_adapter_status(struct zfcp_adapter *adapter, u32 mask)
 		atomic_or(common_mask, &port->status);
 	read_unlock_irqrestore(&adapter->port_list_lock, flags);
 
+	/*
+	 * if `scsi_host` is missing, xconfig/xport data has never completed
+	 * yet, so we can't access it, but there are also no SDEVs yet
+	 */
+	if (adapter->scsi_host == NULL)
+		return;
+
 	spin_lock_irqsave(adapter->scsi_host->host_lock, flags);
 	__shost_for_each_device(sdev, adapter->scsi_host)
 		atomic_or(common_mask, &sdev_to_zfcp(sdev)->status);
@@ -1679,6 +1686,13 @@ void zfcp_erp_clear_adapter_status(struct zfcp_adapter *adapter, u32 mask)
 	}
 	read_unlock_irqrestore(&adapter->port_list_lock, flags);
 
+	/*
+	 * if `scsi_host` is missing, xconfig/xport data has never completed
+	 * yet, so we can't access it, but there are also no SDEVs yet
+	 */
+	if (adapter->scsi_host == NULL)
+		return;
+
 	spin_lock_irqsave(adapter->scsi_host->host_lock, flags);
 	__shost_for_each_device(sdev, adapter->scsi_host) {
 		atomic_andnot(common_mask, &sdev_to_zfcp(sdev)->status);
-- 
2.17.1
