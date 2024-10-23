Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE51C729B;
	Wed, 23 Oct 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693841; cv=none; b=RTll2XdsEwV2qJSk8HTs7yYISXisP+5dgBp2Ao4JBq0Q1Z6dNDKh+pndiVF0qthq8eshaSRglHfkBjQpQZ0PAJeDiFOItJg1g1Sj0r8AiIMH+ZLxP9GNAQi/0opjVDrAmwkq/AjVlcYMBg+JpzVgjabDgf3mhWI1+e+EVuYlXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693841; c=relaxed/simple;
	bh=o/iUv/QeiUIIxgh39xa8PcUoll0cIbbEDFx12+h4Kzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArGmiMAWn6RmudUELnO6BMi0UmGer8CYAILeV2LPsGeLXBRgMiLlfqajWIltbocWfChltv6h+6sbCZgy+09Lu9xBiztcVKUGyugrYVx3gGQhjQU+kFwzXe+8s4TVXw/tzqWCk8lkCXNhpbdUjzqT446UkBsITfiV68feH5R3zbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFDLMZEJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFDLMZEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E607DC4CEC6;
	Wed, 23 Oct 2024 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693840;
	bh=o/iUv/QeiUIIxgh39xa8PcUoll0cIbbEDFx12+h4Kzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFDLMZEJ7YKsZBdt/tJV1tkopPkThjEW2TFXPy8mFiZr7tNbzpwvtlut53yR2CtFA
	 9n0uB0vYx37IaS0aSGP1o75cAOidIdTMnZ7JAdBkuSdjGHp/IbSYRj+7CZfbzMjpnY
	 MYMTQWhQ1DmJDMA9oI5YWU8SChI//3lmRbmNv33ac+pqX/i2APaOKJq4L+8/FXB2Ni
	 Pt4oN/MofOwPclBg7dPRHRA/nciJChD7xNK5PAH43m56gnimGHTy8KN3VVuEi3NTUN
	 AYhfdtAKNJnlYUJZ5mqt7HfljGkd8K8z3g4CuhHGaO952E+VC+9/Jd2DSkYhiegJLK
	 RbGf/6kUw14YQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 17/30] s390/ap: Fix CCA crypto card behavior within protected execution environment
Date: Wed, 23 Oct 2024 10:29:42 -0400
Message-ID: <20241023143012.2980728-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 78f636e82b2288462498e235dc5a886426ce5dd7 ]

A crypto card comes in 3 flavors: accelerator, CCA co-processor or
EP11 co-processor. Within a protected execution environment only the
accelerator and EP11 co-processor is supported. However, it is
possible to set up a KVM guest with a CCA card and run it as a
protected execution guest. There is nothing at the host side which
prevents this. Within such a guest, a CCA card is shown as "illicit"
and you can't do anything with such a crypto card.

Regardless of the unsupported CCA card within a protected execution
guest there are a couple of user space applications which
unconditional try to run crypto requests to the zcrypt device
driver. There was a bug within the AP bus code which allowed such a
request to be forwarded to a CCA card where it is finally
rejected and the driver reacts with -ENODEV but also triggers an AP
bus scan. Together with a retry loop this caused some kind of "hang"
of the KVM guest. On startup it caused timeouts and finally led the
KVM guest startup fail. Fix that by closing the gap and make sure a
CCA card is not usable within a protected execution environment.

Another behavior within an protected execution environment with CCA
cards was that the se_bind and se_associate AP queue sysfs attributes
where shown. The implementation unconditional always added these
attributes. Fix that by checking if the card mode is supported within
a protected execution environment and only if valid, add the attribute
group.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/ap_bus.c   |  3 +--
 drivers/s390/crypto/ap_bus.h   |  2 +-
 drivers/s390/crypto/ap_queue.c | 28 ++++++++++++++++++++--------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 3ba4e1c5e15df..57aefccbb8556 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1865,13 +1865,12 @@ static inline void ap_scan_domains(struct ap_card *ac)
 		}
 		/* if no queue device exists, create a new one */
 		if (!aq) {
-			aq = ap_queue_create(qid, ac->ap_dev.device_type);
+			aq = ap_queue_create(qid, ac);
 			if (!aq) {
 				AP_DBF_WARN("%s(%d,%d) ap_queue_create() failed\n",
 					    __func__, ac->id, dom);
 				continue;
 			}
-			aq->card = ac;
 			aq->config = !decfg;
 			aq->chkstop = chkstop;
 			aq->se_bstate = hwinfo.bs;
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 0b275c7193196..f4622ee4d8947 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -272,7 +272,7 @@ int ap_test_config_usage_domain(unsigned int domain);
 int ap_test_config_ctrl_domain(unsigned int domain);
 
 void ap_queue_init_reply(struct ap_queue *aq, struct ap_message *ap_msg);
-struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type);
+struct ap_queue *ap_queue_create(ap_qid_t qid, struct ap_card *ac);
 void ap_queue_prepare_remove(struct ap_queue *aq);
 void ap_queue_remove(struct ap_queue *aq);
 void ap_queue_init_state(struct ap_queue *aq);
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 1f647ffd6f4db..dcd1590c0f81f 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -22,6 +22,11 @@ static void __ap_flush_queue(struct ap_queue *aq);
  * some AP queue helper functions
  */
 
+static inline bool ap_q_supported_in_se(struct ap_queue *aq)
+{
+	return aq->card->hwinfo.ep11 || aq->card->hwinfo.accel;
+}
+
 static inline bool ap_q_supports_bind(struct ap_queue *aq)
 {
 	return aq->card->hwinfo.ep11 || aq->card->hwinfo.accel;
@@ -1104,18 +1109,19 @@ static void ap_queue_device_release(struct device *dev)
 	kfree(aq);
 }
 
-struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type)
+struct ap_queue *ap_queue_create(ap_qid_t qid, struct ap_card *ac)
 {
 	struct ap_queue *aq;
 
 	aq = kzalloc(sizeof(*aq), GFP_KERNEL);
 	if (!aq)
 		return NULL;
+	aq->card = ac;
 	aq->ap_dev.device.release = ap_queue_device_release;
 	aq->ap_dev.device.type = &ap_queue_type;
-	aq->ap_dev.device_type = device_type;
-	// add optional SE secure binding attributes group
-	if (ap_sb_available() && is_prot_virt_guest())
+	aq->ap_dev.device_type = ac->ap_dev.device_type;
+	/* in SE environment add bind/associate attributes group */
+	if (ap_is_se_guest() && ap_q_supported_in_se(aq))
 		aq->ap_dev.device.groups = ap_queue_dev_sb_attr_groups;
 	aq->qid = qid;
 	spin_lock_init(&aq->lock);
@@ -1196,10 +1202,16 @@ bool ap_queue_usable(struct ap_queue *aq)
 	}
 
 	/* SE guest's queues additionally need to be bound */
-	if (ap_q_needs_bind(aq) &&
-	    !(aq->se_bstate == AP_BS_Q_USABLE ||
-	      aq->se_bstate == AP_BS_Q_USABLE_NO_SECURE_KEY))
-		rc = false;
+	if (ap_is_se_guest()) {
+		if (!ap_q_supported_in_se(aq)) {
+			rc = false;
+			goto unlock_and_out;
+		}
+		if (ap_q_needs_bind(aq) &&
+		    !(aq->se_bstate == AP_BS_Q_USABLE ||
+		      aq->se_bstate == AP_BS_Q_USABLE_NO_SECURE_KEY))
+			rc = false;
+	}
 
 unlock_and_out:
 	spin_unlock_bh(&aq->lock);
-- 
2.43.0

