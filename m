Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285086;
	b=CJiPznIVUYMiR0MtVkr2q8tuk9MVEWdnL9Jy+p8TTIKAjBPNlA1DyLpmEyEanWv5z14E
	 CJSPdYZK+UKd47ITCngEH6J3eLBQCdCn+s1cftYPHV4xC7hSyUWFJbhFnnEc+LOeyZWgV
	 aOO7wO0uCSnqcKDrRMW45myLFp1HP/d7JZIp8qlZQyRNpOJ/+W//WGFJVXIUcznYGXkuC
	 7q9XmxVniXlB6N3ylgHbJBOMfIZvmAGdWeIid5ig3JjRVIpMI20oWfVCR5ciUYkRuuyfR
	 TFtlfk7RC+GZQGSuY2mZUGX0YsgaiWZX1PdqhtJg4SUY8rsSdUGoqZUvR43HNsXcs+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285086;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=46myARG/OGWuh/nw73XrNi2XTON/aEAFXw6IJmuSHJY=;
	b=Ck8UkT6moreDITh1wd0M7h0f5S++V18nFVNzK6UtkHRezCFwRsRBoJ0vZ0nS5n0ljFc3
	 zcogdQXsiyCkIzfhKwauCaqU1sgIzib7dQw4/0yRA92nF4PAT1hR0OUIOAE1racYE73og
	 8hu/qiq/FXq8IwKcgDuc8YzXMiBui2QAUOIUqW/JI8wP2JkFqfc91J0jGdcEv+H/1eeJg
	 SNDhmzRzXHGwaTAuO6auS3JjUU2Y5pJDh2xXxCfitu11tKIcrNwnrtGfWcC+l+hkzXYJn
	 z/FYA1qa9XRs4hMLSpFYOtODkuBQzkkRoFzClbmCVXQyzZCWtMAxSHoqydhnHyvmJmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C28606A31F;
	Thu, 29 Oct 2026 14:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C28606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3EFC2210B;
	Thu, 29 Oct 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F45A1339F;
	Thu, 29 Oct 2026 14:44:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iNqFENhb42qRUwAAD6G6ig:T4
	(envelope-from <clopez@suse.de>); Thu, 29 Oct 2026 14:44:44 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	linux-mm@kvack.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: linux-s390@vger.kernel.org,
	imbrenda@linux.ibm.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 3/4] KVM: plumb MMU_NOTIFIER_RANGE_PERM_UPGRADE into kvm_gfn_range
Date: Thu, 29 Oct 2026 15:33:36 +0100
Message-ID: <20261029143336.390231-6-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261029143336.390231-3-clopez@suse.de>
References: <20261029143336.390231-3-clopez@suse.de>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: A3EFC2210B
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

Propagate the permission upgrade flag from the mmu_notifier range into
struct kvm_gfn_range, so the unmap handler can react accordingly. The
value is not consumed yet, so no functional change.

Signed-off-by: Carlos López <clopez@suse.de>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a..aa109818cede 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -274,6 +274,7 @@ struct kvm_gfn_range {
 	enum kvm_gfn_range_filter attr_filter;
 	bool may_block;
 	bool lockless;
+	bool perm_upgrade;
 };
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..0d0073615fa8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -532,6 +532,7 @@ struct kvm_mmu_notifier_range {
 	bool flush_on_ret;
 	bool may_block;
 	bool lockless;
+	bool perm_upgrade;
 };
 
 /*
@@ -613,6 +614,7 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
 			 */
 			gfn_range.arg = range->arg;
 			gfn_range.may_block = range->may_block;
+			gfn_range.perm_upgrade = range->perm_upgrade;
 			/*
 			 * HVA-based notifications aren't relevant to private
 			 * mappings as they don't have a userspace mapping.
@@ -738,6 +740,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.on_lock	= kvm_mmu_invalidate_start,
 		.flush_on_ret	= true,
 		.may_block	= mmu_notifier_range_blockable(range),
+		.perm_upgrade = !!(range->flags & MMU_NOTIFIER_RANGE_PERM_UPGRADE),
 	};
 
 	trace_kvm_unmap_hva_range(range->start, range->end);
@@ -2552,6 +2555,7 @@ static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 
 	gfn_range.arg = range->arg;
 	gfn_range.may_block = range->may_block;
+	gfn_range.perm_upgrade = range->perm_upgrade;
 
 	/*
 	 * If/when KVM supports more attributes beyond private .vs shared, this
-- 
2.51.0

