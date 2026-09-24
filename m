Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AFE3ABD96;
	Thu, 24 Sep 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253655; cv=none; b=Hz2ejI2sn+S4b8nKU5zHPOuVL4BoB7238LRRXOsSpVB9hF/7P9M5a0+mg5N+JEf2XwG+2yH6HoPkqeTdy36kHAP9mpbdg+nc7yJtJgdedoIhyuNN66NsC2YtODjS1rNIPUEst/5S9o3lAeBP3c9VNz+dXygVgz0tmFwDSAEyyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253655; c=relaxed/simple;
	bh=4s6QAGOSw02obaoUejOkLC5JwzN47+Sds/ZrPWOhowY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIYAlXYHSqFm4gHjYNonasaUUwKqOt69H4XT2FE29AKxYR402Qbtz9FQ0RapJev1GbPnAAA3yRH3n6JPC8UhOPZC3FD7eqQTvO7j2a8Y/G/dLemh3liyJ0e+jW7yNto6BwamgZJVGq5T3eGi6pq2gucm3Sfv00vPzrMtV4wQO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xcjT4bKS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xcjT4bKS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=4s6QAGOSw02obaoUejOkLC5JwzN47+Sds/ZrPWOhowY=; t=1790253654; x=1791463254; 
	b=xcjT4bKSZPusZnkeafvQfeysOmh+9FFTNCsPzBDP5s5XMHe7KpkmYf6gZwkTAeUJ64CQKlz/xmz
	rityTms73GO+V9xIR4d6W3NIKBpZjJNCBhE5kKjSCJloornyrZLwfN1/m+JThtsuF2IS9xUVfghyP
	DVe3wWqp4sjSFIrggFHYeaxqE766y81Ep33lb15WjMFe5Phm6JkO2NQZK9rOvlYGr+hTo/WkSjO1n
	p2nzNVlIfw/oP5ON3UnWDwwwhKvgKXPYgAkCL3pOS1pTRTF+1EqXxnEVIYP57n56C1qimPE3SdiZn
	u96wckIx1FMf7RcRZnrnkjvJcrj0D9Jp9j0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9ikq-000000092x8-32Wu;
	Thu, 24 Sep 2026 14:40:48 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/4] ORC unwinder cleanup & UML support
Date: Thu, 24 Sep 2026 14:35:49 +0200
Message-ID: <20260924124039.1621965-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since UML is pretty much "just x86" I'd figured for years it
should be "simple" to add ORC unwinder support. It's not quite
as simple as I thought, but I managed - though to not have to
copy/paste _quite_ as much code, this series first cleans up
the already common code between x86 and loongarch.

Most of the code is indeed copy/paste, but with adjustments
that are not really abstractable for making common code.

It touches s390 because I thought we could end up with some
compilation errors from s390 unnecessarily (and accidentally?)
declaring unwind_module_init(), maybe it's not needed since
the new orc.h isn't included anywhere it could conflict.

Works for x86 and um, builds for loongarch (but I don't see
a reason it wouldn't work).

No idea how we'd merge this and if the MAINTAINER entry is
really where it should be, but I'm also not in a hurry :)

johannes

