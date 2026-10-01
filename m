Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA24D9550
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862010; cv=none; b=MbZtVgmAW/iF1ePN10RywjycVmW6oBWV9v4yEAgEZ71Q5NDMkmppnRLEzwpm+mgAXPlA7LwYeO2ovNhf9J7/D2rzM6ERADvbr9hxfR56BoUbUKsDwBU5fdneVyTTd02t+sjmbbkbyhmQRW8JjZ3IpRzaknLzpWA6UBI+yGqgAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862010; c=relaxed/simple;
	bh=44EZaq4IayZwFnSEKr7sAoYn1kVxome40EQ9XQHbL/E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Vz5PWsMtfJZ9ahjaeHB5NSf726aAH08SYhy0JPpdMI/5asjtGM92HDruJTjRX18jRsGPJGZpwf4f+7FO9frM4R+6taam6z/mjjI5m5Ts2qU0cClWrriHd5HWGLtlctE0lkp1xzsbP65s6If7c09K/B6jD64Wr6zv2qemZr+9q5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Vvo60XYF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yE0Y3aPz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Vvo60XYF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yE0Y3aPz"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id A8D61EC01CF
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 09:40:07 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 01 Oct 2026 09:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790861991;
	 x=1790948391; bh=Uwp2ZDOoPY3tI2VNi4uZ1TmL4tpZAymbe2XPjfSWC3g=; b=
	Vvo60XYFrWy2XPdLwFA9adRkgSN3UVtkoS97ON0g2cGLCnP/r70JvNVCKk02dTpg
	VDO1wr+/WyiNuQcycIM88DErSPgqbuSU94W8y016zNYI446AuE+uTIftFoiNdWAu
	FmvLnI1iVuzLIHxP+h5qSkg5dckZO8Nm+09yWalyTUwYhdEIULLSaf49/9ozGQVZ
	sFcs+noqoxMH57+7ZYpSBQZ0lLPFqII3mpuy1wp6t5FXcrKaQ4PzCYS5EDoFdjVX
	7PR3k6b2zyNse0qgFebEvb+PQRPXDA8ZQg1bdc1kS+clYqOgRdRJrtxkhy4vxkCH
	2Hnoq6IBtYmhr2ACmlZdbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790861991; x=
	1790948391; bh=Uwp2ZDOoPY3tI2VNi4uZ1TmL4tpZAymbe2XPjfSWC3g=; b=y
	E0Y3aPzlONuyx97IbQDkB4tJwxI4yrGQ0Uh6wjPCIopZN/XwMX7BiVptHeT2n7J4
	JHLSu6Lked9EkPyOzQmskgXlQ39Fa+a8Kc4jWz8ZBDEifiqfcnG3CZBJmc77mUYW
	MDVjwJPSUCXjCOdtDGmo8d75WwK3FXVmYgcrzgHsLNZ+H2fNdkuRJZLrGoxBu1Xl
	rbu7lhXbIOcKaH6AJyuu9qb/gRwNp1lCsolXgizZ+Jlq1EVFaG/nM2ZkkAeDGWf+
	PI55JTlT8JMJjNyz7zWPecjxOzglND4gkkRFqQ2nxceOh7z+53xrU5Bi5v9aQdMi
	gQm+O2J6WY1RlD8L2adRA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790861991; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:FM9MZ+kPMb+ds1sVRTAne+0DXGXCR0r/SDDI9qhZ55wUDI3
	cnX9s77TPWbbZrQcOwIhxyZL/qkOkA0u3HFhCozLEzdcfZX9gKEo4afnHYFmCmHm
	BS6+IwyJZ5/HzsoIYF+OUINQl2CZJAuhCLZUO4vPuG6Do0pBVfTSy6Rdvxpk++hm
	FUN245s7dwswQ4IjI7jVVvNt0cTZbUqi1hR3cyn+EknAik/f5cffZMeCyZB9a11W
	sz5e6jYg0kAKn5xSp7V1f4zZ8sdxTcJJ46DKYWoCLyGHnmPaalzFL5WL2GZgFsVG
	axGb/uvQgB832Q1zB7OwUDQ3r9634jhMs3HWYLw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BGpLFMCduRgTg7y1aJr8Ihh10vNT6FWHgqI8rrxK5fI=:44EZaq4IayZwFnSEKr7sAoYn1kVxome40EQ9XQHbL/E=;
X-ME-Sender: <xms:oGK-aqKqS5O8pEqGgKCvh__LvsScmCIsvi5uWnyQVKCo8Zk4lQQwIQ>
    <xme:oGK-as8GbFf_iRvMnim8wlA19YZROZHMvzVXmocivAHkXrM_d6iXEiGBw6qXEAu1S
    fE61CGw6T95gOkCwEXVs_MLfrviBAyYn5mk8p9PXCqMwpUGceO2MWTO>
