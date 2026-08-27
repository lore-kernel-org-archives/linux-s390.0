Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF3E486645;
	Thu, 27 Aug 2026 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846438; cv=none; b=cMvRUfTFuQgNJdnvP9+Bd76aFh+V2WX7q9MMUZP9MS/cyT3A6VX29KdWU6kH0BpQul97Tc79Fa86Ms3cfvF5Cgi16yKS9uN4m7wGMVGO/dkIqURAS69Z5IvjLmjCt4T9V6X2monwnqnY1kLhgvAJWxU9OPvTeqQexgI5M/XYEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846438; c=relaxed/simple;
	bh=MfuLMdT8y47iXW3M3N9sJejbjqwoAwpqJeUaYiUsrG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kG/X+0qJX6G9coitaIRWhJHjWxQr9z3wv47bZdvWZZdTGuiRRXtd307gM86Gl8F7e/NCegtIWbOf65SO8bGwLSencMiTRDRPnZnKXgoJALMcZHl9FencQAk+9R3WmIex//58V/Mikq60Q6KG9rlVuJNUn+sBC952dzO9nYaj6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5WlEOS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5WlEOS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7576F1F00A3D;
	Thu, 27 Aug 2026 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846435;
	bh=MfuLMdT8y47iXW3M3N9sJejbjqwoAwpqJeUaYiUsrG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C5WlEOS7+KiUUlzdvqjZKSCG0fpQRA+zobpFt3IDHx6ZZzzV3cakASuEmzVpWYp4O
	 x3ecv0zV41CkgNq3ptP8fmdBDZIEyDcGePF0YADoIdVVEoeGOYJe3Srzkfi2PRYd/9
	 U6zDqwUsLlPb9GrCfYrposTnD3SNIHDst8m7/Xj4k9YAIUcioaJzlecNa1H1lESp6x
	 EP/IA3FzSZj8gAFpJeN2F3oVKjxtAWgSEh81qfGwJ4cE53o4YkjLJ9yGpkzCA4AyX1
	 wjxL3anPQ4AfB0cZ6uKUqL26wXkiEII/biF8PiDw4JosvpfH7wUtdMvZsygGWkiFQ7
	 jRIacv7lp5W1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/21] KVM: s390: vsie: Move release/acquire gmap
 shadow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260827-vsie-sigpi-v6-7-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-7-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:00:34 +0000
Message-Id: <20260827160035.7576F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move {release,acquire}_gmap_shadow() up in preparation for the next patch.
> No change intended.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D7

