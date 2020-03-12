Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726599AbgCLSPo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 14:15:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CIEbVY099881
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 14:15:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yqt6jr1hh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 14:15:42 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Thu, 12 Mar 2020 17:45:21 -0000
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 02/10] zfcp: expose fabric name as common fc_host sysfs attribute
Date: Thu, 12 Mar 2020 18:44:57 +0100
In-Reply-To: <20200312174505.51294-1-maier@linux.ibm.com>
References: <20200312174505.51294-1-maier@linux.ibm.com>
Message-Id: <20200312174505.51294-3-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>

FICON Express8S or older, as well as card features newer than
FICON Express16S+ have no certain firmware level requirement.

FICON Express16S or FICON Express16S+ have the following
minimum firmware level requirements to show a proper fabric name value:
 z13 machine
  FICON Express16S  , MCL P08424.005 , LIC version 0x00000721
 z14 machine
  FICON Express16S  , MCL P42611.008 , LIC version 0x10200069
  FICON Express16S+ , MCL P42625.010 , LIC version 0x10300147
Otherwise, the read value is not the fabric name.
Each FCP channel of these card features might need one SAN fabric re-login
after concurrent microcode update, in order to show the proper fabric name.
Possible ways to trigger a SAN fabric re-login are one of:
Pull fibres between FCP channel port and SAN switch port on either side
and re-plug, disable SAN switch port adjacent to FCP channel port and
re-enable switch port, or at Service Element toggle off all CHPIDs of
FCP channel over all LPARs and toggle CHPIDs on again.
Zfcp operating subchannels (FCP devices) on such FCP channel recovers
a fabric re-login.

Initialize fabric name for any topology and have it an invalid WWPN
0x0 for anything but fabric topology.
Otherwise for e.g. point-to-point topology one could see the initial
-1 from fc_host_setup() and after a link unplug our fabric name would
turn to 0x0 (with subsequent commit ("zfcp: fix fc_host attributes
that should be unknown on local link down)) and stay 0x0 on link replug.
I did not initialize to 0x0 somewhere even earlier in the code path
such that it would not flap from real to 0x0 to real on e.g. an exchange
config data with fabric topology.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c  | 5 +++++
 drivers/s390/scsi/zfcp_scsi.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 223a805f0b0b..0289b09120f3 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -532,8 +532,10 @@ static int zfcp_fsf_exchange_config_evaluate(struct zfcp_fsf_req *req)
 		adapter->peer_wwpn = be64_to_cpu(plogi->fl_wwpn);
 		adapter->peer_wwnn = be64_to_cpu(plogi->fl_wwnn);
 		fc_host_port_type(shost) = FC_PORTTYPE_PTP;
+		fc_host_fabric_name(shost) = 0;
 		break;
 	case FSF_TOPO_FABRIC:
+		fc_host_fabric_name(shost) = be64_to_cpu(plogi->fl_wwnn);
 		if (bottom->connection_features & FSF_FEATURE_NPIV_MODE)
 			fc_host_port_type(shost) = FC_PORTTYPE_NPIV;
 		else
@@ -541,8 +543,10 @@ static int zfcp_fsf_exchange_config_evaluate(struct zfcp_fsf_req *req)
 		break;
 	case FSF_TOPO_AL:
 		fc_host_port_type(shost) = FC_PORTTYPE_NLPORT;
+		fc_host_fabric_name(shost) = 0;
 		/* fall through */
 	default:
+		fc_host_fabric_name(shost) = 0;
 		dev_err(&adapter->ccw_device->dev,
 			"Unknown or unsupported arbitrated loop "
 			"fibre channel topology detected\n");
@@ -601,6 +605,7 @@ static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 		fc_host_node_name(shost) = 0;
 		fc_host_port_name(shost) = 0;
 		fc_host_port_id(shost) = 0;
+		fc_host_fabric_name(shost) = 0;
 		fc_host_speed(shost) = FC_PORTSPEED_UNKNOWN;
 		fc_host_port_type(shost) = FC_PORTTYPE_UNKNOWN;
 		adapter->hydra_version = 0;
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index 3910d529c15a..cb7efe8b2753 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -871,5 +871,6 @@ struct fc_function_template zfcp_transport_functions = {
 	.show_host_symbolic_name = 1,
 	.show_host_speed = 1,
 	.show_host_port_id = 1,
+	.show_host_fabric_name = 1,
 	.dd_bsg_size = sizeof(struct zfcp_fsf_ct_els),
 };
-- 
2.17.1
