Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104483C13EC;
	Wed, 26 Aug 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757279; cv=none; b=QpeyvNm7LZBtn1N0L9sXGIWsQbVk0DurPj9+nw8wuvTghnTSlvZp9YokH3ofeIbqxI3QsuAdEehHpbAxzmijEbHQyZv//vFpBHzPQiPnToJPdW4XY6LVxbchjqUs05egeHljDoyYksQe7+lkAUb7sazIc8XsCi0YkNBFmL+oVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757279; c=relaxed/simple;
	bh=yFgSBvFjwIoTXhNNQ2cgWb7JvRwJ3yQ3LnjM4DQJo4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JZVfDvGWUnsLAqQoiwZfPHvZMt4H0m8YKorrCJw6hsOj8dbMcz43IvVVhj4BOKOIA5SV4zCAihZ8DEHmBwoZkunHT6neRL+IlcywmToSWE6V1p9cD9VQey9kNryW1EeE4RoHNO9nZ8uOphbq2RJSF+Ah1O88sqsIP07H08Q83Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMWNHNeU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMWNHNeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529291F000E9;
	Wed, 26 Aug 2026 15:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757277;
	bh=yFgSBvFjwIoTXhNNQ2cgWb7JvRwJ3yQ3LnjM4DQJo4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dMWNHNeUwZ99MXTH/7I3GtJVUDkuybkvddTSqxT+VmzSZ8IBon1ocnjassmh5oLed
	 uwjN3X5nURcEvNgR2VuE0dF3OoD9O/c6kVpeERUrsbEIsAFwWLIe1CIRWDr2REqZ6L
	 ti2ljt8jlRCPMsfkY2bpqH3IoEQa5WjHIejiNxFHb0DaHDT+gjKeJF6nbgNA8DEB5D
	 22hAE7LkOxTK3R2iv9iQQtbZfq1G2BBTHsKuIVaOeG2cum5yKh6XUWDwsXNPcpkI1j
	 uhnLgZeEZqtmQawFkFOrF2LoEZhAKvZbjGPG1mMYTqSyppC7ayYOWJRtemzTrDnypJ
	 LVt4+bYTOmVow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/21] KVM: s390: vsie: Move release/acquire gmap
 shadow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-7-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-7-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:14:36 +0000
Message-Id: <20260826151437.529291F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D7

