Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691713;
	b=yqeJrbsYaCGKuDVh8lSp9/w7PsL1EHvOiOP3ymVY2WYSMuZqDFJFkw7UZ7g6XakJ7QKE
	 SbCj7xagwtpXeE0OyvZJCVeyDroyVBX242BbPAK0JasX2hA0hLx+xztXWoW34bP+gZFMl
	 /1OSdTa1uNp7FDdpT0vkg8ZZ9oHpnBVWNCD+3q6zJG70oIS8OLuizBSJQwEyRbADpkHBm
	 ghonT7FL9gxnkerVBpEyflmAhK9PAx8Jlw07XfFNy1q/Sv9vIAFPdo9VDAyU2ImQRSQCU
	 Y5l5qq61+w0BoDZgo32v/yU668tOyv/WEQ/gAzps+azMxObmS6ptbPvH2FkZmgX8iIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691713;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Pa/qSMCChRGH42K3rYTSztXsaxvBOYR3oBjTN9/+VqU=;
	b=2ZnXgWkF/eLXaRmdicZmVJ1sF9j7kWCfqiK4dLAtP5eYK1vLLN/nxnWS4f6nq9Otp2Ys
	 7nmw5AfJ90vEONjr6yXs/ALxinD1Oh/RLn5YlydNHlb8Iia2Zz2WKtgNwItqMOPVxpRIw
	 WIdGUrKrDjExZ9mbhDZG9pejTYVcWxKpFCTY1dxO1OVMI64dqZw2mq4tL6HJX7VBJqs8Q
	 QRldlZRC3CQJEJS159Rv5O4DaLUZ0VEtYaHnF7FMWONJbNFEy20F6NY4OQApXV7/lYWkJ
	 3pTcb52wQPFtGNWV0gecnNnPO4/zHtZkm0wz6RhmX2PftoaYSgt/SqXhLNTePWEQkXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP3x1Ccg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B8606A331;
	Thu, 26 Nov 2026 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP3x1Ccg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F70E1F000D3;
	Thu, 26 Nov 2026 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691712;
	bh=Pa/qSMCChRGH42K3rYTSztXsaxvBOYR3oBjTN9/+VqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MP3x1CcgVdwXZovNmf2Ki608k9RA+upmwxLp4DhhwvWZFzw5QHNd1LujvDkgy5dqK
	 VudlIr+IQ0y5h01MkihEvEk+fN3u6e0wS395BMpBkuMKyfNQDtQIXifIJtscUMPgMn
	 mRMkfl5ZkqBv6Pnrvr3XlMzLeXxLL8XTGCTeQjY+DsJ0sPHkki4BSfureOMycyH4Ig
	 6F6k/5CR5+LLNSNVwEdIqxm8cn75nagz+yLvq8j0f6/pr5fLtiTxD0jmw41RAcqdG1
	 gDHYFA178/+99Xx/ijLHYcEFPmOPjXC5GwRv8Ar3G2pFnmTMGX0EXfDolIxf5QrwSJ
	 NJqE+CbJ3opQQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:17 +0200
Subject: [PATCH RFC v2 04/54] s390/boot: stop parsing the command line at
 "--"
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-4-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

The kernel parses its parameters up to "--" and passes everything after it
to init. The decompressor parses the whole command line, so an argument
meant for init still takes effect in the decompressor if it has the name of
a parameter the decompressor knows, like "mem=".

Stop at "--", like parse_args() does.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/boot/ipl_parm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 8bbd102fa50f..ed28ea2fc1d1 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -268,6 +268,10 @@ void parse_boot_command_line(void)
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
+		/* The arguments after "--" are for init */
+		if (!val && !strcmp(param, "--"))
+			break;
+
 		if (!strcmp(param, "mem") && val)
 			memory_limit = round_down(memparse(val, NULL), PAGE_SIZE);
 

-- 
2.53.0

