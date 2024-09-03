Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7E18BBBD
	for <linux-s390@vger.kernel.org>; Tue,  3 Sep 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381058; cv=none; b=toOaqhn9xFnJQH+ZeMQQLAO5mnl7Gz4ErCvMOTu++WKyDe55SvhSD5KziDU7mZqryBuIKCQLA1rRynpWHPwr/6neBov7w2sYsjJ7aoWY9AwrrMamsyYsFvZNsoj6mcKGJLHeEYn+PdZigOXZUidNFNDq0yOO+nRIfWZygMqfgl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381058; c=relaxed/simple;
	bh=DVNaHrhGdeeNDyxAyeSdLv3wZlzpfgoOzo7WchAjbq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjg22ekV234c6T+iAK6ZdrPzrNI0gfzZPTr93yMMirxv2/APEBftm/r3LoiYUOxt5kZdKFgftM19Vqdyu7o646DfXhKlW9BalNb5KpNZLKGAiM6cIoRLecJhV+YMqiWGzOIua2dt6ZQ72JzSBsH/GVLmwP4w/LDxHJQUwpJC5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wCxhUgXy; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wCxhUgXy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725381053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ItTT1ofl67Qx6qoM/paB6gC9h88l9uMn+lTF4xll28I=;
	b=wCxhUgXywgh+iCSp5MYg6y1jvSHm2x6diiCwreF2/QMspOI24IUZvviIXnFNZ11wawMDci
	3Nz4MnXUCSaklvWm8V8TqnIff8oAwwCmd2J9Q1zJGal5hQB0Dr6SHRgUOONajgn4bpxXSB
	+z8T3JToDc0X+uzmbf5/QTNUkjfaPYU=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com,
	lvivier@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	atishp@rivosinc.com,
	cade.richard@berkeley.edu,
	jamestiotio@gmail.com
Subject: [kvm-unit-tests PATCH 0/3] Support cross compiling with clang
Date: Tue,  3 Sep 2024 18:30:47 +0200
Message-ID: <20240903163046.869262-5-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Modify configure to allow --cc=clang and a cross-prefix to be specified
together (as well as --cflags). This allows compiling with clang, but
using cross binutils for everything else, including the linker. So far
tested on riscv 32- and 64-bit and aarch64 (with some hacks to the code
to get it to compile - which is why there's no gitlab-ci patch for aarch64
in this series). I suspect it should work for other architectures too.

Andrew Jones (3):
  riscv: Drop mstrict-align
  configure: Support cross compiling with clang
  riscv: gitlab-ci: Add clang build tests

 .gitlab-ci.yml | 28 ++++++++++++++++++++++++++++
 configure      | 11 ++++++++---
 riscv/Makefile |  2 +-
 3 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.46.0