X-ME-Proxy-Cause: dmFkZTEdx5AqovL1MTEo9qQdIf1UspZIhV2/zxzYRmwyd+bfaXPeYA2sFWVvA4rtnWQssz
    e/2T3RJgnanif0LUm5IZ4ZAoV5grcdZq8G0huQxY29Y8wRoYp009HNfv+KgK5P0w8gmFDz
    vuFpNcewv5coXrOM/gbTVyOCjoacUGWKLvFYxLZoD9S9vDqeLMeRitS9iJywkISeFaDiOG
    9HH2239doQyc+FRdEt6Dz45AR1v0pEqiNZCMXnPubcaWeWH/WeBdO1NtWDppw33wUpE9ib
    hFCl0FzAh+BwPd/iWfy1e3RgasoKugqSILaqPXGOHF4i0TS2V6y7Ghsg/2kzdADRJ67tFk
    sAomxwNvOZE3Xl4f/XP3A66f9+z9gspYtzZhE4n76yksZa22YcktB2kJwt0AKSyvWKqBnW
    uThVg1YEV1xUtXdeifE7P+vxCE6CDd5LJ/7+dXXv+Yf4HAaKsl9TzqphOh6uZSnAtXOjHe
    kjhUwVDtlG2ldd0RYCQAAvdnkapM11UMiRGoBcZgec6rtl/YDvWJHkkF8HXPtm6zq/s32M
    RM32kc482Ehq7OcsYWXwZvkFARvGyQVFMaMyJSLOcZsQHNLk6CBbaSwOB+baaHKM2a09ih
    NBkhZ1o7/ENmZlRpShwI8nt1Qe3hGLG5Hb6dsqZU2wuIFvmIxC7QFcNP0u3Q
X-ME-Proxy: <xmx:pWK-ak-68vXD1ePX4y31qlVBoKs_NqqSxrJHMUKlKasmB4u1PJxesw>
    <xmx:pWK-agA8IgXnKSdK4QKof0d01XAqAbnMT9DOVIKV8plUbRPRL6zAmQ>
    <xmx:pWK-auE1s0-gtqaMocgsUVh5dhVkU53_2Of23DTTKtkiFQiexqfdvg>
    <xmx:pWK-aq1g8e83K9bz6wyRWDXEDrfkLCMGvfwelPYVnOiv_WIGGc2O2w>
    <xmx:p2K-ar_Hipd_0Tf2XNyz7_3JwgUuiODDRV-TrdSqE9bmmYkIE4Xc8zHN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 8214032A008A; Thu,  1 Oct 2026 09:39:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AompHzTHtn-7
Date: Thu, 01 Oct 2026 15:39:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steffen Eiden" <seiden@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Andreas Grapentin" <gra@linux.ibm.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Friedrich Welter" <fritz@linux.ibm.com>,
 "Gautam Gala" <ggala@linux.ibm.com>,
 "Hariharan Mari" <hari55@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Hendrik Brueckner" <brueckner@linux.ibm.com>,
 "Ilya Leoshkevich" <iii@linux.ibm.com>,
 "Janosch Frank" <frankja@linux.ibm.com>,
 "Joey Gouly" <joey.gouly@arm.com>, "Nico Boehr" <nrb@linux.ibm.com>,
 "Nina Schoetterl-Glausch" <oss@nina.schoetterlglausch.eu>,
 "Oliver Upton" <oupton@kernel.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Sean Christopherson" <seanjc@google.com>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>, "Will Deacon" <will@kernel.org>,
 "Zenghui Yu" <yuzenghui@huawei.com>,
 "Fuad Tabba" <fuad.tabba@linux.dev>
Message-Id: <40dd808c-bddf-4a7a-be81-53c64de2707d@app.fastmail.com>
In-Reply-To: <20261001132715.108643-A-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <179085262878.3865846.5787241839391727949.b4-ty@b4>
 <20261001132715.108643-A-seiden@linux.ibm.com>
Subject: Re: (subset) [PATCH v9 00/24] KVM: s390: Introduce arm64 KVM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 1, 2026, at 15:27, Steffen Eiden wrote:
> On Thu, Oct 01, 2026 at 12:04:51PM +0100, Marc Zyngier wrote:
>
> quick fix: 

Ah, I was about to send the same thing.

> I can send the two fixup patches as a reply here for this tomorrow or 
> later today if you want. 

My build bot is churning away looking for more corner cases.
I initially had the wrong base, but with this one and the other
two I sent, things are starting to look good. I'll keep it
running over night, but if you don't hear from me for any additional
build regressions in the next hour, it's probably fine.

      Arnd
