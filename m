Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174222EBDFA
	for <linux-s390@vger.kernel.org>; Tue, 18 Nov 2025 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427196; cv=none; b=tT82td49ajj9UzRCPTDmGmTED/SqAv9gqURtgJ8cBD9QbqtvMtwdHmb02wsKosjl7/AHrRNbPn5C/QGe9kf1sQoScz+yBOKIY7gnR+lrl5zSh4G3WSQXNbI8cF6v653hdSdVQtKhVaGFRiWOpxqJH/eDysqNjb/tVnQiM5463xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427196; c=relaxed/simple;
	bh=jt9WKX1uERfxJ/zhVyFnKQ1xA4vxy7qQ/dPEiwgeuVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILVO4tikLABEzfzZ3lxagH3KmQGvSRRSl0K4tdaEuDNxDTnNcyFpZImNViQdCJldO7rvRrkYnkW+FSNAfQ/CiGBd4qOgGiX3AY1sh+S7NKYWqv3T/G8dU1v2wHhOCOe6vYM3LIbe2AYT/P7vaHX5T+H3GCcXV4V34Fw9HUo7PKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=mWINoDV4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="mWINoDV4"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7ba92341f07so190339b3a.1
        for <linux-s390@vger.kernel.org>; Mon, 17 Nov 2025 16:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427194; x=1764031994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcuRUUrpMUmurCMk/WunQ3qmMdUvqKgEyZujMl9eoWo=;
        b=mWINoDV4/q2iMKSqN5qBthWtyldxqxOWW7gj26v6qPhjgVTbqA5I77gYytFDfuz1OU
         mlh0r3oyDkWOF+gAwpqonTt7zOeYIfN7Tp27xKbCwUrXgW6ztz//4BDxev5KD7AUFm6+
         oej0mxpX5asOaa6gj10NgPCt5Gur53rxRZ7EQLi4UpNmpMeYvTOzT6rPfn3MHWs6aNa6
         qqXvEhoR0FWgThUpXqHzr98Jrn+1comvaGglxM3oJW5tMHQLnvCg9qP6v6O/LjTnND+Z
         NMehJDhtnCOayDTJzQuE8svVMtaUofZxQGbraT9aSFKS425HtbfbCJVtma1qY0tWLPsg
         QIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427194; x=1764031994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hcuRUUrpMUmurCMk/WunQ3qmMdUvqKgEyZujMl9eoWo=;
        b=iGR4OgwAxxRTj8ix8Dagrzv3Fkwf8ZcwP7i5Sk//PIB23bWa3Sxr3PVU0qbTo+mBlR
         WruGDxP9ytXt9OyvGgq3UObGrRhgWvg0ZXrx8ULnsjeBG6Vlazv2GsLIQnz6UG7mipqU
         f3vo9nVpVxzoi+rFDkYuCxWt8BgXIkdZyYjIfbOB+DSOn2Fq5BlmpSYvpVtpKgGOROVI
         eVUruWq4mnwypmtHtWDsYdYVkQCRuLovtPWlZlaJHdK+iw3W3umeUjiPfFIWl5J5BHgN
         8uxyaEuTz6071GvNLGsEcQJYfvvYwGctNXJP2SqGaJtZyJmYVu+F7TJJZTIiDnvzeQT2
         0N+w==
X-Forwarded-Encrypted: i=1; AJvYcCWtC4ncFlYc65SdJV8gTPil9Eu3P0S5oVQ6J4RflnNnkGq3rRnD6Kn4rnIdCHTPBbjTVKCoLOu3RT9I@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRqvEqN2Xxx42o1ycb27b+N0V6UVpbu/BPakptSL9B6P0RNoL
	PN3NZs4CU7GzLgD/l8ZU1FkNVi1XOLJCGK9a1AwJSSpdUn+phy0R81qEBgtqev3xyIwCegBhycG
	osePx
X-Gm-Gg: ASbGncsxe350SBw8tv63h9iwxFAPU9HFHvUQLB34/2OwaES5My+dTNYZxy+MueOpMFO
	Hzv0SK6ns8J3cYJEmwxR92082DpPAd+yV02h8aDooACQGIRdbJP8cIfBdQVVMTiJ3Sh7pZr+bwE
	4yWP3sXQ0Rsuw+wOyCyOmYA9wyWvQFBko+iXKQrDVFNlJ8rPyyF68snQchEZTEWqkCWMmn1P5qv
	DQtz/oJbSyhh8L2u84D0wG4880fU6w45aRID91lpebcU3EwQW87+BmuMxGMAqYCnjPMa14bnFMn
	5bG8MMJYEePwRXGVlUcB1sqiBOdBdTnobNfx7cIpaXFX6/MxHjhFpTTLOgpKlFXhamgyeROzqju
	33TCufBXOKohu2r5IxPQ+TWb5Bxl7tCohcpnucrJLZx+IdrthHiYWaTrgOSKklbOn
X-Google-Smtp-Source: AGHT+IHKa0TQpIk3ZCC102SD0uVPqHW4J3CaGovuSZooSd+82JPVtQAFEykilK1Fg8MDDO7aWQzABg==
X-Received: by 2002:a05:7022:b92:b0:119:e55a:95a3 with SMTP id a92af1059eb24-11c796a9cc6mr281075c88.5.1763427194062;
        Mon, 17 Nov 2025 16:53:14 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:13 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH bpf-next 2/7] bpf: Enable BPF_LINK_UPDATE for freplace links
Date: Mon, 17 Nov 2025 16:52:54 -0800
Message-ID: <20251118005305.27058-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118005305.27058-1-jordan@jrife.io>
References: <20251118005305.27058-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement program update logic for freplace links.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 kernel/bpf/trampoline.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 010bcba0db65..0b6a5433dd42 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -614,6 +614,21 @@ static int __bpf_trampoline_update_prog(struct bpf_tramp_link *link,
 					struct bpf_prog *new_prog,
 					struct bpf_trampoline *tr)
 {
+	enum bpf_tramp_prog_type kind;
+	int err = 0;
+
+	kind = bpf_attach_type_to_tramp(link->link.prog);
+	if (kind == BPF_TRAMP_REPLACE) {
+		WARN_ON_ONCE(!tr->extension_prog);
+		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
+					 tr->extension_prog->bpf_func,
+					 new_prog->bpf_func);
+		if (err)
+			return err;
+		tr->extension_prog = new_prog;
+		return 0;
+	}
+
 	return -ENOTSUPP;
 }
 
-- 
2.43.0

