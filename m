Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBF7383C6B;
	Mon,  2 Mar 2026 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458124; cv=none; b=aI3rFz0QcrJYJ35fxY1hlQf4qLNz4YxuNG0X2yZ0kNW0hSI7Pd52euG7ESyxykydHsIqmFwoMui4gl0D9FDpJKQbS3K+HsWZyFcuWMUyXmbpjf0bl64ogDUV3TqxFhm6bBPW4YNhcfaj7ubBHpnb3RRNU/b1y3iFcI9X9/+ctno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458124; c=relaxed/simple;
	bh=XuD5v7vcsXp0J/YdrUJ8HL0Un9orsSbvu2jek84EM1A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kzWxVjAqHwT13hmphsddriGoF2xGZ2FJFF0Uuq9hlul5ShxaOaQsltw1+HpCQvLsOjoSbpck33CzC8paIMwJ7tGLcpnlNF5WSnkhMNat403XWKSDUwNfdLvBZhqysNr9GXp5WfcHh+JEkka0gmwiLeKuytZzJ7srzbLWQJJ/Q7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=CnVsYB+8; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="CnVsYB+8"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jw-003ZDt-84; Mon, 02 Mar 2026 14:28:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:To:From; bh=TqCugejn+OGjGM2P4bwUziYu78OGaka0Bim+UNMgjx0=; b=CnVsYB+8+
	VTkexEkCIXtWxDk0ct8bmk056FpnSkPCeP5i9Yz34bIo3y9sfFFKxB70WZvWoa5uqvPOn8FGr0qGf
	EbIp0aausm3TBu9LxPZnWweSATT+ezR5WZWL2ZB5A/AohwyvAn5sRz/2VIhze8//praDWx5tUs3Kh
	uSZ5LHvoL37lkFaTAFRYZPn6z3367lk4BEMixUtiAnxmBvTrEt3Nok0C2xREQl+pFHBZNSGve89hN
	sVBOcOV0Nc47MyZUOiMqCn7FnHZ5wI0tCUtCptdrGMcotngqvg2PlvnsYF2JihFCbaufaLijoNZFG
	NDR1Prmpt8MS2YYeGDqIb7kqQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Js-0003sJ-UZ; Mon, 02 Mar 2026 14:28:21 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vx3Jf-008UTR-B9; Mon, 02 Mar 2026 14:28:07 +0100
From: david.laight.linux@gmail.com
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andre Almeida <andrealmeid@igalia.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	David Laight <david.laight.linux@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Kees Cook <kees@kernel.org>,
	akpm@linux-foundation.org
Subject: [PATCH v2 0/5] uaccess: Updates to scoped_user_access()
Date: Mon,  2 Mar 2026 13:27:50 +0000
Message-Id: <20260302132755.1475451-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Converting kernel/signal.c to use scoped_user_access() had compilation
warnings because some of the pointers are 'pointer to const'.
This is fixed in patch 1.

The same problem has been found compiling arch/powerpc/lib/checksum_wrappers.c

For v2 I've changed the code to use 'auto' and replaced the over-complex
CLASS definition (and its for loop) with a much simpler __cleanup() function
on the second loop.

Patches 2 and 3 factor out the 'autoterminating nested for loops'.
I'm sure there'll be a 'bikeshed' discussion about the names.

Patch 4 stops warnings from -Wshadow (enabled by W=2).
I did think about making the _diag_xxx conditional on a W=2 build,
but since the pre-processor just emits #pragma lines and they are
smaller that the for() loop it doesn't seem worth while.

Patch 5 is the change to signal.c that prompted patch 1.
The generated code looks fine, but I've not tested it.
Most of the changes are to 'compat' code - so are probably not
usually performance critical.
IIRC the non-compat code uses copy_to/from_user() for the structures
so is probably slower than the compat code's member by member copy.

David Laight (5):
  uaccess: Fix scoped_user_read_access() for 'pointer to const'
  compiler.h: Add generic support for 'autoterminating nested for()
    loops'
  uaccess.h: Use with() and and_with() in __scoped_user_access()
  uaccess: Disable -Wshadow in __scoped_user_access()
  signal: Use scoped_user_access() instead of __put/get_user()

 include/linux/compiler.h | 26 +++++++++++++++
 include/linux/uaccess.h  | 51 ++++++++++------------------
 kernel/signal.c          | 72 +++++++++++++++++++++++-----------------
 3 files changed, 86 insertions(+), 63 deletions(-)

-- 
2.39.5

