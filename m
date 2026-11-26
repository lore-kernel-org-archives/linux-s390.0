Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705594;
	b=Rbb/7gvUJ2oOnypDwtGpFPrjpri+4qe+su0PhAuSD8xbcqE5ZwMXGzhIU/+FCAjJudbq
	 hYKdYpkKvw/XBnbEOivmGD/6D45q1BX8VrdhRkjClAcNCM0syT2Uo03uptMpeCzI53qz0
	 6ZN20hgWj7GFu8Y8tFGtTi6L6NNTxWlZVqwtxahAI1yGVOM/JcDYyiDF/TuRd8Y0pBcnR
	 VJopGj9CKFmgao5j2894toTrQmo/Ss8nAn0dW97/4AOlKb+AINJo7avMoUNvDoOYsKf1r
	 Q9lcbSgnVDn5W/vJ2ijxIQBkdCWHsUnyXbjArN73/orQ0+xv0W63w+3j1fGaIlrgUdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vFxzL6N7fV5dEdD6E6EPpo4S+xvEUTNbT1G/ro5XjSQ=;
	b=PEh6rkgP1yYP4ammHgHv22k6rxHVEUqAbWS7e4+XWBgsXulB6DSRP+Ry7lhm70CNadjY
	 7lrYqmVLjlstf9AmcgPah6JHINRPuO3dhrSWBbe3w0unnn8dO0QUFPfqkCBQ+YPlH7YKY
	 QKiQGUIgSS1qhroyYwHdijfMzPszjDQWMGV+Kj2+ju+tE6/gJjX5oYf4IIyPlDnf2f0aB
	 jsHBdIlKoZipghKcqxlzr/owgWIYCL27wS/duc+fFk4K8a1P02DBc0dBalGU6DNPcMhBp
	 rS8WFj0fZiPkjUXPG/Xup3UVr/4bBys3dEZ4KViAorMdI9A70oDgP4+WwfEgdm8Xrhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=cyj1fHpi;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3ED606A684
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 15:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F3ED606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=cyj1fHpi
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cde5a7d79b0so3648426a12.2
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795705593; x=1796310393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFxzL6N7fV5dEdD6E6EPpo4S+xvEUTNbT1G/ro5XjSQ=;
        b=cyj1fHpignlDujJCnViGY8sX6x8wogPXBpBDbUr/XIdmWpWrKtxMFMMCszkNH5KK9U
         C41GxztehbjKMlbgmqYxIdLHn2VzjSTutkCUPcqXt+TEJt64BDjWklhaWCq3SZDfnOX6
         KmhhKc5hkKYtcCSsx4GDGusu3eAXwjUr5s5bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705593; x=1796310393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFxzL6N7fV5dEdD6E6EPpo4S+xvEUTNbT1G/ro5XjSQ=;
        b=kSq9qNrLvtMsLczOjYl8k3kZcyhzh5yJnpzS+wDTBT7rIq3FL4CBpQD3qbVkPXvVbM
         LUgJrPflruEXMoQbOGOylgppgUPoLJI58mpccutvOq2Kz07jNamt0Z5hi+KBNzh8Jim0
         c7IMMLglxTBocmuVwckZdy7o1hJvH9MDhBFGAkEcVbEJu/yCiiKNHtzXUtD2DzLfYbWV
         g3RFthMv3Vmz8zAXrXwrELVpIJU/oTwIyK+CQsR/aBXdk8eHIwfeAsMFUHTS7RrR1LDY
         z71hSKX21vcbJ/1m/wypwYvXg6mZZj6BHTbFi4r77kkCNIivLdjoK5P28bWj3XKlipuT
         69lA==
X-Forwarded-Encrypted: i=1; AL+hErGP+GuI5OOCR0QPTddgIvRKvsuXUqs8wVMJyF8Q/2dV3OU2FEaGYSvNILAIPAdSHXDsc1VQcgVKb6CK@vger.kernel.org
X-Gm-Message-State: APuU4Z9a5ZpaWZL0DXlbup0/vy3HvywtGWg500mPltO0I+aSnk2Fkxn0
	WagW4B/JTOcigk1Z+NWo38qIMAWvV6rdv3cKfBPjEyFFIOJNRHXKY8qpnvE2t6ZYZ04=
