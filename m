Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EF1D8A0D;
	Wed, 15 Jan 2025 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970945; cv=none; b=Eu1GPZ2ZINxCJrYJIe84liavGKs4+9VgXTSPuuypP1lCW2gafXeqci5WQueAk4JnRgB4NEOALFbP2XXWk/q/ACPWuBHxvKFIx9S34vJxjE0iQoRNaTScblKa75D/vWIIulxPpAwnqpX/0BF2hdTrkyL9UxXUYLQLVLNM32WMtFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970945; c=relaxed/simple;
	bh=FUjlJDN+4Nksbi6eIo9rP1tSJz6LipiNnlHfrpQ3pRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpLNok7euy+EF8Otfm9RgrOGkD+G0kJ6jvNpS2Di6or0kCzQVLIcP1eyy4KjILotsr6U9UzoSxbnZWWX7jMzy2kWk8C+nyctpc5ztACJeT4V+Berer+mL+K8oPHDiqEIW67nNZwZDd+DMvYGcyezeeTy7MARgHLx8v42pJfvISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c6c3nm+G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c6c3nm+G"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHXS0k028583;
	Wed, 15 Jan 2025 19:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E29i78O/hTJl7fkSQ
	LdRdQR4cRCFr5mDjPRMvTCVJqo=; b=c6c3nm+GjwlhF52S+zkx3ZMCVVS3fOOEu
	sG+BHAiAyxAkF0LbzB84H6+BoYCq9bbwMpheSoiHGxBsGWv1HQb3x6t2jpjVfpT0
	zuccXokxli4vzfkjyidX1eTEF36VLu35khoAkd1jXB8UXgDgH3yk+B/JQ8XMPLJm
	iP507qjENuAbzU+GifjFYggSU6c3g6wbdGA55mhkrRCCI3aPPZ56S+cpDlgCgx2T
	D6BL48vDKTHBR+U/VPFLxyQDnuEEe+NQ4Spa5MRFz1bBR48lJ4Bm7EhmNw/jsLGb
	GypgeuUxfWKJID23Z/w037QvYdicgD8EeiTrykOOfeJ6G4MKD/Pew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gjvcd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FJtXWR011500;
	Wed, 15 Jan 2025 19:55:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gjvcd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHaxFb007364;
	Wed, 15 Jan 2025 19:55:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yna6ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FJtR5M50987410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:55:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99C702004B;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ADFF20040;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 4E7C6E0D86; Wed, 15 Jan 2025 20:55:27 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [RFC net-next 4/7] net/ism: Add kernel-doc comments for ism functions
Date: Wed, 15 Jan 2025 20:55:24 +0100
Message-ID: <20250115195527.2094320-5-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115195527.2094320-1-wintera@linux.ibm.com>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MY-skRTw3QyqdBbcymjsfS-DEPy2j0CA
X-Proofpoint-GUID: e1nNPZiZHo9fi1SEkJK_9v7zxkxXLzFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150142

Note that in this RFC this patch is not complete, future versions
of this patch need to contain comments for all ism_ops.
Especially signal_event() and handle_event() need a good generic
description.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 include/linux/ism.h | 115 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/include/linux/ism.h b/include/linux/ism.h
index 50975847248f..bc165d077071 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -13,11 +13,26 @@
 #include <linux/workqueue.h>
 #include <linux/uuid.h>
 
