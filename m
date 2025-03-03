Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B872C3755
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107469; cv=fail; b=OIm25daK41jRMm26IXLnGBQnWlbT3/cdDeNkt3VH2vWnrOaNRC1NtAotyQhdd6I1FqZqKLPkqBPJ9U2DYla+a6rlojZXUWJg+/R9imObSi4d3NjqtxGmCpzd+4Sa1H99Jz+OcBQeeBgJJrqoR+4MkNLP8CYGeYnv9rEZ2vmtino=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107469; c=relaxed/simple;
	bh=Jpb+o8kZmle8ALsCLg4utbX+Tdvv5P/Fwam+h44eiwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJvgoCfQnVmwgweS08R6PCAUU1pZ4pozASzKaPg2I3cTnndMpLrWgyryV5apO2aVU6NzKwX2k7+xZHiXVaBTj42y/6ySlYhygFk/rJSNNDriLcJ1bd9XtI6nb3Rqf9pIBXcPsEUNIuGtaSswhbvLknqARTElX3BlBxzppYElIUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbCusKeg reason="signature verification failed"; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fOvo9r/; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbCusKeg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fOvo9r/"
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 0FB2840CECDB
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 19:57:46 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=UbCusKeg;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1fOvo9r/
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gzV729WzG2rS
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 19:26:14 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0976D42722; Tue,  4 Mar 2025 19:25:12 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbCusKeg;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fOvo9r/
X-Envelope-From: <linux-kernel+bounces-541540-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbCusKeg;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fOvo9r/
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id D0ECC423DC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:23:56 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 66CD13063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:23:56 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC833BD470
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297111FECD7;
	Mon,  3 Mar 2025 11:11:25 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855131F8BAA;
	Mon,  3 Mar 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000280; cv=none; b=S9cmjqW7FGyLKtiNhg1bX21xKFMV7JFXZJgcMedkMJsa7bj4uhmTrddtboPPIikCbsJLCk+kln3b+n9L18kLPyv7JIAxOoWeyh2p3QcoEUUxf+QSZBIldGBphA/V06fwT+MIlQJ3DK3ve255JAhC2/Sbb/69SpvroccYmfva76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000280; c=relaxed/simple;
	bh=ysgS01DaUNRNFmCyqFaIEAFFgwufR+E1yAt/1uNSO8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkhkJSkv9mw+HRllY+c3WSGlN2pBmAqllondoQKVk8gnOdWYJpa69y5vdswwjcBe6MinueK/kNunTHA0ATi11KYB7+BehbiOtJZLYNr6tzYEkVo6MN9ei4EaYvdg4iY8ceg66cKZ0vhrCG57aUNyWfknb0o9mBWLGjd+x3dSkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbCusKeg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fOvo9r/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgB3LhMqOZ+YBkO0ZZD/ZAGt3jgrVFlcoSgeSBFrG1A=;
	b=UbCusKegiY4htXtXb6cmiKpgLftrm8OW6HF0kY4SBA0xVA6X8uBoNc4HcYBYgf3qB7EKjy
	0vnRhbCV99EGmEO9CIOQU5AdcQcMfSuVz/5cfuOEsSLtkpmIdb9tmSJn0nh1ZOEYvHWBXd
	x5ohKq3YewG7wcBF2kCJNgLCwTZ1D8/+mkjUHVAlRsJkask5JVQkRUpUXvBwP5yhscXqaz
	XCh3Z8GjDsSWj8I/uJ8qzqf1Kvs1B2NRxSEdIpg0gcMkgu4ew/f79wpGOjeFlZX68JF+W3
	yzEpHQhM86wPsh+PyaBRXS68MAr6198hI5WbIhM1S9V/TuYtYWMg1LfvvT3P/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgB3LhMqOZ+YBkO0ZZD/ZAGt3jgrVFlcoSgeSBFrG1A=;
	b=1fOvo9r/qH+GjFBoFmV4Mq1GTv7uo31luHW62OlEVNNKdplS0DAqHgugpnuoBkmS+FSCDn
	OTxv7inUt8L/yyCQ==
Date: Mon, 03 Mar 2025 12:11:17 +0100
Subject: [PATCH 15/19] x86/vdso: Prepare introduction of struct vdso_clock
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20250303-vdso-clock-v1-15-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=3053;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xyNISseLOTNZW4PPjUER0EQo8UUOOyYEKCLROc72ytc=;
 b=0qWgzjrxn8OGxXIBksBvp9I3CDmpmtrU83qA8jyzdK/S89J9zVZl5lnjSVCXoSYPOtqJjB5z6
 Eds45EkmeVCCIxtaR0ZY0XAX3AF9MFiqoAGHbKfXMXIBaSvGGgd69bM
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gzV729WzG2rS
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712143.67576@2ga7sGlmGMvIjL2lMe/0tg
X-ITU-MailScanner-SpamCheck: not spam
Message-ID: <20250303111117.0IHyV3kfLRmu6ZcbU4zcgXT8_nQU4dnCEdfxfjLktmY@z>

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable=
