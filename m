Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428249;
	b=kpn1onZTLXq9U1qGJVaAF2bbrB/XzGURVUCMHhqRpHSvrWGWIY5vrFnNSwSe/WN8LYRB
	 AZ+xSqlqJGRr3cysCcqSulwcYrxaViXNEPar8ARGG7ACi+7onm/3W2VpvMs3XqIPn7X/a
	 WI4BIJYVNpEB3bbS7g950Om3uv84kkwZlAGzOPPWv5+/lvva+XfR0rbYBS2fq/ELC8mQe
	 LckyrTbukZ6Na8sem4I4fHfTuhyqQga1Gc0uLsWFP4WNYre43DOgbRDWDKUSkhEBCFZIS
	 Ra1OlHSWuhLAuJTD8m8Vk+DkKNHzonZInaK/iB0ncnpV4XSKostO8K86r747a+og+aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428249;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F7qrX3L0M7ok1LN+UCzsb1jHIcmPgoN82+5an1saUsM=;
	b=JRoIxsKKCJXZxqsC7uKDP6hPhlLqtOjirxN6SkqUDRuZJZgNyC6y4UBZPvOzkloH5Skf
	 4itRvLpYgmO1eUx5UEcDJEYzEfczL25D9K1tPHPCLotO0tuF8QPHCrbR+M73sQzG3EMic
	 3piki2YgWzRJUH22dbmCu8AmP3KCYt7dkDcT8I9us0OOZb96hGeBwEpvgFYzFr8qI0hnP
	 z/PkhPxOit5pHTkHhwHzqZbsyaptR4s2R5p/4ZLb/+KbpSlRsEGgexyxcgQWpMsu0udC3
	 cNb5ivdkk3N4geOuUeOG0dlbYA6wL9HEOOKSpYVmqTzn6Ae1XDUhLtXeqDuyesmF4ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxYMSAlm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B140606A333
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxYMSAlm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903EA1F00A05;
	Wed, 11 Nov 2026 20:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428249;
	bh=F7qrX3L0M7ok1LN+UCzsb1jHIcmPgoN82+5an1saUsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DxYMSAlmePUFXWP81dcjrzClABlSudZFGkwDQ9nDorTjd/Pyi5rYKoj4o5RdVN/Fn
	 goKERlofe12kj7BL+h3TdNUHIgLJTcKVpypjqU+E5t4oQHIwVJKWZ30KJKE3l3Gw6L
	 4QR2vmh8ai5WhWhClYSg5a/3/XNFgI39M/p1WoLeY93XtqMorjpZScen30HqAMUK38
	 QgYMiPbq8L+/iPb9LSOk7BM2j48WeAVepiXklJeI3KaoaSusP1MntTOKxY6RgS/vVr
	 GUDMbb7cYbLJszRLFQa6IvHzAPEqFZs+hEls7yU+yyo/bHZVV4eAWOqXc4yZwcIggg
	 Exln1sOibC5Zw==
Message-ID: <sashiko-outbox-209631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 08/14] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-9-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:17:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
> starts a process of restoring the device state of the vfio device on the
> target system. To prepare for restoring the device state, open a file
> stream to receive the guest's AP configuration saved when the device state
> on the source system transitioned from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_STOP_COPY.
>=20
> Note:
> This commit introduces the file operations structure for migration state
> files with a stub implementation of the write operation. The complete
> implementation is provided in the subsequent commit.
>=20
> This incremental approach allows for easier review of the migration
> infrastructure setup separate from the actual implementation logic.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D8