-/* The remote peer rgid can use dmb_tok to write into this buffer. */
+/*
+ * DMB - Direct Memory Buffer
+ * ==========================
+ * An ism client provides an DMB as input buffer for a local receiving
+ * ism device for exactly one (remote) sending ism device. Only this
+ * sending device can send data into this DMB using move_data(). Sender
+ * and receiver can be the same device.
+ * TODO: Alignment and length rules (CPU and DMA). Device specific?
+ */
 struct ism_dmb {
+	/* dmb_tok - Token for this dmb
+	 * Used by remote sender to address this dmb.
+	 * Provided by ism fabric in register_dmb().
+	 * Unique per ism fabric.
+	 */
 	u64 dmb_tok;
+	/* rgid - GID of designated remote sending device */
 	u64 rgid;
 	u32 dmb_len;
+	/* sba_idx - Index of this DMB on this receiving device */
 	u32 sba_idx;
 	u32 vlan_valid;
 	u32 vlan_id;
@@ -25,6 +40,8 @@ struct ism_dmb {
 	dma_addr_t dma_addr;
 };
 
+/* ISM event structure (currently device type specific) */
+// TODO: Define and describe generic event properties
 struct ism_event {
 	u32 type;
 	u32 code;
@@ -33,38 +50,89 @@ struct ism_event {
 	u64 info;
 };
 
+//TODO: use enum typedef
 #define ISM_EVENT_DMB	0
 #define ISM_EVENT_GID	1
 #define ISM_EVENT_SWR	2
 
 struct ism_dev;
 
+/*
+ * ISM clients
+ * ===========
+ * All ism clients have access to all ism devices
+ * and must provide the following functions to be called by
+ * ism device drivers:
+ */
 struct ism_client {
+	/* client name for logging and debugging purposes */
 	const char *name;
+	/**
+	 *  add() - add an ism device
+	 *  @dev: device that was added
+	 *
+	 * Will be called during ism_register_client() for all existing
+	 * ism devices and whenever a new ism device is registered.
+	 * *dev is valid until ism_client->remove() is called.
+	 */
 	void (*add)(struct ism_dev *dev);
+	/**
+	 * remove() - remove an ism device
+	 * @dev: device to be removed
+	 *
+	 * Will be called whenever an ism device is unregistered.
+	 * Before this call the device is already inactive: It will
+	 * no longer call client handlers.
+	 * The client must not access *dev after this call.
+	 */
 	void (*remove)(struct ism_dev *dev);
+	/**
+	 * handle_event() - Handle control information sent by device
+	 * @dev: device reporting the event
+	 * @event: ism event structure
+	 */
 	void (*handle_event)(struct ism_dev *dev, struct ism_event *event);
-	/* Parameter dmbemask contains a bit vector with updated DMBEs, if sent
-	 * via ism_move_data(). Callback function must handle all active bits
-	 * indicated by dmbemask.
+	/**
+	 * handle_irq() - Handle signalling of a DMB
+	 * @dev: device owns the dmb
+	 * @bit: sba_idx=idx of the ism_dmb that got signalled
+	 *	TODO: Pass a priv pointer to ism_dmb instead of 'bit'(?)
+	 * @dmbemask: ism signalling mask of the dmb
+	 *
+	 * Handle signalling of a dmb that was registered by this client
+	 * for this device.
+	 * The ism device can coalesce multiple signalling triggers into a
+	 * single call of handle_irq(). dmbemask can be used to indicate
+	 * different kinds of triggers.
 	 */
 	void (*handle_irq)(struct ism_dev *dev, unsigned int bit, u16 dmbemask);
-	/* Private area - don't touch! */
+	/* client index - provided by ism layer */
 	u8 id;
 };
 
 int ism_register_client(struct ism_client *client);
 int  ism_unregister_client(struct ism_client *client);
 
+//TODO: Pair descriptions with functions
+/*
+ * ISM devices
+ * ===========
+ */
 /* Mandatory operations for all ism devices:
  * int (*query_remote_gid)(struct ism_dev *dev, uuid_t *rgid,
  *	                   u32 vid_valid, u32 vid);
  *	Query whether remote GID rgid is reachable via this device and this
  *	vlan id. Vlan id is only checked if vid_valid != 0.
+ *	Returns 0 if remote gid is reachable.
  *
  * int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
  *			    void *client);
- *	Register an ism_dmb buffer for this device and this client.
+ *	Allocate and register an ism_dmb buffer for this device and this client.
+ *	The following fields of ism_dmb must be valid:
+ *	rgid, dmb_len, vlan_*; Optionally:requested sba_idx (non-zero)
+ *	Upon return the following fields will be valid: dmb_tok, sba_idx
+ *		cpu_addr, dma_addr (if applicable)
+ *	Returns zero on success
  *
  * int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
  *	Unregister an ism_dmb buffer
@@ -81,10 +149,15 @@ int  ism_unregister_client(struct ism_client *client);
  * u16 (*get_chid)(struct ism_dev *dev);
  *	Returns ism fabric identifier (channel id) of this device.
  *	Only devices on the same ism fabric can communicate.
- *	chid is unique per HW system, except for 0xFFFF, which denotes
- *	an ism_loopback device that can only communicate with itself.
- *	Use chid for fast negative checks, but only query_remote_gid()
- *	can give a reliable positive answer.
+ *	chid is unique per HW system. Use chid for fast negative checks,
+ *	but only query_remote_gid() can give a reliable positive answer:
+ *	Different chid: ism is not possible
+ *	Same chid: ism traffic may be possible or not
+ *		   (e.g. different HW systems)
+ *	EXCEPTION: A value of 0xFFFF denotes an ism_loopback device
+ *		that can only communicate with itself. Use GID or
+ *		query_remote_gid()to determine whether sender and
+ *		receiver use the same ism_loopback device.
  *
  * struct device* (*get_dev)(struct ism_dev *dev);
  *
@@ -109,6 +182,28 @@ struct ism_ops {
 	int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
 			    struct ism_client *client);
 	int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
+	/**
+	 * move_data() - write into a remote dmb
+	 * @dev: Local sending ism device
+	 * @dmb_tok: Token of the remote dmb
+	 * @idx: signalling index
+	 * @sf: signalling flag;
+	 *      if true, idx will be turned on at target ism interrupt mask
+	 *      and target device will be signalled, if required.
+	 * @offset: offset within target dmb
+	 * @data: pointer to data to be sent
+	 * @size: length of data to be sent
+	 *
+	 * Use dev to write data of size at offset into a remote dmb
+	 * identified by dmb_tok. Data is moved synchronously, *data can
+	 * be freed when this function returns.
+	 *
+	 * If signalling flag (sf) is true, bit number idx bit will be
+	 * turned on in the ism signalling mask, that belongs to the
+	 * target dmb, and handle_irq() of the ism client that owns this
+	 * dmb will be called, if required. The target device may chose to
+	 * coalesce multiple signalling triggers.
+	 */
 	int (*move_data)(struct ism_dev *dev, u64 dmb_tok, unsigned int idx,
 			 bool sf, unsigned int offset, void *data,
 			 unsigned int size);
-- 
2.45.2

