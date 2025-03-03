Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC8E27E1A1
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107613; cv=fail; b=psuplusqL7mx76PV9joaNZHh/HmZDDWGshgGzx/Vz/r31HkcmKELTfF7qLtdL2hti91a7JK/mm+RRvXheBuA+Ms0ChTdBBTh0bMKez4cHTfkPwo+QBpLy6j8ojBdQKxlagNQcpXqDY1078TSsLtdJccjjhUjvlyzgLxDS5LK4vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107613; c=relaxed/simple;
	bh=0xL0F9rdElvB+NQbmj2NrRU9PnlyhTsMf4tikqFVt+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KM7KYD/iop8ust8Cy0q2e+LoJyavmnXo250PAt/7dArvIWsNNEYVIHocowILHak74ra6KvIXfyNqy9V5GTCDa1GavRqOOQAYvewgDoDCY0KzgiLlbSG8cIlcHurMTqTfsVsrqaPsmyMbboZqGwJKkfIBdPyx8Bqq5/1oqXWymoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5uWwxgC reason="signature verification failed"; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txGhQuO8; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5uWwxgC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txGhQuO8"
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 101E440D00FE
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 20:00:10 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Y5uWwxgC;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=txGhQuO8
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dz60mGhzFy18
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:55:46 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9662942752; Tue,  4 Mar 2025 17:55:31 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5uWwxgC;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txGhQuO8
X-Envelope-From: <linux-kernel+bounces-541542-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5uWwxgC;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txGhQuO8
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 4035F42889
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:20:55 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id E8D523063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:20:54 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAB3173213
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9161FF1A4;
	Mon,  3 Mar 2025 11:11:25 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEE1FC7E6;
	Mon,  3 Mar 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000282; cv=none; b=Zi+D3d0iZttAkMhQst4RROjAuRLie0ZnOXgv5EVRQROUOjJo0IWNvnkFEsWJHMsWXxH289nd5Qv7Cgljb4Yiz3I2lBKo8vdDZHJhasR++kgqJBn7ifLcxAKppUag9EChKNQzaUpLP472hbGoYYD0KPUR18xO25w8qHUYnKhOIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000282; c=relaxed/simple;
	bh=4W0/ux5EhNgOnsFPnNp1J2/rUjYoy2NJ0USEfInHEWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLwr27VZxeI46HcHHaMXNTFZ3bL4cQKaqZ6ZfZbENKXOSBtNFoCHOBHe0+V9baptg7VU59yRnpfxXKilx/4ZReYXfa/g81MEWbezAWyXGan2Uz2PNHUhunOIlaCm9DYBrLFfmVfjNHjFEB/L5biCvAEVx8LHgix2MPPChmAgSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5uWwxgC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txGhQuO8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUFxaeOa8MxkhoOaa265B/ccj1bobA8YN971cVAYoCE=;
	b=Y5uWwxgCwKEcrzJAENfdOv9giYLmvYx0m8BkwnRw3rjkGWNDqwO1mi2jZBcU076us9cfpe
	NlIJ+nVEMz8yi0rHBd2d+N1S4xFgN9job+iswQJ+t+uhFMk8qoKYgI0iSixGv80eQRpXZJ
	T36BOlunSnevhikVuciu604kS6m0N/R5WbRALLYbB5QZOKmvkFiWAkJh7ziL6RjXpn1LI0
	NPQ9hz2VV6MqBqjoTxM8BFjYhcUmtPMQBsqvXjWlP8lFjQvInRUewL3iTuYV8Nn0z8aVSp
	FH8tcof86vHWIUGIYK9ADtOe7Q/94P1alvifw6OqsiOaWgUFrp7XuzLhxC0M7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUFxaeOa8MxkhoOaa265B/ccj1bobA8YN971cVAYoCE=;
	b=txGhQuO8g6BysurNHcVyDXbTp4j02hmRD4DuL7Zh74mFtq1/JxyrjKsLn/OMUI10Pa7IKC
	QoVL79GgITZAauCg==
Date: Mon, 03 Mar 2025 12:11:18 +0100
Subject: [PATCH 16/19] arm64/vdso: Prepare introduction of struct
 vdso_clock
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20250303-vdso-clock-v1-16-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
In-Reply-To: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=1512;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=L7kK/MCZMD7r1X/TTNdxBJdzqOQW5bJywl2DJquziWk=;
 b=fJgzjZCc5WkxvrFlLjxD+BfXszci8Y3cDqbkKCkbvF2kHXyYJjhzAfWZAte2yMP84uv4/uX+e
 gS1QU3HJXulDpcBrLb18rkXvBchGsQOAZLb+5338gjRvJQush6GNM2G
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dz60mGhzFy18
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712296.43456@7gq9ZkHnwnp/hLB+11hT6Q
X-ITU-MailScanner-SpamCheck: not spam
Message-ID: <20250303111118.oSNSRh_nwGeguib5qtMxU7bSbppEAJjC1IRhsgvyBog@z>

From: Nam Cao <namcao@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable=
