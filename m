Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FE220F5A
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557189; cv=none; b=GUF9vDaTHU/mK4k+bqb3rcijNh3UU8VBgaC14pkSbSMPGxYHtdDXZ9ChS3+17tgmVV6qKDFjIMAdChoowHJ12tu34tOm9qtU28rKtcyLK1YTALVofl1me1P1kBqKguiRsiZjiBJdc0xkgxUfzQfSzFm+D0AOBL++Nicd8aQudI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557189; c=relaxed/simple;
	bh=zVHFDvGYoUXdaacnFc9cbOZNnkV4Sl8Ts12QDaxIW58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMUpxBLsxWNNLAl9f84mAoE3rkzIw7FSmDQmWYO4DyXXV2wPqwhofu5Jw1G8i6es80pMleK1OcK6FvQyO1rlAZH0BCBMsaM7pZPpKU5bINkvSyIneq4/dnw4Jom+t5NwLKNsV5lDVxw/qIxCYfhuejy847G5an9H9rLEs28d3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWmlS5aS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWmlS5aS"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso1176478a91.1
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557187; x=1749161987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qpJ3lqvWpdWxqkl3QOJ7dzcCaTBGRsqwoUxsRp/BgHs=;
        b=MWmlS5aSS4MUwkUDoN2wPA+5dWkbydMfydSrBB0ZGJB4eownD2evuZq0ac8EwbZdga
         0CZIRPGHlLdztVpbHNZc4/fqldhD/PsFuF9mlntp4W5gbftPVhIXc27ikyDsYyQNNm1K
         V8jBzQ46dSdJlPzvT/pDOqC6ejxuC565ah6wRJGIM/oxuOfpu2foiko/X09BkcLQ5BZE
         Dwde23OVqosF/1/JcEJAmEWSX53v7IB2hAX4IWDLp7u6Em3VW+Z8ET70P/tAKWluaUNS
         Z3MBuBnIPy6af+ZZBd5tyZ4ptS86fXeNjKBeHb95jC2B+IQk6ld6ueDnsgjwJ2wx24Yr
         MzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557187; x=1749161987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpJ3lqvWpdWxqkl3QOJ7dzcCaTBGRsqwoUxsRp/BgHs=;
        b=eITS6T2pVaq7c6Ydvb1y2VUJcBNvVN34bFU9GQ0UX34xhoQhQuhrpW2ko1nhtI6fQG
         syIF3jA/DxENHjtaXC2hqt61AbAegxvjll4/62YDYXCxOlX9GT1lHrrRjnlANrluwFdt
         lPJoPA06KP7S/Yvr/u1SPcrS3uX0A7BSMtqIWjF/7RUIbRYStSuooMCdcpZPicrzek++
         nF4ghds42DanB1NdZGSjtGvhxlTCFeeaOmxuoTwZtYCnuXNp1N7xlqSxDjdqGjBvAgt0
         ZKqfsDvIVgh3vGaTraykh9ZPMNgFQIGV1vd3gUBGzE+SAv5Fr9OmSq+rPoQBYP+wJGPr
         KXvw==
X-Forwarded-Encrypted: i=1; AJvYcCUwWT9vc1rVjjv82ZOZmkyW79gawNuWYUyodOUyZpomp1caUuxg/sPQNR/5W0fOkNaGm8fM2zYt+WSZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNlOTPqc2WnkROpqU2IjSSLe7fYgW69OjF22GrkQ7hQb6R8oE
	rZthVJwQOZmF4g5FVcm5VcnMNV/3XJmgoHhYAUmPxKnuxZU/5O+q8iHGvOB3pHylo1TcEQx3ozk
	PDy1fAQ==
X-Google-Smtp-Source: AGHT+IFX7xA/wNBD+GkVjlH4FgWC9b0N7YtakX+E8PhKZ0lflUPRAVkfmvb9rXlMNwMUrMjpe+LFsX0XUn4=
X-Received: from pjj12.prod.google.com ([2002:a17:90b:554c:b0:311:f699:df0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc6:b0:30e:3737:7c87
 with SMTP id 98e67ed59e1d1-31245dec83emr1180483a91.5.1748557187294; Thu, 29
 May 2025 15:19:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:17 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-5-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 04/16] x86: Use X86_PROPERTY_MAX_VIRT_ADDR in is_canonical()
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Use X86_PROPERTY_MAX_VIRT_ADDR in is_canonical() instead of open coding a
*very* rough equivalent.  Default to a maximum virtual address width of
48 bits instead of 64 bits to better match real x86 CPUs (and Intel and
AMD architectures).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/processor.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index 6b61a38b..8c6f28a3 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -1022,9 +1022,14 @@ static inline void write_pkru(u32 pkru)
 
 static inline bool is_canonical(u64 addr)
 {
-	int va_width = (raw_cpuid(0x80000008, 0).a & 0xff00) >> 8;
-	int shift_amt = 64 - va_width;
+	int va_width, shift_amt;
 
+	if (this_cpu_has_p(X86_PROPERTY_MAX_VIRT_ADDR))
+		va_width = this_cpu_property(X86_PROPERTY_MAX_VIRT_ADDR);
+	else
+		va_width = 48;
+
+	shift_amt = 64 - va_width;
 	return (s64)(addr << shift_amt) >> shift_amt == addr;
 }
 
-- 
2.49.0.1204.g71687c7c1d-goog

