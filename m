Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE733280404
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111794; cv=fail; b=SaFrq8Eycm5dkMty6LMYHHReUQVxWwio9LCQQAE5FR6E+JxZPRkRT5rJTqRJwr5hoXzHz2pp4L7ZIcdnW8YPmE0u28+SlSFwEOMJrR21IqRUBEjZLlPtzeCAnrcokOejrkhtT5NQ3N/DLpS3vfZ4L6d+fih4kmzrFqzTcYkLX1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111794; c=relaxed/simple;
	bh=0xL0F9rdElvB+NQbmj2NrRU9PnlyhTsMf4tikqFVt+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIsUEI953L9u9WnK0yWPa3I0MNzJDwfYmnhgiD7UnB4Pzi9UIL6Y9k4C0erPi/yVkAFyO1+DnhwmziRAAzo0uitVkpALp09cofmXomHA8+6bZGENc9tEcogriOTSlTGdkBBOExaPwHAltO5hmw43cq9ll6w062apabPPW//xks0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J2PnJ8Er reason="signature verification failed"; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GwBc4N7J; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J2PnJ8Er";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GwBc4N7J"
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 61BAC408B64C
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 21:09:51 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=J2PnJ8Er;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GwBc4N7J
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dCK5nlGzFwNs
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:17 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 4DBB34278D; Tue,  4 Mar 2025 17:20:58 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J2PnJ8Er;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GwBc4N7J
X-Envelope-From: <linux-kernel+bounces-541541-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J2PnJ8Er;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GwBc4N7J
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 0982542978
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:25:07 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 93E8C3063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:25:07 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282E83BD09A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225271F3FCB;
	Mon,  3 Mar 2025 11:11:25 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCB41FBEAF;
	Mon,  3 Mar 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000281; cv=none; b=athv0CKh7zM7vFISJQg4WlOv7FrUaI0AwztdvCYwSMSOlZQ7HzVM4Sqa4yfo7XwngoE+tlfYy+KxcGi6bUZrnxIe3oe0gNBoGvcW1q879oVKg5SBMXlhlx2OCYM1SbSWXbwY6maJWwRqIJRavzHiKZ7/vDO5ZPrfJPv9yg8GQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000281; c=relaxed/simple;
	bh=98E4VrqWtF5AW/xLBGM4T2qtKg+zPc3dVoKozXn+hFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIzTo9XaJwaMXRDzZQRL78CEfCNqff3GbkRC9kVMhP+8V+9E1OfEJ/PeI/Gw9kIjz0pBdwmEJFRdU59JoThUL5ClfHJB04W4Wo6Eycj/hLM7mmSN1iJ3W/Omkir9y8/3HOabtAaLyFmi4IF/7ouBVjOwBXf9tiLgVesJGU+hqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J2PnJ8Er; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GwBc4N7J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZM1ca5Q9+J4hpNMdg9ysh15hAgKOmycAt5hVatLnOo=;
	b=J2PnJ8ErcXhVIuRvqvkHXj7+dnNdS1EYL5YDEQZoOxgEkdIVKIFeg07b0VEIi3KThnzbt0
	ah3FK8WH0SUuZVYvxjp9pmpwO9vjxDPFsKHVNT/DUtprc2AbKlrSe/944ut+VipnhpibNE
	29SbO2Xuxo/jL/txmYAIO16qHVwJFP+bvw3QcgHJXU/FohbxePmQm/Y+7++xwQnw/Hws2/
	Hfq0VCWqKAR6lbMcAGPJux4b9Ev4LSi4bIfjXBPTW28XOqHQejdiPSeTSjqNqMnc5FIwO/
	uUO5w4RFlrbUUu8nnclDM2MIzMtXJU72CkI7ELp9NW9W5sVsPcqWIk3/EMh6Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZM1ca5Q9+J4hpNMdg9ysh15hAgKOmycAt5hVatLnOo=;
	b=GwBc4N7JUlvmihVy8GcCVvbKSPyE3aY+zPykltsPgrrIWLNMhdZU0VqRTlm2Ku0wvazGx9
	XnuHfIQjnht8pgCw==
Date: Mon, 03 Mar 2025 12:11:19 +0100
Subject: [PATCH 17/19] powerpc/vdso: Prepare introduction of struct
 vdso_clock
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20250303-vdso-clock-v1-17-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=1274;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=J/Meo4khXD/IuyjcSchvegknYNCvt5RiCWDXgeCNEuA=;
 b=ipqT0aYN+nLJcWWGgAiulZ2z34jv+h8RZjUb8zE4PSrDBBV3fg7CNnQswUAW4p7fvphbY9V95
 iF6oxWHwSrZAnFYXR+PzpHDR0Rb2CslyLmtoDfl4dn1AAze7BQJj/Ii
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dCK5nlGzFwNs
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716478.397@5Eu9z0RBDi5i3p2UaApPzA
X-ITU-MailScanner-SpamCheck: not spam
Message-ID: <20250303111119.IeMj1tujvGtiA2MzY3Fk9g9_3s1HvO4HoGV7EPehlec@z>

From: Nam Cao <namcao@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable=
