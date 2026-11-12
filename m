Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493535;
	b=sFxLyE0LHBDs3G5vH/jl9ovil5sZg3Q+RNSK2NYkcHeocL2VzQpbgJN596kjau+v70mv
	 /gEpyia6JNqSgHj/sVCHlRA9KEtEG61Y+KWCCvIkYrQnv6Mfvh6SS7WKhzQNlDHM6iZmp
	 nO7QPKeMJADoHgx4M60DGKpRTRtss3+G9uzHmBsb1I76DJr015iWECaVAxa0WFzv+z7YK
	 6mQt64SJGI8aqDrZZyvV4nKUAyTTLls/qVDGbTilsof4eoOSvLfLnPeLhX0mp6F4ige+p
	 TFds/cQgUmQqqOS4XzrDBmlkWx9dZbhhFUiy2WgPuxhUEKlLqtXwUgw/u+Oz23NBk5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493535;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=fSNuCMsN1VNgtr3D4qnj+zDeO7DxOLUKfJqgOoVCVPU=;
	b=yfkq9JNsMNM0Rj1pPFQ2kNN5gRTAlWqwR1la89VV7GYzZHHyrptjnoHh1siAftSpvvep
	 wxLko7OmvQfvvsfnINlN9O2N6muojskIm+oD4EZktsp8jPN7XR5w5qxKot1F8gkNH+6gi
	 UdZJJZYM0e3Fj1gByOIsvtRD6Ym6gypZPduDvQuCDFyctwoDozuC4G1ApeGotR0aIMDdg
	 9wQnuf81pBrI1lra99f4LlSsxceyWhDKUERyCCeHubNru1aeo9/flvl8o4fjF5lkRfvyf
	 QIS3rAtxnlBxUKpBY7xLq2/+2V7p3F96xZakDa2SCPg0CeJgvFajKd7Rd6GQzNeE6wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IJ1JzRmh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pcu88trj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IJ1JzRmh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pcu88trj;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C656F6072A0E;
	Thu, 12 Nov 2026 14:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C656F6072A0E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IJ1JzRmh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pcu88trj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IJ1JzRmh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pcu88trj
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2297F1F8B4;
	Thu, 12 Nov 2026 14:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSNuCMsN1VNgtr3D4qnj+zDeO7DxOLUKfJqgOoVCVPU=;
	b=IJ1JzRmhJB+1jyg5pCgn5nlsjCZQQcblG2IgVIsUEyxmDSn8wbK/iDhbqzwvP4PQj8JFF2
	XkLhsnaARIvc9iasv/O8vDYAqgAizdDeAMQSBG83PnKfbHi86DLayceFpiiniA8zZr0JQZ
	kZ7WA1Mfh5AGJUs8JY7Xr7QmGVd4nfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSNuCMsN1VNgtr3D4qnj+zDeO7DxOLUKfJqgOoVCVPU=;
	b=pcu88trjNhOJVGCafuuVQ5n9cn/S2UvWpMZdS+iHleTTMFEQhC7gpSLC/y+B8VP/75G/t6
	BfmLZW/EyrOPx5Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSNuCMsN1VNgtr3D4qnj+zDeO7DxOLUKfJqgOoVCVPU=;
	b=IJ1JzRmhJB+1jyg5pCgn5nlsjCZQQcblG2IgVIsUEyxmDSn8wbK/iDhbqzwvP4PQj8JFF2
	XkLhsnaARIvc9iasv/O8vDYAqgAizdDeAMQSBG83PnKfbHi86DLayceFpiiniA8zZr0JQZ
	kZ7WA1Mfh5AGJUs8JY7Xr7QmGVd4nfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSNuCMsN1VNgtr3D4qnj+zDeO7DxOLUKfJqgOoVCVPU=;
	b=pcu88trjNhOJVGCafuuVQ5n9cn/S2UvWpMZdS+iHleTTMFEQhC7gpSLC/y+B8VP/75G/t6
	BfmLZW/EyrOPx5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F14A0134F4;
	Thu, 12 Nov 2026 14:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9GzDFnM9WoAPwAAD6G6ig:T3
	(envelope-from <clopez@suse.de>); Thu, 12 Nov 2026 14:25:31 +0000
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
Subject: [PATCH v3 2/9] riscv: mm: add pud_soft_dirty()
Date: Thu, 12 Nov 2026 15:20:31 +0100
Message-ID: <20261112142039.907090-4-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261112142039.907090-2-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
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
X-Spamd-Result: default: False [-16.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLpaod1bh3ffbsf8emkm3npqp6)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -16.30
X-Spam-Level: 
X-Spam-Flag: NO

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

