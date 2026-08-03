Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7B429CFF;
	Mon,  3 Aug 2026 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780587; cv=none; b=kO9tUPlH/Wevb8PIhutvgjlb64Z5wlDMaUVzae7723qvrgPdf1tW+/d+wGKfD0wOj1sRUA/YQvSmHbKqMxKkVmGMsVq0VSGQJ+ygOZTRuth/zlOJhyVZaodD/BoSBO7IMtLqr+ty9PmT1jK375UZyhA4tI1xOgvWp7gZEjcgfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780587; c=relaxed/simple;
	bh=3djY4vwK3kLP1cCs5kxM6oytgwV2KyswPnSYuVc5pJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hoAxVMSdS30SIMbomy76BQ1+WT/NOsMFZgGnCPbLYQihNmqfAGN5Zb1ixdgCU6aAJL7fvQqzPyEckevJFXEU3pyVMH2yvzcVtK1ieFu7tz8FKHILlfM00/ECfIZlU3HhlWyczXKwnmKuWVupDeaFO2TKFJ/B9M+CXS5t158W6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGxgPME/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGxgPME/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F841F000E9;
	Mon,  3 Aug 2026 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780585;
	bh=Rv8BRseyPOtn/uKpF41HrKkmiFykHz8FnOEF3H4yMyg=;
	h=From:To:Cc:Subject:Date;
	b=AGxgPME/8ZjDQ09hO2RmyKexLkzG7hg2vwfCMB8w1zaY07he5rcxTb9GhSFeeMNyc
	 m3oezVSK0M2nEz02KuX/RhyIUzanu9Oee70SZzTMVaCVxhA9N7oJsrNya594iO0Exj
	 19lN4nEb+VhtLx2UwM1EEGKLr2xNSHPCJ4oHyAOCa3Kktd9VEkSx6KaAdfkYge4tR7
	 X6Eg4cY6GUb6oyRCUo3cWxfgb4yuR64MIOLW810wODamUZeEI/+fsxBmpNRCnRyAxV
	 L/nrwY25ZI5AEwylO6/khW77C7kAdH53V5sfjBVaylpt9oUejBiRbHFGF9OsMF3sm4
	 U4Czpw43k25OA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: driver-core@lists.linux.dev,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org
Subject: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Date: Mon,  3 Aug 2026 20:09:31 +0200
Message-ID: <20260803180931.97202-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

s390 does not provide `ioremap()`/`iounmap()` under `!CONFIG_HAS_IOMEM`:

    In file included from rust/helpers/helpers.c:68:
    rust/helpers/io.c:8:9: error: call to undeclared function 'ioremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
        8 |         return ioremap(offset, size);
          |                ^
    rust/helpers/io.c:8:9: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'void *' [-Wint-conversion]
        8 |         return ioremap(offset, size);
          |                ^~~~~~~~~~~~~~~~~~~~~
    rust/helpers/io.c:19:2: error: call to undeclared function 'iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
       19 |         iounmap(addr);
          |         ^
    ./arch/s390/include/asm/io.h:31:17: note: expanded from macro 'iounmap'
       31 | #define iounmap iounmap
          |                 ^
    rust/helpers/io.c:19:2: note: did you mean 'kunmap'?
    ./arch/s390/include/asm/io.h:31:17: note: expanded from macro 'iounmap'
       31 | #define iounmap iounmap
          |                 ^
    ./include/linux/highmem.h:46:20: note: 'kunmap' declared here
       46 | static inline void kunmap(const struct page *page);
          |                    ^

so e.g. an `allnoconfig` with Rust fails.

I assume we will need to `#ifdef` the helpers, plus the users; or stub
at some layer to avoid changing callers.

I hope that helps & thanks!

Cheers,
Miguel
