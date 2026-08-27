Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257F46E00B;
	Thu, 27 Aug 2026 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846536; cv=none; b=AApf1xI0bl0X/7KtOVhIMNFCc3bIcJnXRB2YGEFmBVY+sR27CzAE1SzX/QrrEXH/i9nx2ClM4IdJUyo+3+AzawKOHOQvLOffJUAVnUhij531KOHKdnS01Q0Dbz1tH1tIXiHnfGYjT0FqXdAQMZrArpJYxxTRfF/lHcLLQzF+1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846536; c=relaxed/simple;
	bh=m8qAPgGKOWL8B5TknQWVs+mivh9BAj+SIabEQ7nZRlI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HtWqhniAQR70L7q7uWMiq6xs8n/Lu0bmjvFYssHmzpngYHmRdRjvq7wORjAs/haj7DTfFGy8oNyKa3btW0kilQL+5t/WOUHWj32dlmNYJY5fHRLyHgG8YFJ0rBT/BGDP6vRiqRSzbgsZVC5vk8Nhw54wRilG1VC6feRLmSq2/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTx3K7hO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTx3K7hO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9961F000E9;
	Thu, 27 Aug 2026 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846535;
	bh=m8qAPgGKOWL8B5TknQWVs+mivh9BAj+SIabEQ7nZRlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTx3K7hOs+BTBsNXF7ZDxk2w5hMCZEzlSbrNUNZoEM3pb4M7CB3vmN2f7LQspdtX8
	 1Z1lAEraWFLibIW5d/szOQCI9U0PQoDsUcLf2JQaLQlJrjRmrMJAT75zjfHc/XZop5
	 vdHRN9gbN2xEzih+w73O+N14Xpo0oS6iKI13X34FyFiusToqX1yCglG0/XN5Nmz2zt
	 UcZ+OqfD2qpmw6QxiF4JmYfqQBcmyjLTTQGFg0oZpu41cnsyNKVYpJWbgCb9JkOPRB
	 h8WSWvWlUhM/3ihMJnaaEAwVC0NIw/VRpqGZE6qD08UxXgQ/uM0mk+EppOT3AdvJVy
	 zxSgWDs2VPRmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/21] KVM: s390: vsie: Add helper reset_vsie_page()
 and unshadow_intercept()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-11-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-11-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:02:14 +0000
Message-Id: <20260827160214.BB9961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Extract helper method from existing code to reuse in new code.
>=20
> reset_vsie_page() clears and releases gmap related to vsie_page.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D11

