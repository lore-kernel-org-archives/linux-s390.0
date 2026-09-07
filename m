Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB83AE199
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763144; cv=none; b=H3DMUZh/IcaTgdYzEyLzxYGuilTz7D4RMfz7D8888ptJbHUkUrEtCbf2wxhhZKsP3x7VxshRTeI6NDwUUBx+mduxkkm1WiMM6HhhU/q3c78Yb+F9JogsInFqopmcGvKJ85f0Hect24ojJU1QG42/U9+t+Wgfm447owTbtcSkm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763144; c=relaxed/simple;
	bh=jEgkKwiyoxuMC5wTr8kixxozONSkfyPRKTMBVQAHgQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEuTrcu3ArL70OpVhrL8bGO8Fxn/+BJb3n1/6bqUYx9p8o+GOvFkPi/IPUnijkaxggkld12Z7kF5WbUTFetAhKJszKKXYrGd9sjdswGTUckwYzOXHRTvnVocDreeMMA3dP36pHO2uFrWiePZsQjuCZXmERsTbPsskV0OAwku9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rI6CxK9Q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI6CxK9Q"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso2093196a12.0
        for <linux-s390@vger.kernel.org>; Sun, 06 Sep 2026 23:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763142; x=1789367942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s/FXUJ33N4p0Q7W6CXLXn9+k4avrHrXQ3KzqocooPUA=;
        b=rI6CxK9QD7AeHuw/QIoZVlTlfv+hszg4SAGcWB4jJ74EXm4wTgOtBotnb2x2i+KfcP
         FMaXwuL6yw7gYj2mDDHOwnDcWHUBVH2W/8/YXqmcXEQ3Bq/x5WT+jCuNzuGjyDgSOzK3
         AvVPdF8lrQw7QmsI4ZBEZ/5s/oh+fsfOCYivyp8kH+NDdlsKztk1Ejwv+SZLa1G599q+
         E0yj+wyp+IyTDTLqnPpgiEJgBs2/IitDJJ+VGZBFyiHpGWpv1izUvod3OtjQ2AQwYJuK
         tDuoAnSyh6Dnrv+Cq8BZg+/Fy2zxh+gENZ7y797SaZ1LBXwAwdFA9P88qCDhHD4+F3ng
         OgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763142; x=1789367942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/FXUJ33N4p0Q7W6CXLXn9+k4avrHrXQ3KzqocooPUA=;
        b=BsjEChFJfNkU9UNxvPlBcGVsBZj3qZEx5l5eZojxRgTwG4MuzeYL+eThKU6b+Nq2h3
         k9qK1tEFaeVMmzNH3XoOrb8GG68IckCijqA61fsz2+4/pihoHloAh0ThtIL7ueLu6vEy
         oC2qba0BSInPqzBUAL1RITyjXtunu2CW9Jb6w+XhCsh/I7LgUc4J9fGgX+s44A8MczhZ
         kCqiqfpKUpXJGbZWx157ZhBb/jNeGI81XMTFN+eP9u29Ra0AB9jnw8QhceLF2tp2kxXX
         J7/T2MrVhh66ULmnqWc4tlynLUlH6W/S/OwnTxf8CGDYYq4vfi4kEUsOzw8zbwU4I4BC
         dfSg==
X-Gm-Message-State: AFuF++mASa1Q0RL0genRanBY8OgWjYFT10aPA4kHL95+XunI3Mlt3Fvc
	wJvsv76H0qPsBXNuUR+lE7uH82Io13HvW4MvWCKL8XEFeumMec3SwOuq
X-Gm-Gg: AYBFou2FLwxNO0Z/LhPvY/YYBRBK0TXmyPi3+7gSUQqL6MwAy4bvct97JScbokYMxH4
	A1aOf6d16U4zv5+/dH7+zsjLkjfQFhiUKOI3LKG5UnhuTZBOVhWWTYvSmQs9zI1fLSlE4oZQSJJ
	taNiDVkYqlKLkcXFjJvxUnYp3Y5n5Dvl+fH95ObDkllJhe4IsuqFO5vwl6kcaDCeoIatC2O4bQt
	dGBNa/UTeuWhkxzErHXwiqHYOquXyJoFbVsANv6ei5OjGyNnJPhCyPo4RMgnItGeKxZVUG7390C
	SjCOLDFzniPACv22TuvpAHwlIVhQ8c2qo3adSUwitACR653dRKNmSNBSRzjMDoKSyYZPW3UeAi4
	ye5xc+J1uS9V8J1tRUlQSmGS63OjNL1U8AROuEjmN6nqaS8Vf6/svVtAmM6+1PmSsz9fwPSaD9H
	V4O7Cc+dKCGM7/TZKafjVL1MINJ1Fy1G/HHK+Hi4JymJsm5xYIHNBsg7fTCyfuEv52W8vt0w6U1
	ysOStye+C2JKQ==
