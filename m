Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065323;
	b=XM7AxgedAl5SuCMD5/k+0jqpTN0NIieVMEjswkdpARVuyPWPBDfc326o408r+L29p/LH
	 RvZvkVHrkdAZ3d0WFmddote3e6iKhvRQ1sCE1PUQQzCn79VWTJ55UNupBbZ24kTTvcqiv
	 xMuWAeVdl9amFPeAcl1UEBQ0RQC9Nf8sJC/ckbhz6otam0hBw4QE7krBh5Sw+5Q406eDK
	 KjgR1SPaRUdFteIdDEi6SGXxRrEJcH7+2sNhCfvrP3VUpBUQuF6AsJBbyhiLXO6lmi/5p
	 IWUCjXwUzERQVwMpgjh0VHBqSidAkI1l+ODFVNbRZu0Yp4Xv1oAt4rjO7sBp+OUqGTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065323;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=nB7NyMM3+R/ysxmgGPhpf3VtSpdLduKfuUDtKW50pjU=;
	b=AzM6wHDPKcnjVrCbc0v3BTV8Rfmd3NWnIqBJMaP8F3xsr7roSxnv3q1aH5w6s/s6Hw9H
	 UPGfZTMrv1NijShM+Qt14RAo4Kv+beV2NhNp9uQdyFjX+WElq8agDdvdro29AN3cn0Rbb
	 VglLigUjbj95aXgy2OjJj3EVqwa6d29WqqA1m6V3vZEjCxvDj0976oQcyvCA3+Q0gsiya
	 fTWn3aM7v1BBkeTQOw/ZvxIbHaU7F3eoRePasHjgV/Y+nEsXcdxMho3InFbX/Wvp+g+DI
	 er6nNEUkkrxnh25WRGJGci4mpzN/bY0GOKtmuqKy+yI+uH4hw3HPGncRvEHFcfGPPXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=X+tuZ839;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MapbBIfr;
	arc=none smtp.remote-ip=103.168.172.136
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF8606A320
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 05:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BFF8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=X+tuZ839;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MapbBIfr
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 910401381B64
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 00:15:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 19 Nov 2026 00:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795065321; x=
	1795072521; bh=nB7NyMM3+R/ysxmgGPhpf3VtSpdLduKfuUDtKW50pjU=; b=X
	+tuZ839rtn44ra+tvX2/152CSn6sDJOi7eousXbFCygf3cj8uGPHOY9zUJba5huv
	LCDQkU3Us9mEAnjbN5Ef+LAxHS1Pn9feoFU19N4WImH0CStAhcTDg0M0nF2CEbEU
	1bVoUzI/sDEC8n07qqeXwanpSDwadkHK1wPasK1FW0h8ivlRmbuI/oVU4rMg8ZjE
	BuNY+34UfeNjEbECb66jlcoUTPgDrySsv3b4nliyi3+1bHnjA7GATLSoIOlgesNw
	kiDiz8RLAec8dWe2IzNJlMf3v5PDuycDgC4rzc+4mL6LbVjJ1y+yqLkeLGvjiRUf
	JZVNPCJoN8mUsJIbxPlcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795065321; x=1795072521; bh=n
	B7NyMM3+R/ysxmgGPhpf3VtSpdLduKfuUDtKW50pjU=; b=MapbBIfr7L6+jr/nb
	+T7Wbr7xE94G4iBTC7xM69GXLXTNZ1A+AMhCTT65P1yp+UI5192y2+nqRlnVySGY
	//mKjxGvSOp9DRW0Eoa0qcpNvZo5e7pFU2B2QOaCHfreaRpvCWu0DfQXS56Jo6SM
	goTpD2+y0TsyLTQw11fG6S7bnHMy5bRxV010QexQnDd7OwrU/TMNE6sQyiQBj76u
	2sZM7G9KtRQKUgbqRdAlsWj9Dz1V79tDu5pKTcaaxrt255k2kGifMJC94A+o6550
	ggPUrWfejInKfJ3ffJm1zGP9tSYuRjt8gOfaUdwP50AyD6Sx0h9cNONhcSYmYSds
	JYEcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795065321; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:KNukBpWltCHrktvOmBAyWridcxcr+E+wbGArDohJcfVb5JN
	lUc3g2i9SXd/4VzqXg5PSE7mgXYl3/WMGCrzDESCI27AoRkubi1ibKMyC2Q92jKC
	LyG+EbZpkuhTmAf8fHrERHselPT/35ia+/xcKScoFS33FQZ4S3qQufglIYMIZLgD
	4vcYDWUGhM9vOYvfL1oK3DkkBzagBSU1FDTp2GDskUMpxC3PODPj5gOydPkrkIhg
	J6ScImitnLoFWKMc74Pg4yzUcGYIsMk6wu0STrcAMvJmoCUjyB68f9N9R0VRQh+4
	yu4fQBVQuojNojAs2AY5efn6an6IlBLcIQffHtQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:x//NWy/h1nXC+M2WEmBfJfyd3519ihGy7lPGHXQNuSc=:4+p7gG5BwT/2fGf8d6eViKD6hqgE7hcriyEtzB2mdtQ=;
