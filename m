Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFC31D381
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463822; cv=none; b=Ca2nMxx8YeDXKZIipbVyAuzd/xwbg+4H0mQT/zYPI8b87wLDbXoZpv2luAJUwLG1/x5EUuiq+NCqFfX6h8mYdHjHvl+d1/sreSG0P82VgUDdx4ilqkjRq0WltCpPNQ9L7UVMMMGphf4+0t3eT0VKXWRwm2UFA2T/bDmLPfEZ0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463822; c=relaxed/simple;
	bh=jgfGgoNNtT1dpeJOzCcI62vYDerLNLfToFocSoP6lHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UQzbZFTH7NCXmVFH6+rhJbNiAm8Ws3iyFcMoD623if0apQCBOnrpVWMKnlldAGxUOxxWDqY57j9eJE5dkl8/eoeUp7d9QyRf90cRbbzuIqPBGdGFL688+3v8SvRn04N+vVo8IvYdH0srsKHsihuFSm0kHj87VwXYTVEcg0mgRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=H7IPP/VR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="H7IPP/VR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso39349745e9.0
        for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779463818; x=1780068618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8mC6YmKGbcgPvjI1xvNdPKo2F0RFZ1L9Hpnxyf+wD6k=;
        b=H7IPP/VRKJVY912WasdwnJ8rbbxxXMjlyZuZnZykWiHL2QuvF4ocnRmEJ9rZN8vRz3
         yV6ydau9BAB74AgBOvY+kyi8/PL9QB8aWnadtkXJTY0TcqXhi6cBnTxYXvdXv5mtpt6p
         Im0FOMo5uYqAfaaL/Nbzzmql0yaif3ud/3U8N89ZAli8GsysjT/ei7wq3uY5XeFcwscV
         P6cfyxdX7/3PPg+eY4yqiFdlI2SYqqibZDw43J+iq64HWBeGRahipS+YuyP6EDf3vTEb
         s4aPmjcLfWWHpYg7VEc1KfKjd0OTwrbJg03wtRRGiOv98830sE38y279tW+emxyAOJk/
         mjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463818; x=1780068618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mC6YmKGbcgPvjI1xvNdPKo2F0RFZ1L9Hpnxyf+wD6k=;
        b=Km88sOoluryJkf7J5W6v3SWzfI/Gi4blzgffeY/NxVC068+MP0/WfLRUCbB1ihmClW
         /51M6KsxkiwpRRRt/pLT4DJiUuE/oGRN6a6Tu2CfSJ5lLvKGvaShauFaMybYzO5FEdCw
         gOdjC3OURLCFYXF5h5wKsvtod0AymLHg/TUqiP8Lk+Sk7w36GGgUMgjINft3kQzR71uk
         moen+lqiptA1xhe8biWwStBTFiyfmDgL21mbb8DQ57aF5p87n9OyJiad0S6EtTL5zPS6
         V6B7TdBwBRMyTAmKrpeHREf3CTxZzhEghf+Sffic5IHOhsyQ25DcD8aCk0XQOGU1MvhW
         w5KQ==
X-Forwarded-Encrypted: i=1; AFNElJ+r4WMmOK2BHl+d3bM3L9lQj3M0jmS2xo5cF79yZBSk0k3KRFW3+hAtX781rg8foVZjsxTqleSPKnsc@vger.kernel.org
X-Gm-Message-State: AOJu0YyG744Yp0JRR4x1rY4zLmaSSqpUUYD84p8NBQ2GS345zlhfZVT5
	MsIAz4nalQs9hbZ2kfPtZX/i4Ld/RRQQ6Gb0g78lLTDcIqXrBR1ftoczY+ci1V6+ye8=
X-Gm-Gg: Acq92OFF4rwze3zU2ww98P9b1KTleMVFtJqEvKytmwES1S9Ozsqutd7gZ2Cyzg4HrmG
	F4Ep0gjfFveZBHXnKWEBe+Q2n9yH1D+T4sHgD0ADByW76kQICn7x654nBxcKNBh+P2ujOqPv/kF
	V+DjJP2WdOk71PYQg5SmlFCqTiJEcGHnNmIlZLlGdppPT3RBEduSubc5Mih95FVzBUAh6RtCkNZ
	iVIUXGJaQPEbZDO/RjbErbL5IHDD76Xc/SXUEDCkvOWUYwiREViqahbHAN6U98EUXCVqnJJAijo
	k7Mk/u64SOO/4Q4+HUTVVvQ7zlhGjI7FPOUj9K0vcb80NBQEiXXN2vE1wbg7s9ZiaR4nFKzK2KE
	TuQRJIFQl9NyrE4BMJCgKWXSqqkXePfXbvAMJxjdvq9OwLNTC5nvWy1Hd2LjacgHfI0xlgpzlcu
	qysMFQKI45uTYUYOGPukorJUMZPD5HD/xQvphdXzHk68qbkoX0yHPwTbeeJ3e7Cjc3iNDxV5B+m
	Qc1RFO0BRopRHc=
