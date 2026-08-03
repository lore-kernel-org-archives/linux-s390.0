Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C3399356;
	Mon,  3 Aug 2026 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762241; cv=none; b=DAKL+270/EURW+GF7bXXPo4aSHRy4rnyUeK9xYi+jMmf7ym/yNr5Tq3JfdHrGaqS5WRnmVTPCBPTCZFZ2Z35i8BhB3c+Sz2BN1jxHjwGKSTqavp1Jz+Y8hvfLZhFUzqYFSxQfj/WFrE0dWsiu0XT9j1O4fj+CVOJVUpD5VYZrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762241; c=relaxed/simple;
	bh=vU1JTq5rfxGjdPBat9L+OT3C/AKQno4C2s0AwMhBXok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bwwhZJBDuPoHLwhsVC4MN3/vePEwvGScMi3v7D4be673v3TiACv6sDw+LsqSnve+MPZnppJVoLsd6WthqZAa/7XrRHGZTta7Hx8PbKCofKzXGd1UJX0WDPe+hsPR4NDPUY8B4r3gUbyz0A513Af+H1JCAl2PdPvjg8uPkmWCWUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAaVBmEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAaVBmEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386A61F000E9;
	Mon,  3 Aug 2026 13:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762240;
	bh=vU1JTq5rfxGjdPBat9L+OT3C/AKQno4C2s0AwMhBXok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZAaVBmEeYZ98PAC1TzEILW0N1Dh4FSND3oDc78KdQHxY7Whtkn8icuZ1VLw5OBncq
	 GcLb1Br0dVRGRit9pF59mA4CfJ1LMskE1BUhzl0ZnFM/nZyzCJluyocwvQWbDottdN
	 GL8Ut6jerWbfC+ZUtne9aGT8Z83Aw+TZbZ7I1svY1WYfr+QIyp9n8BtTFb8rr54/qh
	 FZKYurdkC9a8QO9R2rdfM/7yqzKpScXfwbyT1JkuBeVdZQH5XQItnBEf274l/VGpKl
	 9cDCtQQVDm0nrazovHasZ621cbkTjMqhxiYdpdm/HyvX4aaln4NNvEwwmTw+I3AgUw
	 nZdlYMEZtGT+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/13] KVM: s390: Fix ordering when adding to SCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260803124040.126471-13-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-13-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:03:57 +0000
Message-Id: <20260803130359.386A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When adding a new vCPU to the SCA area, the validity bit in the MCN was
> set before the pointer to the state description, potentially allowing
> for a race.
>=20
> Fix by setting the pointer before setting the bit.
>=20
> Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D12

