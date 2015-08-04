Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Senna Tschudin <peter.senna@gmail.com>
Subject: [PATCH 1/2] s390: Remove unneeded semicolon
Date: Tue,  4 Aug 2015 17:11:15 +0200
Message-Id: <1438701075-30664-1-git-send-email-peter.senna@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: wein@de.ibm.com, stefan.haberland@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, maier@linux.vnet.ibm.com, peter.senna@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Remove unneeded semicolon.

The semantic patch that detects this change is available
at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
Tested by cross compilation only.

 drivers/s390/block/dasd_alias.c | 6 +++---
 drivers/s390/char/monreader.c   | 2 +-
 drivers/s390/scsi/zfcp_fsf.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index a2597e6..19805a72 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -58,7 +58,7 @@ static struct alias_server *_find_server(struct dasd_uid *uid)
 		    && !strncmp(pos->uid.serial, uid->serial,
 				sizeof(uid->serial)))
 			return pos;
-	};
+	}
 	return NULL;
 }
 
@@ -69,7 +69,7 @@ static struct alias_lcu *_find_lcu(struct alias_server *server,
 	list_for_each_entry(pos, &server->lculist, lcu) {
 		if (pos->uid.ssid == uid->ssid)
 			return pos;
-	};
+	}
 	return NULL;
 }
 
@@ -97,7 +97,7 @@ static struct alias_pav_group *_find_group(struct alias_lcu *lcu,
 		if (pos->uid.base_unit_addr == search_unit_addr &&
 		    !strncmp(pos->uid.vduit, uid->vduit, sizeof(uid->vduit)))
 			return pos;
-	};
+	}
 	return NULL;
 }
 
diff --git a/drivers/s390/char/monreader.c b/drivers/s390/char/monreader.c
index 0da3ae3..b7d6030 100644
--- a/drivers/s390/char/monreader.c
+++ b/drivers/s390/char/monreader.c
@@ -95,7 +95,7 @@ static void dcss_mkname(char *ascii_name, char *ebcdic_name)
 		if (ascii_name[i] == '\0')
 			break;
 		ebcdic_name[i] = toupper(ascii_name[i]);
-	};
+	}
 	for (; i < 8; i++)
 		ebcdic_name[i] = ' ';
 	ASCEBC(ebcdic_name, 8);
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 21ec5e2..4ac73e0 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -204,7 +204,7 @@ static void zfcp_fsf_status_read_link_down(struct zfcp_fsf_req *req)
 		break;
 	case FSF_STATUS_READ_SUB_FIRMWARE_UPDATE:
 		zfcp_fsf_link_down_info_eval(req, NULL);
-	};
+	}
 }
 
 static void zfcp_fsf_status_read_handler(struct zfcp_fsf_req *req)
-- 
2.1.0
