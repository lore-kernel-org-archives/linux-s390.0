Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633343;
	b=1Fu90Bj+w1xMaEJzWNsSfkevwmGwG1aTahYBS9VGkA5g8D6k6xkA0fEVh6/20YC9w2bL
	 mhawrwKNDWXehtXLdTt5/02dZuQJZf/orPSe4PIjUADhLR4+tTbLv0w/Xil1mbbzUsQfY
	 z+rQa4NVIY5xJVxIb6VlgH4MUvGyirFG4Qb9jygS9eEAeZBA9I9Y3mt5t7xEotfJM8WZ4
	 ogWks7FIq5pmcPecjveVsITjW8LgrPk6DrwtVxXxxr36ExOiViLF+l33SF10BIot4SW3A
	 ThLdRGgxpdLraRdqHpTC/bgsLV1EmdRhIj7Buu9btt80k01xTYmBnogLesuIUzt6Auw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633343;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3+8X9IEvHkWMLI1MnnjG7sPQ8rjxk1KxG5+vodzv6k0=;
	b=KH9+MMU/3o1dwDX3RG3Yybe3FtF3YXUyhAcuh2ljn4gFLyTRaP8BXv/IgRdXxu+hqhoL
	 PTTAidzbXZkm/xDs0H93OFlOtp+hMFktpHk4g6jE9+X6KTOM+HOifnrZ2QcpgVpAwHCpv
	 UV1jF6SwHRxxgR6pIao5Q+7gokr7rMtFNObmG6HIVXTe/k6amxUkiat2/81fe6Qg2RvbL
	 ktqjBAjTzSJScBPcHUDAYf6vwADLmVrYo2WURJidgiKXnlKimLOgQ/CXwd/w3BpCzGnJc
	 Ga3F1RB5TDZAz8p4u0QnUWk2NNExgIFASCmxzEqDxMTato6Pu1AA4yqJqOhK0XYI7ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TdIy7M5/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3860D01EF
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdIy7M5/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ED51F00A17;
	Mon,  2 Nov 2026 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633343;
	bh=3+8X9IEvHkWMLI1MnnjG7sPQ8rjxk1KxG5+vodzv6k0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TdIy7M5/7jaCXWeamKfyQJALwsBwPXdFd9+JhGHftdson1c1NPDw6lp4f/F/DjUNP
	 hnqrhp90C4nzAaoN3yUFOO5COFDODJX+1lED5m5FEXwO/ptydsL+cc9EK5aO1pwUQx
	 fkvIjgLv05R0i1XH7rJn5z+VZZ6+AMpulLfR0qeQe2jJzVnBdnfNLGZz1a2hXzcEyp
	 u/NzmI5+xhU/iY5xa7Byx+L9sQXVnk67v6TxOvn6JY1RBQ4XdL0LHOsAfEZ7I7UVEU
	 81rHkPzK0QTptePFRF94tVK4o/vCTjhwFDn4bAB3iwktSYNyvEZgvbu0wLzFAa3R6R
	 83DOUQW5bIs9w==
Message-ID: <sashiko-outbox-193662@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/14] s390/vfio-ap: Data structures for
 facilitating vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-3-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:29:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Creates the data structures used to facilitate state transitions during
> vfio device migration.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D2