X-ME-Sender: <xms:54X-aho_4vnnPquv-OcJCaLJUPyMtmONCVPGAJperguEiPfYtqBbFg>
    <xme:54X-atcUTrB8kgIfLeDTdVatV-K0OoF0ZP2r4ZX3WPEcQS0-XAgGTJkDkeG2oEuzj
    rLO5fUGEpWY97rzBD5bw5Ko1FBnlKiAvko0o9rXX1TvfRn6ozMT1J8>
X-ME-Received: <xmr:54X-apoG77N28j-gDtcYRM10JWcfECYA3P8FK6HQiJ7FHK3H0APXSHp88o2wH9nkevS322BTiQY>
X-ME-Proxy-Cause: dmFkZTGhOmZn91BW8pxHvBMWXRqhbLMysp8Q4TvoI+VE9JbSYAz0c/4zd+rMp6yJOnzQo2
    A5h1+Ma3DwwRz0lh04L5XOWbUr4LmVOSOkHzpY/w2yLXGwmcxZredAsP80hMCQrJRFodW6
    fmevnh4d26BVXSXn55rBOjAyx+h1bESp7gOITB+AIkBvzyJYGo0ESemuyh5h9uJD60i+cs
    SgAZ3CvmPdBrooaNlYfuH3M0HsG27/6DablfXZ89RfIZExguJZ8ORWOgjF0hFWp3UR9raT
    3tReRAeuihRXAsm9oqtGE+5YCk876shunhrpseVaBMkz0D3wHUm1dvwS6tCtN64SczWLEn
    DuDdQwcYEIyrIp3ndQyEaBgkuOsANeEsOYAmiMe5BKYSCCscMTQTaA7bUQTdT6x2SL99mc
    EUQODC5AfuKbMNxP/Du61PY2puKdqVCkV3+Tj2MSc94/QSUyNMqYek+Yv0FJ1UbYiNlyrf
    Dnot7ED3QRTkVgCtq9MaF7Q85ATJahP/UiowPn4G+To3EsPmA3oeh0AsCvZ4gVbYqU7hOJ
    F7+WWByG6u6U+GL8WxBKjc6F/n6WShQdTeCvDenqqOMGya2CnkJ8dAWj319wv25W8G1+/8
    rT7muG5iAUUuzY6DkFFkzKUn5f4NY69Kts+aQyf5MaAnpzKasBu+TSjoeOAA
X-ME-Proxy: <xmx:54X-apS2YRuzof4jvWet_kxz44WkEnql4uUwPonuQ0QVH0sa7svGJA>
    <xmx:54X-arx6inLsBrg-Tf1IxmB_y7hsOGZShniWqqg7vapbad7zq59tSQ>
    <xmx:54X-aog9aBPY90lWo6IWsIbsmYaUsr_HqTTPBwRBXHY114KefCSlCw>
    <xmx:54X-an-yVrgaL7OWQVQnQxZNCLETee9XviNCC5sg_XgPQyln9JvbIw>
    <xmx:6YX-aobwTqTMr42AXmk7bvGgz7NskPIhynqV0CtdcbgTyOySumcUqW7H>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 00:15:16 -0500 (EST)
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Lechner <dlechner@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH] s390/vfio: Allow untainted use of driver_override
Date: Wed, 18 Nov 2026 22:15:04 -0700
Message-ID: <20261119051507.3306075-1-alex@shazbot.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vfio_ap and vfio_ccw drivers bind devices through driver_override.
With the introduction of the support_driver_override flag in the core
driver struct, it's now required for drivers to declare themselves as
driver_override compatible, otherwise driver_override bindings will be
denied or generate a kernel taint.

Set the support_driver_override flag on the vfio_ap and vfio_ccw driver
structs.

Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Alex Williamson <alex@shazbot.org>
---

Uwe, this should complete the vfio drivers needing driver override,
covering the s390 specific drivers.  Thanks,

Alex

 drivers/s390/cio/vfio_ccw_drv.c   | 1 +
 drivers/s390/crypto/vfio_ap_drv.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 7546bd137e4e..77765cde87f7 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -375,6 +375,7 @@ static struct css_driver vfio_ccw_sch_driver = {
 	.drv = {
 		.name = "vfio_ccw",
 		.owner = THIS_MODULE,
+		.support_driver_override = true,
 	},
 	.subchannel_type = vfio_ccw_sch_ids,
 	.irq = vfio_ccw_sch_irq,
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8e69ed286bb9..2d47dc643269 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv = {
 	.on_config_changed = vfio_ap_on_cfg_changed,
 	.on_scan_complete = vfio_ap_on_scan_complete,
 	.ids = ap_queue_ids,
+	.driver.support_driver_override = true,
 };
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
-- 
2.54.0