X-Gm-Gg: AZFdTZf1ANY3KUkCIYQhE7gUG2sf33jJSkHkYMssHZN9tVP2OXEuMFSu7qDHCcSNHIz
	BcWAaCPoreiPMYdnw+0N7oOXuypcdTvrABXXW4j88eIKCPJyxrDBVTAao3g62imkZ476yXOT0Po
	z5dUqoMS4AqJ/E2RKOC46jrPkA96+5PQUNMVMcUpxd3f2iLXKS7ikEvaTxKJDTHiNFw16YTP4dM
	9Tk/mgvGvEfBcPoW0cVrixC8SOOEAypKkcRNex8mO6O2TF4qRV6gCsy0dFmS1gkiGWztcAcNFqm
	hMO4D50pfC5uSrwpb5JPgYy2jSRTgatHjDr/tHVjjmHax3fKngTV9vcBh/TaZk3UoDtPjtAjVUl
	RTAYdOo3+cHXqcxz/DfI6koSFDrApPswe+xnA7OEkfbzurld3HhDJMGJvtBISKuPlpGP0+onKq7
	eR/PEVTNA9pBv9FQGZRIAuXskIctgTR60TZ/6SJg282Zb9CK7VbTe5jQdx7oFjoSHAFJzVIsDE3
	T3tojjAO5yEdIpDkIbw92tGrLUlaFFuO4qMrxJeTShK1tEydjnG1XC0NxQ+iH4pVdxDRv2c6fiV
	IWOAVIZ5M6+gLn4F9ZKZh6x6I79isrtJKJMrEhwvJf4QhQUeJtJZKG8sQjZZ+kJs9AvCpa8sz+V
	IREWwowuqGtoY1nWMHFVyaHRWG8PHXTIHSJaYokRWRlFaZofeqYZJonXDi1YkTx97qg==
X-Received: by 2002:a17:90b:48d0:b0:3b3:b5b8:1f43 with SMTP id 98e67ed59e1d1-3b41c97115amr22991604a91.62.1795705592804;
        Thu, 26 Nov 2026 07:06:32 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde84cd5ed8sm8039585a12.10.2026.11.26.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:06:32 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kapil@presceralabs.ai,
	stable@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH net v3] net/smc: bound the DMB-nocopy send-buffer credit by what was sent
Date: Thu, 26 Nov 2026 20:36:25 +0530
Message-Id: <20261126150625.2113302-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <sashiko-outbox-233892@kernel.org>
References: <sashiko-outbox-233892@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you - the finding is right on both halves, and the remedy is the one
you name.  v4 is posted separately.

[Medium] torn cursor read and non-atomic update in
         smc_cdc_msg_recv_action()

Confirmed.  smc_curs_diff() reads wrap and count with plain loads:

	if (old->wrap != new->wrap)
		return max_t(int, 0, ((size - old->count) + new->count));

and this path runs in a tasklet under bh_lock_sock(), which does not
exclude smc_tx_rdma_writes() advancing conn->tx_curs_sent under
conn->send_lock.  So passing &conn->tx_curs_sent in place can pair a
pre-wrap wrap with a post-wrap count, exactly as your interleaving shows.
Both outcomes you describe follow: the difference collapses to zero and
the credit is lost after local_rx_ctrl.cons has already moved, or it
exceeds sndbuf_desc->len and the bound does nothing.

The second half is right as well.  smc_curs_add() is

	curs->count += value;
	if (curs->count >= size) {
		curs->wrap++;
		curs->count -= size;
	}

so in place it sets count and then wrap with plain stores and transiently
leaves count >= sndbuf_desc->len, where the code it replaced wrote the
cursor with a single atomic64 store through smc_curs_copy().

v4 does what you suggest, and what smc_tx_prepared_sends() already does
here: it snapshots both cursors with smc_curs_copy(), computes both
differences from the snapshots, advances the local copy of tx_curs_fin and
writes it back with smc_curs_copy().  The cursor update is one atomic
64-bit write again and neither read can tear.

One note for the record: the torn read is not only in the line v3 added.
The diff_tx computation read &conn->tx_curs_fin in place before this
series, and the snapshot closes that too.

What is bounded, and the bound itself, are unchanged from v3.

Tested on 7.3.1 with KASAN; net/smc/smc_cdc.o builds clean at W=1.

pw-bot: cr
