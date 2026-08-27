Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFB147FAF9;
	Thu, 27 Aug 2026 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846277; cv=none; b=snHgI2vh4zmj1ZN45yBsj9NmyWmdOofuip1lKxKI88Y5C+Bzs6hA+rqojtDi004w5YUz+6p0iqf4lOhWUUWYg/Kod40h3aG11e1epOB1aNpyTWw6loxNOvWSNI7hDAYMQeTU0vYY9uecXw7OcC2GpTROJHftNBMgR88YxKd22KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846277; c=relaxed/simple;
	bh=YyGfVNIJ/rdmmAPO5pjrWP0RHw3PuzdzQczKB0eSHIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bTMCdubD09zJ8QZZxLCOxd1x1ygk7PExjX/7thQa8OlJ4DNOUjafe6gYw++NUB/MiFUMR/4RvDgQfeYTexmHc7E0y9oxN5tZkWAB96Xh+glvcONwGO8FS4zeHgdvnW+VrHT/aG3ThhBYFoNfAgqMkz5ojBCOBdYjbfb4dO7bTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYKvnNPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYKvnNPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29FC1F000E9;
	Thu, 27 Aug 2026 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846276;
	bh=YyGfVNIJ/rdmmAPO5pjrWP0RHw3PuzdzQczKB0eSHIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYKvnNPWmHealYR4EMCKp42FyNLETB34p+QWFqmSMZb2PCuP7svZRbX3vJ1p/MNh/
	 g23pFMtr2WaMPTE4+f5A8OpkRrP7LsOj5zP+WZgkGdLoor0eA1EBkcqs9lnfQM/q67
	 2lguiIARWlAyugZ79Wdx6nFSVz6askY3/v988kzH1Be5iXHeWb0BLfUqCV4nKDmx2U
	 YxfK0qA1VH5FaVaajgLR1Ep54nm65k5ChY1LKr36FowS+sfnlsbsKXyof5yqg5f7xX
	 WHLEIgB5AtLK+Tbwf9D1svhAb5d7nJnL8B5HfV2ggZqQ3HwsTm7EOsxcLtFepv8s3B
	 98OSLZB+EMNbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/21] KVM: s390: vsie: Move pin/unpin_scb methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-6-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-6-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 15:57:55 +0000
Message-Id: <20260827155755.B29FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move {,un}pin_scb() up in preparation for the next patches.
> No change intended.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D6

