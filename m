Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533150;
	b=5j5v+k4CT9KM1xlwistKD6LH+/udTNNjO6RcejHwWFJUhtUFvWcCCNnLLf7ET5QXMOzR
	 hJw+lquObp/5ztUiraF2+ARBzZhUbPYmWYdKChdSw0Ic5ibZ7rzTzNF7hZBM5r0k21UrN
	 8vRrBrmKLHz4bLCfWhczL0XQj1gQNVsRy4HZNbVUmTE3WJMf35sgiz85MbEy3fIaJS+5A
	 sTiFesuEkmLUsrR8n13IzQo/t7ANFMAz2aU0+WD//ppp1XDHGl2QlK2bUnaEnDGjhka3N
	 u5kigCSqFURMk7OOyeUUtYPhopmExlpgT+OoWci8tgu/MR0s3hMHdFCxBAIl96OYHXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533150;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hIZqfHvkeV48wYKVgFESXaKGPL4jCR6YGzUw6vDNOiE=;
	b=WKTj/+o/kcPFXqwYdBeXlyWataBc8HNn5ZVpwOqTXUqjY0UPwVCHRyHkGiPfWGCbXFPl
	 cXA05QgY4wxtr78Hj5xyKoGa8l5HlJci4i3jaGsuy9zYoL67PDDmwIv3we5NIacbTBb45
	 yNnUXzYOKH+jqboAGo7/ZBQEvRtYy/f+KVsNDU9NsXOypBJpYOoMb6tS7G+nIGbpvAzQR
	 9VqMNOsuL28hNOa0qkmN4S98/BP1c7llgk+1uU5irxYpaMqXyff7WN3zRggxDplXMvptK
	 Y6ONYTDtKu7fgHDUI7flSq2aVoNlbfFrSv9qQRIB0q69nfB5QWH2yvtoTCfPJyH0SZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5CbzX8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A17606A31A;
	Tue, 20 Oct 2026 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5CbzX8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0D61F000CF;
	Tue, 20 Oct 2026 21:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792533149;
	bh=hIZqfHvkeV48wYKVgFESXaKGPL4jCR6YGzUw6vDNOiE=;
	h=From:Subject:Date:To:Cc;
	b=W5CbzX8stvqc7tXLuLY0WiKQqgETZYSS2a2gj9p4YCZCWPk0sYqfBLaZJ/+0DWPRB
	 MVZuyVQUY1D+I8j4+/DPWeUEwMi3gP0t74VyvL1dZBjNuL2ILfwhwwvH/Hxiu4Pd60
	 mCPIkPaVfMaZUlsudU//4i7AcmQEwiCDthAXLjfqxMBBYHBcpEl9l+Q6Ye6hapPlOj
	 5x96MEvgge7sZJehJz+FxAEqZL3+HtV4hbf/mwnmY8IjnIsVQHD0OHu2OoGo10X74z
	 R6RO2YMYhFmziUitr5s7jRJ1ohOOAHcfbPYlFQ2BsndwSZey6Nkoy39EsH/CnvVUoN
	 voDYTg/diIWbQ==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] kbuild: Fallout from moving '-mfentry' check into
 Kconfig stage
Date: Tue, 20 Oct 2026 14:52:17 -0700
Message-Id: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDsQA3HhVYqLOE7MNBglsaUi3
 t2oyw/e+3fInIQztNUOiX+SZY4F9asC8jaOjDIUg1a6qZVWGGiOTkZ08sfJcVzThuSZAhpltOn
 J2IYslP+SuIzu9rt7nL/9h2m9gnAcJ2/ZXxZ9AAAA
X-Change-ID: 20261020-kconfig-fix-mfentry-check-50525bc5a6ca
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Julian Braha <julianbraha@gmail.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, linux-s390@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=nathan@kernel.org;
 h=from:subject:message-id; bh=frpQhPa8vDtdOo+LjW/wRQXA5GT8qEG7+AzXAKCkRJw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnXH01X+C8W8bCL5X2VY1ZBrs6+TYabzlid+x/jtPFrp
 /CH54wlHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiAvcZGTYsEH5z8yuzwe/k
 E4fD2D8puB9KWBZ4USdImjn+Psvaj78YfrMcO/b9UWP44jmnL2WfLy9t/XdW9+wzN3Elzi+rXFv
 4GDkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

Ricardo reported an issue from moving the compiler test for '-mfentry'
into Kconfig. In testing that patch, I noticed that the kernel.org GCC
builds for s390 were not probing correctly for '-mfentry' support.

The first patch moves the check for '-mfentry' back into Kbuild where we
have the proper information for whether this flag is actually supported.

The second patch documents the reasons for these issues for future
travelers to hopefully avoid these problems.

I plan to take this via kbuild-fixes after sufficient review/comments.

---
Nathan Chancellor (2):
      kbuild: Move testing of '-mfentry' back to Makefile from Kconfig
      scripts/Kconfig.toolchain: Highlight cc-option differences between Kconfig and Kbuild

 Makefile                  |  3 ++-
 scripts/Kconfig.toolchain | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)
---
base-commit: 997208ce9f43f01febac956cf9aeffe89945e3c1
change-id: 20261020-kconfig-fix-mfentry-check-50525bc5a6ca

Best regards,
--  
Cheers,
Nathan

