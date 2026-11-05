Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898056;
	b=x8SyAJlhNFCWiLXoIyzBv7ba3/+7ulfePp73269CEuvtXP27EU5j6tQOy6cPLik0YtmR
	 eL2NZAHoPLKTfZqKMPkWOVjRXzOgu2+2lUjZ0OfXsMqVVsvEEQyqE7FEs7lUosGRNdjex
	 JPWLdprBtKFX6XA6I9dsQjC7comwkc8rI69c76ZVtUcesGUDc+2F5dHm8pzphm9P1C22d
	 WMMhyZQatwxRwHcrqBVyon4JdpDCqWmdMdBECjdkJ9szmaJkhSe8/FYyqT6nPvCiGI9/Y
	 Zj7wdf/bXxMoCwAA55zqwC9qn4CaT/eoKdrXq1Yj2/E209sLtTMW7WM5zVRkO5iu6eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898056;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=fSNuCMsN1VNgtr3D4qnj+zDeO7DxOLUKfJqgOoVCVPU=;
	b=u2qJTr+kf6HTTKb+Bj8PpcA/MtGR+DdTlEjVOUG4KNceTopx2u0P4j20VV6SHcZeH2N6
	 ogdQDuT3XAQEW+6m/7jyAEauRL+feoilVy6GOKgSTOvldojXfmAiiDSmQ4dq6XElerp58
	 RP6mASdUonexGjZ3WIIc8A9pBZmG1n7wWbHvb+oadGlqsqpBNtFmCnmhcFecomtL238i8
	 J5Fn7QuH1jAZg86A3o01WW5PEt64+UxLvKxFUMrnrA0sOZB23nV3yI1CeNAxS6BIegYps
	 59zXSQZCXlTXp/+W0wUg1usSn6DEFEOmfNcq8b1jzimcqIUcogAeQSnDgrc3J0qYAXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wZcwpmL0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ScUWjmOT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wZcwpmL0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ScUWjmOT;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA85606A330;
	Thu,  5 Nov 2026 17:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA85606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wZcwpmL0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ScUWjmOT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wZcwpmL0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ScUWjmOT
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B07D1F8AC;
	Thu,  5 Nov 2026 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSNuCMsN1VNgtr3D4qnj+zDeO7DxOLUKfJqgOoVCVPU=;
	b=wZcwpmL0mpdBmgeFbL6TAWnZ3KpTQAk2vo2FQaqARxV/NjrreaAfTHteFuvP5vnSOY7amM
	nKJNOUuuo1R52BYjaZEXW2XIJqDD7OujtciEIsvOGxb+8g4BRvs9oGHRuXT79wQ7Tn3aDR
	PQUKmDFwSlsxsL21YFzmFe+SgREGIY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSNuCMsN1VNgtr3D4qnj+zDeO7DxOLUKfJqgOoVCVPU=;
	b=ScUWjmOTcEgPwuaLb0MYbEyHbeErNT48bHZn8A0DlZTs5+YrlWLTp9TJGYai1n4VSOYWFk
	EXlmgoMvrLJF8wDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wZcwpmL0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ScUWjmOT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSNuCMsN1VNgtr3D4qnj+zDeO7DxOLUKfJqgOoVCVPU=;
	b=wZcwpmL0mpdBmgeFbL6TAWnZ3KpTQAk2vo2FQaqARxV/NjrreaAfTHteFuvP5vnSOY7amM
	nKJNOUuuo1R52BYjaZEXW2XIJqDD7OujtciEIsvOGxb+8g4BRvs9oGHRuXT79wQ7Tn3aDR
	PQUKmDFwSlsxsL21YFzmFe+SgREGIY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSNuCMsN1VNgtr3D4qnj+zDeO7DxOLUKfJqgOoVCVPU=;
	b=ScUWjmOTcEgPwuaLb0MYbEyHbeErNT48bHZn8A0DlZTs5+YrlWLTp9TJGYai1n4VSOYWFk
	EXlmgoMvrLJF8wDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 264B713505;
	Thu,  5 Nov 2026 17:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMEkC0K27GqWRwAAD6G6ig:T3
	(envelope-from <clopez@suse.de>); Thu, 05 Nov 2026 17:00:53 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	peterx@redhat.com,
	ljs@kernel.org,
	imbrenda@linux.ibm.com,
	borntraeger@linux.ibm.com,
	frankja@linux.ibm.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 2/9] riscv: mm: add pud_soft_dirty()
Date: Thu,  5 Nov 2026 17:49:59 +0100
Message-ID: <20261105165004.2663799-6-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261105165004.2663799-4-clopez@suse.de>
References: <20261105165004.2663799-4-clopez@suse.de>
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
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLc61iri4wja3i5zzttafaxsi4)];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 4B07D1F8AC

riscv supports soft-dirty and PUD-sized transparent huge pages, but only
provides pmd_soft_dirty() and not pud_soft_dirty(). Add it, so generic
code can check the soft-dirty bit of a huge PUD.

Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/riscv/include/asm/pgtable.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2ebd5fa5adc5..40890f51dec6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -949,6 +949,11 @@ static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
 	return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
 }
 
+static inline bool pud_soft_dirty(pud_t pud)
+{
+	return pte_soft_dirty(pud_pte(pud));
+}
+
 #ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES
 static inline bool pmd_swp_soft_dirty(pmd_t pmd)
 {
-- 
2.51.0

