Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F35F861
	for <linux-s390@vger.kernel.org>; Mon,  8 Apr 2024 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573763; cv=none; b=uiQ2QJufgEUGhnsCtf3OO7HI/JFxZUfOxs+1cRV7LNgzxB+CJ6e98GOReovkEwPaKOXcvu4LrlftGRcgyDaJzMKWv0h85iPZbTb+6yVYp7L+7i1tdgLPcKBh5tpMYr82vKbFH31i5QAP5y3Rq6pJUiuqZkB7cbR6hmrok5Zyw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573763; c=relaxed/simple;
	bh=kEgF9I/ipHqHK/VgVuJ8B/ldXF4n52hinx8TTVFqrbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRufIWhBlnMTRh0oLwr6YCDqG8AOdrqoepS4S5PcOoIIc6Wo2CYp8FifU4T8q5AvB3KcQrtIP46FXaxRYwb5MDgNeGQ+NNyarVWyPSdYPF16J0Z0gnY5/NhGVDx+UQW6TPJJgz9c8+8anuUUaVbB7vQwoMA9jyxMJglUYnxxAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=NRks62Cy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="NRks62Cy"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so9085941a12.1
        for <linux-s390@vger.kernel.org>; Mon, 08 Apr 2024 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712573759; x=1713178559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqQDXPfK9efO5t44B+8ce16kPk2snvMFmnndCGXCakU=;
        b=NRks62CyFjyz5+5YWPmKk2fIYwrWL1k6CmwblsjoG753AflHpDyJub2cQ4CoSCJSjI
         p8McSBpthGrgghmrORwnTB6Wdzuiko6OzmiAdeCSOLEA7Ebc/9NQhso1DE5Rk4QqShj0
         89rn3PR+A+ktzlWBmnFLTBmPnfPHDbImn6uRjVO/vkdou07UbsuCy50CwlFU5NXpQDtF
         NBx17W/uEmNm9Is/Fhw2dUfb2F8rQLideTxoSQWcpdL+l9tFS8pC1YUMvRBYomaTJKTx
         0jxbXZJOdRWRxloDjWbjuPc9gitvsKNW6u1chaxxgpQyUBdedaUOStOClzC0I8GnYidM
         Kktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712573759; x=1713178559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqQDXPfK9efO5t44B+8ce16kPk2snvMFmnndCGXCakU=;
        b=E3e2TAANU14dC8UCJCM8ytaqjp+BBr+ZclzegIay+QdNwCkBnW5vEYz3q8txpzgvKA
         ixa4A/13iZ1DgsH5HWPV8U3Zx/exVPhTM5v5dxiXwDFJ4zNmInT+fKDd5rxArNLifew0
         sLmvv18v4S+hoR6tvEe7YpAHM7Msq6vhZ84J3+fJDu8fLDRkLHHRGLrAKLdERlxV6DKs
         lHatfBLI/fVWeHkJwc7p1ozK77zKaa7Q8Dzzbm9S9f7U+5Ym+iQ5jUDuXl2vk9t9PmKz
         cSkjkyk6T0njh1+YTIjtTRbYaEgkFH9w5f1KtN9Hg7zJbz/rx1/RyklrXbebO13z/t4a
         h3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXTryiSVjusou3gYxq2vWjYha2KTWfyEPeRDnfwavNYnwssW4XtMWwZJebW4VVSZOnaOf8wOBdbOaE/W935KyRf54Rrj2GzGqK51w==
X-Gm-Message-State: AOJu0YzdS/BsXfCC6WY6Q8au/c1GHJ7/kEpxXM9+qEym2pP0n1haeQZ8
	fyPsv6F7TIOq9iNMcWjBWTDQRBTxZJvlY5aqluiCUpBB6uVfYvZAIYF8mRxhFSQ=
X-Google-Smtp-Source: AGHT+IGVaPWTXesL6CrfDHvqS/I8wRxWNWsnEaZhlmzN2xzxmYEK/dbsAWen74B807WwEhMUvEGwuw==
X-Received: by 2002:a17:907:7e85:b0:a51:ab81:6062 with SMTP id qb5-20020a1709077e8500b00a51ab816062mr9443862ejc.30.1712573758841;
        Mon, 08 Apr 2024 03:55:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id se1-20020a170906ce4100b00a51a9d87570sm4008517ejb.17.2024.04.08.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:55:58 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] s390/tools: Use ARRAY_SIZE() to fix Coccinelle warnings
Date: Mon,  8 Apr 2024 12:55:17 +0200
Message-ID: <20240408105515.2328-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following two Coccinelle/coccicheck warnings reported by
array_size.cocci:

	WARNING: Use ARRAY_SIZE
	WARNING: Use ARRAY_SIZE

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/s390/tools/gen_facilities.c   | 2 +-
 arch/s390/tools/gen_opcode_table.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 68580cbea4e6..ebd8a947e97c 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -149,7 +149,7 @@ static void print_facility_lists(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < sizeof(facility_defs) / sizeof(facility_defs[0]); i++)
+	for (i = 0; i < ARRAY_SIZE(facility_defs); i++)
 		print_facility_list(&facility_defs[i]);
 }
 
diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
index a1bc02b29c81..468b70c85f62 100644
--- a/arch/s390/tools/gen_opcode_table.c
+++ b/arch/s390/tools/gen_opcode_table.c
@@ -138,7 +138,7 @@ static struct insn_type *insn_format_to_type(char *format)
 	strcpy(tmp, format);
 	base_format = tmp;
 	base_format = strsep(&base_format, "_");
-	for (i = 0; i < sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(insn_type_table); i++) {
 		ptr = insn_type_table[i].format;
 		while (*ptr) {
 			if (!strcmp(base_format, *ptr))
-- 
2.44.0