X-Received: by 2002:a05:6a20:4311:b0:3c3:bbe6:95de with SMTP id adf61e73a8af0-3da39eacfc8mr26989135637.6.1788763141995;
        Sun, 06 Sep 2026 23:39:01 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-336c2571039sm7367363eec.25.2026.09.06.23.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:39:01 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390: fix typos in comments
Date: Mon,  7 Sep 2026 12:08:56 +0530
Message-ID: <20260907063856.27600-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/s390/block/dasd_3990_erp.c | 6 +++---
 drivers/s390/block/dasd_eckd.c     | 4 ++--
 drivers/s390/char/raw3270.c        | 2 +-
 drivers/s390/char/vmlogrdr.c       | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 736459477c19..121cb9ae5c67 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -103,7 +103,7 @@ dasd_3990_erp_int_req(struct dasd_ccw_req * erp)
 
 	/* first time set initial retry counter and erp_function */
 	/* and retry once without blocking queue		 */
-	/* (this enables easier enqueing of the cqr)		 */
+	/* (this enables easier enqueuing of the cqr)		 */
 	if (erp->function != dasd_3990_erp_int_req) {
 
 		erp->retries = 256;
@@ -302,7 +302,7 @@ dasd_3990_erp_action_4(struct dasd_ccw_req * erp, char *sense)
 
 	/* first time set initial retry counter and erp_function    */
 	/* and retry once without waiting for state change pending  */
-	/* interrupt (this enables easier enqueing of the cqr)	    */
+	/* interrupt (this enables easier enqueuing of the cqr)	    */
 	if (erp->function != dasd_3990_erp_action_4) {
 
 		DBF_DEV_EVENT(DBF_INFO, device, "%s",
@@ -1078,7 +1078,7 @@ dasd_3990_erp_bus_out(struct dasd_ccw_req * erp)
 
 	/* first time set initial retry counter and erp_function */
 	/* and retry once without blocking queue		 */
-	/* (this enables easier enqueing of the cqr)		 */
+	/* (this enables easier enqueuing of the cqr)		 */
 	if (erp->function != dasd_3990_erp_bus_out) {
 		erp->retries = 256;
 		erp->function = dasd_3990_erp_bus_out;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 8d976dd58a6c..9d1b11020b4e 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2060,7 +2060,7 @@ dasd_eckd_psf_ssc(struct dasd_device *device, int enable_pav,
 }
 
 /*
- * Valide storage server of current device.
+ * Valid storage server of current device.
  */
 static int dasd_eckd_validate_server(struct dasd_device *device,
 				     unsigned long flags)
@@ -5672,7 +5672,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 	char *dst;
 
 	/*
-	 * raw track access needs to be mutiple of 64k and on 64k boundary
+	 * raw track access needs to be multiple of 64k and on 64k boundary
 	 * For read requests we can fix an incorrect alignment by padding
 	 * the request with dummy pages.
 	 */
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index aa9c4d81225c..6861bf27d15f 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -420,7 +420,7 @@ struct raw3270_ua {	/* Query Reply structure for Usable Area */
 		char  flags0;
 		char  flags1;
 		short w;	/* Width of usable area */
-		short h;	/* Heigth of usavle area */
+		short h;	/* Height of usavle area */
 		char  units;	/* 0x00:in; 0x01:mm */
 		int   xr;
 		int   yr;
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 383e7e2bd69f..005735a89920 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -444,7 +444,7 @@ static int vmlogrdr_receive_data(struct vmlogrdr_priv_t *priv)
 		spin_unlock_bh(&priv->priv_lock);
 		/* An rc of 5 indicates that the record was bigger than
 		 * the buffer, which is OK for us. A 9 indicates that the
-		 * record was purged befor we could receive it.
+		 * record was purged before we could receive it.
 		 */
 		if (rc == 5)
 			rc = 0;
-- 
2.48.1

