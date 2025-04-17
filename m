Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B7226CEE;
	Thu, 17 Apr 2025 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884911; cv=none; b=CViYP7LG3GOBEV4gQFSZBHku5ygQMSyHSwPIFVH1Hwj4eEwyef0I/4tTXqbG2x+BOHIywVlM996CMPhR7FTSzjm2Sdd0bLcWazTUJfATJGJkRvHNroJmSyEP8DZJQAzwnNN6Y/2qhLGeumwvDYtpYpnukZOf8xmhl+JL/4kq4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884911; c=relaxed/simple;
	bh=ROmjIK9stdF7h78XYJoFECATRlnOtUjoflDwHaRaxGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndezZPvGrjP+y7vP3iKPuPpv1egdUmYGcay4qQWvO7afoIN3uSWr9ihEfYYWawuHLhSc97RnH4/DUe4xj8d3nbAkBGr7QcqeHsspJk/IvA3Ys06f3D7yk9+8Lxf2qkKsw9KgQWoTWyEGq7Fy/XCXnPZ29qjsgrqg+vOriug9NZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZqgW4gd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZqgW4gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5096FC4CEED;
	Thu, 17 Apr 2025 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744884910;
	bh=ROmjIK9stdF7h78XYJoFECATRlnOtUjoflDwHaRaxGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DZqgW4gd0XObqtM0z9Z9ecMrx6bEsGiBN4ThwsHPDgRx2RoGHW7IdiaeM5m5uTiEE
	 hfb+OxfIgEmHOawRMc5s/1zDzi1UTinbVb6iX+KJhFhe4Iwl7LFZ2UNWauXAljQBin
	 u1VBufo7XU83Z9CuoU4uskANp79bbkLh65lP/m3LbszfDvBKQBVv4UTrwpGphH7LMu
	 849qawDsxIRpVF8Xlsh+W/vsArdyuYkzTbMgMdamOplE/hu+0DMJsuiq07gjEoARTQ
	 U9TSUhAKgy9sOMA31VxmglgTOdJH+laxBsKI/RxAbjE7glAyb6DnzwavB6jpAxm4Uu
	 0v6I80cA68C0w==
From: Simon Horman <horms@kernel.org>
Date: Thu, 17 Apr 2025 11:15:02 +0100
Subject: [PATCH net 2/2] MAINTAINERS: Add s390 networking drivers to
 NETWORKING DRIVERS
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-ism-maint-v1-2-b001be8545ce@kernel.org>
References: <20250417-ism-maint-v1-0-b001be8545ce@kernel.org>
In-Reply-To: <20250417-ism-maint-v1-0-b001be8545ce@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
X-Mailer: b4 0.14.0

These files are already correctly covered by the S390 NETWORKING DRIVERS
section. In practice commits for these drivers feed into the Networking
subsystem. So it seems appropriate to also list them under NETWORKING
DRIVERS.

This aids developers, and tooling such as get_maintainer.pl
alike to CC patches to all the appropriate people and mailing lists.
And is in keeping with an ongoing effort for NETWORKING entries
in MAINTAINERS to more accurately reflect the way code is maintained.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fecaf05fb2e7..9dee0e85d32c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16760,6 +16760,7 @@ F:	Documentation/networking/net_cachelines/net_device.rst
 F:	drivers/connector/
 F:	drivers/net/
 F:	drivers/ptp/
+F:	drivers/s390/net/
 F:	include/dt-bindings/net/
 F:	include/linux/cn_proc.h
 F:	include/linux/etherdevice.h
@@ -16769,6 +16770,7 @@ F:	include/linux/fddidevice.h
 F:	include/linux/hippidevice.h
 F:	include/linux/if_*
 F:	include/linux/inetdevice.h
+F:	include/linux/ism.h
 F:	include/linux/netdev*
 F:	include/linux/platform_data/wiznet.h
 F:	include/uapi/linux/cn_proc.h

-- 
2.47.2

