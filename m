Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAFC191F89
	for <linux-s390@vger.kernel.org>; Wed, 24 Sep 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674103; cv=pass; b=Cgz93BTLUAT/Pkcnt+WajaEA0oahCgKnfzeEdL56sv8o3Zh1X6apaCuD7zAEmYpQz7DgnXc94zJE0H81QHuEW+N22oYVWLWkSrVX48mG8PerTQRplehxUfKMhpt3SEHzC6z2Z4YZmHsXqIkQepZNPoVUkF0IaqYr2Wu3yyJFAwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674103; c=relaxed/simple;
	bh=AWveDXA8ALJzWgHEIwnedN8w9zGfyFbE+EAufRDnZAo=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=CkxnA5ckSGNMDTYEzDi3mkD5+gTejPSolUi33UQ4VhrFMHCJ1qF6XblPGj182ygZEyaBA6qX+g4PdZdplZJSiJTiCzxBcQb2j9nIZTXBsegN3RaWHyOsvRrOb4zK7pQuQatIkYSd0zY+T8ThgiWbH96kycM57rOWeGDYfZzzZfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=C/CArbLt; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="C/CArbLt"
ARC-Seal: i=1; a=rsa-sha256; t=1758674101; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=JweJUzuL/WQJmGNpMFW1Jpo4Pynt30z2TxoYkShGP15lr87q1OGarCPH96dBaG18XLJdT2ttc1WK5T6Yb+fr1Az2zLjJPiXHhIHcu6AF5ZDv/W65UfY6ToZJ5NGQczwA03zmV66J04dtLoK8yvYB/aF+ngPSPnzvSq+CeJNc4SY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674101; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=AWveDXA8ALJzWgHEIwnedN8w9zGfyFbE+EAufRDnZAo=; 
	b=lzopzpspTDnZpVeFXsHa+3V4cdnU32ztiNf1Qh/Dm0DLeoeMtk3Us17QbuNyeCX4IteLD1UPoJuQGvAqoVskIcdz/LFgIlqwnl4BOz0bUbydVst1qsLCveJtsgT3cIB5tVTWnfo4NsK8wUiQbMWnn9wW406iJiiwkYLxpKU0GoA=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9ab582b0-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653580616.0598269629054;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=C/CArbLtp5rFZ/zYJ+3Z4ebi0gL7Y0+Svz9mEsOSDBbdgS8OI2fr7Cnu2o4sQzXeiRWjA+nlvVLXegmt7202z+bfxMsV3yKiFvT//FykfvEHwO5rfDkjGoj71BGR0ebuFtRrC+UcKA3ObTb+iqzhfCvdvtkHsg7pV4c6CyIBP0k=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=AWveDXA8ALJzWgHEIwnedN8w9zGfyFbE+EAufRDnZAo=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-s390@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9ab582b0-98d8-11f0-9ce0-52540088df93.19978ffc65b@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9ab582b0-98d8-11f0-9ce0-52540088df93.19978ffc65b
X-JID: 2d6f.1aedd99b146bc1ac.s1.9ab582b0-98d8-11f0-9ce0-52540088df93.19978ffc65b
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9ab582b0-98d8-11f0-9ce0-52540088df93.19978ffc65b
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9ab582b0-98d8-11f0-9ce0-52540088df93.19978ffc65b
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9ab582b0-98d8-11f0-9ce0-52540088df93.19978ffc65b@zeptomail.com>
X-ZohoMailClient: External

To: linux-s390@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