X-Received: by 2002:a05:600c:3112:b0:490:40ee:d561 with SMTP id 5b1f17b1804b1-49042487e14mr57090625e9.7.1779463818055;
        Fri, 22 May 2026 08:30:18 -0700 (PDT)
Received: from localhost (p200300f65f47db04fdedbb26b9ad100d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:fded:bb26:b9ad:100d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904179c615sm19335555e9.4.2026.05.22.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 08:30:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 net-next] s390/ism: Drop superflous zeros in pci_device_id array
Date: Fri, 22 May 2026 17:30:09 +0200
Message-ID: <20260522153010.777081-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3296; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=jgfGgoNNtT1dpeJOzCcI62vYDerLNLfToFocSoP6lHQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqEHaC0pvCCp+h5VkYJmhzo/Mv4dpfaM605RjVM DQwz3dUu16JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahB2ggAKCRCPgPtYfRL+ TuLuB/9R5g3cb6bPRPsQXqpV0jjvv7NzE5fns437rY4vjBTkAG4ia92B7JWDedDcKlh4j94tlov dDI+78V7NyfiFctPdoU1yaWutFFRNf91krp8Yqs9ruJASIV8aq/ku5X/hhcE9rOsdVBwjdm2/qv KjEGyFkuxolTzC7UakAHXSi0sxq6X2ZytqtXptb4SUJDOJCx2WmEcrA5t7kqD1paItpKCwUUbB9 JJxFVb5C2HmZWVL6GedHo4Md7HdIV0EhSVpFLpanLTEt9PGPwdJppfQxHtCH6XXpEL501RuLGC6 +gAIHWysC3BgCV4jLUgIAqGHppwI0ZWckDlNUWSQ3d+R1XZU
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .driver_data member of the struct pci_device_id array were
initialized by a list expressions to zero without making use of that
value. In this case it's better to not specify a value at all and let
the compiler fill in the zeros. Same for the list terminator that can
better be completely empty.

This patch doesn't introduce changes to the compiled array.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

while being a cleanup that can stand on its own this is also a
preparation for making driver_data an anonymous union that requires that
.driver_data is initialized by name and not by list order. The union
allows to make better use of the C type system and drops the need for
casting. The change to a driver will look as follows:

	diff --git a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
	index 1739971478ff..c0d9da81d512 100644
	--- a/arch/x86/platform/intel-mid/pwr.c
	+++ b/arch/x86/platform/intel-mid/pwr.c
	@@ -347,7 +347,7 @@ struct mid_pwr_device_info {
	 
	 static int mid_pwr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
	 {
	-	struct mid_pwr_device_info *info = (void *)id->driver_data;
	+	struct mid_pwr_device_info *info = id->driver_data_ptr;
		struct device *dev = &pdev->dev;
		struct mid_pwr *pwr;
		int ret;
	@@ -471,8 +471,8 @@ static const struct mid_pwr_device_info tng_info = {
	 
	 /* This table should be in sync with the one in drivers/pci/pci-mid.c */
	 static const struct pci_device_id mid_pwr_pci_ids[] = {
	-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PENWELL), .driver_data = (kernel_ulong_t)&pnw_info },
	-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_TANGIER), .driver_data = (kernel_ulong_t)&tng_info },
	+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PENWELL), .driver_data_ptr = &pnw_info },
	+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_TANGIER), .driver_data_ptr = &tng_info },
		{}
	 };
 
which is a nice improvement dropping three casts and that will make the
compiler say:

arch/x86/platform/intel-mid/pwr.c: In function ‘mid_pwr_probe’:
arch/x86/platform/intel-mid/pwr.c:350:44: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  350 |         struct mid_pwr_device_info *info = id->driver_data_ptr;
      |                                            ^~

(so it promotes that driver data is supposed to be const).

The patch under discussion touches the only pci driver below
drivers/s390, so the example is from a different subsystem. Also this
means no further patches for this part of my quest to that subsystem.

Best regards
Uwe
 drivers/s390/net/ism_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 7d0479e4e095..d99c588d3e00 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -23,8 +23,8 @@ MODULE_LICENSE("GPL");
 #define DRV_NAME "ism"
 
 static const struct pci_device_id ism_device_table[] = {
-	{ PCI_VDEVICE(IBM, PCI_DEVICE_ID_IBM_ISM), 0 },
-	{ 0, }
+	{ PCI_VDEVICE(IBM, PCI_DEVICE_ID_IBM_ISM) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, ism_device_table);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

