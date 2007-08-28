From: Swen Schillig <swen@vnet.ibm.com>
Date: Tue, 28 Aug 2007 07:31:09 +0000
Subject: [PATCH 7/10] zfcp: cleanup, separation of ERP, non ERP-version for exchange_ functions
Message-Id: <200708280931.09719.swen@vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Swen Schillig <swen@vnet.ibm.com>

cleanup, using ERP request mempool for all ERP versions of
the exchange functions (exchange_config (ECD), exchange_port (EPD) )
providing individual versions of the ECD, EPD functions for ERP 
and other purposes (_sync).

Signed-off-by: Swen Schillig <swen@vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c  |    2 
 drivers/s390/scsi/zfcp_ext.h  |    8 -
 drivers/s390/scsi/zfcp_fsf.c  |  231 ++++++++++++++++++++++++++++++------------
 drivers/s390/scsi/zfcp_scsi.c |    5 
 4 files changed, 175 insertions(+), 71 deletions(-)

Index: HEAD/drivers/s390/scsi/zfcp_ext.h
===================================================================
--- HEAD.orig/drivers/s390/scsi/zfcp_ext.h
+++ HEAD/drivers/s390/scsi/zfcp_ext.h
@@ -82,9 +82,11 @@ extern int  zfcp_fsf_open_unit(struct zf
 extern int  zfcp_fsf_close_unit(struct zfcp_erp_action *);
 
 extern int  zfcp_fsf_exchange_config_data(struct zfcp_erp_action *);
-extern int  zfcp_fsf_exchange_port_data(struct zfcp_erp_action *,
-					struct zfcp_adapter *,
-					struct fsf_qtcb_bottom_port *);
+extern int  zfcp_fsf_exchange_config_data_sync(struct zfcp_adapter *,
+                                              struct fsf_qtcb_bottom_config *);
+extern int  zfcp_fsf_exchange_port_data(struct zfcp_erp_action *);
+extern int  zfcp_fsf_exchange_port_data_sync(struct zfcp_adapter *,
+                                             struct fsf_qtcb_bottom_port *);
 extern int  zfcp_fsf_control_file(struct zfcp_adapter *, struct zfcp_fsf_req **,
 				  u32, u32, struct zfcp_sg_list *);
 extern void zfcp_fsf_start_timer(struct zfcp_fsf_req *, unsigned long);
Index: HEAD/drivers/s390/scsi/zfcp_fsf.c
===================================================================
--- HEAD.orig/drivers/s390/scsi/zfcp_fsf.c
+++ HEAD/drivers/s390/scsi/zfcp_fsf.c
@@ -1941,25 +1941,28 @@ zfcp_fsf_exchange_config_data(struct zfc
 {
 	volatile struct qdio_buffer_element *sbale;
 	struct zfcp_fsf_req *fsf_req;
+	struct zfcp_adapter *adapter = erp_action->adapter;
 	unsigned long lock_flags;
-	int retval = 0;
+	int retval;
 
 	/* setup new FSF request */
-	retval = zfcp_fsf_req_create(erp_action->adapter,
+	retval = zfcp_fsf_req_create(adapter,
 				     FSF_QTCB_EXCHANGE_CONFIG_DATA,
 				     ZFCP_REQ_AUTO_CLEANUP,
-				     erp_action->adapter->pool.fsf_req_erp,
+				     adapter->pool.fsf_req_erp,
 				     &lock_flags, &fsf_req);
-	if (retval < 0) {
+	if (retval) {
 		ZFCP_LOG_INFO("error: Could not create exchange configuration "
 			      "data request for adapter %s.\n",
-			      zfcp_get_busid_by_adapter(erp_action->adapter));
-		goto out;
+			      zfcp_get_busid_by_adapter(adapter));
+		write_unlock_irqrestore(&adapter->request_queue.queue_lock,
+					lock_flags);
+		return retval;
 	}
 
 	sbale = zfcp_qdio_sbale_req(fsf_req, fsf_req->sbal_curr, 0);
-        sbale[0].flags |= SBAL_FLAGS0_TYPE_READ;
-        sbale[1].flags |= SBAL_FLAGS_LAST_ENTRY;
+	sbale[0].flags |= SBAL_FLAGS0_TYPE_READ;
+	sbale[1].flags |= SBAL_FLAGS_LAST_ENTRY;
 
 	fsf_req->qtcb->bottom.config.feature_selection =
 			FSF_FEATURE_CFDC |
@@ -1971,23 +1974,71 @@ zfcp_fsf_exchange_config_data(struct zfc
 
 	zfcp_erp_start_timer(fsf_req);
 	retval = zfcp_fsf_req_send(fsf_req);
+	write_unlock_irqrestore(&adapter->request_queue.queue_lock,
+				lock_flags);
 	if (retval) {
-		ZFCP_LOG_INFO
-		    ("error: Could not send exchange configuration data "
-		     "command on the adapter %s\n",
-		     zfcp_get_busid_by_adapter(erp_action->adapter));
+		ZFCP_LOG_INFO("error: Could not send exchange configuration "
+			      "data command on the adapter %s\n",
+			      zfcp_get_busid_by_adapter(adapter));
 		zfcp_fsf_req_free(fsf_req);
 		erp_action->fsf_req = NULL;
-		goto out;
 	}
+	else
+		ZFCP_LOG_DEBUG("exchange configuration data request initiated "
+			       "(adapter %s)\n",
+			       zfcp_get_busid_by_adapter(adapter));
 
-	ZFCP_LOG_DEBUG("exchange configuration data request initiated "
-		       "(adapter %s)\n",
-		       zfcp_get_busid_by_adapter(erp_action->adapter));
+	return retval;
+}
 
- out:
-	write_unlock_irqrestore(&erp_action->adapter->request_queue.queue_lock,
+int
+zfcp_fsf_exchange_config_data_sync(struct zfcp_adapter *adapter,
+				struct fsf_qtcb_bottom_config *data)
+{
+	volatile struct qdio_buffer_element *sbale;
+	struct zfcp_fsf_req *fsf_req;
+	unsigned long lock_flags;
+	int retval;
+
+	/* setup new FSF request */
+	retval = zfcp_fsf_req_create(adapter, FSF_QTCB_EXCHANGE_CONFIG_DATA,
+				     0, NULL, &lock_flags, &fsf_req);
+	if (retval) {
+		ZFCP_LOG_INFO("error: Could not create exchange configuration "
+			      "data request for adapter %s.\n",
+			      zfcp_get_busid_by_adapter(adapter));
+		write_unlock_irqrestore(&adapter->request_queue.queue_lock,
+					lock_flags);
+		return retval;
+	}
+
+	sbale = zfcp_qdio_sbale_req(fsf_req, fsf_req->sbal_curr, 0);
+	sbale[0].flags |= SBAL_FLAGS0_TYPE_READ;
+	sbale[1].flags |= SBAL_FLAGS_LAST_ENTRY;
+
+	fsf_req->qtcb->bottom.config.feature_selection =
+			FSF_FEATURE_CFDC |
+			FSF_FEATURE_LUN_SHARING |
+			FSF_FEATURE_NOTIFICATION_LOST |
+			FSF_FEATURE_UPDATE_ALERT;
+
+	if (data)
+		fsf_req->data = (unsigned long) data;
+
+	zfcp_fsf_start_timer(fsf_req, ZFCP_FSF_REQUEST_TIMEOUT);
+	retval = zfcp_fsf_req_send(fsf_req);
+	write_unlock_irqrestore(&adapter->request_queue.queue_lock,
 				lock_flags);
+	if (retval)
+		ZFCP_LOG_INFO("error: Could not send exchange configuration "
+			      "data command on the adapter %s\n",
+			      zfcp_get_busid_by_adapter(adapter));
+	else
+		wait_event(fsf_req->completion_wq,
+			   fsf_req->status & ZFCP_STATUS_FSFREQ_COMPLETED);
+
+	zfcp_fsf_req_free(fsf_req);
+
 	return retval;
 }
 
@@ -2016,11 +2067,17 @@ zfcp_fsf_exchange_config_evaluate(struct
 	adapter->peer_d_id = 0;
 
 	if (xchg_ok) {
+
+		if (fsf_req->data)
+			memcpy((struct fsf_qtcb_bottom_config *) fsf_req->data,
+				bottom, sizeof (struct fsf_qtcb_bottom_config));
+
 		fc_host_node_name(shost) = bottom->nport_serv_param.wwnn;
 		fc_host_port_name(shost) = bottom->nport_serv_param.wwpn;
 		fc_host_port_id(shost) = bottom->s_id & ZFCP_DID_MASK;
 		fc_host_speed(shost) = bottom->fc_link_speed;
-		fc_host_supported_classes(shost) = FC_COS_CLASS2 | FC_COS_CLASS3;
+		fc_host_supported_classes(shost) =
+				FC_COS_CLASS2 | FC_COS_CLASS3;
 		adapter->hydra_version = bottom->adapter_type;
 		if (fc_host_permanent_port_name(shost) == -1)
 			fc_host_permanent_port_name(shost) =
@@ -2053,7 +2110,8 @@ zfcp_fsf_exchange_config_evaluate(struct
 		       min(FC_SERIAL_NUMBER_SIZE, 17));
 	}
 
-	ZFCP_LOG_NORMAL("The adapter %s reported the following characteristics:\n"
+	ZFCP_LOG_NORMAL("The adapter %s reported the following "
+			"characteristics:\n"
 			"WWNN 0x%016Lx, "
 			"WWPN 0x%016Lx, "
 			"S_ID 0x%06x,\n"
@@ -2090,7 +2148,7 @@ zfcp_fsf_exchange_config_evaluate(struct
 	return 0;
 }
 
-/*
+/**
  * function:    zfcp_fsf_exchange_config_data_handler
  *
  * purpose:     is called for finished Exchange Configuration Data command
@@ -2125,7 +2183,7 @@ zfcp_fsf_exchange_config_data_handler(st
 					adapter->peer_wwpn,
 					adapter->peer_d_id);
 			debug_text_event(fsf_req->adapter->erp_dbf, 0,
-					 "top-p-to-p");
+					"top-p-to-p");
 			break;
 		case FC_PORTTYPE_NLPORT:
 			ZFCP_LOG_NORMAL("error: Arbitrated loop fibrechannel "
@@ -2138,8 +2196,8 @@ zfcp_fsf_exchange_config_data_handler(st
 			return -EIO;
 		case FC_PORTTYPE_NPORT:
 			ZFCP_LOG_NORMAL("Switched fabric fibrechannel "
-				      "network detected at adapter %s.\n",
-				      zfcp_get_busid_by_adapter(adapter));
+					"network detected at adapter %s.\n",
+					zfcp_get_busid_by_adapter(adapter));
 			break;
 		default:
 			ZFCP_LOG_NORMAL("bug: The fibrechannel topology "
@@ -2179,7 +2237,8 @@ zfcp_fsf_exchange_config_data_handler(st
 		if (zfcp_fsf_exchange_config_evaluate(fsf_req, 0))
 			return -EIO;
 
-		atomic_set_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK, &adapter->status);
+		atomic_set_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK,
+				&adapter->status);
 
 		zfcp_fsf_link_down_info_eval(adapter,
 			&qtcb->header.fsf_status_qual.link_down_info);
@@ -2187,7 +2246,7 @@ zfcp_fsf_exchange_config_data_handler(st
 	default:
 		debug_text_event(fsf_req->adapter->erp_dbf, 0, "fsf-stat-ng");
 		debug_event(fsf_req->adapter->erp_dbf, 0,
-			    &fsf_req->qtcb->header.fsf_status, sizeof (u32));
+			    &fsf_req->qtcb->header.fsf_status, sizeof(u32));
 		zfcp_erp_adapter_shutdown(adapter, 0);
 		return -EIO;
 	}
@@ -2197,74 +2256,118 @@ zfcp_fsf_exchange_config_data_handler(st
 /**
  * zfcp_fsf_exchange_port_data - request information about local port
  * @erp_action: ERP action for the adapter for which port data is requested
- * @adapter: for which port data is requested
- * @data: response to exchange port data request
  */
 int
-zfcp_fsf_exchange_port_data(struct zfcp_erp_action *erp_action,
-			    struct zfcp_adapter *adapter,
-			    struct fsf_qtcb_bottom_port *data)
+zfcp_fsf_exchange_port_data(struct zfcp_erp_action *erp_action)
 {
 	volatile struct qdio_buffer_element *sbale;
-        struct zfcp_fsf_req *fsf_req;
+	struct zfcp_fsf_req *fsf_req;
+	struct zfcp_adapter *adapter = erp_action->adapter;
 	unsigned long lock_flags;
-	int retval = 0;
+	int retval;
 
 	if (!(adapter->adapter_features & FSF_FEATURE_HBAAPI_MANAGEMENT)) {
 		ZFCP_LOG_INFO("error: exchange port data "
-                              "command not supported by adapter %s\n",
+			      "command not supported by adapter %s\n",
 			      zfcp_get_busid_by_adapter(adapter));
-                return -EOPNOTSUPP;
-        }
+		return -EOPNOTSUPP;
+	}
 
 	/* setup new FSF request */
 	retval = zfcp_fsf_req_create(adapter, FSF_QTCB_EXCHANGE_PORT_DATA,
-				     erp_action ? ZFCP_REQ_AUTO_CLEANUP : 0,
-				     NULL, &lock_flags, &fsf_req);
-	if (retval < 0) {
+				     ZFCP_REQ_AUTO_CLEANUP,
+				     adapter->pool.fsf_req_erp,
+				     &lock_flags, &fsf_req);
+	if (retval) {
 		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-                              "exchange port data request for"
-                              "the adapter %s.\n",
+			      "exchange port data request for"
+			      "the adapter %s.\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		write_unlock_irqrestore(&adapter->request_queue.queue_lock,
 					lock_flags);
 		return retval;
 	}
 
-	if (data)
-		fsf_req->data = (unsigned long) data;
-
 	sbale = zfcp_qdio_sbale_req(fsf_req, fsf_req->sbal_curr, 0);
-        sbale[0].flags |= SBAL_FLAGS0_TYPE_READ;
-        sbale[1].flags |= SBAL_FLAGS_LAST_ENTRY;
+	sbale[0].flags |= SBAL_FLAGS0_TYPE_READ;
+	sbale[1].flags |= SBAL_FLAGS_LAST_ENTRY;
 
-	if (erp_action) {
-		erp_action->fsf_req = fsf_req;
-		fsf_req->erp_action = erp_action;
-		zfcp_erp_start_timer(fsf_req);
-	} else
-		zfcp_fsf_start_timer(fsf_req, ZFCP_FSF_REQUEST_TIMEOUT);
+	erp_action->fsf_req = fsf_req;
+	fsf_req->erp_action = erp_action;
+	zfcp_erp_start_timer(fsf_req);
 
 	retval = zfcp_fsf_req_send(fsf_req);
+	write_unlock_irqrestore(&adapter->request_queue.queue_lock, lock_flags);
+
 	if (retval) {
 		ZFCP_LOG_INFO("error: Could not send an exchange port data "
-                              "command on the adapter %s\n",
+			      "command on the adapter %s\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		zfcp_fsf_req_free(fsf_req);
-		if (erp_action)
-			erp_action->fsf_req = NULL;
+		erp_action->fsf_req = NULL;
+	}
+	else
+		ZFCP_LOG_DEBUG("exchange port data request initiated "
+			       "(adapter %s)\n",
+			       zfcp_get_busid_by_adapter(adapter));
+	return retval;
+}
+
+
+/**
+ * zfcp_fsf_exchange_port_data_sync - request information about local port
+ * and wait until information is ready
+ */
+int
+zfcp_fsf_exchange_port_data_sync(struct zfcp_adapter *adapter,
+				struct fsf_qtcb_bottom_port *data)
+{
+	volatile struct qdio_buffer_element *sbale;
+	struct zfcp_fsf_req *fsf_req;
+	unsigned long lock_flags;
+	int retval;
+
+	if (!(adapter->adapter_features & FSF_FEATURE_HBAAPI_MANAGEMENT)) {
+		ZFCP_LOG_INFO("error: exchange port data "
+			      "command not supported by adapter %s\n",
+			      zfcp_get_busid_by_adapter(adapter));
+		return -EOPNOTSUPP;
+	}
+
+	/* setup new FSF request */
+	retval = zfcp_fsf_req_create(adapter, FSF_QTCB_EXCHANGE_PORT_DATA,
+				0, NULL, &lock_flags, &fsf_req);
+	if (retval) {
+		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
+			      "exchange port data request for"
+			      "the adapter %s.\n",
+			      zfcp_get_busid_by_adapter(adapter));
 		write_unlock_irqrestore(&adapter->request_queue.queue_lock,
 					lock_flags);
 		return retval;
 	}
 
+	if (data)
+		fsf_req->data = (unsigned long) data;
+
+	sbale = zfcp_qdio_sbale_req(fsf_req, fsf_req->sbal_curr, 0);
+	sbale[0].flags |= SBAL_FLAGS0_TYPE_READ;
+	sbale[1].flags |= SBAL_FLAGS_LAST_ENTRY;
+
+	zfcp_fsf_start_timer(fsf_req, ZFCP_FSF_REQUEST_TIMEOUT);
+	retval = zfcp_fsf_req_send(fsf_req);
 	write_unlock_irqrestore(&adapter->request_queue.queue_lock, lock_flags);
 
-	if (!erp_action) {
+	if (retval)
+		ZFCP_LOG_INFO("error: Could not send an exchange port data "
+			      "command on the adapter %s\n",
+			      zfcp_get_busid_by_adapter(adapter));
+	else
 		wait_event(fsf_req->completion_wq,
 			   fsf_req->status & ZFCP_STATUS_FSFREQ_COMPLETED);
-		zfcp_fsf_req_free(fsf_req);
-	}
+
+	zfcp_fsf_req_free(fsf_req);
+
 	return retval;
 }
 
@@ -2277,18 +2380,16 @@ static void
 zfcp_fsf_exchange_port_evaluate(struct zfcp_fsf_req *fsf_req, int xchg_ok)
 {
 	struct zfcp_adapter *adapter;
-	struct fsf_qtcb *qtcb;
-	struct fsf_qtcb_bottom_port *bottom, *data;
+	struct fsf_qtcb_bottom_port *bottom;
 	struct Scsi_Host *shost;
 
 	adapter = fsf_req->adapter;
-	qtcb = fsf_req->qtcb;
-	bottom = &qtcb->bottom.port;
+	bottom = &fsf_req->qtcb->bottom.port;
 	shost = adapter->scsi_host;
 
-	data = (struct fsf_qtcb_bottom_port*) fsf_req->data;
-	if (data)
-		memcpy(data, bottom, sizeof(struct fsf_qtcb_bottom_port));
+	if (fsf_req->data)
+		memcpy((struct fsf_qtcb_bottom_port*) fsf_req->data, bottom,
+			sizeof(struct fsf_qtcb_bottom_port));
 
 	if (adapter->connection_features & FSF_FEATURE_NPIV_MODE)
 		fc_host_permanent_port_name(shost) = bottom->wwpn;
Index: HEAD/drivers/s390/scsi/zfcp_scsi.c
===================================================================
--- HEAD.orig/drivers/s390/scsi/zfcp_scsi.c
+++ HEAD/drivers/s390/scsi/zfcp_scsi.c
@@ -731,7 +731,7 @@ zfcp_get_fc_host_stats(struct Scsi_Host 
 	if (!data)
 		return NULL;
 
-	ret = zfcp_fsf_exchange_port_data(NULL, adapter, data);
+	ret = zfcp_fsf_exchange_port_data_sync(adapter, data);
 	if (ret) {
 		kfree(data);
 		return NULL; /* XXX return zeroed fc_stats? */
@@ -761,7 +761,7 @@ zfcp_reset_fc_host_stats(struct Scsi_Hos
 	if (!data)
 		return;
 
-	ret = zfcp_fsf_exchange_port_data(NULL, adapter, data);
+	ret = zfcp_fsf_exchange_port_data_sync(adapter, data);
 	if (ret) {
 		kfree(data);
 	} else {
@@ -800,6 +800,7 @@ struct fc_function_template zfcp_transpo
 	.show_host_port_type = 1,
 	.show_host_speed = 1,
 	.show_host_port_id = 1,
+	.disable_target_scan = 1,
 };
 
 /**
Index: HEAD/drivers/s390/scsi/zfcp_erp.c
===================================================================
--- HEAD.orig/drivers/s390/scsi/zfcp_erp.c
+++ HEAD/drivers/s390/scsi/zfcp_erp.c
@@ -2197,7 +2197,7 @@ zfcp_erp_adapter_strategy_open_fsf_xport
 	zfcp_erp_action_to_running(erp_action);
 	write_unlock_irq(&adapter->erp_lock);
 
-	ret = zfcp_fsf_exchange_port_data(erp_action, adapter, NULL);
+	ret = zfcp_fsf_exchange_port_data(erp_action);
 	if (ret == -EOPNOTSUPP) {
 		debug_text_event(adapter->erp_dbf, 3, "a_xport_notsupp");
 		return ZFCP_ERP_SUCCEEDED;
